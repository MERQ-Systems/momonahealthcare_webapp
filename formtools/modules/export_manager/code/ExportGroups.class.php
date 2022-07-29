<?php


namespace FormTools\Modules\ExportManager;

use FormTools\Core;
use PDO;


class ExportGroups
{
	/**
	 * Returns all information about an export type group.
	 *
	 * @param integer $export_group_id
	 */
	public static function getExportGroup($export_group_id)
	{
		$db = Core::$db;

		$db->query("
            SELECT *
            FROM   {PREFIX}module_export_groups
            WHERE  export_group_id = :export_group_id
        ");
		$db->bind("export_group_id", $export_group_id);
		$db->execute();

		$export_group_info = $db->fetch();

		// get any custom list of clients, if this is a Private export type
		$db->query("
            SELECT account_id
            FROM   {PREFIX}module_export_group_clients
            WHERE  export_group_id = :export_group_id
        ");
		$db->bind("export_group_id", $export_group_id);
		$db->execute();

		$export_group_info["client_ids"] = $db->fetchAll(PDO::FETCH_COLUMN);

		return $export_group_info;
	}


	/**
	 * Returns an array of all export type groups in the database.
	 *
	 * @return array
	 */
	public static function getExportGroups()
	{
		$db = Core::$db;

		$db->query("
            SELECT   *
            FROM     {PREFIX}module_export_groups
            ORDER BY list_order
        ");
		$db->execute();
		$results = $db->fetchAll();

		$infohash = array();
		foreach ($results as $field) {
			$field["num_export_types"] = ExportTypes::getNumExportTypes($field["export_group_id"]);
			$infohash[] = $field;
		}

		return $infohash;
	}


	/**
	 * Adds a new export type group to the database.
	 * @param $info
	 * @param $L
	 * @return array
	 */
	public static function addExportGroup($info, $L)
	{
		$db = Core::$db;

		$info = array_merge(array(
			"access_type" => "public",
			"form_view_mapping" => "all",
			"forms_and_views" => null,
			"visibility" => "show",
			"popup_height" => null,
			"popup_width" => null,
			"action" => "new_window",
			"action_button_text" => $L["word_generate"],
			"smarty_template" => "",
			"headers" => "",
			"content_type" => "text"
		), $info);

		// get the next highest order count
		$db->query("SELECT count(*) FROM {PREFIX}module_export_groups");
		$db->execute();
		$order = $db->fetch(PDO::FETCH_COLUMN) + 1;

		// define the default options
		$db->query("
            INSERT INTO {PREFIX}module_export_groups (group_name, access_type, form_view_mapping, forms_and_views,
                visibility, icon, action, action_button_text, popup_height, popup_width, headers, content_type,
                smarty_template, list_order)
            VALUES (:group_name, :access_type, :form_view_mapping, :forms_and_views, :visibility,
                :icon, :action, :action_button_text, :popup_height, :popup_width, :headers, :content_type,
                :smarty_template, :list_order)
        ");
		$db->bindAll(array(
			"group_name" => $info["group_name"],
			"access_type" => $info["access_type"],
			"form_view_mapping" => $info["form_view_mapping"],
			"forms_and_views" => $info["forms_and_views"],
			"visibility" => $info["visibility"],
			"icon" => $info["icon"],
			"action" => $info["action"],
			"action_button_text" => $info["action_button_text"],
			"popup_height" => $info["popup_height"],
			"popup_width" => $info["popup_width"],
			"headers" => $info["headers"],
			"content_type" => $info["content_type"],
			"smarty_template" => $info["smarty_template"],
			"list_order" => $order
		));
		$db->execute();

		return array(true, $L["notify_export_group_added"], $db->getInsertId());
	}


	/**
	 * Updates an export type group.
	 *
	 * @param array $info
	 * @return array
	 */
	public static function updateExportGroup($info, $L)
	{
		$db = Core::$db;

		$db->query("
            UPDATE {PREFIX}module_export_groups
            SET    visibility = :visibility,
                   group_name = :group_name,
                   icon = :icon,
                   action = :action,
                   action_button_text = :action_button_text,
                   content_type = :content_type,
                   popup_height = :popup_height,
                   popup_width = :popup_width,
                   headers = :headers,
                   smarty_template = :smarty_template
            WHERE  export_group_id = :export_group_id
        ");
		$db->bindAll(array(
			"visibility" => $info["visibility"],
			"group_name" => $info["group_name"],
			"icon" => $info["icon"],
			"action" => $info["action"],
			"action_button_text" => $info["action_button_text"],
			"content_type" => $info["content_type"],
			"popup_height" => $info["popup_height"],
			"popup_width" => $info["popup_width"],
			"headers" => isset($info["headers"]) ? $info["headers"] : "",
			"smarty_template" => $info["smarty_template"],
			"export_group_id" => $info["export_group_id"]
		));
		$db->execute();

		return array(true, $L["notify_export_group_updated"]);
	}


	public static function updateExportGroupPermissions($info, $L)
	{
		$db = Core::$db;

		$form_view_mapping = $info["form_view_mapping"];
		$selected_client_ids = (isset($info["selected_client_ids"])) ? $info["selected_client_ids"] : array();

		$forms_and_views = "";
		if ($form_view_mapping != "all") {
			$form_ids = (isset($info["form_ids"])) ? $info["form_ids"] : array();
			$view_ids = (isset($info["view_ids"])) ? $info["view_ids"] : array();
			$forms_and_views = implode(",", $form_ids) . "|" . implode(",", $view_ids);
		}

		$db->query("
            UPDATE {PREFIX}module_export_groups
            SET    access_type = :access_type,
                   form_view_mapping = :form_view_mapping,
                   forms_and_views = :forms_and_views
            WHERE  export_group_id = :export_group_id
        ");
		$db->bindAll(array(
			"access_type" => $info["access_type"],
			"form_view_mapping" => $form_view_mapping,
			"forms_and_views" => $forms_and_views,
			"export_group_id" => $info["export_group_id"]
		));
		$db->execute();

		// now update the list of clients that may have been manually assigned to this (private) export group. If
		// it private, that's cool! Just clear out the old dud data
		$db->query("
            DELETE FROM {PREFIX}module_export_group_clients
            WHERE export_group_id = :export_group_id
        ");
		$db->bind("export_group_id", $info["export_group_id"]);
		$db->execute();

		foreach ($selected_client_ids as $account_id) {
			$db->query("
                INSERT INTO {PREFIX}module_export_group_clients (export_group_id, account_id)
                VALUES (:export_group_id, :account_id)
            ");
			$db->bindAll(array(
				"export_group_id" => $info["export_group_id"],
				"account_id" => $account_id
			));
			$db->execute();
		}

		return array(true, $L["notify_export_group_updated"]);
	}


	/**
	 * Deletes an export group and any associated Export types.
	 *
	 * @param integer $export_group_id
	 */
	public static function deleteExportGroup($export_group_id, $L)
	{
		$db = Core::$db;

		$db->query("DELETE FROM {PREFIX}module_export_groups WHERE export_group_id = :export_group_id");
		$db->bind("export_group_id", $export_group_id);
		$db->execute();

		$db->query("DELETE FROM {PREFIX}module_export_types WHERE export_group_id = :export_group_id");
		$db->bind("export_group_id", $export_group_id);
		$db->execute();

		$db->query("DELETE FROM {PREFIX}module_export_group_clients WHERE export_group_id = :export_group_id");
		$db->bind("export_group_id", $export_group_id);
		$db->execute();

		// now make sure there aren't any gaps in the export group ordering
		ExportGroups::checkExportGroupOrder();

		return array(true, $L["notify_export_group_deleted"]);
	}


	/**
	 * This can be called after deleting an export group, or whenever is needed to ensure that the
	 * order of the export groups are consistent, accurate & don't have any gaps.
	 */
	public static function checkExportGroupOrder()
	{
		$db = Core::$db;

		$db->query("
            SELECT export_group_id
            FROM   {PREFIX}module_export_groups
            ORDER BY list_order ASC
        ");
		$db->execute();
		$ordered_groups = $db->fetchAll(PDO::FETCH_COLUMN);

		$order = 1;
		foreach ($ordered_groups as $export_group_id) {
			$db->query("
                UPDATE {PREFIX}module_export_groups
                SET    list_order = :list_order
                WHERE  export_group_id = :export_group_id
            ");
			$db->bindAll(array(
				"list_order" => $order,
				"export_group_id" => $export_group_id
			));
			$db->execute();
			$order++;
		}
	}


	/**
	 * Called by the administrator on the Export Type Groups page. It reorders the export groups, which determines
	 * the order in which they appear in the client and admin pages.
	 *
	 * @param array $info
	 */
	public static function reorderExportGroups($info, $L)
	{
		$db = Core::$db;

		$sortable_id = $info["sortable_id"];
		$export_group_ids = explode(",", $info["{$sortable_id}_sortable__rows"]);

		$order = 1;
		foreach ($export_group_ids as $export_group_id) {
			$db->query("
                UPDATE {PREFIX}module_export_groups
                SET    list_order = :list_order
                WHERE  export_group_id = :export_group_id
            ");
			$db->bindAll(array(
				"list_order" => $order,
				"export_group_id" => $export_group_id
			));
			$db->execute();

			$order++;
		}

		return array(true, $L["notify_export_group_reordered"]);
	}


	/**
	 * This returns the IDs of the previous and next export groups, for the << prev, next >> navigation.
	 *
	 * @param integer $export_group_id
	 * @return array prev_id => the previous export group ID (or empty string)
	 *               next_id => the next export group ID (or empty string)
	 */
	public static function getExportGroupPrevNextLinks($export_group_id)
	{
		$db = Core::$db;

		$db->query("
            SELECT export_group_id
            FROM   {PREFIX}module_export_groups
            ORDER BY list_order ASC
        ");
		$db->execute();

		$sorted_ids = $db->fetchAll(PDO::FETCH_COLUMN);
		$current_index = array_search($export_group_id, $sorted_ids);

		$return_info = array("prev_id" => "", "next_id" => "");
		if ($current_index === 0) {
			if (count($sorted_ids) > 1) {
				$return_info["next_id"] = $sorted_ids[$current_index + 1];
			}
		} else if ($current_index === count($sorted_ids) - 1) {
			if (count($sorted_ids) > 1)
				$return_info["prev_id"] = $sorted_ids[$current_index - 1];
		} else {
			$return_info["prev_id"] = $sorted_ids[$current_index - 1];
			$return_info["next_id"] = $sorted_ids[$current_index + 1];
		}

		return $return_info;
	}


	public static function deserializedExportGroupMapping($str)
	{
		$form_ids = array();
		$view_ids = array();

		if (!empty($str)) {
			list($form_ids, $view_ids) = explode("|", $str);
			$form_ids = explode(",", $form_ids);
			$view_ids = explode(",", $view_ids);
		}

		return array(
			"form_ids" => $form_ids,
			"view_ids" => $view_ids
		);
	}
}
