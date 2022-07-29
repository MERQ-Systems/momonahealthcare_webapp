<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:39:34
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_main.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd75c60db170_70377384',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '45b28f02fc3e6139022148e2e0ed7f2f5f606f93' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_main.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd75c60db170_70377384 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
?>
<div class="subtitle underline margin_top_large"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_settings'], 'UTF-8');?>
</div>

<?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


<form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post" onsubmit="return rsv.validate(this, rules)">
    <input type="hidden" name="page" value="main"/>

    <table class="list_table" cellpadding="0" cellspacing="1">
        <tr>
            <td class="pad_left_small" width="200"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_core_version'];?>
</td>
            <td class="pad_left_small">
                <?php if ($_smarty_tpl->tpl_vars['settings']->value['release_type'] == "alpha") {?>
                    <span><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
-alpha-<?php echo $_smarty_tpl->tpl_vars['settings']->value['release_date'];?>
</span>
                <?php } elseif ($_smarty_tpl->tpl_vars['settings']->value['release_type'] == "beta") {?>
                    <span><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
-beta-<?php echo $_smarty_tpl->tpl_vars['settings']->value['release_date'];?>
</span>
                <?php } else { ?>
                    <span><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
</span>
                <?php }?>
            </td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_api_version'];?>
</td>
            <td class="pad_left_small">
                <?php echo (($tmp = @$_smarty_tpl->tpl_vars['settings']->value['api_version'])===null||$tmp==='' ? "<span class=\"light_grey\">".((string)$_smarty_tpl->tpl_vars['LANG']->value['notify_no_api_installed'])."</span>" : $tmp);?>

            </td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_program_name'];?>
</td>
            <td><input type="text" name="program_name" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['program_name'];?>
" style="width: 98%"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_logo_link_url'];?>
</td>
            <td><input type="text" name="logo_link" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['logo_link'];?>
" style="width: 98%"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_cache_folder'];?>
</td>
            <td>
                <?php echo $_smarty_tpl->tpl_vars['cache_folder']->value;?>

                <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_clear_cache_folder'];?>
"
                       onclick="ft.clear_cache_folder('clear_folder_result')" />

                <div id="clear_folder_result"></div>
            </td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_clients_per_page'];?>
</td>
            <td><input type="text" name="num_clients_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_clients_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_emails_per_page'];?>
</td>
            <td><input type="text" name="num_emails_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_emails_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_forms_per_page'];?>
</td>
            <td><input type="text" name="num_forms_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_forms_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_option_lists_per_page'];?>
</td>
            <td><input type="text" name="num_option_lists_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_option_lists_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_menus_per_page'];?>
</td>
            <td><input type="text" name="num_menus_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_menus_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_modules_per_page'];?>
</td>
            <td><input type="text" name="num_modules_per_page" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['num_modules_per_page'];?>
"
                       style="width: 30px"/></td>
        </tr>
        <tr>
            <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_default_date_field_search_value'];?>
</td>
            <td>
                <select name="default_date_field_search_value">
                    <option value="none"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "none") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_none'];?>
</option>
                    <option value="today"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "today") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_today'];?>
</option>
                    <option value="last_7_days"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "last_7_days") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_last_7_days'];?>
</option>
                    <option value="month_to_date"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "month_to_date") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_month_to_date'];?>
</option>
                    <option value="year_to_date"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "year_to_date") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_year_to_date'];?>
</option>
                    <option value="previous_month"
                            <?php if ($_smarty_tpl->tpl_vars['settings']->value['default_date_field_search_value'] == "previous_month") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_the_previous_month'];?>
</option>
                </select>
            </td>
        </tr>
        <?php echo smarty_function_template_hook(array('location'=>"admin_settings_main_tab_bottom"),$_smarty_tpl);?>

    </table>

    <p>
        <input type="submit" name="update_main" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_update'];?>
"/>
    </p>

</form>

<?php }
}
