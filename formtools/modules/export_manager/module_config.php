<?php

$STRUCTURE = array();
$STRUCTURE["tables"] = array();
$STRUCTURE["tables"]["module_export_groups"] = array(
    array(
        "Field"   => "export_group_id",
        "Type"    => "smallint(5) unsigned",
        "Null"    => "NO",
        "Key"     => "PRI",
        "Default" => ""
    ),
    array(
        "Field"   => "group_name",
        "Type"    => "varchar(255)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "access_type",
        "Type"    => "enum('admin','public','private')",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "public"
    ),
    array(
        "Field"   => "form_view_mapping",
        "Type"    => "enum('all','except','only')",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "all"
    ),
    array(
        "Field"   => "forms_and_views",
        "Type"    => "mediumtext",
        "Null"    => "YES",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "visibility",
        "Type"    => "enum('show','hide')",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "show"
    ),
    array(
        "Field"   => "icon",
        "Type"    => "varchar(100)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "action",
        "Type"    => "enum('file','popup','new_window')",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "popup"
    ),
    array(
        "Field"   => "action_button_text",
        "Type"    => "varchar(255)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "{\$L.word_display}"
    ),
    array(
        "Field"   => "popup_height",
        "Type"    => "varchar(5)",
        "Null"    => "YES",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "popup_width",
        "Type"    => "varchar(5)",
        "Null"    => "YES",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "headers",
        "Type"    => "text",
        "Null"    => "YES",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "smarty_template",
        "Type"    => "mediumtext",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "list_order",
        "Type"    => "tinyint(4)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    )
);
$STRUCTURE["tables"]["module_export_group_clients"] = array(
    array(
        "Field"   => "export_group_id",
        "Type"    => "mediumint(8) unsigned",
        "Null"    => "NO",
        "Key"     => "PRI",
        "Default" => ""
    ),
    array(
        "Field"   => "account_id",
        "Type"    => "mediumint(8) unsigned",
        "Null"    => "NO",
        "Key"     => "PRI",
        "Default" => ""
    )
);
$STRUCTURE["tables"]["module_export_types"] = array(
    array(
        "Field"   => "export_type_id",
        "Type"    => "mediumint(8) unsigned",
        "Null"    => "NO",
        "Key"     => "PRI",
        "Default" => ""
    ),
    array(
        "Field"   => "export_type_name",
        "Type"    => "varchar(255)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "export_type_visibility",
        "Type"    => "enum('show','hide')",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => "show"
    ),
    array(
        "Field"   => "filename",
        "Type"    => "varchar(255)",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "export_group_id",
        "Type"    => "smallint(6)",
        "Null"    => "YES",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "smarty_template",
        "Type"    => "text",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    ),
    array(
        "Field"   => "list_order",
        "Type"    => "tinyint(3) unsigned",
        "Null"    => "NO",
        "Key"     => "",
        "Default" => ""
    )
);


$HOOKS = array(
    array(
        "hook_type"       => "template",
        "action_location" => "admin_submission_listings_bottom",
        "function_name"   => "",
        "hook_function"   => "displayExportOptions",
        "priority"        => "50"
    ),
    array(
        "hook_type"       => "template",
        "action_location" => "client_submission_listings_bottom",
        "function_name"   => "",
        "hook_function"   => "displayExportOptions",
        "priority"        => "50"
    )
);


$FILES = array(
    "code/",
    "code/ExportGroups.class.php",
    "code/ExportTypes.class.php",
    "code/General.class.php",
    "code/index.html",
    "code/Module.class.php",
    "css/",
    "css/index.html",
    "css/styles.css",
    "export.php",
    "export_groups/",
    "export_groups/add.php",
    "export_groups/add_type.php",
    "export_groups/edit.php",
    "export_groups/index.html",
    "export_groups/page_add_export_type.php",
    "export_groups/page_edit_export_type.php",
    "export_groups/page_export_types.php",
    "export_groups/page_main.php",
    "export_groups/page_permissions.php",
    "help.php",
    "images/",
    "images/icon_export.gif",
    "images/icons/",
    "images/icons/csv.gif",
    "images/icons/printer.gif",
    "images/icons/printer.png",
    "images/icons/xls.gif",
    "images/icons/xml.jpg",
    "index.php",
    "lang/",
    "lang/en_us.php",
    "lang/index.html",
    "library.php",
    "scripts/",
    "scripts/admin.js",
    "scripts/export_manager.js",
    "scripts/index.html",
    "module_config.php",
    "reset.php",
    "settings.php",
    "smarty_plugins/",
    "smarty_plugins/function.export_groups_dropdown.php",
    "smarty_plugins/function.smart_display_field.php",
    "smarty_plugins/index.html",
    "templates/",
    "templates/export_groups/",
    "templates/export_groups/add.tpl",
    "templates/export_groups/edit.tpl",
    "templates/export_groups/index.html",
    "templates/export_groups/tab_add_export_type.tpl",
    "templates/export_groups/tab_edit_export_type.tpl",
    "templates/export_groups/tab_export_types.tpl",
    "templates/export_groups/tab_main.tpl",
    "templates/export_groups/tab_permissions.tpl",
    "templates/export_options_html.tpl",
    "templates/help.tpl",
    "templates/index.html",
    "templates/index.tpl",
    "templates/reset.tpl",
    "templates/settings.tpl"
);
