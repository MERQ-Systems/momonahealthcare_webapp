<?php

require_once("../../global/library.php");

use FormTools\Core;
use FormTools\Modules;

$module = Modules::initModulePage("admin");
$root_url = Core::getRootUrl();

//use FormTools\Modules\SystemCheck\Generation;
//Generation::getRepoFiles(realpath(dirname(__DIR__ . "/../../../")));
//exit;

$module->displayPage("templates/index.tpl");
