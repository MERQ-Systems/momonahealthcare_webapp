<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Modules\SystemCheck\General;
use FormTools\Modules\SystemCheck\Hooks;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();
$root_url = Core::getRootUrl();

if (isset($_GET["repair"])) {
    $module_ids = explode(",", $_GET["repair"]);
    list($g_success, $g_message) = Hooks::resetModuleHookCalls($module_ids);
}

// example
//Generation::generateModuleHookArray("module_hooks_manager_rules", "1.1.4");
//exit;

$word_testing_uc = mb_strtoupper($L["word_untested"]);
$word_passed_uc  = mb_strtoupper($L["word_passed"]);
$word_failed_uc  = mb_strtoupper($L["word_failed"]);
$notify_hook_verification_complete_problems = addcslashes($L["notify_hook_verification_complete_problems"], '"');

$page_vars = array();
$page_vars["module_list"] = General::getCompatibleModules("hooks");
$page_vars["head_js"] =<<< EOF
g.messages = [];
g.messages["word_testing_c"] = "{$L["word_testing_c"]}";
g.messages["word_untested"] = "$word_testing_uc";
g.messages["word_passed"] = "$word_passed_uc";
g.messages["word_failed"] = "$word_failed_uc";
g.messages["phrase_missing_table_c"] = "{$L["phrase_missing_table_c"]}";
g.messages["phrase_missing_column_c"] = "{$L["phrase_missing_column_c"]}";
g.messages["phrase_table_looks_good_c"] = "{$L["phrase_table_looks_good_c"]}";
g.messages["phrase_invalid_column_c"] = "{$L["phrase_invalid_column_c"]}";
g.messages["text_tables_test"] = "{$L["text_tables_test"]}";
g.messages["notify_test_complete_problems"] = "{$L["notify_test_complete_problems"]}";
g.messages["notify_test_complete_no_problems"] = "{$L["notify_test_complete_no_problems"]}";
g.messages["validation_no_components_selected"] = "{$L["validation_no_components_selected"]}";
g.messages["notify_hook_verification_complete_problems"] = "$notify_hook_verification_complete_problems";

var loading = new Image();
loading.src = "$root_url/modules/system_check/images/loading.gif";
$(function() {
  $("#repair_hooks").live("click", function() {
    window.location = "hooks.php?repair=" + sc_ns.hook_verification_failed_module_ids.toString();
  });
});
EOF;

$module->displayPage("templates/hooks.tpl", $page_vars);
