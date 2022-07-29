<?php

require_once("../../global/library.php");

use FormTools\Modules;

$module = Modules::initModulePage("client");
if ($request["action"] == "remember_advanced_settings") {
    Modules::loadModuleField("swift_mailer", "remember_advanced_settings", "remember_advanced_settings");
}
