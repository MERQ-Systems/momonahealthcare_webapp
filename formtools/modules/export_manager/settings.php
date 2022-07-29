<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Modules\ExportManager\General;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();

$success = true;
$message = "";
if (isset($request["update"])) {
    list ($success, $message) = General::updateSettings($request, $L);
}

$module_settings = Modules::getModuleSettings();
$module_id = Modules::getModuleIdFromModuleFolder("export_manager");

$page_vars = array(
    "g_success" => $success,
    "g_message" => $message,
    "head_title" => "{$L["module_name"]} - {$LANG["word_settings"]}",
    "module_settings" => $module_settings,
    "module_version" => $module->getVersion(),
    "allow_url_fopen" => (ini_get("allow_url_fopen") == "1")
);

$module->displayPage("templates/settings.tpl", $page_vars);
