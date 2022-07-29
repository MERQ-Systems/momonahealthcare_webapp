<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Modules\ExportManager\ExportGroups;

$module = Modules::initModulePage("admin");
$LANG = Core::$L;
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

$sortable_id = "export_group_list";

$success = true;
$message = "";
if (isset($request["add_export_group"])) {
    list ($success, $message) = ExportGroups::addExportGroup($request, $L);
}
if (isset($request["delete"])) {
    list ($success, $message) = ExportGroups::deleteExportGroup($request["delete"], $L);
}
if (isset($request["update"])) {
    $request["sortable_id"] = $sortable_id;
    list ($success, $message) = ExportGroups::reorderExportGroups($request, $L);
}

$export_groups = ExportGroups::getExportGroups();

$page_vars = array(
    "g_success" => $success,
    "g_message" => $message,
    "export_groups" => $export_groups,
    "sortable_id" => $sortable_id,
    "js_files" => array("$root_url/global/scripts/sortable.js")
);

$page_vars["head_js"] =<<< EOF
var page_ns = {};
page_ns.dialog = $("<div></div>");

page_ns.delete_export_group = function(el) {
  ft.create_dialog({
    dialog:     page_ns.dialog,
    title:      "{$LANG["phrase_please_confirm"]}",
    content:    "{$L["confirm_delete_export_group"]}",
    popup_type: "warning",
    buttons: [{
      text: "{$LANG["word_yes"]}",
      click: function() {
        var export_group_id = $(el).closest(".row_group").find(".sr_order").val();
        window.location = "index.php?delete=" + export_group_id;
      }
    },
    {
      text: "{$LANG["word_no"]}",
      click: function() {
        $(this).dialog("close");
      }
    }]
  });
  return false;
}
EOF;

$module->displayPage("templates/index.tpl", $page_vars);
