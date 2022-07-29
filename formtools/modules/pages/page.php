<?php

require("../../global/library.php");

use FormTools\General;
use FormTools\Modules;
use FormTools\Sessions;
use FormTools\Pages;

// this just checks that SOMEONE's logged in - even someone via the Submission Accounts module
$module = Modules::initModulePage("client");

$page_id = $request["id"];
$page_info = $module->getPage($page_id);

// check permissions! The above code handles booting a user out if they're not logged in,
// so the only case we're worried about
$account_type = Sessions::get("account.account_type");
$account_id   = Sessions::get("account.account_id");

$has_permission = true;
if ($account_type == "client") {
    if ($page_info["access_type"] == "admin") {
        $has_permission = false;
    }
    if ($page_info["access_type"] == "private") {
        if (!in_array($account_id, $page_info["clients"])) {
            $has_permission = false;
        }
    }
}

$L = $module->getLangStrings();

// pretty crumby. We need a consistent way to handle in-page errors
if (!$has_permission) {
    $head_title = "";
    $content = "<div class=\"error\"><div style=\"padding: 8px\">" . $L["notify_no_permissions"] . "</div></div>";
    $page_info["heading"] = "Error";
} else {
    $head_title = "{$L["word_page"]} - {$page_info["heading"]}";
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
}

$page_vars = array(
    "page"         => "custom_page",
    "page_id"      => $page_id,
    "phrase_edit_page" => $L["phrase_edit_page"],
    "account_type" => $account_type,
    "page_url"     => Pages::getPageUrl("custom_page"),
    "head_title"   => $head_title,
    "page_info"    => $page_info,
    "content"      => $content
);

$module->displayPage("../../modules/pages/templates/page.tpl", $page_vars);
