<?php

use FormTools\Forms;
use FormTools\Modules\ExportManager\ExportGroups;

$success = true;
$message = "";
if (isset($request["update_permissions"])) {
    list ($success, $message) = ExportGroups::updateExportGroupPermissions($request, $L);
}

$forms = Forms::getFormViewList();
$export_group_info = ExportGroups::getExportGroup($export_group_id);
$mappings = ExportGroups::deserializedExportGroupMapping($export_group_info["forms_and_views"]);

$page_vars["page"] = "permissions";
$page_vars["g_success"] = $success;
$page_vars["g_message"] = $message;
$page_vars["forms"] = $forms;
$page_vars["selected_form_ids"] = $mappings["form_ids"];
$page_vars["selected_view_ids"] = $mappings["view_ids"];
$page_vars["export_group_id"] = $export_group_id;
$page_vars["export_group_info"] = $export_group_info;
$page_vars["head_title"] = "{$L["module_name"]} - {$LANG["word_permissions"]}";
$page_vars["head_js"] =<<< EOF

$(function() {
  $("input[name=access_type]").bind("click change", function() {
    var form_type = this.value;
    if (form_type == "private") {
      $("#custom_clients").show();
    } else {
      $("#custom_clients").hide();
    }
  });

  $("input[name=form_view_mapping]").bind("click change", function() {
    var form_type = this.value;
    if (form_type == "all") {
      $("#custom_forms").hide();
    } else {
      $("#custom_forms").show();
    }
  });

  $(".form_ids").bind("click", function() {
    var form_id = this.value;
    if (this.checked) {
      $("#f" + form_id + "_views").show();
    } else {
      $("#f" + form_id + "_views").hide();
    }
  });

  $(".view_ids").bind("click", function() {
    var view_id = this.value;
    if ($(this).hasClass("all_views")) {
      if (this.checked) {
        $(this).closest("ul").find(".view_ids").not(".all_views").attr({ checked: "", disabled: "disabled" });
      } else {
        $(this).closest("ul").find(".view_ids").not(".all_views").attr({ disabled: "" });
      }
    }
  });

  $("form").bind("submit", function() {
    ft.select_all("selected_client_ids[]");
  });
});
EOF;

$module->displayPage("templates/export_groups/edit.tpl", $page_vars);
