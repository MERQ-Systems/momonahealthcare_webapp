<?php

/**
 * Contains all functions relating to the Table Verification page.
 */


namespace FormTools\Modules\SystemCheck;

use FormTools\Core;
use FormTools\General as CoreGeneral;

class Tables
{

    /**
     * This is called for each table. It returns an array with the following values. If the table doesn't
     * exist, it only returns the table
     *   "table_exists"    => true/false
     *   "missing_columns" => array of col names
     *   "invalid_columns" => hash of array of hashes (*sigh*).
     *                         "column_name" => array(
     *                                            "Type" => array(
     *                                               "should_be" => "whatever the type should be"
     *                                               "is"        => "whatever the type actually is"
     *                                            ),
     *                                            ...
     *                                          )
     *                        "Type" in the example above can be "Type", "Null", "Key" or "default", as per the
     *                        column data in the system_check.php files.
     *
     * @param array $component_info
     * @param string $table_name
     */
    public static function checkComponentTable($component_info, $table_name)
    {
        // first, check the table exists
        $results = array();
        $table_exists = CoreGeneral::checkDbTableExists($table_name);
        $results["table_exists"] = $table_exists;

        // if the table exists, run tests on all the columns in the table
        if ($table_exists) {
            $info = Tables::checkComponentTableColumns($component_info, $table_name);
            $results["missing_columns"] = $info["missing_columns"];
            $results["invalid_columns"] = $info["invalid_columns"];
        }

        return $results;
    }


    /**
     * Called by sc_check_component_table. See that function comments for a clear description of the
     * return values.
     *
     * @param array $component_info
     * @param string $table_name
     */
    private static function checkComponentTableColumns($component_info, $table_name)
    {
        $db = Core::$db;
        $table_prefix = Core::getDbTablePrefix();

        $missing_columns = array();
        $invalid_columns = array();

        // get the actual content of the db table (should be moved to helper)
        $db->query("SHOW COLUMNS FROM `$table_name`");
        $db->execute();

        $actual_column_info = array();
        foreach ($db->fetchAll() as $row) {
            $default = preg_replace("/\\$/", "\\\\$", $row["Default"]);
            $actual_column_info[$row['Field']] = array(
                "Type" => $row['Type'],
                "Null" => $row['Null'],
                "Key" => $row['Key'],
                "Default" => $default
            );
        }

        $table_name_without_prefix = preg_replace("/^{$table_prefix}/", "", $table_name);

        foreach ($component_info["tables"][$table_name_without_prefix] as $desired_column_info) {
            $curr_column_name = $desired_column_info["Field"];

            // if the curr column name from the structure file isn't found in the ACTUAL column info list,
            // it's missing!
            if (!array_key_exists($curr_column_name, $actual_column_info)) {
                $missing_columns[] = $curr_column_name;
                continue;
            }

            // now check each of the values
            $invalid_values = array();
            if ($desired_column_info["Type"] != $actual_column_info[$curr_column_name]["Type"]) {
                $invalid_values = array(
                    "field" => "Type",
                    "should_be" => $desired_column_info["Type"],
                    "is" => $actual_column_info[$curr_column_name]["Type"]
                );
            }

            if (!empty($invalid_values)) {
                $invalid_columns[] = array(
                    "column" => $curr_column_name,
                    "invalid_values" => $invalid_values
                );
            }
        }

        return array(
            "missing_columns" => $missing_columns,
            "invalid_columns" => $invalid_columns
        );
    }

    public static function getComponentTables($component_info)
    {
        $dbPrefix = Core::getDbTablePrefix();

        $tables = array();
        while (list($table_name) = each($component_info["tables"])) {
            $tables[] = "{$dbPrefix}{$table_name}";
        }

        return $tables;
    }
}
