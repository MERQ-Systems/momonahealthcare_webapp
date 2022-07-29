<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\General;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();

$page = Modules::loadModuleField("system_check", "page", "page", "summary");
$root_url = Core::getRootUrl();
$same_page = General::getCleanPhpSelf();

$page_vars = array(
    "page" => $page,
    "tabs" => array(
        "summary" => array(
            "tab_label" => $L["word_summary"],
            "tab_link" => "{$same_page}?page=summary",
            "pages" => array("summary")
        ),
        "phpinfo" => array(
            "tab_label" => "phpinfo",
            "tab_link" => "{$same_page}?page=phpinfo",
            "pages" => array("phpinfo")
        )
    )
);

if ($page === "phpinfo") {
    $module->displayPage("templates/env.tpl", $page_vars);
} else {
    require_once("env_tab_summary.php");
}
