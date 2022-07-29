<?php

require("../../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Modules\ExportManager\General;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

$page_vars = array(
    "icons" => General::getExportIcons(),
    "head_title" => "{$L["module_name"]} - {$L["phrase_add_export_group"]}"
);

$page_vars["head_js"] =<<< END
var rules = [];
rules.push("required,group_name,{$L["validation_no_export_group_name"]}");
END;

$module->displayPage("templates/export_groups/add.tpl", $page_vars);
