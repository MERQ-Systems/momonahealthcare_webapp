<?php


namespace FormTools\Modules\FieldTypeFile;

use FormTools\Core;
use FormTools\FieldTypes;
use FormTools\Hooks as CoreHooks;
use FormTools\Module as FormToolsModule;
use PDO;


class Module extends FormToolsModule
{
	protected $moduleName = "File Upload";
	protected $moduleDesc = "File upload fields for your Form Tools forms.";
	protected $author = "Ben Keen";
	protected $authorEmail = "ben.keen@gmail.com";
	protected $authorLink = "https://formtools.org";
	protected $version = "2.2.4";
	protected $date = "2019-04-27";
	protected $originLanguage = "en_us";

	protected $nav = array(
		"module_name" => array("index.php", false)
	);

	public function install($module_id)
	{
		$db = Core::$db;
		$LANG = Core::$L;

		// check it's not already installed (i.e. check for the unique field type identifier)
		$field_type_info = FieldTypes::getFieldTypeIdByIdentifier("file");
		if (!empty($field_type_info)) {
			return array(false, $LANG["notify_module_already_installed"]);
		}

		// find the FIRST field type group. Most installations won't have the Custom Fields module installed so
		// the last group will always be "Special Fields". For installations that DO, and that it's been customized,
		// the user can always move this new field type to whatever group they want. Plus, this module will be
		// installed by default, so it's almost totally moot
		$db->query("
            SELECT group_id
            FROM   {PREFIX}list_groups
            WHERE  group_type = 'field_types'
            ORDER BY list_order ASC
            LIMIT 1
        ");
		$db->execute();

		// assumption: there's at least one field type group
		$group_id = $db->fetch(PDO::FETCH_COLUMN);

		// now find out how many field types there are in the group so we can add the row with the correct list order
		$db->query("SELECT count(*) FROM {PREFIX}field_types WHERE group_id = :group_id");
		$db->bind("group_id", $group_id);
		$db->execute();

		$next_list_order = $db->fetch(PDO::FETCH_COLUMN) + 1;

		$field_type_id = Settings::addFieldType($module_id, $group_id, $next_list_order);
		Settings::installOrUpdateFieldTypeSettings($field_type_id);

		// lastly, add our hooks
		$this->resetHooks();

		return array(true, "");
	}


	/**
	 * Uninstallation completely removes the field type. It also changes the field type ID from any file fields
	 * to a generic text field.
	 * @param $module_id
	 * @return array
	 */
	public function uninstall($module_id)
	{
		$field_type_info = FieldTypes::getFieldTypeByIdentifier("file");

		if (!empty($field_type_info)) {
			FieldTypes::deleteFieldType("file", "textbox");
		}

		return array(true, "");
	}


	public function upgrade($module_id, $old_module_version)
	{
		$this->resetModule();
	}


	public function resetModule()
	{
		$L = $this->getLangStrings();

		Settings::updateFieldType();

		$field_type_info = FieldTypes::getFieldTypeByIdentifier("file");
		Settings::installOrUpdateFieldTypeSettings($field_type_info["field_type_id"]);
		$this->resetHooks();

		return array(true, $L["notify_field_type_reset"]);
	}


	/**
	 * Called on installation and upgrades.
	 */
	public function resetHooks()
	{
		CoreHooks::unregisterModuleHooks("field_type_file");

		CoreHooks::registerHook("code", "field_type_file", "manage_files", "FormTools\\Submissions::updateSubmission", "updateSubmissionHook", 50, true);
		CoreHooks::registerHook("code", "field_type_file", "manage_files", "FormTools\\Submissions::processFormSubmission", "processFormSubmissionHook", 50, true);
		CoreHooks::registerHook("code", "field_type_file", "manage_files", "FormTools\\API->processFormSubmission", "apiProcessFormSubmissionHook", 50, true);
		CoreHooks::registerHook("code", "field_type_file", "start", "FormTools\\Files::deleteSubmissionFiles", "deleteSubmissionsHook", 50, true);
		CoreHooks::registerHook("code", "field_type_file", "start", "FormTools\\Fields::getUploadedFiles", "getUploadedFilesHook", 50, true);
		CoreHooks::registerHook("template", "field_type_file", "head_bottom", "", "includeJs");
		CoreHooks::registerHook("template", "field_type_file", "standalone_form_fields_head_bottom", "", "includeStandaloneJs");
	}


	// ----------------------------------------------------------------------------------------------------------------

	// hooks

	public function updateSubmissionHook($params)
	{
		$L = $this->getLangStrings();
		return Hooks::updateSubmissionHook($params, $L);
	}

	public function deleteFilesFromField($form_id, $submission_id, $field_id, $files, $force_delete = false)
	{
		$L = $this->getLangStrings();
		return Hooks::deleteFilesFromField($form_id, $submission_id, $field_id, $files, $force_delete, $L);
	}

	public function includeJs($template, $page_data)
	{
		$L = $this->getLangStrings();
		Hooks::includeJs($page_data["page"], $L);
	}

	public function includeStandaloneJs()
	{
		$L = $this->getLangStrings();
		Hooks::includeStandaloneJs($L);
	}

	public function processFormSubmissionHook($params)
	{
		$L = $this->getLangStrings();
		return Hooks::processFormSubmissionHook($params, $L);
	}

	public function apiProcessFormSubmissionHook($params)
	{
		$L = $this->getLangStrings();
		return Hooks::apiProcessFormSubmissionHook($params, $L);
	}

	public function deleteSubmissionsHook($params)
	{
		$L = $this->getLangStrings();
		return Hooks::deleteSubmissionsHook($params, $L);
	}

	public function getUploadedFilesHook($params)
	{
		return Hooks::getUploadedFilesHook($params);
	}
}
