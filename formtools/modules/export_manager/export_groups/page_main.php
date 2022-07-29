<?php

use FormTools\Modules\ExportManager\ExportGroups;
use FormTools\Modules\ExportManager\General;

$success = true;
$message = "";
if (isset($request["update_export_group"])) {
    list ($success, $message) = ExportGroups::updateExportGroup($request, $L);
}

$export_group = ExportGroups::getExportGroup($export_group_id);

$page_vars["g_success"] = $success;
$page_vars["g_message"] = $message;
$page_vars["export_group_info"] = $export_group;
$page_vars["page"] = "main";
$page_vars["icons"] = General::getExportIcons();
$page_vars["head_title"] = "{$L["module_name"]} - {$L["phrase_edit_export_group"]}";
$page_vars["head_js"] =<<< END
var page_ns = {};
page_ns.change_action_type = function(action_type) {
  if (action_type == "file") {
    $("#headers").attr("disabled", "disabled");
  } else {
    $("#headers").attr("disabled", "");
  }
}

var rules = [];
rules.push("required,group_name,Please enter the export group name.");
rules.push("if:action=popup,required,popup_height,Please enter the popup height.");
rules.push("if:action=popup,required,popup_width,Please enter the popup width.");
END;

$module->displayPage("templates/export_groups/edit.tpl", $page_vars);
