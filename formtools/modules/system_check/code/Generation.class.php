<?php


namespace FormTools\Modules\SystemCheck;

use FormTools\Core;


class Generation
{

    /**
     * Helper function for devs who need to quickly generate the module_config.php file for their module tables.
     *
     * @param array $tables
     * @param string $version (for core builds only)
     */
    public static function generateDbConfigFile($tables, $version = "")
    {
        $db = Core::$db;

        $init_str = "";
        $version_str = "";
        if (!empty($version)) {
            $init_str = "\$STRUCTURE = array();";
            $version_str = "[\"$version\"]";
        }

        $html = <<< EOF
    $init_str
\$STRUCTURE$version_str = array();
\$STRUCTURE{$version_str}["tables"] = array();

EOF;

        foreach ($tables as $table_name) {
            $html .= '$STRUCTURE' . $version_str . '["tables"]["' . $table_name . '"] = array(' . "\n";

            $db->query("SHOW COLUMNS FROM {PREFIX}$table_name");
            $db->execute();
            $info = $db->fetchAll();

            $rows = array();
            foreach ($info as $row) {
                $default = preg_replace("/\\$/", "\\\\$", $row["Default"]);
                $str = <<< EOF
    array(
        "Field"   => "{$row['Field']}",
        "Type"    => "{$row['Type']}",
        "Null"    => "{$row['Null']}",
        "Key"     => "{$row['Key']}",
        "Default" => "{$default}"
    )
EOF;
                $rows[] = $str;
            }

            $html .= implode(",\n", $rows);
            $html .= "\n);\n";
        }

        return $html;
    }


    /**
     * Like the previous function, this for use by module developers. It parses the hook_calls table and
     * generates a PHP representation of the hooks calls being used by the module. That info is then
     * placed in the module_config.php file for use by this module.
     */
    public static function generateModuleHookArray($module_folder, $version)
    {
        $db = Core::$db;

        $db->query("SELECT * FROM {PREFIX}hook_calls WHERE module_folder = :module_folder");
        $db->bind("module_folder", $module_folder);
        $db->execute();

        $hooks = array();
        foreach ($db->fetchAll() as $row) {
            $hooks[] = <<< END
    array(
        "hook_type"       => "{$row["hook_type"]}",
        "action_location" => "{$row["action_location"]}",
        "function_name"   => "{$row["function_name"]}",
        "hook_function"   => "{$row["hook_function"]}",
        "priority"        => "{$row["priority"]}"
    )
END;
        }
        $hooks_str = implode(",\n", $hooks);

        $version_str = "[\"$version\"]";

        $php = "\$HOOKS = array();\n"
        . "\$HOOKS$version_str = array(\n"
        . $hooks_str
        . "\n);";

        echo $php;
    }

    /*
     * Generates a list of files for the current repo - as determined by the folder path passed (assumes to be
     * in a git repo).
     */
    public static function getRepoFiles($folder)
    {
        exec("cd $folder; git ls-files", $files);

        $rows = array();
        foreach ($files as $file) {
            $rows [] = "    \"{$file}\"";
        }

        $php = "\$FILES = array(\n" . implode($rows, ",\n") . "\n);";
        echo $php;
    }
}
