<?php

require_once("../../global/library.php");

use FormTools\Modules;
use FormTools\Sessions;
use FormTools\Submissions;
use FormTools\ViewFields;


switch ($request["action"]) {

	// called by the administrator or client on the Edit Submission page
	case "delete_submission_files":
		$module = Modules::initModulePage("client");

		$form_id = Sessions::get("curr_form_id");
		$submission_id = Sessions::get("last_submission_id");
		$view_id = Sessions::get("form_{$form_id}_view_id");
		$field_id = $request["field_id"];

		// check the submission and field being deleted belongs to the View the user is in
		$view_field = ViewFields::getViewField($view_id, $field_id);
		if (!Submissions::checkViewContainsSubmission($form_id, $view_id, $submission_id) || empty($view_field)) {
			output_json_with_return_vars(array(
				"success" => false,
				"message" => "Permission denied."
			));
			break;
		}

		$files = $request["files"];
		$force_delete = ($request["force_delete"] == "true") ? true : false;

		list ($success, $message, $deleted_files) = $module->deleteFilesFromField($form_id, $submission_id, $field_id, $files, $force_delete);
		output_json_with_return_vars(array(
			"success" => $success,
			"message" => $message,
			"deleted_files" => $deleted_files
		));
		break;

	// this is called when the field type is being used in the Form Builder. This is just slightly more restrictive than
	// the logged-in context: it pulls the form ID and submission ID from sessions instead of from the page (which could
	// be hacked)
	case "delete_submission_file_standalone":
		$module = Modules::initModulePage();
		$published_form_id = (isset($request["published_form_id"])) ? $request["published_form_id"] : "";

		if (empty($published_form_id)) {
			output_json_with_return_vars(array(
				"success" => 0,
				"message" => "Your form is missing the form_tools_published_form_id ID field."
			));
			exit;
		}
		$form_id = $_SESSION["form_builder_{$published_form_id}"]["form_tools_form_id"];
		$submission_id = $_SESSION["form_builder_{$published_form_id}"]["form_tools_submission_id"];
		$field_id = $request["field_id"];
		$force_delete = ($request["force_delete"] == "true") ? true : false;
		$files = $request["files"];

		list ($success, $message, $deleted_files) = $module->deleteFilesFromField($form_id, $submission_id, $field_id, $files, $force_delete);
		output_json_with_return_vars(array(
			"success" => 1,
			"message" => $message,
			"deleted_files" => $deleted_files
		));
		break;
}


function output_json_with_return_vars($data)
{
	global $request;
	echo json_encode(array_merge($request["return_vars"], $data));
}
