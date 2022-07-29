<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

$tinymce_available = Modules::checkModuleAvailable("field_type_tinymce");

$page_id = isset($request["page_id"]) ? $request["page_id"] : "";

$g_success = true;
$g_message = "";
if (isset($_POST["add_page"])) {
    list($g_success, $g_message, $page_id) = $module->addPage($_POST);
}

if (empty($page_id)) {
    header("location: index.php");
    exit;
}

if (isset($_POST["update_page"])) {
    list($g_success, $g_message) = $module->updatePage($_POST["page_id"], $_POST);
}

$page_info = $module->getPage($page_id);

// this stores the default editor in the page. The values are either "codemirror", "tinymce": all
// code editing is done through one of those editors
$editor = ($page_info["content_type"] == "html" && $page_info["use_wysiwyg"] == "yes") ? "tinymce" : "codemirror";

$page_vars = array(
    "g_success" => $g_success,
    "g_message" => $g_message,
    "head_title" => $L["phrase_edit_page"],
    "page_id" => $page_id,
    "page_info" => $page_info,
    "tinymce_available" => ($tinymce_available ? "yes" : "no")
);

if ($tinymce_available) {
    $page_vars["js_files"] = array("$root_url/modules/field_type_tinymce/tinymce/tinymce.min.js");
}

$page_vars["head_css"] =<<< END
body .mce-ico {
    font-size: 13px;
}
body .mce-btn button {
    padding: 3px 5px 3px 7px;
}
END;

$page_vars["head_js"] =<<< END
if (typeof pages_ns == undefined) {
    var pages_ns = {};
}

pages_ns.current_editor = "$editor";
var rules = [];
rsv.onCompleteHandler = function() {
    $("#use_wysiwyg_hidden").val($("#uwe").attr("checked") ? "yes" : "no");
    ft.select_all(document.pages_form["selected_client_ids[]"]);
    return true;
}
END;

$module->displayPage("templates/edit.tpl", $page_vars);
