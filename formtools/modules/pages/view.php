<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\General;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();

$page_id = $request["page_id"];
$page_info = $module->getPage($page_id);

$content = $page_info["content"];
switch ($page_info["content_type"]) {
    case "php":
        ob_start();
        eval($page_info["content"]);
        $content = ob_get_contents();
        ob_end_clean();
        break;

    case "smarty":
        $content = General::evalSmartyString($page_info["content"]);
        break;
}

$page_vars = array(
    "page_id" => $page_id,
    "phrase_edit_page" => $L["phrase_edit_page"],
    "head_title" => "{$L["word_page"]} - {$page_info["heading"]}",
    "page_info" => $page_info,
    "content" => $content
);

$module->displayPage("templates/view.tpl", $page_vars);
