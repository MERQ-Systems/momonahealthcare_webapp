<?php

/**
 * Export.php
 *
 * This file does the actual generation of the content for view / display by the user. It calls the
 * export.tpl found in the /modules/export_manager/templates folder.
 */

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Sessions;

$module = Modules::initModulePage("client");
$L = $module->getLangStrings();
$root_dir = Core::getRootDir();
$root_url = Core::getRootUrl();

// passed in explicitly via POST or GET
$export_group_id = (isset($request["export_group_id"])) ? $request["export_group_id"] : "";
$export_type_id = (isset($request["export_type_id"])) ? $request["export_type_id"] : "";
$results = (isset($request["export_group_{$export_group_id}_results"])) ? $request["export_group_{$export_group_id}_results"] : "all";

// drawn from sessions
$form_id = Sessions::getWithFallback("curr_form_id", "");
$view_id = Sessions::getWithFallback("form_{$form_id}_view_id", "");
$order = Sessions::getWithFallback("current_search.order", "");
$search_fields = Sessions::getWithFallback("current_search.search_fields", array());

$export_group_results = Modules::loadModuleField("export_manager", "export_group_{$export_group_id}_results", "export_group_{$export_group_id}_results");

$module->export(array(
	"form_id" => $form_id,
	"view_id" => $view_id,
	"order" => $order,
	"search_fields" => $search_fields,
	"export_group_id" => $export_group_id,
	"export_type_id" => $export_type_id,
	"results" => $results
));
