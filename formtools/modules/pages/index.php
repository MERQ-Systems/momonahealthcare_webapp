<?php

require_once("../../global/library.php");

use FormTools\General;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();

if (isset($_GET["delete"])) {
    list($g_success, $g_message) = $module->deletePage($_GET["delete"]);
}

$page = Modules::loadModuleField("pages", "page", "module_pages_page", 1);
$num_pages_per_page = Modules::getModuleSettings("num_pages_per_page");
$pages_info = $module->getPages($num_pages_per_page, $page);

$results     = $pages_info["results"];
$num_results = $pages_info["num_results"];

$text_intro_para_2 = General::evalSmartyString($L["text_intro_para_2"], array("url" => "../../admin/settings/index.php?page=menus"));

$page_vars = array(
    "pages" => $results,
    "head_title" => $L["module_name"],
    "pagination" => General::getPageNav($num_results, $num_pages_per_page, $page, "", "page"),
    "js_messages" => array("word_edit", "phrase_please_confirm", "word_yes", "word_no"),
    "module_js_messages" => array("confirm_delete_page"),
    "text_intro_para_2" => $text_intro_para_2
);

$module->displayPage("templates/index.tpl", $page_vars);
