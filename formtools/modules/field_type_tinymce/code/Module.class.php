<?php


namespace FormTools\Modules\FieldTypeTinymce;

use FormTools\Core;
use FormTools\FieldTypes;
use FormTools\General;
use FormTools\Hooks;
use FormTools\Module as FormToolsModule;
use PDO, Exception;


class Module extends FormToolsModule
{
    protected $moduleName = "TinyMCE Field";
    protected $moduleDesc = "This module lets you choose a TinyMCE rich-text editor for your form fields.";
    protected $author = "Ben Keen";
    protected $authorEmail = "ben.keen@gmail.com";
    protected $authorLink = "https://formtools.org";
    protected $version = "2.0.8";
    protected $date = "2019-03-17";
    protected $originLanguage = "en_us";

    protected $jsFiles = array(
        "{FTROOT}/global/scripts/sortable.js",
        "{MODULEROOT}/tinymce/tinymce.min.js"
    );

    protected $nav = array(
        "module_name" => array("index.php", false),
        "word_help" => array("help.php", false)
    );


    private static $viewFieldSmartyMarkup =<<< END
{if \$CONTEXTPAGE == "edit_submission"}
    {\$VALUE}
{elseif \$CONTEXTPAGE == "submission_listing"}
    {\$VALUE|strip_tags}
{else}
    {\$VALUE|nl2br}
{/if}
END;

    private static $editFieldSmartyMarkup =<<< END
<textarea name="{\$NAME}" id="cf_{\$NAME}_id" class="cf_tinymce">{\$VALUE}</textarea>
<script>
cf_tinymce_settings["{\$NAME}"] = {literal}{{/literal}
    skin: "lightgray",
    branding: false,
    menubar: false,
    elementpath: false,
{if \$toolbar == "basic"}
    toolbar: [
        'bold italic underline strikethrough | bullist numlist'
    ],
{elseif \$toolbar == "simple"}
    toolbar: [
        'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | link unlink forecolor backcolor'
    ],
    plugins: 'hr link textcolor lists',
{elseif \$toolbar == "advanced"}
    toolbar: [
        'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | undo redo link unlink | fontselect fontsizeselect',
        'forecolor backcolor | subscript superscript code'
    ],
    plugins: 'hr link textcolor lists code',
{elseif \$toolbar == "expert"}
    toolbar: [
        'bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr |  formatselect fontselect fontsizeselect',
        'undo redo link unlink | forecolor backcolor | subscript superscript | newdocument charmap removeformat cleanup code'
    ],
    plugins: 'hr link textcolor lists code',
{/if}
{if \$resizing}
    statusbar: true,
    resize: true
{else}
    statusbar: false,
    resize: false
{/if}
{literal}}{/literal}
</script>
{if \$comments}
    <div class="cf_field_comments">{\$comments}</div>
{/if}
END;

    private static $resourceCss =<<< END
body .mce-ico {
    font-size: 13px;
}
body .mce-btn button {
    padding: 3px 5px 3px 7px;
}
END;

    private static $resourceJs =<<< END
// this is populated by each tinyMCE WYWISYG with their settings on page load
var cf_tinymce_settings = {};

$(function() {
    $('textarea.cf_tinymce').each(function() {
        var field_name = $(this).attr("name");
        var settings   = cf_tinymce_settings[field_name];
        settings.selector = "#" + $(this).attr("id");
        tinymce.init(settings);
    });
});

cf_tinymce_settings.check_required = function() {
    var errors = [];
    for (var i=0; i<rsv_custom_func_errors.length; i++) {
        if (rsv_custom_func_errors[i].func != "cf_tinymce_settings.check_required") {
            continue;
        }
        var field_name = rsv_custom_func_errors[i].field;
        var val = $.trim(tinyMCE.get("cf_" + field_name + "_id").getContent());
        if (!val) {
            var el = document.edit_submission_form[field_name];
            errors.push([el, rsv_custom_func_errors[i].err]);
        }
    }
    if (errors.length) {
        return errors;
    }
    return true;
}
END;

    private static $fieldTypeRecordMap = array(
        "is_editable" => "no",
        "non_editable_info" => "This module can only be edited via the tinyMCE module.",
        "field_type_name" => "{\$LANG.word_wysiwyg}",
        "field_type_identifier" => "tinymce",
        "is_file_field" => "no",
        "is_date_field" => "no",
        "raw_field_type_map" => "textarea",
        "raw_field_type_map_multi_select_id" => null,
        "compatible_field_sizes" => "large,very_large",
        "view_field_rendering_type" => "smarty",
        "view_field_php_function_source" => "core",
        "view_field_php_function" => "",
        "php_processing" => ""
    );

    private static $validationRecordMap = array(
        "rsv_rule" => "function",
        "rule_label" => "{\$LANG.word_required}",
        "rsv_field_name" => "",
        "custom_function" => "cf_tinymce_settings.check_required",
        "custom_function_required" => "yes",
        "default_error_message" => "{\$LANG.validation_default_rule_required}"
    );


    private static $fieldTypeSettings = array(
        array(
            "field_label" => "Toolbar",
            "field_setting_identifier" => "toolbar",
            "field_type" => "select",
            "field_orientation" => "na",
            "default_value" => "simple",
            "options" => array(
                array(
                    "option_text" => "Basic",
                    "option_value" => "basic",
                    "is_new_sort_group" => "yes"
                ),
                array(
                    "option_text" => "Simple",
                    "option_value" => "simple",
                    "is_new_sort_group" => "yes"
                ),
                array(
                    "option_text" => "Advanced",
                    "option_value" => "advanced",
                    "is_new_sort_group" => "yes"
                ),
                array(
                    "option_text" => "Expert",
                    "option_value" => "expert",
                    "is_new_sort_group" => "yes"
                )
            )
        ),

        array(
            "field_label" => "Allow Toolbar Resizing",
            "field_setting_identifier" => "resizing",
            "field_type" => "radios",
            "field_orientation" => "horizontal",
            "default_value" => "true",
            "options" => array(
                array(
                    "option_text" => "Yes",
                    "option_value" => "true",
                    "is_new_sort_group" => "yes"
                ),
                array(
                    "option_text" => "No",
                    "option_value" => "false",
                    "is_new_sort_group" => "no"
                )
            )
        ),

        array(
            "field_label" => "Field Comments",
            "field_setting_identifier" => "comments",
            "field_type" => "textarea",
            "field_orientation" => "na",
            "default_value" => ""
        )
    );


    /**
     * Our installation function. This adds the required data to the field types and field settings tables for
     * the field to become immediately usable.
     *
     * @param integer $module_id
     */
    public function install($module_id)
    {
        $db = Core::$db;
        $LANG = Core::$L;
        $L = $this->getLangStrings();

        // check it's not already installed
        $field_type_info = FieldTypes::getFieldTypeByIdentifier("tinymce");

        if (!empty($field_type_info)) {
            return array(false, $LANG["notify_module_already_installed"]);
        }

        // find the LAST field type group. Most installations won't have the Custom Fields module installed so
        // the last group will always be "Special Fields". For installations that DO, and that it's been customized,
        // the user can always move this new field type to whatever group they want. Plus, this module will be
        // installed by default, so it's almost totally moot
        $db->query("
            SELECT group_id
            FROM   {PREFIX}list_groups
            WHERE  group_type = 'field_types'
            ORDER BY list_order DESC
            LIMIT 1
        ");
        $db->execute();
        $group_id = $db->fetch(PDO::FETCH_COLUMN);

        try {
            // now find out how many field types there are in the group so we can add the row with the correct list order
            $db->query("SELECT count(*) FROM {PREFIX}field_types WHERE group_id = :group_id");
            $db->bind("group_id", $group_id);
            $db->execute();

            $next_list_order = $db->fetch(PDO::FETCH_COLUMN) + 1;

            $field_type_id = self::addFieldType($module_id, $group_id, $next_list_order);
            self::addValidation($field_type_id);
            self::addFieldTypeSettings($field_type_id);

            $this->resetHooks();
            return array(true, "");
        } catch (Exception $e) {
            return array(false, $L["notify_error_installing"] . $e->getMessage());
        }
    }


    /**
     * Uninstallation completely removes the field type. It also changes the field type ID from any WYSIWYG fields
     * to a generic textarea.
     *
     * @param integer $module_id
     */
    public function uninstall($module_id)
    {
        FieldTypes::deleteFieldType("tinymce", "textarea");
        return array(true, "");
    }


    public function upgrade($module_id, $old_module_version)
    {
        $this->resetHooks();

        if (General::isVersionEarlierThan($old_module_version, "2.0.6")) {
            $this->resetFieldType($module_id);
        }

		if (General::isVersionEarlierThan($old_module_version, "2.0.7")) {
			$this->updateEditFieldSmartyMarkup();
		}

    }


    public function resetHooks ()
    {
        $this->clearHooks();
        Hooks::registerHook("template", "field_type_tinymce", "head_bottom", "", "includeFiles");
        Hooks::registerHook("template", "field_type_tinymce", "standalone_form_fields_head_bottom", "", "includeStandaloneFiles");
    }


    /**
     * This includes the tinyMCE file on the Edit Submission pages.
     */
    public function includeFiles($hook_name, $page_data)
    {
        $root_url = Core::getRootUrl();
        $curr_page = $page_data["page"];

        if ($curr_page != "admin_edit_submission" && $curr_page != "client_edit_submission") {
            return;
        }

        echo "<script src=\"$root_url/modules/field_type_tinymce/tinymce/tinymce.min.js\"></script>";
    }


    public function includeStandaloneFiles($hook_name, $page_data)
    {
        $root_url = Core::getRootUrl();
        echo "<script src=\"$root_url/modules/field_type_tinymce/tinymce/tinymce.min.js\"></script>";
    }


    /**
     * Updates the default settings for the WYSIWYG field.
     *
     * @param array $info
     */
    public function updateSettings($info)
    {
        $db = Core::$db;
        $L = $this->getLangStrings();

        // to update them we need to know the field type ID - use the identifier to get it
        $field_type_info = FieldTypes::getFieldTypeByIdentifier("tinymce");

        if (!isset($field_type_info["field_type_id"]) || !is_numeric($field_type_info["field_type_id"])) {
            return array(false, $L["notify_update_settings_no_field_found"]);
        }

        $field_type_id = $field_type_info["field_type_id"];

        // now update each of the settings. Klutzy!
        $identifiers = array("toolbar", "resizing");
        foreach ($identifiers as $identifier) {
            switch ($identifier) {
                case "resizing":
                    if (!isset($info[$identifier])) {
                        $new_default_value = "true";
                    } else {
                        $new_default_value = ($info[$identifier] == "yes") ? "true" : "";
                    }
                    break;
                case "path_info_location":
                    if (!isset($info[$identifier])) {
                        $new_default_value = "bottom";
                    } else {
                        $new_default_value = $info[$identifier];
                    }
                    break;
                default:
                    $new_default_value = $info[$identifier];
                    break;
            }

            $db->query("
                UPDATE {PREFIX}field_type_settings
                SET    default_value = :default_value
                WHERE  field_type_id = :field_type_id AND
                       field_setting_identifier = :identifier
                LIMIT 1
            ");
            $db->bindAll(array(
                "default_value" => $new_default_value,
                "field_type_id" => $field_type_id,
                "identifier" => $identifier
            ));
            $db->execute();
        }

        return array(true, $L["notify_default_settings_updated"]);
    }

    /**
     * Called on upgrading to 2.0.4. This resets the module to its factory defaults retaining the original
     * database integrity, i.e. the field type, field type settings, validation and options are all *updated* in place,
     * rather than wiping them out and reinserting.
     *
     * It's kind of a kludge, quite honestly. Ideally it would just wipe out the old data, insert the new and update
     * any references. It's the latter that's fiddly. So for now we're going to go with this.
     */
    public static function resetFieldType($module_id)
    {
        $db = Core::$db;

        $original_field_type = FieldTypes::getFieldTypeByIdentifier("tinymce");
        if (empty($original_field_type)) {
            return array(false, "TODO");
        }

        $field_type_id = $original_field_type["field_type_id"];

        // update the main field types record
        $db->query("
            UPDATE {PREFIX}field_types
            SET    is_editable = :is_editable,
                   non_editable_info = :non_editable_info, 
                   managed_by_module_id = :managed_by_module_id,
                   field_type_name = :field_type_name,
                   field_type_identifier = :field_type_identifier,
                   group_id = :group_id,
                   is_file_field = :is_file_field,
                   is_date_field = :is_date_field,
                   raw_field_type_map = :raw_field_type_map,
                   raw_field_type_map_multi_select_id = :raw_field_type_map_multi_select_id,
                   list_order = :list_order,
                   compatible_field_sizes = :compatible_field_sizes,
                   view_field_rendering_type = :view_field_rendering_type,
                   view_field_php_function_source = :view_field_php_function_source,
                   view_field_php_function = :view_field_php_function,
                   view_field_smarty_markup = :view_field_smarty_markup,
                   edit_field_smarty_markup = :edit_field_smarty_markup,
                   php_processing = :php_processing,
                   resources_css = :resources_css,
                   resources_js = :resources_js
            WHERE field_type_id = :field_type_id
        ");
        $db->bindAll(array(
            "is_editable" => self::$fieldTypeRecordMap["is_editable"],
            "non_editable_info" => self::$fieldTypeRecordMap["non_editable_info"],
            "managed_by_module_id" => $module_id,
            "field_type_name" => self::$fieldTypeRecordMap["field_type_name"],
            "field_type_identifier" => self::$fieldTypeRecordMap["field_type_identifier"],
            "group_id" => $original_field_type["group_id"],
            "is_file_field" => self::$fieldTypeRecordMap["is_file_field"],
            "is_date_field" => self::$fieldTypeRecordMap["is_date_field"],
            "raw_field_type_map" => self::$fieldTypeRecordMap["raw_field_type_map"],
            "raw_field_type_map_multi_select_id" => self::$fieldTypeRecordMap["raw_field_type_map_multi_select_id"],
            "list_order" => $original_field_type["list_order"],
            "compatible_field_sizes" => self::$fieldTypeRecordMap["compatible_field_sizes"],
            "view_field_rendering_type" => self::$fieldTypeRecordMap["view_field_rendering_type"],
            "view_field_php_function_source" => self::$fieldTypeRecordMap["view_field_php_function_source"],
            "view_field_php_function" => self::$fieldTypeRecordMap["view_field_php_function"],
            "view_field_smarty_markup" => self::$viewFieldSmartyMarkup,
            "edit_field_smarty_markup" => self::$editFieldSmartyMarkup,
            "php_processing" => self::$fieldTypeRecordMap["php_processing"],
            "resources_css" => self::$resourceCss,
            "resources_js" => self::$resourceJs,
            "field_type_id" => $field_type_id
        ));
        $db->execute();

        // 2. Validation. We know there's only a single rule so we don't worry about order & just update the single record
        $validation_rules = FieldTypes::getFieldTypeValidationRules($field_type_id);
        $rule = $validation_rules[0];

        $db->query("
            UPDATE {PREFIX}field_type_validation_rules
            SET    rsv_rule = :rsv_rule,
                   rule_label = :rule_label,
                   rsv_field_name = :rsv_field_name,
                   custom_function = :custom_function,
                   custom_function_required = :custom_function_required,
                   default_error_message = :default_error_message
            WHERE  rule_id = :rule_id
        ");

        $db->bindAll(self::$validationRecordMap);
        $db->bind("rule_id", $rule["rule_id"]);
        $db->execute();

        // clean up any old field type settings that are no longer applicable
        self::removeOldFieldTypeSettings($field_type_id);
    }


    // helpers

    private static function addFieldType ($module_id, $group_id, $list_order)
    {
        $db = Core::$db;

        $db->query("
            INSERT INTO {PREFIX}field_types (is_editable, non_editable_info, managed_by_module_id, field_type_name,
                field_type_identifier, group_id, is_file_field, is_date_field, raw_field_type_map, 
                raw_field_type_map_multi_select_id, list_order, compatible_field_sizes,
                view_field_rendering_type, view_field_php_function_source, view_field_php_function,
                view_field_smarty_markup, edit_field_smarty_markup, php_processing, resources_css, resources_js)
            VALUES (:is_editable, :non_editable_info, :module_id, :field_type_name, :field_type_identifier, :group_id,
                :is_file_field, :is_date_field, :raw_field_type_map, :raw_field_type_map_multi_select_id, :list_order,
                :compatible_field_sizes, :view_field_rendering_type, :view_field_php_function_source, :view_field_php_function,
                :view_field_smarty_markup, :edit_field_smarty_markup, :php_processing, :resources_css, :resources_js)
        ");
        $db->bindAll(self::$fieldTypeRecordMap);
        $db->bindAll(array(
            "module_id" => $module_id,
            "group_id" => $group_id,
            "list_order" => $list_order,
            "view_field_smarty_markup" => self::$viewFieldSmartyMarkup,
            "edit_field_smarty_markup" => self::$editFieldSmartyMarkup,
            "resources_css" => self::$resourceCss,
            "resources_js" => self::$resourceJs
        ));
        $db->execute();

        return $db->getInsertId();
    }


    private static function addValidation ($field_type_id)
    {
        $db = Core::$db;

        $db->query("
            INSERT INTO {PREFIX}field_type_validation_rules (field_type_id, rsv_rule, rule_label, rsv_field_name,
              custom_function, custom_function_required, default_error_message, list_order)
            VALUES (:field_type_id, :rsv_rule, :rule_label, :rsv_field_name, :custom_function, :custom_function_required,
              :default_error_message, :list_order)
        ");
        $db->bindAll(self::$validationRecordMap);
        $db->bind("field_type_id", $field_type_id);
        $db->bind("list_order", 1);
        $db->execute();
    }


    private static function addFieldTypeSettings ($field_type_id)
    {
        $db = Core::$db;

        $setting_list_order = 1;
        foreach (self::$fieldTypeSettings as $setting) {

            $db->query("
                INSERT INTO {PREFIX}field_type_settings (field_type_id, field_label, field_setting_identifier, field_type,
                    field_orientation, default_value, list_order)
                VALUES (:field_type_id, :field_label, :field_setting_identifier, :field_type, :field_orientation, 
                    :default_value, :list_order)
            ");
            $db->bindAll(array(
                "field_type_id" => $field_type_id,
                "field_label" => $setting["field_label"],
                "field_setting_identifier" => $setting["field_setting_identifier"],
                "field_type" => $setting["field_type"],
                "field_orientation" => $setting["field_orientation"],
                "default_value" => $setting["default_value"],
                "list_order" => $setting_list_order
            ));
            $db->execute();
            $setting_id = $db->getInsertId();

            if (isset($setting["options"])) {
                self::addFieldSettingOptions($setting_id, $setting["options"]);
            }

            $setting_list_order++;
        }
    }


    private static function addFieldSettingOptions($setting_id, $options)
    {
        $db = Core::$db;

        $order = 1;
        foreach ($options as $row) {
            $db->query("
                INSERT INTO {PREFIX}field_type_setting_options (setting_id, option_text, option_value, option_order, is_new_sort_group)
                VALUES (:setting_id, :option_text, :option_value, :option_order, :is_new_sort_group)
            ");
            $db->bindAll(array(
                "setting_id" => $setting_id,
                "option_text" => $row["option_text"],
                "option_value" => $row["option_value"],
                "option_order" => $order,
                "is_new_sort_group" => $row["is_new_sort_group"]
            ));
            $db->execute();

            $order++;
        }
    }


    private static function removeOldFieldTypeSettings($field_type_id)
    {
        $db = Core::$db;
        $known_field_type_setting_identifiers = array_column(self::$fieldTypeSettings, "field_setting_identifier");

        $identifiers = implode("', '", $known_field_type_setting_identifiers);
        $db->query("
            SELECT setting_id 
            FROM {PREFIX}field_type_settings
            WHERE field_type_id = :field_type_id AND 
                  field_setting_identifier NOT IN ('$identifiers')
        ");
        $db->bind("field_type_id", $field_type_id);
        $db->execute();

        $old_field_settings = $db->fetchAll(PDO::FETCH_COLUMN);
        FieldTypes::deleteFieldTypeSettings($old_field_settings);
    }


    private function updateEditFieldSmartyMarkup()
	{
		$db = Core::$db;

		$original_field_type = FieldTypes::getFieldTypeByIdentifier("tinymce");
		$field_type_id = $original_field_type["field_type_id"];

		// update the main field types record
		$db->query("
            UPDATE {PREFIX}field_types
            SET    edit_field_smarty_markup = :edit_field_smarty_markup
            WHERE  field_type_id = :field_type_id
        ");
		$db->bindAll(array(
			"edit_field_smarty_markup" => self::$editFieldSmartyMarkup,
			"field_type_id" => $field_type_id
		));
		$db->execute();
	}
}
