<?php

use FormTools\Modules;
use FormTools\Sessions;

$success = true;
$message = "";
if (isset($_POST["send"])) {
    list($success, $message) = $module->sendTestEmail($_POST);
}

$email = Sessions::get("account.email");

$settings = $module->getSettings();
$test_email_format = Modules::loadModuleField("swift_mailer", "test_email_format", "test_email_format", "text");
$recipient_email   = Modules::loadModuleField("swift_mailer", "recipient_email", "recipient_email", $email);
$from_email        = Modules::loadModuleField("swift_mailer", "from_email", "from_email", $email);

$page_vars = array(
    "g_success" => $success,
    "g_message" => $message,
    "page" => $page,
    "tabs" => $tabs,
    "test_email_format" => $test_email_format,
    "recipient_email" => $recipient_email,
    "from_email" => $from_email,
    "sm_settings" => $settings,
    "php_version" => phpversion()
);

$page_vars["head_js"] =<<<END
var rules = [];
rules.push("required,recipient_email,{$L["validation_no_recipient_email"]}");
rules.push("valid_email,recipient_email,{$L["validation_invalid_recipient_email"]}");
rules.push("required,from_email,{$L["validation_no_sender_email"]}");
rules.push("valid_email,from_email,{$L["validation_invalid_sender_email"]}");
END;

$module->displayPage("templates/index.tpl", $page_vars);
