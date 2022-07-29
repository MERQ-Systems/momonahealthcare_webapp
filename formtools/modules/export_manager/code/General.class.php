<?php

namespace FormTools\Modules\ExportManager;

use FormTools\Core;
use FormTools\Files;
use FormTools\General as CoreGeneral;
use FormTools\Modules;


class General
{
	/**
	 * Returns a list of all export icons, found in the /modules/export_manager/images/icons/ folder.
	 *
	 * return array an array of image filenames.
	 */
	public static function getExportIcons()
	{
		$root_dir = Core::getRootDir();
		$icon_folder = "$root_dir/modules/export_manager/images/icons/";

		// store all the icon filenames in an array
		$filenames = array();
		if ($handle = opendir($icon_folder)) {
			while (false !== ($file = readdir($handle))) {
				$extension = Files::getFilenameExtension($file, true);
				if ($extension == "jpg" || $extension == "gif" || $extension == "bmp" || $extension == "png") {
					$filenames[] = $file;
				}
			}
		}

		return $filenames;
	}


	/**
	 * Called on the Settings page. Updates the generated file folder information.
	 *
	 * @param array $info
	 * @return array [0] T/F [1] Error / notification message
	 */
	public static function updateSettings($info, $L)
	{
		$settings = array(
			"file_upload_dir" => $info["file_upload_dir"],
			"file_upload_url" => $info["file_upload_url"],
			"export_timeout" => $info["export_timeout"]
		);

		Modules::setModuleSettings($settings);
		return array(true, $L["notify_settings_updated"]);
	}


	/**
	 * Used in generating the filenames; this builds most of the placeholder values (the date-oriented ones)
	 * to which the form and export-specific placeholders are added.
	 *
	 * @return array the placeholder array
	 */
	public static function getExportFilenamePlaceholderHash()
	{
		$offset = CoreGeneral::getCurrentTimezoneOffset();
		$date_str = CoreGeneral::getDate($offset, CoreGeneral::getCurrentDatetime(), "Y|y|F|M|m|n|d|D|j|g|h|H|s|U|a|G|i");
		list($Y, $y, $F, $M, $m, $n, $d, $D, $j, $g, $h, $H, $s, $U, $a, $G, $i) = explode("|", $date_str);

		$placeholders = array(
			"datetime" => "$Y-$m-$d.$H-$i-$s",
			"date" => "$Y-$m-$d",
			"time" => "$H-$i-$s",
			"Y" => $Y,
			"y" => $y,
			"F" => $F,
			"M" => $M,
			"m" => $m,
			"G" => $G,
			"i" => $i,
			"n" => $n,
			"d" => $d,
			"D" => $D,
			"j" => $j,
			"g" => $g,
			"h" => $h,
			"H" => $H,
			"s" => $s,
			"U" => $U,
			"a" => $a
		);

		return $placeholders;
	}


	public static function removeTables()
	{
		$db = Core::$db;

		$db->query("DROP TABLE {PREFIX}module_export_groups");
		$db->execute();

		$db->query("DROP TABLE {PREFIX}module_export_group_clients");
		$db->execute();

		$db->query("DROP TABLE {PREFIX}module_export_types");
		$db->execute();
	}


	public static function clearTableData()
	{
		$db = Core::$db;

		$db->query("TRUNCATE {PREFIX}module_export_group_clients");
		$db->execute();

		$db->query("TRUNCATE {PREFIX}module_export_groups");
		$db->execute();

		$db->query("TRUNCATE {PREFIX}module_export_types");
		$db->execute();

		$db->query("DELETE FROM {PREFIX}settings WHERE module = 'export_manager'");
		$db->execute();
	}
}
