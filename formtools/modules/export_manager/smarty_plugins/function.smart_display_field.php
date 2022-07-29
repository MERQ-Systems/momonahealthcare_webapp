<?php

use FormTools\FieldTypes;
use FormTools\Modules\ExportManager\ExportGroups;


$export_group_context_map = array();

/**
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.smart_display_field
 * Type:     function
 * Name:     smart_display_field
 * Purpose:  This function functionally does the same as the Core display_custom_field Smarty function,
 *           except that it's designed to display the field values in bulk. To speed things up, it caches
 *           as much info as it can, to reduce DB queries etc.
 * -------------------------------------------------------------
 */
function smarty_function_smart_display_field($params, &$smarty)
{
	global $export_group_context_map;

	// ugly, this should be passed in $params but that wouldn't be backward compatible. This just figures out the appropriate
	// context on the very first
	$export_group_id = $smarty->getTemplateVars("export_group_id");
	if (!empty($export_group_id)) {
		if (isset($export_group_context_map[$export_group_id])) {
			$params["context"] = $export_group_context_map[$export_group_id];
		} else {
			$export_group = ExportGroups::getExportGroup($export_group_id);
			if ($export_group["content_type"] == "text") {
				$params["context"] = "export:text";
			} else {
				$params["context"] = "export:html";
			}
			$export_group_context_map[$export_group_id] = $params["context"];
		}
	}

	$value = FieldTypes::generateViewableField($params);

	// additional code for CSV encoding
	if (isset($params["escape"])) {
		if ($params["escape"] == "csv") {
			$value = preg_replace("/\"/", "\"\"", $value);
			if (strstr($value, ",") || strstr($value, "\n")) {
				$value = "\"$value\"";
			}
		}
		if ($params["escape"] == "excel") {
			$value = preg_replace("/(\n\r|\n)/", "<br style=\"mso-data-placement:same-cell;\" />", $value);
		}
	}

	echo $value;
}
