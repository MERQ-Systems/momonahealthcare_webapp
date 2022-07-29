<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\General;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

$success = true;
$message = "";
if (isset($request["reset_field_type"])) {
	list($success, $message) = $module->resetModule();
}

$page = array(
	"g_success" => $success,
	"g_message" => $message,
	"intro_desc" => General::evalSmartyString($L["text_intro_desc"], array("link" => "$root_url/admin/settings/index.php?page=files"))
);

$module->displayPage("templates/index.tpl", $page);
