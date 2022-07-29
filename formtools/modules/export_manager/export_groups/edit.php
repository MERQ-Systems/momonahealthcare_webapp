<?php

require("../../../global/library.php");

use FormTools\Core;
use FormTools\General as CoreGeneral;
use FormTools\Modules;
use FormTools\Modules\ExportManager\ExportGroups;
use FormTools\Modules\ExportManager\ExportTypes;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

$export_group_type_id = "export_group_types";
$page            = Modules::loadModuleField("export_manager", "page", "export_manager_tab", "main");
$export_group_id = Modules::loadModuleField("export_manager", "export_group_id", "export_manager_export_group_id", "export_group_id");

$success = true;
$message = "";
if (isset($request["add_export_type"])) {
    list ($success, $message) = ExportTypes::addExportType($request, $L);
}

$php_self = CoreGeneral::getCleanPhpSelf();
$tabs = array(
    "main" => array(
        "tab_label" => "Main",
        "tab_link"  => "$php_self?page=main&export_group_id=$export_group_id"
    ),
    "permissions" => array(
        "tab_label" => $LANG["word_permissions"],
        "tab_link"  => "$php_self?page=permissions&export_group_id=$export_group_id"
    ),
    "export_types" => array(
        "tab_label" => "Export Types",
        "tab_link"  => "$php_self?page=export_types&export_group_id=$export_group_id",
        "pages" => array("export_types", "add_export_type", "edit_export_type")
    )
);


$links = ExportGroups::getExportGroupPrevNextLinks($export_group_id);
$prev_tabset_link = (!empty($links["prev_id"])) ? "edit.php?page=$page&export_group_id={$links["prev_id"]}" : "";
$next_tabset_link = (!empty($links["next_id"])) ? "edit.php?page=$page&export_group_id={$links["next_id"]}" : "";

$page_vars = array(
    "tabs" => $tabs,
    "samepage" => $php_self,
    "show_tabset_nav_links" => true,
    "prev_tabset_link" => $prev_tabset_link,
    "next_tabset_link" => $next_tabset_link
);

// load the appropriate code pages
switch ($page) {
    case "main":
        require("page_main.php");
        break;
    case "permissions":
        require("page_permissions.php");
        break;
    case "export_types":
        require("page_export_types.php");
        break;
    case "add_export_type":
        require("page_add_export_type.php");
        break;
    case "edit_export_type":
        require("page_edit_export_type.php");
        break;

    default:
        require("page_main.php");
        break;
}
