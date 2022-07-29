<?php


namespace FormTools\Modules\Pages;

use FormTools\Core;
use FormTools\General;
use FormTools\Hooks;
use FormTools\Menus;
use FormTools\Module as FormToolsModule;
use FormTools\Modules;
use FormTools\Pages as CorePages;
use PDO, Exception;


class Module extends FormToolsModule
{
	protected $moduleName = "Pages";
	protected $moduleDesc = "This module lets you define your own custom pages to link to from within the Form Tools UI. This lets you to add help pages, client splash pages or any other custom information.";
	protected $author = "Ben Keen";
	protected $authorEmail = "ben.keen@gmail.com";
	protected $authorLink = "https://formtools.org";
	protected $version = "2.0.7";
	protected $date = "2019-03-17";
	protected $originLanguage = "en_us";
	protected $jsFiles = array(
		"{FTROOT}/global/codemirror/lib/codemirror.js",
		"{FTROOT}/global/codemirror/mode/xml/xml.js",
		"{FTROOT}/global/codemirror/mode/php/php.js",
		"{FTROOT}/global/codemirror/mode/smarty/smarty.js",
		"{FTROOT}/global/codemirror/mode/htmlmixed/htmlmixed.js",
		"{FTROOT}/global/codemirror/mode/css/css.js",
		"{FTROOT}/global/codemirror/mode/javascript/javascript.js",
		"{FTROOT}/global/codemirror/mode/clike/clike.js",
		"{MODULEROOT}/scripts/pages.js"
	);
	protected $cssFiles = array(
		"{FTROOT}/global/codemirror/lib/codemirror.css",
	);

	protected $nav = array(
		"word_pages" => array("index.php", false),
		"phrase_add_page" => array("add.php", true),
		"word_settings" => array("settings.php", false),
		"word_help" => array("help.php", false)
	);

	public function __construct()
	{
		parent::__construct(Core::$user->getLang());
		CorePages::registerPage("custom_page", "/modules/pages/page.php");
	}

	/**
	 * The installation script for the Pages module. This creates the module_pages database table.
	 */
	public function install($module_id)
	{
		$db = Core::$db;

		$queries = array();
		$queries[] = "
            CREATE TABLE {PREFIX}module_pages (
                page_id mediumint(8) unsigned NOT NULL auto_increment,
                page_name varchar(50) NOT NULL,
                access_type enum('admin','public','private') NOT NULL default 'admin',
                content_type enum('html','php','smarty') NOT NULL default 'html',
                use_wysiwyg enum('yes','no') NOT NULL default 'yes',
                heading varchar(255) default NULL,
                content text,
                PRIMARY KEY (page_id)
            ) DEFAULT CHARSET=utf8
        ";

		$queries[] = "
            CREATE TABLE IF NOT EXISTS {PREFIX}module_pages_clients (
                page_id mediumint(9) unsigned NOT NULL,
                client_id mediumint(9) unsigned NOT NULL,
                PRIMARY KEY (page_id, client_id)
            ) DEFAULT CHARSET=utf8
        ";

		$queries[] = "INSERT INTO {PREFIX}settings (setting_name, setting_value, module) VALUES ('num_pages_per_page', '10', 'pages')";

		$success = true;
		$message = "";
		try {
			foreach ($queries as $query) {
				$db->query($query);
				$db->execute();
			}
		} catch (Exception $e) {
			$L = $this->getLangStrings();
			$success = false;
			$message = General::evalSmartyString($L["notify_problem_installing"], array("error" => $e->getMessage()));
		}

		$this->resetHooks();

		return array($success, $message);
	}


	/**
	 * The uninstallation script for the Pages module. This basically does a little clean up
	 * on the database to ensure it doesn't leave any footprints. Namely:
	 *   - the module_pages table is removed
	 *   - any references in client or admin menus to any Pages are removed
	 *   - if the default login page for any user account was a Page, it attempts to reset it to
	 *     a likely login page (the Forms page for both).
	 *
	 * The message returned by the script informs the user the module has been uninstalled, and warns them
	 * that any references to any of the Pages in the user accounts has been removed.
	 *
	 * @return array [0] T/F, [1] success message
	 */
	public function uninstall($module_id)
	{
		$db = Core::$db;

		$success = true;

		try {
			$db->query("SELECT page_id FROM {PREFIX}module_pages");
			$db->execute();
			$rows = $db->fetchAll();

			foreach ($rows as $row) {
				$page_id = $row["page_id"];
				$db->query("DELETE FROM {PREFIX}menu_items WHERE page_identifier = :page_identifier");
				$db->bind("page_identifier", "page_{$page_id}");
				$db->execute();
			}

			// delete the Pages module tables
			$db->query("DROP TABLE {PREFIX}module_pages");
			$db->execute();

			$db->query("DROP TABLE {PREFIX}module_pages_clients");
			$db->execute();

			// update sessions in case a Page was in the administrator's account menu
			Menus::cacheAccountMenu(Core::$user->getAccountId());

			$db->query("DELETE FROM {PREFIX}settings WHERE module = 'pages'");

			$L = $this->getLangStrings();
			$message = $L["notify_module_uninstalled"];

		} catch (Exception $e) {
			$success = false;
			$message = $e->getMessage();
		}

		return array($success, $message);
	}


	public function upgrade($module_id, $old_module_version)
	{
		$this->resetHooks();
	}


	public function resetHooks()
	{
		$this->clearHooks();
		Hooks::registerHook("code", "pages", "middle", "FormTools\\Menus::getAdminMenuPagesDropdown", "addPagesMenuItems", 20, true);
		Hooks::registerHook("code", "pages", "middle", "FormTools\\Menus::getClientMenuPagesDropdown", "addPagesMenuItems", 20, true);
	}


	/**
	 * Updates the setting on the Settings page.
	 *
	 * @param array $info
	 * @return array [0] true/false
	 *               [1] message
	 */
	public function updateSettings($info)
	{
		$L = $this->getLangStrings();

		Modules::setModuleSettings(array(
			"num_pages_per_page" => $info["num_pages_per_page"]
		));

		return array(true, $L["notify_settings_updated"]);
	}


	/**
	 * Adds a new page to the module_pages table.
	 *
	 * @param array $info
	 * @return array standard return array
	 */
	public function addPage($info)
	{
		$db = Core::$db;
		$L = $this->getLangStrings();

		$content_type = $info["content_type"];
		$access_type = $info["access_type"];
		$use_wysiwyg = $info["use_wysiwyg_hidden"];

		$content = $info["codemirror_content"];
		if ($content_type == "html" && $use_wysiwyg == "yes") {
			$content = $info["wysiwyg_content"];
		}

		$success = true;
		$message = $L["notify_page_added"];
		$page_id = "";

		try {
			$db->query("
                INSERT INTO {PREFIX}module_pages (page_name, content_type, access_type, use_wysiwyg, heading, content)
                VALUES (:page_name, :content_type, :access_type, :use_wysiwyg, :heading, :content)
            ");
			$db->bindAll(array(
				"page_name" => $info["page_name"],
				"content_type" => $content_type,
				"access_type" => $access_type,
				"use_wysiwyg" => $use_wysiwyg,
				"heading" => $info["heading"],
				"content" => $content
			));
			$db->execute();

			$page_id = $db->getInsertId();

			if ($access_type == "private" && isset($info["selected_client_ids"])) {
				foreach ($info["selected_client_ids"] as $client_id) {
					$db->query("
                        INSERT INTO {PREFIX}module_pages_clients (page_id, client_id)
                        VALUES (:page_id, :client_id)
                    ");
					$db->bindAll(array(
						"page_id" => $page_id,
						"client_id" => $client_id
					));
					$db->execute();
				}
			}
		} catch (Exception $e) {
			$success = false;
			$message = $L["notify_page_not_added"];
		}

		return array($success, $message, $page_id);
	}


	/**
	 * Deletes a page.
	 *
	 * TODO: delete this page from any menus.
	 *
	 * @param integer $page_id
	 */
	public function deletePage($page_id)
	{
		$db = Core::$db;
		$L = $this->getLangStrings();

		if (empty($page_id) || !is_numeric($page_id)) {
			return array(false, "");
		}

		$db->query("DELETE FROM {PREFIX}module_pages WHERE page_id = :page_id");
		$db->bind("page_id", $page_id);
		$db->execute();

		$db->query("
            DELETE FROM {PREFIX}menu_items
            WHERE page_identifier = :page_identifier
        ");
		$db->bind("page_identifier", "page_{$page_id}");
		$db->execute();

		// this is dumb, but better than nothing. If we just updated any menus, re-cache the admin menu just in case
		if ($db->numRows() > 0) {
			Menus::cacheAccountMenu(1);
		}

		return array(true, $L["notify_delete_page"]);
	}


	/**
	 * Returns all information about a particular Page.
	 *
	 * @param integer $page_id
	 * @return array
	 */
	public function getPage($page_id)
	{
		$db = Core::$db;

		$db->query("SELECT * FROM {PREFIX}module_pages WHERE page_id = :page_id");
		$db->bind("page_id", $page_id);
		$db->execute();

		$page_info = $db->fetch();

		$db->query("SELECT client_id FROM {PREFIX}module_pages_clients WHERE page_id = :page_id");
		$db->bind("page_id", $page_id);
		$db->execute();

		$page_info["clients"] = $db->fetchAll(PDO::FETCH_COLUMN);

		return $page_info;
	}


	/**
	 * Returns a page worth of Pages from the Pages module.
	 *
	 * @param mixed $num_per_page a number or "all"
	 * @param integer $page_num
	 * @return array
	 */
	public function getPages($num_per_page, $page_num = 1)
	{
		$db = Core::$db;

		if ($num_per_page == "all") {
			$db->query("SELECT * FROM {PREFIX}module_pages ORDER BY heading");
		} else {

			// determine the offset
			if (empty($page_num)) {
				$page_num = 1;
			}
			$first_item = ($page_num - 1) * $num_per_page;

			$db->query("SELECT * FROM {PREFIX}module_pages ORDER BY heading LIMIT $first_item, $num_per_page");
		}
		$db->execute();
		$results = $db->fetchAll();

		$db->query("SELECT count(*) FROM {PREFIX}module_pages");
		$db->execute();

		return array(
			"results" => $results,
			"num_results" => $db->fetch(PDO::FETCH_COLUMN)
		);
	}


	public function updatePage($page_id, $info)
	{
		$db = Core::$db;
		$L = $this->getLangStrings();

		$content_type = $info["content_type"];
		$use_wysiwyg = $info["use_wysiwyg_hidden"];
		$access_type = $info["access_type"];

		$content = $info["codemirror_content"];
		if ($content_type == "html" && $use_wysiwyg == "yes") {
			$content = $info["wysiwyg_content"];
		}

		$db->query("
            UPDATE {PREFIX}module_pages
            SET    page_name = :page_name,
                   content_type = :content_type,
                   access_type = :access_type,
                   use_wysiwyg = :use_wysiwyg,
                   heading = :heading,
                   content = :content
            WHERE  page_id = :page_id
        ");
		$db->bindAll(array(
			"page_name" => $info["page_name"],
			"content_type" => $content_type,
			"access_type" => $access_type,
			"use_wysiwyg" => $use_wysiwyg,
			"heading" => $info["heading"],
			"content" => $content,
			"page_id" => $page_id
		));
		$db->execute();

		$db->query("DELETE FROM {PREFIX}module_pages_clients WHERE page_id = :page_id");
		$db->bind("page_id", $page_id);
		$db->execute();

		if ($access_type == "private" && isset($info["selected_client_ids"])) {
			foreach ($info["selected_client_ids"] as $client_id) {
				$db->query("INSERT INTO {PREFIX}module_pages_clients (page_id, client_id) VALUES (:page_id, :client_id)");
				$db->bindAll(array(
					"page_id" => $page_id,
					"client_id" => $client_id
				));
				$db->execute();
			}
		}

		return array(true, $L["notify_page_updated"]);
	}

	public function addPagesMenuItems($params)
	{
		$L = $this->getLangStrings();

		$pages_info = $this->getPages("all");
		$pages = $pages_info["results"];

		$select_lines = $params["select_lines"];

		if (count($pages) > 0) {
			$select_lines[] = array(
				"type" => "optgroup_open",
				"label" => $L["phrase_pages_module"]
			);
			foreach ($pages as $page) {
				$page_id = $page["page_id"];
				$page_name = $page["page_name"];
				$select_lines[] = array(
					"type" => "option",
					"k" => "page_{$page_id}",
					"v" => "$page_name"
				);
			}
			$select_lines[] = array("type" => "optgroup_close");
		}

		return array(
			"select_lines" => $select_lines
		);
	}
}
