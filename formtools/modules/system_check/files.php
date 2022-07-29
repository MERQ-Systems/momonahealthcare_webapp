<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;
use FormTools\Modules\SystemCheck\Files;
use FormTools\Modules\SystemCheck\General;

$module = Modules::initModulePage("admin");
$L = $module->getLangStrings();

$root_url = Core::getRootUrl();

$word_testing_uc = mb_strtoupper($L["word_untested"]);
$word_passed_uc  = mb_strtoupper($L["word_passed"]);
$word_failed_uc  = mb_strtoupper($L["word_failed"]);
$notify_file_verification_complete_problems = addcslashes($L["notify_file_verification_complete_problems"], '"');

$page_vars = array(
    "core_version" => Core::getVersionString(),
    "module_list" => General::getCompatibleModules("files"),
    "theme_list" => Files::getCompatibleThemes()
);

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
g.messages["notify_file_verification_complete_problems"] = "$notify_file_verification_complete_problems";
var loading = new Image();
loading.src = "$root_url/modules/system_check/images/loading.gif";
EOF;

$module->displayPage("templates/files.tpl", $page_vars);
