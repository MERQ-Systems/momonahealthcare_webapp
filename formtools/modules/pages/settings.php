<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();

$LANG = Core::$L;

if (isset($_POST["update"])) {
    list ($g_success, $g_message) = $module->updateSettings($_POST);
}

$page_vars = array();
$page_vars["head_title"] = "{$L["word_pages"]} - {$LANG["word_settings"]}";
$page_vars["num_pages_per_page"] = Modules::getModuleSettings("num_pages_per_page");

$module->displayPage("templates/settings.tpl", $page_vars);
