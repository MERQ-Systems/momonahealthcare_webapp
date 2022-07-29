<?php


namespace FormTools\Modules\ExportManager;

use FormTools\Core;
use FormTools\Fields;
use FormTools\FieldTypes;
use FormTools\Forms;
use FormTools\General as CoreGeneral;
use FormTools\Hooks;
use FormTools\Module as FormToolsModule;
use FormTools\Modules;
use FormTools\Sessions;
use FormTools\Settings;
use FormTools\Submissions;
use FormTools\Views;

use Exception;


class Module extends FormToolsModule
{
	protected $moduleName = "Export Manager";
	protected $moduleDesc = "Define your own ways of exporting form submission data for view / download. Excel, Printer-friendly HTML, XML and CSV are included by default.";
	protected $author = "Ben Keen";
	protected $authorEmail = "ben.keen@gmail.com";
	protected $authorLink = "https://formtools.org";
	protected $version = "3.2.0";
	protected $date = "2019-11-09";
	protected $originLanguage = "en_us";
	protected $jsFiles = array(
		"{MODULEROOT}/scripts/admin.js",
		"{FTROOT}/global/scripts/sortable.js",
		"{FTROOT}/global/codemirror/lib/codemirror.js",
		"{FTROOT}/global/codemirror/mode/smarty/smarty.js"
	);
	protected $cssFiles = array(
		"{MODULEROOT}/css/styles.css",
		"{FTROOT}/global/codemirror/lib/codemirror.css"
	);

	protected $nav = array(
		"module_name" => array("index.php", false),
		"word_settings" => array("settings.php", true),
		"phrase_reset_defaults" => array("reset.php", true),
		"word_help" => array("help.php", true)
	);

	public function install($module_id)
	{
		$L = $this->getLangStrings();

		$success = true;
		$message = "";

		try {
			$this->createTables();

			General::clearTableData();
			$this->addHtmlExportGroup();
			$this->addExcelExportGroup();
			$this->addXmlExportGroup();
			$this->addCsvExportGroup();
			$this->addModuleSettings();
		} catch (Exception $e) {
			$success = false;
			$message = $L["notify_installation_problem_c"] . " <b>" . $e->getMessage() . "</b>";
		}

		$this->resetHooks();

		return array($success, $message);
	}

	public function uninstall($module_id)
	{
		$db = Core::$db;

		$db->query("DROP TABLE {PREFIX}module_export_groups");
		$db->execute();

		$db->query("DROP TABLE {PREFIX}module_export_group_clients");
		$db->execute();

		$db->query("DROP TABLE {PREFIX}module_export_types");
		$db->execute();

		return array(true, "");
	}


	public function upgrade($module_id, $old_module_version)
	{
		$this->resetHooks();

		// upgrading to 3.1.0
		self::addExportGroupContentType();

		// upgrading to 3.2.0
		self::addExportTimeoutSetting();
	}


	public function resetHooks()
	{
		$this->clearHooks();

		Hooks::registerHook("template", "export_manager", "admin_submission_listings_bottom", "", "displayExportOptions");
		Hooks::registerHook("template", "export_manager", "client_submission_listings_bottom", "", "displayExportOptions");
	}

	public function resetData()
	{
		$L = $this->getLangStrings();

		$success = true;
		$message = $L["notify_reset_to_default"];

		try {
			General::clearTableData();
			$this->addHtmlExportGroup();
			$this->addExcelExportGroup();
			$this->addXmlExportGroup();
			$this->addCsvExportGroup();
			$this->addModuleSettings();
		} catch (Exception $e) {
			$success = false;
			$message = $L["notify_installation_problem_c"] . " <b>" . $e->getMessage() . "</b>";
		}

		return array($success, $message);
	}

	/**
	 * This hook function is what actually outputs the Export options at the bottom of the Submission Listing page.
	 *
	 * @param string $template_name
	 * @param array $params
	 */
	public function displayExportOptions($template_name, $params)
	{
		$account_id = Sessions::get("account.account_id");
		$root_url = Core::getRootUrl();
		$smarty = Core::$smarty;
		$L = $this->getLangStrings();

		$form_id = $params["form_id"];
		$view_id = $params["view_id"];

		$is_admin = ($template_name == "admin_submission_listings_bottom");
		if ($is_admin) {
			$account_id = "admin";
		}

		// this does all the hard work of figuring out what groups & types should appear
		$export_groups = ExportTypes::getAssignedExportTypes($account_id, $form_id, $view_id);

		// now for the fun stuff! We loop through all export groups and log all the settings for
		// each of the fields, based on incoming POST values
		$page_vars = array();
		foreach ($export_groups as $export_group) {
			$export_group_id = $export_group["export_group_id"];
			$page_vars["export_group_{$export_group_id}_results"] = Modules::loadModuleField("export_manager",
				"export_group_{$export_group_id}_results", "export_group_{$export_group_id}_results");
			$page_vars["export_group_{$export_group_id}_export_type"] = Modules::loadModuleField("export_manager",
				"export_group_{$export_group_id}_export_type", "export_group_{$export_group_id}_export_type");
		}

		// now pass the information to the Smarty template to display
		$smarty->assign("export_groups", $export_groups);
		$smarty->assign("is_admin", $is_admin);
		$smarty->assign("page_vars", $page_vars);
		$smarty->assign("L", $L);
		$smarty->assign("SESSION", Sessions::get("export_manager"));
		$smarty->assign("LANG", $params["LANG"]);
		$smarty->assign("export_icon_folder", "$root_url/modules/export_manager/images/icons");

		echo $smarty->fetch("../../modules/export_manager/templates/export_options_html.tpl");
	}


	private function addHtmlExportGroup()
	{
		$L = $this->getLangStrings();

		$smarty_template = <<< END
<html>
<head>
    <title>{\$export_group_name}</title>
    {literal}
    <style type="text/css">
    body { margin: 0px; }
    table, td, tr, div, span {
        font-family: verdana; font-size: 8pt;
    }
    table { empty-cells: show }
    #nav_row { background-color: #efefef; padding: 10px; }
    #export_group_name { color: #336699; font-weight:bold }
    .print_table { border: 1px solid #dddddd; }
    .print_table th {
        border: 1px solid #cccccc;
        background-color: #efefef;
        text-align: left;
    }
    .print_table td { border: 1px solid #cccccc; }
    .one_item { margin-bottom: 15px; }
    .page_break { page-break-after: always; }
    </style>
    <style type="text/css" media="print">
    .no_print { display: none }
    </style>
    {/literal}
</head>
<body>
    <div id="nav_row" class="no_print">
        <span style="float:right">
            {if \$page_type != "file"}
                {* if there's more than one export type in this group, display the types in a dropdown *}
                {if \$export_types|@count > 1}
                    <select name="export_type_id" onchange="window.location='{\$same_page}?export_group_id={\$export_group_id}&export_group_{\$export_group_id}_results={\$export_group_results}&export_type_id=' + this.value">
                    {foreach from=\$export_types item=export_type}
                        <option value="{\$export_type.export_type_id}" {if \$export_type.export_type_id == \$export_type_id}selected{/if}>
                            {eval var=\$export_type.export_type_name}
                        </option>
                    {/foreach}
                    </select>
                {/if}
            {/if}
            <input type="button" onclick="window.close()" value="{\$LANG.word_close}" />
            <input type="button" onclick="window.print()" value="{\$L.word_print}" />
        </span>
        <span id="export_group_name">{eval var=\$export_group_name}</span>
    </div>
    <div style="padding: 15px">{\$export_type_smarty_template}</div>
</body>
</html>
END;

		list ($success, $message, $export_group_id) = ExportGroups::addExportGroup(array(
			"group_name" => $L["phrase_html_printer_friendly"],
			"icon" => "printer.png",
			"action" => "popup",
			"action_button_text" => $L["word_display"],
			"popup_height" => 600,
			"popup_width" => 800,
			"smarty_template" => $smarty_template,
			"content_type" => "html"
		), $L);

		$table_smarty_template = <<< END
<h1>{\$form_name} - {\$view_name}</h1>

<table cellpadding="2" cellspacing="0" width="100%" class="print_table">
<tr>
    {foreach from=\$display_fields item=column}
    <th>{\$column.field_title}</th>
    {/foreach}
</tr>
{strip}
{foreach from=\$submissions item=submission}
    {assign var=submission_id value=\$submission.submission_id}
    <tr>
        {foreach from=\$display_fields item=field_info}
            {assign var=col_name value=\$field_info.col_name}
            {assign var=value value=\$submission.\$col_name}
            <td>
                {smart_display_field form_id=\$form_id view_id=\$view_id submission_id=\$submission_id
                    field_info=\$field_info field_types=\$field_types settings=\$settings value=\$value}
            </td>
        {/foreach}
    </tr>
{/foreach}
{/strip}
</table>
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $L["phrase_table_format"],
			"visibility" => "show",
			"filename" => "submissions-{\$M}.{\$j}.html",
			"export_group_id" => $export_group_id,
			"smarty_template" => $table_smarty_template
		), $L);

		$one_by_one_smarty_template = <<< END
<h1>{\$form_name} - {\$view_name}</h1>

{strip}
{foreach from=\$submissions item=submission}
    {assign var=submission_id value=\$submission.submission_id}
    <table cellpadding="2" cellspacing="0" width="100%" class="print_table one_item">
    {foreach from=\$display_fields item=field_info}
        {assign var=col_name value=\$field_info.col_name}
        {assign var=value value=\$submission.\$col_name}
        <tr>
            <th width="140">{\$field_info.field_title}</th>
            <td>
                {smart_display_field form_id=\$form_id view_id=\$view_id submission_id=\$submission_id field_info=\$field_info
                    field_types=\$field_types settings=\$settings value=\$value}
            </td>
        </tr>
    {/foreach}
    </table>
{/foreach}
{/strip}
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $L["phrase_one_by_one"],
			"visibility" => "show",
			"filename" => "submissions-{\$M}.{\$j}.html",
			"export_group_id" => $export_group_id,
			"smarty_template" => $one_by_one_smarty_template
		), $L);

		$one_submission_smarty_template = <<< END
<h1>{\$form_name} - {\$view_name}</h1>

{foreach from=\$submissions item=submission name=row}
    {assign var=submission_id value=\$submission.submission_id}
    <table cellpadding="2" cellspacing="0" width="100%" class="print_table one_item">
    {foreach from=\$display_fields item=field_info}
        {assign var=col_name value=\$field_info.col_name}
        {assign var=value value=\$submission.\$col_name}
        <tr>
            <th width="140">{\$field_info.field_title}</th>
            <td>
                {smart_display_field form_id=\$form_id view_id=\$view_id submission_id=\$submission_id field_info=\$field_info
                    field_types=\$field_types settings=\$settings value=\$value}
            </td>
        </tr>
    {/foreach}
    </table>
    {if !\$smarty.foreach.row.last}
        <div class="no_print"><i>- {\$L.phrase_new_page} -</i></div>
        <br class="page_break" />
    {/if}
{/foreach}
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $L["phrase_one_submission_per_page"],
			"visibility" => "show",
			"filename" => "submissions-{\$M}.{\$j}.html",
			"export_group_id" => $export_group_id,
			"smarty_template" => $one_submission_smarty_template
		), $L);
	}

	public function addExcelExportGroup()
	{
		$L = $this->getLangStrings();

		list ($success, $message, $export_group_id) = ExportGroups::addExportGroup(array(
			"group_name" => $L["word_excel"],
			"icon" => "xls.gif",
			"headers" => "Pragma: public\nCache-Control: max-age=0\nContent-Type: application/vnd.ms-excel; charset=utf-8\nContent-Disposition: attachment; filename={\$filename}",
			"smarty_template" => "<html>\n<head>\n</head>\n<body>\n\n{\$export_type_smarty_template}\n\n</body>\n</html>"
		), $L);

		$excel_smarty_template = <<< END
<h1>{\$form_name} - {\$view_name}</h1>

<table cellpadding="2" cellspacing="0" width="100%" class="print_table">
<tr>
    {foreach from=\$display_fields item=column}
    <th>{\$column.field_title}</th>
    {/foreach}
</tr>
{strip}
{foreach from=\$submissions item=submission}
    {assign var=submission_id value=\$submission.submission_id}
    <tr>
    {foreach from=\$display_fields item=field_info}
        {assign var=col_name value=\$field_info.col_name}
        {assign var=value value=\$submission.\$col_name}
        <td>
            {smart_display_field form_id=\$form_id view_id=\$view_id submission_id=\$submission_id
                field_info=\$field_info field_types=\$field_types settings=\$settings value=\$value escape="excel"}
        </td>
    {/foreach}
</tr>
{/foreach}
{/strip}
</table>
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $L["phrase_table_format"],
			"visibility" => "show",
			"filename" => "submissions-{\$M}.{\$j}.xls",
			"export_group_id" => $export_group_id,
			"smarty_template" => $excel_smarty_template
		), $L);
	}

	private function addXmlExportGroup()
	{
		$L = $this->getLangStrings();
		$LANG = Core::$L;

		list ($success, $message, $export_group_id) = ExportGroups::addExportGroup(array(
			"group_name" => $L["word_xml"],
			"visibility" => "hide",
			"icon" => "xml.jpg",
			"headers" => "Content-type: application/xml; charset=\"octet-stream\"\r\nContent-Disposition: attachment; filename={\$filename}",
			"smarty_template" => "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\r\n\r\n{\$export_type_smarty_template}"
		), $L);

		$xml_smarty_template = <<< END
{strip}
<export>
    <export_datetime>{\$datetime}</export_datetime>
    <export_unixtime>{\$U}</export_unixtime>
    <form_info>
        <form_id>{\$form_id}</form_id>
        <form_name><![CDATA[{\$form_name}]]></form_name>
        <form_url>{\$form_url}</form_url>
    </form_info>
    <view_info>
        <view_id>{\$view_id}</view_id>
        <view_name><![CDATA[{\$view_name}]]></view_name>
    </view_info>
    <submissions>
        {foreach from=\$submissions item=submission name=row}
            <submission>
            {foreach from=\$display_fields item=field_info name=col_row}
                {assign var=col_name value=\$field_info.col_name}
                {assign var=value value=\$submission.\$col_name}
                <{\$col_name}><![CDATA[{smart_display_field form_id=\$form_id 
                    view_id=\$view_id submission_id=\$submission.submission_id
                    field_info=\$field_info field_types=\$field_types
                    settings=\$settings value=\$value}]]></{\$col_name}>
            {/foreach}
        </submission>
        {/foreach}
    </submissions>
</export>
{/strip}
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $LANG["phrase_all_submissions"],
			"visibility" => "show",
			"filename" => "form{\$form_id}_{\$datetime}.xml",
			"export_group_id" => $export_group_id,
			"smarty_template" => $xml_smarty_template
		), $L);
	}

	private function addCsvExportGroup()
	{
		$LANG = Core::$L;
		$L = $this->getLangStrings();

		list ($success, $message, $export_group_id) = ExportGroups::addExportGroup(array(
			"group_name" => $L["word_csv"],
			"visibility" => "hide",
			"icon" => "csv.gif",
			"headers" => "Content-type: text/csv;\r\nContent-Disposition: attachment; filename={\$filename}",
			"smarty_template" => "{\$export_type_smarty_template}"
		), $L);

		$csv_smarty_template = <<< END
{strip}
{foreach from=\$display_fields item=column name=row}
  {* workaround for an absurd Microsoft Excel problem, in which the first
     two characters of a file cannot be ID; see:
     http://support.microsoft.com/kb/323626 *}
  {if \$smarty.foreach.row.first && \$column.field_title == "ID"}
    'ID
  {else}
    {\$column.field_title|escape:'csv'}
  {/if}
  {if !\$smarty.foreach.row.last},{/if}
{/foreach}
{/strip}
{foreach from=\$submissions item=submission name=row}{strip}
  {foreach from=\$display_fields item=field_info name=col_row}
    {assign var=col_name value=\$field_info.col_name}
    {assign var=value value=\$submission.\$col_name}
    {smart_display_field form_id=\$form_id view_id=\$view_id 
      submission_id=\$submission.submission_id field_info=\$field_info
      field_types=\$field_types settings=\$settings value=\$value
      escape="csv"}
    {* if this wasn't the last row, output a comma *}
    {if !\$smarty.foreach.col_row.last},{/if}
  {/foreach}{/strip}
{if !\$smarty.foreach.row.last}
{/if}
{/foreach}
END;

		ExportTypes::addExportType(array(
			"export_type_name" => $LANG["phrase_all_submissions"],
			"visibility" => "show",
			"filename" => "form{\$form_id}_{\$datetime}.csv",
			"export_group_id" => $export_group_id,
			"smarty_template" => $csv_smarty_template
		), $L);
	}


	private function addModuleSettings()
	{
		$root_dir = Core::getRootDir();

		$upload_dir = str_replace("\\", "\\\\", $root_dir);
		$separator = "/";
		if (strtoupper(substr(PHP_OS, 0, 3) == 'WIN')) {
			$separator = "\\\\";
		}

		$root_url = Core::getRootUrl();
		$upload_dir .= "{$separator}upload";

		Settings::set(array(
			"file_upload_dir" => $upload_dir,
			"file_upload_url" => "$root_url/upload",
			"export_timeout" => 300
		), "export_manager");
	}


	private function createTables()
	{
		$db = Core::$db;

		$queries = array();
		$word_display = addcslashes($L["word_display"], "''");
		$queries[] = "
            CREATE TABLE {PREFIX}module_export_groups (
              export_group_id smallint(5) unsigned NOT NULL auto_increment,
              group_name varchar(255) NOT NULL,
              access_type enum('admin','public','private') NOT NULL default 'public',
              form_view_mapping enum('all','except','only') NOT NULL default 'all',
              forms_and_views mediumtext NULL,
              visibility enum('show','hide') NOT NULL default 'show',
              icon varchar(100) NOT NULL,
              action enum('file','popup','new_window') NOT NULL default 'popup',
              action_button_text varchar(255) NOT NULL default '$word_display',
              content_type varchar(50) NOT NULL,
              popup_height varchar(5) default NULL,
              popup_width varchar(5) default NULL,
              headers text,
              smarty_template mediumtext NOT NULL,
              list_order tinyint(4) NOT NULL,
              PRIMARY KEY  (export_group_id)
            ) DEFAULT CHARSET=utf8
        ";

		$queries[] = "
            CREATE TABLE {PREFIX}module_export_group_clients (
            export_group_id mediumint(8) unsigned NOT NULL,
            account_id mediumint(8) unsigned NOT NULL,
            PRIMARY KEY  (export_group_id, account_id)
            ) DEFAULT CHARSET=utf8
        ";

		$queries[] = "
            CREATE TABLE {PREFIX}module_export_types (
              export_type_id mediumint(8) unsigned NOT NULL auto_increment,
              export_type_name varchar(255) NOT NULL,
              export_type_visibility enum('show','hide') NOT NULL default 'show',
              filename varchar(255) NOT NULL,
              export_group_id smallint(6) default NULL,
              smarty_template text NOT NULL,
              list_order tinyint(3) unsigned NOT NULL,
              PRIMARY KEY (export_type_id)
            ) DEFAULT CHARSET=utf8
        ";

		foreach ($queries as $query) {
			$db->query($query);
			$db->execute();
		}
	}

	public function export($params)
	{
		$L = $this->getLangStrings();
		$root_dir = Core::getRootDir();
		$root_url = Core::getRootUrl();

		$module_settings = Settings::get("", "export_manager");

		// if any of the required fields weren't entered, just output a simple blank message
		if (empty($params["form_id"]) || empty($params["view_id"]) || empty($params["order"]) ||
			empty($params["search_fields"]) || empty($params["export_group_id"])) {
			echo $L["notify_export_incomplete_fields"];
			exit;
		}

		$form_id = $params["form_id"];
		$view_id = $params["view_id"];
		$order = $params["order"];
		$search_fields = $params["search_fields"];
		$export_group_id = $params["export_group_id"];
		$export_type_id = $params["export_type_id"];
		$results = $params["results"];

		set_time_limit($module_settings["export_timeout"]);

		// if the user only wants to display the currently selected rows, limit the query to those submission IDs
		$submission_ids = array();
		if ($results == "selected") {
			$submission_ids = Sessions::get("form_{$form_id}_selected_submissions");
		}

		// perform the almighty search query
		$results_info = Submissions::searchSubmissions($form_id, $view_id, "all", 1, $order, "all", $search_fields, $submission_ids);

		$form_info = Forms::getForm($form_id);
		$view_info = Views::getView($view_id);
		$form_fields = Fields::getFormFields($form_id, array(
			"include_field_type_info" => true,
			"include_field_settings" => true
		));
		$field_types = FieldTypes::get(true);

		// display_fields contains ALL the information we need for the fields in the template
		$display_fields = array();
		foreach ($view_info["fields"] as $view_field_info) {
			$curr_field_id = $view_field_info["field_id"];
			foreach ($form_fields as $form_field_info) {
				if ($form_field_info["field_id"] != $curr_field_id) {
					continue;
				}
				$display_fields[] = array_merge($form_field_info, $view_field_info);
			}
		}

		// first, build the list of information we're going to send to the export type smarty template
		$placeholders = General::getExportFilenamePlaceholderHash();
		$placeholders["export_group_id"] = $export_group_id;
		$placeholders["export_type_id"] = $export_type_id;
		$placeholders["export_group_results"] = $results;
		$placeholders["field_types"] = $field_types;
		$placeholders["same_page"] = CoreGeneral::getCleanPhpSelf();
		$placeholders["display_fields"] = $display_fields;
		$placeholders["submissions"] = $results_info["search_rows"];
		$placeholders["num_results"] = $results_info["search_num_results"];
		$placeholders["view_num_results"] = $results_info["view_num_results"];
		$placeholders["form_info"] = $form_info;
		$placeholders["view_info"] = $view_info;
		$placeholders["timezone_offset"] = Sessions::get("account.timezone_offset");

		// pull out a few things into top level placeholders for easy use
		$placeholders["form_id"] = $form_id;
		$placeholders["form_name"] = $form_info["form_name"];
		$placeholders["form_url"] = $form_info["form_url"];
		$placeholders["view_id"] = $view_id;
		$placeholders["view_name"] = $view_info["view_name"];
		$placeholders["settings"] = Settings::get();

		$export_group_info = ExportGroups::getExportGroup($export_group_id);
		$export_types = ExportTypes::getExportTypes($export_group_id);


		// if the export type ID isn't available, the export group only contains a single (visible) export type
		$export_type_info = array();
		if (empty($export_type_id)) {
			foreach ($export_types as $curr_export_type_info) {
				if ($curr_export_type_info["export_type_visibility"] == "show") {
					$export_type_info = $curr_export_type_info;
					break;
				}
			}
		} else {
			$export_type_info = ExportTypes::getExportType($export_type_id);
		}

		$placeholders["export_group_name"] = CoreGeneral::createSlug(CoreGeneral::evalSmartyString($export_group_info["group_name"]));
		$placeholders["export_group_type"] = CoreGeneral::createSlug(CoreGeneral::evalSmartyString($export_type_info["export_type_name"]));
		$placeholders["page_type"] = $export_group_info["action"]; // "file" / "popup" or "new_window"
		$placeholders["filename"] = CoreGeneral::evalSmartyString($export_type_info["filename"], $placeholders);

		$template = $export_type_info["export_type_smarty_template"];
		$placeholders["export_type_name"] = $export_type_info["export_type_name"];

		$plugin_dirs = array("$root_dir/modules/export_manager/smarty_plugins");
		$export_type_smarty_template = CoreGeneral::evalSmartyString($template, $placeholders, $plugin_dirs);


		// next, add the placeholders needed for the export group smarty template
		$template = $export_group_info["smarty_template"];
		$placeholders["export_group_name"] = CoreGeneral::evalSmartyString($export_group_info["group_name"]);
		$placeholders["export_types"] = $export_types;
		$placeholders["export_type_smarty_template"] = $export_type_smarty_template;

		$placeholders["L"] = $L;
		$page = CoreGeneral::evalSmartyString($template, $placeholders);

		if ($export_group_info["action"] == "new_window" || $export_group_info["action"] == "popup") {

			// if required, send the HTTP headers
			if (!empty($export_group_info["headers"])) {
				$headers = preg_replace("/\r\n|\r/", "\n", $export_group_info["headers"]);
				$header_lines = explode("\n", $headers);
				foreach ($header_lines as $header) {
					header(CoreGeneral::evalSmartyString($header, $placeholders));
				}
			}
			echo $page;

			// create a file on the server
		} else {
			$file_upload_dir = $module_settings["file_upload_dir"];
			$file_upload_url = $module_settings["file_upload_url"];

			$file = "$file_upload_dir/{$placeholders["filename"]}";
			if ($handle = @fopen($file, "w")) {
				fwrite($handle, $page);
				fclose($handle);
				@chmod($file, 0777);

				$placeholders = array("url" => "$file_upload_url/{$placeholders["filename"]}");
				$message = CoreGeneral::evalSmartyString($L["notify_file_generated"], $placeholders);
				echo json_encode(array(
					"success" => 1,
					"message" => $message,
					"target_message_id" => "ft_message"
				));
				exit;
			} else {
				$placeholders = array(
					"url" => "$file_upload_url/{$placeholders["filename"]}",
					"folder" => $file_upload_dir,
					"export_manager_settings_link" => "$root_url/modules/export_manager/settings.php"
				);
				$message = CoreGeneral::evalSmartyString($L["notify_file_not_generated"], $placeholders);
				echo json_encode(array(
					"success" => 0,
					"message" => $message,
					"target_message_id" => "ft_message"
				));
				exit;
			}
		}
	}


	/**
	 * Wrapper methods. This is for convenience: anyone consuming this module can just call:
	 *      $module = Modules::getModuleInstance();
	 * and access the methods here.
	 */
	public function getExportGroups()
	{
		return ExportGroups::getExportGroups();
	}

	public function getExportGroup($export_group_id)
	{
		return ExportGroups::getExportGroup($export_group_id);
	}

	public function getExportTypes($export_group, $only_return_visible)
	{
		return ExportTypes::getExportTypes($export_group, $only_return_visible);
	}

	public function getExportType($export_type_id)
	{
		return ExportTypes::getExportType($export_type_id);
	}

	public function getExportFilenamePlaceholderHash()
	{
		return General::getExportFilenamePlaceholderHash();
	}

	// -----------------------------------------------------------------------------------------------------------------

	// "Content type" setting added to Export Group in 3.1.0 to give Field Types a little more clue about the formatting
	// context of some generated content. Specifically, this lets the File Upload module know whether to output HTML
	// links or plain text URLs depending on export format
	private function addExportGroupContentType()
	{
		$db = Core::$db;

		if (!CoreGeneral::checkDbTableFieldExists("module_export_groups", "content_type")) {
			try {
				$db->query("
					ALTER TABLE {PREFIX}module_export_groups
					ADD content_type VARCHAR(50) NOT NULL AFTER action_button_text
				");
				$db->execute();

				$db->query("
					UPDATE {PREFIX}module_export_groups
					SET content_type = 'text'
				");
				$db->execute();

				// pity, but we don't have a guaranteed way to identify the HTML/Printer-friendly field to set it to
				// "html" so we make an educated guess. Users can always manually change this value within the module
				$db->query("
					UPDATE {PREFIX}module_export_groups
					SET content_type = 'html'
					WHERE group_name = 'HTML / Printer-friendly'
				");
				$db->execute();

			} catch (Exception $e) {
			}
		}
	}

	private function addExportTimeoutSetting()
	{
		$settings = Settings::get("", "export_manager");
		if (!array_key_exists($settings, "export_timeout")) {
			Settings::set(array("export_timeout" => 300), "export_manager");
		}
	}
}
