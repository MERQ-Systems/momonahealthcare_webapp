<?php

/**
 * actions.php
 *
 * This file handles all server-side responses for Ajax requests. All information is returned in JSON
 * format.
 */

require_once("../../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Settings;
use FormTools\Themes;

use FormTools\Modules\SystemCheck\Files;
use FormTools\Modules\SystemCheck\General;
use FormTools\Modules\SystemCheck\Hooks;
use FormTools\Modules\SystemCheck\Tables;
use FormTools\Modules\SystemCheck\Orphans;

$module = Modules::initModulePage("admin");

// the action to take and the ID of the page where it will be displayed (allows for
// multiple calls on same page to load content in unique areas)
$request = array_merge($_GET, $_POST);
$action = $request["action"];
$settings = Settings::get();
$root_dir = Core::getRootDir();

switch ($action) {

	// Stage 1 of the Table Verification test: returns a list of tables to test for a particular component
	case "get_component_tables":
		$component = $request["component"];

		// N.B. from 2.1.5 onwards, the Core stores its own DB structure
		if ($component == "core") {
			require_once("$root_dir/global/misc/config_core.php");
			$tables = array_merge(array("FORM TOOLS CORE", "core"), Tables::getComponentTables($STRUCTURE));
		} else {
			$module_info = Modules::getModule($request["component"]); // $request["component"] is just the module ID
			$module_config = General::getModuleConfigFileContents($module_info["module_folder"]);
			$tables = array_merge(array($module_info["module_name"], $request["component"]), Tables::getComponentTables($module_config["tables"]));
		}
		echo json_encode(array("tables" => $tables));
		break;

	// Stage 2 of the Table Verification test: verifies the table structure
	case "verify_table":
		$component = $request["component"];
		if ($component == "core") {
			require_once("$root_dir/global/misc/config_core.php");
			$info = Tables::checkComponentTable($STRUCTURE, $request["table_name"]);
			$info["table_name"] = $request["table_name"];
			echo json_encode($info);
		} else {
			$module_info = Modules::getModule($request["component"]); // $request["component"] is just the module ID
			$module_config = General::getModuleConfigFileContents($module_info["module_folder"]);
			$info = Tables::checkComponentTable($module_config["tables"], $request["table_name"]);
			$info["table_name"] = $request["table_name"];
			echo json_encode($info);
		}
		break;

	// verifies the hooks for a particular module. This is much simpler than the table test. It just examines each module's hooks
	// in a single step and returns the result
	case "verify_module_hooks":
		$module_id = $request["module_id"];
		$module_info = Modules::getModule($module_id);
		$module_folder = $module_info["module_folder"];
		$module_version = $module_info["version"];
		list ($result, $extra_info) = Hooks::verifyModuleHooks($module_folder);

		echo json_encode(array(
			"module_id" => $module_id,
			"module_folder" => $module_folder,
			"module_name" => $module_info["module_name"],
			"result" => $result,
			"extra" => $extra_info
		));
		break;

	case "verify_component_files":
		$component = $request["component"];

		$return_info = array("result" => "pass");
		if ($component == "core") {
			$missing_files = Files::checkCoreFiles();
			$return_info["component_type"] = "core";
			$return_info["component_name"] = "Form Tools Core";
		}
		if (preg_match("/^module_/", $component)) {
			$module_id = preg_replace("/^module_/", "", $component);
			$module_info = Modules::getModule($module_id);
			$missing_files = Files::checkModuleFiles($module_info["module_folder"]);
			$return_info["component_type"] = "module";
			$return_info["component_name"] = $module_info["module_name"];
		}
		if (preg_match("/^theme_/", $component)) {
			$theme_id = preg_replace("/^theme_/", "", $component);
			$theme_info = Themes::getTheme($theme_id);
			$missing_files = Files::checkThemeFiles($theme_info["theme_folder"]);
			$return_info["component_type"] = "theme";
			$return_info["component_name"] = $theme_info["theme_name"];
		}
		if (!empty($missing_files)) {
			$return_info["result"] = "fail";
			$return_info["missing_files"] = $missing_files;
		}
		echo json_encode($return_info);
		break;

	case "find_table_orphans":
		$remove_orphans = isset($request["remove_orphans"]) ? true : false;
		$results = Orphans::findTableOrphans($request["table_name"], $remove_orphans);
		echo json_encode($results);
		break;
}


