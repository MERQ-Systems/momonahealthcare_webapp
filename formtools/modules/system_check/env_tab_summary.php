<?php

use FormTools\Core;
use FormTools\Modules;
use FormTools\Settings;
use FormTools\Themes;

$settings = Settings::get();

$php_version = PHP_VERSION;
$mysql_version = Core::$db->getMysQLVersion();
$suhosin_installed   = (extension_loaded("suhosin")) ? $L["word_installed"] : $L["phrase_not_installed"];
$sessions_available  = (extension_loaded("session")) ? $L["word_available"] : $L["phrase_not_available"];
$curl_available      = (extension_loaded("curl")) ? $L["word_available"] : $L["phrase_not_available"];
$simplexml_available = (extension_loaded("simpleXML")) ? $L["word_available"] : $L["phrase_not_available"];

$page_vars["env_info"] = array(
    "php_version"         => $php_version,
    "mysql_version"       => $mysql_version,
    "suhosin_installed"   => $suhosin_installed,
    "sessions_available"  => $sessions_available,
    "curl_available"      => $curl_available,
    "simpleXML_available" => $simplexml_available
);

$module_list = array();
foreach (Modules::getList() as $module_info) {
	$is_enabled = ucwords($module_info["is_enabled"]);
	$module_list[] = "{$module_info["module_name"]}, {$module_info["version"]}, $is_enabled";
}
$module_list_str = implode("\n", $module_list);

$theme_list = array();
foreach (Themes::getList() as $theme_info) {
	$is_enabled = ucwords($theme_info["is_enabled"]);
	$theme_list[] = "{$theme_info["theme_name"]}, {$theme_info["theme_version"]}, $is_enabled";
}
$theme_list_str = implode("\n", $theme_list);

$report_card =<<< END
Form Tools Core Version: {$settings["program_version"]}
Core Version Upgrade Track: {$settings["core_version_upgrade_track"]}
API Version: {$settings["api_version"]}
PHP Version: $php_version
MySQL Version: $mysql_version
PHP Sessions: $sessions_available
Suhosin Extension: $suhosin_installed
Curl Extension: $sessions_available
SimpleXML Extension: $simplexml_available
____________________________________
MODULES (name, version, enabled)
$module_list_str
____________________________________
THEMES (name, version, enabled)
$theme_list_str

END;

$page_vars["report_card"] = $report_card;

$module->displayPage("templates/env.tpl", $page_vars);
