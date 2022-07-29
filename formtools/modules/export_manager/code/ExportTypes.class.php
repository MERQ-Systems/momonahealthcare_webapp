<?php

namespace FormTools\Modules\ExportManager;

use FormTools\Core;
use PDO;

class ExportTypes
{
    /**
     * Deletes an export type.
     *
     * @param integer $export_type_id
     */
    public static function deleteExportType($export_type_id, $L)
    {
        $db = Core::$db;

        $export_type_info = self::getExportType($export_type_id);

        $db->query("
            DELETE FROM {PREFIX}module_export_types
            WHERE export_type_id = :export_type_id
        ");
        $db->bind("export_type_id", $export_type_id);
        $db->execute();

        // now make sure there aren't any gaps in the
        self::checkExportTypeOrder($export_type_info["export_group_id"]);

        return array(true, $L["notify_export_type_deleted"]);
    }


    /**
     * Returns all information about a particular Export type.
     *
     * @param integer $export_type_id
     * @return array
     */
    public static function getExportType($export_type_id)
    {
        $db = Core::$db;

        $db->query("
            SELECT *, met.smarty_template as export_type_smarty_template
            FROM   {PREFIX}module_export_types met, {PREFIX}module_export_groups metg
            WHERE  met.export_group_id = metg.export_group_id AND
                   met.export_type_id = :export_type_id
        ");
        $db->bind("export_type_id", $export_type_id);
        $db->execute();

        return $db->fetch();
    }


    /**
     * Returns all available export types in the database.
     *
     * @param integer $export_group (optional)
     * @param boolean $only_return_visible (optional, defaulted to FALSE)
     * @return array
     */
    public static function getExportTypes($export_group = "", $only_return_visible = false)
    {
        $db = Core::$db;

        $group_clause = (!empty($export_group)) ? "AND met.export_group_id = $export_group" : "";
        $visibility_clause = ($only_return_visible) ? "AND met.export_type_visibility = 'show'" : "";

        $db->query("
            SELECT *, met.list_order as export_type_list_order, met.smarty_template as export_type_smarty_template
            FROM   {PREFIX}module_export_types met, {PREFIX}module_export_groups metg
            WHERE  met.export_group_id = metg.export_group_id
                $group_clause
                $visibility_clause
            ORDER BY met.list_order
        ");
        $db->execute();

        return $db->fetchAll();
    }


    /**
     * Returns all available export types in the database.
     *
     * @param integer $export_group
     * @return array
     */
    public static function getNumExportTypes($export_group_id)
    {
        $db = Core::$db;
        $db->query("
            SELECT count(*)
            FROM   {PREFIX}module_export_types
            WHERE  export_group_id = :export_group_id
        ");
        $db->bind("export_group_id", $export_group_id);
        $db->execute();

        return $db->fetch(PDO::FETCH_COLUMN);
    }


    /**
     * Adds a new export type.
     *
     * @param array $info
     */
    public static function addExportType($info, $L)
    {
        $db = Core::$db;

        $export_group_id = $info["export_group_id"];

        // get the next highest order count
        $db->query("
            SELECT count(*)
            FROM {PREFIX}module_export_types
            WHERE export_group_id = :export_group_id
        ");
        $db->bind("export_group_id", $export_group_id);
        $db->execute();

        $count = $db->fetch(PDO::FETCH_COLUMN) + 1;

        $db->query("
            INSERT INTO {PREFIX}module_export_types (export_type_name, export_type_visibility, filename, export_group_id, smarty_template, list_order)
            VALUES (:export_type_name, :export_type_visibility, :filename, :export_group_id, :smarty_template, :list_order)
        ");
        $db->bindAll(array(
            "export_type_name" => $info["export_type_name"],
            "export_type_visibility" => $info["visibility"],
            "filename" => $info["filename"],
            "export_group_id" => $info["export_group_id"],
            "smarty_template" => $info["smarty_template"],
            "list_order" => $count
        ));
        $db->execute();

        return array(true, $L["notify_export_type_added"]);
    }


    /**
     * Updates an export type.
     *
     * @param integer $export_type_id
     * @param array
     */
    public static function updateExportType($info, $L)
    {
        $db = Core::$db;

        $db->query("
            UPDATE {PREFIX}module_export_types
            SET    export_type_name = :export_type_name,
                   export_type_visibility = :visibility,
                   filename = :filename,
                   export_group_id = :export_group_id,
                   smarty_template = :smarty_template
            WHERE  export_type_id = :export_type_id
        ");
        $db->bindAll(array(
            "export_type_name" => $info["export_type_name"],
            "visibility" => $info["visibility"],
            "filename" => $info["filename"],
            "export_group_id" => $info["export_group_id"],
            "smarty_template" => $info["smarty_template"],
            "export_type_id" => $info["export_type_id"]
        ));
        $db->execute();

        return array(true, $L["notify_export_type_updated"]);
    }


    /**
     * This can be called after deleting an export type, or whenever is needed to ensure that the
     * order of the export types are consistent, accurate & don't have any gaps.
     */
    public static function checkExportTypeOrder($export_group_id)
    {
        $db = Core::$db;

        if (empty($export_group_id)) {
            return;
        }

        $db->query("
            SELECT export_type_id
            FROM   {PREFIX}module_export_types
            WHERE  export_group_id = :export_group_id
            ORDER BY list_order
        ");
        $db->bind("export_group_id", $export_group_id);
        $db->execute();
        $ordered_types = $db->fetchAll(PDO::FETCH_COLUMN);

        $order = 1;
        foreach ($ordered_types as $export_type_id) {
            $db->query("
                UPDATE {PREFIX}module_export_types
                SET    list_order = :list_order
                WHERE  export_type_id = :export_type_id
            ");
            $db->bindAll(array(
                "list_order" => $order,
                "export_type_id" => $export_type_id
            ));
            $db->execute();

            $order++;
        }
    }


    /**
     * Called by the administrator on the Export Types tab of the Edit Export Group page. It reorders the export
     * types within a particular export group.
     *
     * @param array $info
     */
    public static function reorderExportTypes($info, $L)
    {
        $db = Core::$db;

        $export_group_id = $info["export_group_id"];
        $sortable_id = $info["sortable_id"];
        $export_type_ids = explode(",", $info["{$sortable_id}_sortable__rows"]);

        $order = 1;
        foreach ($export_type_ids as $export_type_id) {
            $db->query("
                UPDATE {PREFIX}module_export_types
                SET    list_order = :list_order
                WHERE  export_type_id = :export_type_id AND
                       export_group_id = :export_group_id
            ");
            $db->bindAll(array(
                "list_order" => $order,
                "export_type_id" => $export_type_id,
                "export_group_id" => $export_group_id
            ));
            $db->execute();

            $order++;
        }

        return array(true, $L["notify_export_types_reordered"]);
    }


    /**
     * This function is used when drawing the visible export options to ths page. It determines which export groups &
     * types get displayed for a particular form, View and account.
     *
     * @param mixed $account_id - "admin" or the client ID
     * @param integer $form_id
     * @param integer $view_id
     * @return array an array of hashes
     */
    public static function getAssignedExportTypes($account_id, $form_id, $view_id)
    {
        $db = Core::$db;

        $is_client = ($account_id == "admin") ? false : true;

        // Step 1: get all accessible export GROUPS
        $private_client_accessible_export_group_ids = array();
        if ($is_client) {
            $db->query("
                SELECT export_group_id
                FROM   {PREFIX}module_export_group_clients
                WHERE  account_id = :account_id
            ");
            $db->bind("account_id", $account_id);
            $db->execute();

            $private_client_accessible_export_group_ids = $db->fetchAll(PDO::FETCH_COLUMN);
        }

        $export_groups = ExportGroups::getExportGroups();
        $accessible_export_groups = array();
        foreach ($export_groups as $group) {
            if ($group["visibility"] == "hide") {
                continue;
            }

            if ($group["access_type"] == "public") {
                $accessible_export_groups[] = $group;
            } else {
                if ($is_client) {
                    if ($group["access_type"] != "admin" && in_array($group["export_group_id"], $private_client_accessible_export_group_ids)) {
                        $accessible_export_groups[] = $group;
                    }
                } else {
                    $accessible_export_groups[] = $group;
                }
            }
        }

        // so far so good. We now have a list of export groups that hav been filtered by visibility & whether
        // the client can see them. Next, factor in the current form ID and view ID
        $filtered_export_groups = array();
        foreach ($accessible_export_groups as $export_group) {
            if ($export_group["form_view_mapping"] == "all") {
                $filtered_export_groups[] = $export_group;
            } else {
                if ($export_group["form_view_mapping"] == "only") {
                    $mapping = ExportGroups::deserializedExportGroupMapping($export_group["forms_and_views"]);
                    if (!in_array($form_id, $mapping["form_ids"])) {
                        continue;
                    }

                    if (in_array("form{$form_id}_all_views", $mapping["view_ids"]) || in_array($view_id, $mapping["view_ids"])) {
                        $filtered_export_groups[] = $export_group;
                    }
                } else {
                    if ($export_group["form_view_mapping"] == "except") {
                        $mapping = ExportGroups::deserializedExportGroupMapping($export_group["forms_and_views"]);
                        if (in_array("form{$form_id}_all_views", $mapping["view_ids"])) {
                            continue;
                        }

                        if (in_array($view_id, $mapping["view_ids"])) {
                            continue;
                        }

                        $filtered_export_groups[] = $export_group;
                    }
                }
            }
        }


        // Step 2: alright! Now we get the list of export types for the accessible Views
        $export_groups_and_types = array();
        foreach ($filtered_export_groups as $export_group) {
            $export_types = self::getExportTypes($export_group["export_group_id"], true);
            if (count($export_types) == 0) {
                continue;
            }

            $export_group["export_types"] = $export_types;
            $export_groups_and_types[] = $export_group;
        }

        return $export_groups_and_types;
    }

}
