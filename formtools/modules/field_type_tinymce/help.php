<?php

require_once("../../global/library.php");

use FormTools\Modules;

$module = Modules::initModulePage("admin");

$page_vars = array();
$module->displayPage("templates/help.tpl", $page_vars);
