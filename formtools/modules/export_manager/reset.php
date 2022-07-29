<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();

$success = true;
$message = "";
if (isset($request["reset"])) {
    list($success, $message) = $module->resetData();
}

$page_vars = array(
    "g_success" => $success,
    "g_message" => $message,
    "head_title" => "{$L["module_name"]} - {$L["phrase_reset_defaults"]}"
);

$module->displayPage("templates/reset.tpl", $page_vars);
