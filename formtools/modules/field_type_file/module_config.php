<?php


$STRUCTURE = array();
$HOOKS = array(
	array(
		"hook_type" => "code",
		"action_location" => "manage_files",
		"function_name" => "FormTools\\Submissions::updateSubmission",
		"hook_function" => "updateSubmissionHook",
		"priority" => "50"
	),
	array(
		"hook_type" => "code",
		"action_location" => "manage_files",
		"function_name" => "FormTools\\Submissions::processFormSubmission",
		"hook_function" => "processFormSubmissionHook",
		"priority" => "50"
	),
	array(
		"hook_type" => "code",
		"action_location" => "manage_files",
		"function_name" => "FormTools\\API->processFormSubmission",
		"hook_function" => "apiProcessFormSubmissionHook",
		"priority" => "50"
	),
	array(
		"hook_type" => "code",
		"action_location" => "start",
		"function_name" => "FormTools\\Files::deleteSubmissionFiles",
		"hook_function" => "deleteSubmissionsHook",
		"priority" => "50"
	),
	array(
		"hook_type" => "code",
		"action_location" => "start",
		"function_name" => "FormTools\\Fields::getUploadedFiles",
		"hook_function" => "getUploadedFilesHook",
		"priority" => "50"
	),
	array(
		"hook_type" => "template",
		"action_location" => "head_bottom",
		"function_name" => "",
		"hook_function" => "includeJs",
		"priority" => "50"
	),
	array(
		"hook_type" => "template",
		"action_location" => "standalone_form_fields_head_bottom",
		"function_name" => "",
		"hook_function" => "includeStandaloneJs",
		"priority" => "50"
	)
);

$FILES = array(
	"code",
	"code/Module.class.php",
	"images/",
	"images/file_upload_icon.png",
	"images/index.html",
	"lang/",
	"lang/en_us.php",
	"lang/index.html",
	"scripts/",
	"scripts/edit_submission.js",
	"scripts/index.html",
	"scripts/standalone.js",
	"templates/",
	"templates/index.tpl",
	"templates/index.html",
	"actions.php",
	"index.php",
	"library.php",
	"module_config.php",
	"README.md",
);
