<?php

require("../../global/library.php");

use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();

$page_vars = array();
$page_vars["head_title"] = "{$L["module_name"]} - {$L["word_help"]}";

$module->displayPage("templates/help.tpl", $page_vars);
