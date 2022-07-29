<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\General;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();

$page = Modules::loadModuleField("swift_mailer", "page", "tab", "settings");
$php_self = General::getCleanPhpSelf();
$tabs = array(
    "settings" => array(
        "tab_label" => $LANG["word_settings"],
        "tab_link" => "$php_self?page=settings"
    ),
    "test" => array(
        "tab_label" => $L["word_test"],
        "tab_link" => "$php_self?page=test"
    )
);

// load the appropriate code page
if ($page === "test") {
    require_once("tab_test.php");
} else {
    require_once("tab_settings.php");
}
