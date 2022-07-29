<?php

use FormTools\Modules;
use FormTools\Modules\FormBuilder\TemplateSets;


// yeesh... terminology for "sections" / "types" / "names" is terrible... they all refer to the same thing
function smarty_function_template_sets($params, &$smarty)
{
    $module = Modules::getModuleInstance("form_builder");
    $L = $module->getLangStrings();

    $name_id = $params["name_id"];
    $class = isset($params["class"]) ? $params["class"] : "";
    $default = isset($params["default"]) ? $params["default"] : "";
    $only_show_complete = isset($params["only_return_complete"]) ? $params["only_return_complete"] : true;
    $is_base_on_dropdown = isset($params["is_base_on_dropdown"]) ? $params["is_base_on_dropdown"] : false;

    $template_sets = TemplateSets::getTemplateSets($only_show_complete);

    $lines = array("<select name=\"{$name_id}\" id=\"{$name_id}\" class=\"$class\">");

    if (!empty($is_base_on_dropdown)) {
        $lines[] = "<option value=\"\">{$L["phrase_new_template_set"]}</option>";
        $lines[] = "<optgroup label=\"{$L["phrase_existing_template_set"]}\">";
    }

    foreach ($template_sets as $set_info) {
        $set_id = $set_info["set_id"];
        $set_name = $set_info["set_name"];
        $selected = ($default == $set_id) ? "selected" : "";

        $lines[] = "<option value=\"$set_id\" $selected>$set_name</option>";
    }

    if (!empty($is_base_on_dropdown)) {
        $lines[] = "</optgroup>";
    }
    $lines[] = "</select>";

    echo implode("\n", $lines);
}
