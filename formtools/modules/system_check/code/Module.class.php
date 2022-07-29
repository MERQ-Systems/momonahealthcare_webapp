<?php

namespace FormTools\Modules\SystemCheck;


use FormTools\Module as FormToolsModule;


class Module extends FormToolsModule
{
	protected $moduleName = "System Check";
	protected $moduleDesc = "This module offers a few tests to analyze and repair your Form Tools installation.";
	protected $author = "Ben Keen";
	protected $authorEmail = "ben.keen@gmail.com";
	protected $authorLink = "http://formtools.org";
	protected $version = "2.1.5";
	protected $date = "2019-03-17";
	protected $originLanguage = "en_us";
	protected $jsFiles = array("scripts/tests.js");
	protected $cssFiles = array("css/styles.css");

	protected $nav = array(
		"module_name" => array("index.php", false),
		"phrase_file_verification" => array("files.php", true),
		"phrase_table_verification" => array("tables.php", true),
		"phrase_hook_verification" => array("hooks.php", true),
		"phrase_orphan_clean_up" => array("orphans.php", true),
		"phrase_environment_info" => array("env.php", false),
		"word_help" => array("help.php", false)
	);
}
