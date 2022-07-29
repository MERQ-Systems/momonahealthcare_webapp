<?php


namespace FormTools\Modules\SystemCheck;

use FormTools\Core;
use FormTools\Themes;


class Files
{
    /**
     * Helper function to return a list of files that are missing from the Core.
     *
     * @return array
     */
    public static function checkCoreFiles()
    {
        $root_dir = Core::getRootDir();

        if (!is_file("$root_dir/global/misc/config_core.php")) {
            return array();
        }

        require_once("$root_dir/global/misc/config_core.php");

        if (!isset($FILES)) {
            return array();
        }

        $missing_files = array();
        foreach ($FILES as $file) {
            // ignore the install/ folder folder + files
            if (preg_match("/^install/", $file)) {
                continue;
            }

            if (!is_file("$root_dir/$file") && !is_dir("$root_dir/$file")) {
                $missing_files[] = $file;
            }
        }

        return $missing_files;
    }


    /**
     * Helper function to look at all installed themes and see which are compatible with the File Verification
     * test (i.e. which have a theme_config.php file defined in the root).
     */
    public static function getCompatibleThemes()
    {
        $root_dir = Core::getRootDir();
        $themes = Themes::getList();

        $compatible_themes = array();
        foreach ($themes as $theme_info) {
            $theme_folder = $theme_info["theme_folder"];

            if (is_file("$root_dir/themes/$theme_folder/theme_config.php")) {
                $compatible_themes[] = $theme_info;
            }
        }

        return $compatible_themes;
    }


    public static function checkModuleFiles($module_folder)
    {
        $root_dir = Core::getRootDir();
        $file = "$root_dir/modules/$module_folder/module_config.php";
        if (!is_file($file)) {
            return array();
        }

        require_once($file);

        if (!isset($FILES)) {
            return array();
        }

        $missing_files = array();
        $root = "modules/$module_folder";
        foreach ($FILES as $file) {
            if (!is_file("$root_dir/$root/$file") && !is_dir("$root_dir/$root/$file")) {
                $missing_files[] = "$root/$file";
            }
        }

        return $missing_files;
    }


    public static function checkThemeFiles($theme_folder)
    {
        $root_dir = Core::getRootDir();
        $file = "$root_dir/themes/$theme_folder/theme_config.php";
        if (!is_file($file)) {
            return array();
        }

        require_once($file);

        if (!isset($FILES)) {
            return array();
        }

        $missing_files = array();
        $root = "themes/$theme_folder";
        foreach ($FILES as $file) {
            if (!is_file("$root_dir/$root/$file") && !is_dir("$root_dir/$root/$file")) {
                $missing_files[] = "$root/$file";
            }
        }

        return $missing_files;
    }

}
