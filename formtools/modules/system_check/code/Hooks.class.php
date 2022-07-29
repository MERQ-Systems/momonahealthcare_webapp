<?php


namespace FormTools\Modules\SystemCheck;


use PDOException;
use FormTools\Core;
use FormTools\Modules;


/**
 * Contains all functions relating to the Hook Verification page.
 */


// ------------------------------------------------------------------------------------------------

class Hooks
{

    /**
     * Verification of the module hooks is very basic, simply because there's always a single solution: resetting
     * them. This function returns a string with four possible values: "pass", "too_many_hooks", "missing_hooks"
     * or "invalid_hooks".
     *
     * If it's anything other than "pass", the user will have the option to reset the hooks for the module via the
     * interface.
     *
     * @param string $module_folder
     * @return string "pass", "too_many_hooks", "missing_hooks", "invalid_hooks"
     */
    public static function verifyModuleHooks($module_folder)
    {
        $db = Core::$db;
        $module_config = General::getModuleConfigFileContents($module_folder);

        $hooks = $module_config["hooks"];
        $expected_num_hooks = count($hooks);

        $db->query("SELECT * FROM {PREFIX}hook_calls WHERE module_folder = :module_folder");
        $db->bind("module_folder", $module_folder);
        $db->execute();

        $actual_num_hooks = $db->numRows();

        $extra_info = "";
        $result = "pass";
        if ($actual_num_hooks < $expected_num_hooks) {
            $result = "missing_hooks";
        } else {
            if ($actual_num_hooks > $expected_num_hooks) {
                $result = "too_many_hooks";
            } else {
                $actual_hooks = array();
                foreach ($db->fetchAll() as $row) {
                    $row["is_found"] = false;
                    $actual_hooks[] = $row;
                }

                // loop through all expected hooks and confirm there's a (single) matching hook in the database
                foreach ($hooks as $hook_info) {
                    $hook_type = $hook_info["hook_type"];
                    $action_location = $hook_info["action_location"];
                    $function_name = $hook_info["function_name"];
                    $hook_function = $hook_info["hook_function"];
                    $priority = $hook_info["priority"];

                    $found = false;
                    for ($i = 0; $i < count($actual_hooks); $i++) {
                        $actual_hook_info = $actual_hooks[$i];
                        if ($actual_hook_info["is_found"]) {
                            continue;
                        }

                        if (($hook_type == $actual_hook_info["hook_type"]) &&
                            ($action_location == $actual_hook_info["action_location"]) &&
                            ($function_name == $actual_hook_info["function_name"]) &&
                            ($hook_function == $actual_hook_info["hook_function"]) &&
                            ($priority == $actual_hook_info["priority"])) {

                            $found = true;
                            $actual_hooks[$i]["is_found"] = true;
                            break;
                        }
                    }

                    if (!$found) {
                        $result = "invalid_hooks";
                        $extra_info = "[missing: $hook_type,$action_location,$function_name,$hook_function,$priority]";
                        break;
                    }
                }
            }
        }

        return array($result, $extra_info);
    }


    /**
     * This explicitly empties and reloads any module's hook calls.
     *
     * @param array $module_ids
     */
    public static function resetModuleHookCalls($module_ids)
    {
        global $L;

        $db = Core::$db;

        $problems = false;
        foreach ($module_ids as $module_id) {
            if (!is_numeric($module_id)) {
                continue;
            }

            $module_info = Modules::getModule($module_id);
            if (empty($module_info)) {
                continue;
            }

            $module_folder = $module_info["module_folder"];
            $module_version = $module_info["version"];

            $module_config = General::getModuleConfigFileContents($module_folder);
            $desired_hooks = isset($module_config["hooks"][$module_version]) ? $module_config["hooks"][$module_version] : $module_config["hooks"];
            if (empty($desired_hooks)) {
                continue;
            }

            $db->query("DELETE FROM {PREFIX}hook_calls WHERE module_folder = :module_folder");
            $db->bind("module_folder", $module_folder);
            $db->execute();

            foreach ($desired_hooks as $hook_info) {
                $db->query("
                    INSERT INTO {PREFIX}hook_calls (hook_type, action_location, module_folder, function_name, hook_function, priority)
                    VALUES (:hook_type, :action_location, :module_folder, :function_name, :hook_function, :priority)
                ");
                $db->bindAll(array(
                    "hook_type" => $hook_info["hook_type"],
                    "action_location" => $hook_info["action_location"],
                    "module_folder" => $module_folder,
                    "function_name" => $hook_info["function_name"],
                    "hook_function" => $hook_info["hook_function"],
                    "priority" => $hook_info["priority"]
                ));

                try {
                    $db->execute();
                } catch (PDOException $e) {
                    $problems = true;
                }
            }
        }

        if ($problems) {
            return array(true, $L["notify_problems_resetting_module_hooks"]);
        } else {
            return array(true, $L["notify_module_hooks_reset"]);
        }
    }

}
