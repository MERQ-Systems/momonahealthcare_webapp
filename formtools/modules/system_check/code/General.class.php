<?php


namespace FormTools\Modules\SystemCheck;

use PDO;
use FormTools\Core;
use FormTools\Modules;


class General
{

    /**
     * Figures out which (if any) of the installed modules are available for a particular test.
     *
     * @param string $test "tables", "hooks" or "files"
     * @return array all compatible modules (not the module_config.php info).
     */
    public static function getCompatibleModules($test)
    {
        $module_list = Modules::getList();

        $compatible_modules = array();
        foreach ($module_list as $module_info) {
            $module_folder = $module_info["module_folder"];
            if ($module_info["is_installed"] != "yes") {
                continue;
            }

            $module_config = General::getModuleConfigFileContents($module_folder);
            if (!$module_config["is_compatible"]) {
                continue;
            }

            $relevant = false;
            switch ($test) {
                case "tables":
                    if ($module_config["includes_table_info"]) {
                        $relevant = true;
                    }
                    break;
                case "hooks":
                    if ($module_config["includes_hook_info"]) {
                        $relevant = true;
                    }
                    break;
                case "files":
                    if ($module_config["includes_file_info"]) {
                        $relevant = true;
                    }
                    break;
            }

            $module_info["module_config"] = $module_config;

            if ($relevant) {
                $compatible_modules[] = $module_info;
            }
        }

        return $compatible_modules;
    }


    /**
     * This is the one entry point for getting data from a module config file.
     *
     * This function returns all config info about a module that can be used by the System Check module.
     * It's compatible with the old Database Integrity module, which required a database_integrity.php file
     * defined in the module root. The new System Check module requires a module_config.php file to be
     * defined in the module root.
     *
     * The module_config.php can define any of the following globals:
     *   $STRUCTURE - which contains the database structure of all module tables. If there's no database,
     *                it (should) define an empty array.
     *   $FILES     - a list of files for this module
     *   $HOOKS     - the list of hook calls that the module uses - or an empty array if none.
     *
     * @param string $module_folder
     * @return array
     */
    public static function getModuleConfigFileContents($module_folder)
    {
        $root_dir = Core::getRootDir();

        // Database Integrity compatibility
        $is_compatible = false;

        // if the module is sporting compatibility with the new System Check module, use that file. Otherwise, use
        // the older Database Integrity module file
        if (is_file("$root_dir/modules/$module_folder/module_config.php")) {
            $is_compatible = true;
            require_once("$root_dir/modules/$module_folder/module_config.php");
        }

        $return_info = array(
            "is_compatible" => $is_compatible,
            "includes_table_info" => false,
            "includes_hook_info" => false,
            "includes_file_info" => false
        );

        // if data is available for the module, tack it all together and return the result
        if ($is_compatible) {
            $includes_table_info = isset($STRUCTURE) ? true : false;
            if ($includes_table_info) {
                $return_info["includes_table_info"] = $includes_table_info;
                $return_info["tables"] = $STRUCTURE;
            }

            $includes_hook_info = isset($HOOKS) ? true : false;
            if ($includes_hook_info) {
                $return_info["includes_hook_info"] = $includes_hook_info;
                $return_info["hooks"] = $HOOKS;
            }

            $includes_file_info = isset($FILES) ? true : false;
            if ($includes_file_info) {
                $return_info["includes_file_info"] = $includes_file_info;
                $return_info["files"] = $FILES;
            }
        }

        return $return_info;
    }


    /** -------------- HELPERS ----------------  **/

    /**
     * Returns an array of valid account IDs. Used in the orphan record testing.
     *
     * @return array
     */
    public static function getAccountIds()
    {
        $db = Core::$db;
        $db->query("SELECT account_id FROM {PREFIX}accounts");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    /**
     * Returns an array of valid form IDs. Used in the orphan record testing.
     *
     * @return array
     */
    public static function getFormIds()
    {
        $db = Core::$db;
        $db->query("SELECT form_id FROM {PREFIX}forms");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    /**
     * Returns an array of valid View IDs. Used in the orphan record testing.
     *
     * @return array
     */
    public static function getViewIds()
    {
        $db = Core::$db;
        $db->query("SELECT view_id FROM {PREFIX}views");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    /**
     * Returns an array of valid View IDs. Used in the orphan record testing.
     *
     * @return array
     */
    public static function getEmailIds()
    {
        $db = Core::$db;
        $db->query("SELECT email_id FROM {PREFIX}email_templates");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    /**
     * Returns an array of valid View IDs. Used in the orphan record testing.
     *
     * @return array
     */
    public static function getFormEmailConfigIds()
    {
        $db = Core::$db;
        $db->query("SELECT form_email_id FROM {PREFIX}form_email_fields");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getListGroupIds()
    {
        $db = Core::$db;
        $db->query("SELECT group_id FROM {PREFIX}list_groups");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getFieldIds()
    {
        $db = Core::$db;
        $db->query("SELECT field_id FROM {PREFIX}form_fields");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getFieldTypeIds()
    {
        $db = Core::$db;
        $db->query("SELECT field_type_id FROM {PREFIX}field_types");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getFieldTypeSettingIds()
    {
        $db = Core::$db;
        $db->query("SELECT setting_id FROM {PREFIX}field_type_settings");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getFormFieldIds($form_id)
    {
        $db = Core::$db;
        $db->query("SELECT field_id FROM {PREFIX}form_fields WHERE form_id = :form_id");
        $db->bind("form_id", $form_id);
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }


    public static function getMenuIds()
    {
        $db = Core::$db;
        $db->query("SELECT menu_id FROM {PREFIX}menus");
        $db->execute();
        return $db->fetchAll(PDO::FETCH_COLUMN);
    }
}
