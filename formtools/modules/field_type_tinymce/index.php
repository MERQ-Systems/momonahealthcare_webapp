<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\FieldTypes;
use FormTools\Modules;

$module = Modules::initModulePage("admin");

$success = true;
$message = "";
if (isset($_POST["update"])) {
    list($success, $message) = $module->updateSettings($_POST);
}

$tinymce_field_type = FieldTypes::getFieldTypeByIdentifier("tinymce");

// convert the settings into a friendlier format for extraction by the page
$settings = array();
foreach ($tinymce_field_type["settings"] as $setting_info) {
    $settings[$setting_info["field_setting_identifier"]] = $setting_info["default_value"];
}

$page_vars = array();
$page_vars["g_success"] = $success;
$page_vars["g_message"] = $message;
$page_vars["module_settings"] = $settings;
$page_vars["head_css"] =<<< END
body .mce-ico {
    font-size: 13px;
}
body .mce-btn button {
    padding: 3px 5px 3px 7px;
}
END;

$page_vars["head_js"] =<<< END
$(function() {

    $("input, select").bind("change", update_editor);
    update_editor(true);

    // changes a toolbar for a particular textarea
    function update_editor(is_initializing) {
        var settings = {
            selector: "#example",
            skin: "lightgray",
            branding: false,
            menubar: false,
            elementpath: false
        };

        if ($("input[name=resizing]:checked").val() == "yes") {
            settings.statusbar = true;
            settings.resize = true;
        } else {
            settings.statusbar = false;
            settings.resize = false;
        }

        var toolbar = $("#toolbar").val();
        switch (toolbar) {
            case "basic":
                settings.toolbar = [
                    'bold italic underline strikethrough | bullist numlist'
                ];
                break;
            case "simple":
                settings.toolbar = [
                    'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | link unlink forecolor backcolor'
                ];
                settings.plugins = 'hr link textcolor lists';
                break;
            case "advanced":
                settings.toolbar = [
                    'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | undo redo link unlink | fontselect fontsizeselect | forecolor backcolor | subscript superscript code'
                ];
                settings.plugins = 'hr link textcolor lists code';
                break;
            case "expert":
                settings.toolbar = [
                    'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | undo redo link unlink | forecolor backcolor | formatselect fontselect fontsizeselect | subscript superscript | newdocument charmap removeformat cleanup code'
                ];
                settings.plugins = 'hr link textcolor lists code';
                break;
        }
        
        if (is_initializing === true) {
            tinymce.init(settings);
        } else {
            tinymce.remove();
            tinymce.init(settings);
        }
    }
});
END;

$module->displayPage("templates/index.tpl", $page_vars);
