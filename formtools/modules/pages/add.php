<?php

require("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

// if the user has the tinyMCE field module installed, offer the option of editing the pages with it
$tinymce_available = Modules::checkModuleAvailable("field_type_tinymce");

$page_vars = array(
    "head_title" => $L["phrase_add_page"],
    "tinymce_available" => ($tinymce_available ? "yes" : "no"),
);

$editor = "codemirror";
if ($tinymce_available) {
    $page_vars["js_files"] = array("$root_url/modules/field_type_tinymce/tinymce/tinymce.min.js");
    $editor = "tinymce";
}

$page_vars["head_css"] =<<< END
body .mce-ico {
    font-size: 13px;
}
body .mce-btn button {
    padding: 3px 5px 3px 7px;
}
END;

$page_vars["head_js"] =<<< EOF
if (typeof pages_ns == undefined) {
  var pages_ns = {};
}

pages_ns.current_editor = "$editor";
var rules = [];
rsv.onCompleteHandler = function() {
  $("#use_wysiwyg_hidden").val($("#uwe").attr("checked") ? "yes" : "no");
  ft.select_all("selected_client_ids[]");
  return true;
}
EOF;

$module->displayPage("templates/add.tpl", $page_vars);
