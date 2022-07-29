<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:38:37
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/themes/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd758d26ddf3_68650960',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '92edfe0bc9c36439184b4ee8ace67dd6983d4216' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/themes/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd758d26ddf3_68650960 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_themes_dropdown')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.themes_dropdown.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


<table cellpadding="0" cellspacing="0" height="35">
    <tr>
        <td width="45"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_themes.gif" width="34" height="29"/></td>
        <td class="title"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_themes'];?>
</td>
    </tr>
</table>

<?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


<div class="margin_bottom_large">
    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_theme_page_intro'];?>

</div>

<form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post" onsubmit="return rsv.validate(this, rules)">
    <table cellspacing="0" cellpadding="1" class="margin_bottom_large">
        <tr>
            <td width="180"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_administrator_theme'];?>
</td>
            <td><?php echo smarty_function_themes_dropdown(array('name_id'=>"admin_theme",'default'=>$_smarty_tpl->tpl_vars['admin_theme']->value,'default_swatch'=>$_smarty_tpl->tpl_vars['admin_theme_swatch']->value),$_smarty_tpl);?>
</td>
        </tr>
        <tr>
            <td><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_default_client_account_theme'];?>
</td>
            <td>
                <?php echo smarty_function_themes_dropdown(array('name_id'=>"default_client_theme",'default'=>$_smarty_tpl->tpl_vars['client_theme']->value,'default_swatch'=>$_smarty_tpl->tpl_vars['client_theme_swatch']->value),$_smarty_tpl);?>

                <span class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_also_default_login_page_theme'];?>
</span>
            </td>
        </tr>
    </table>

    <?php if (count($_smarty_tpl->tpl_vars['themes']->value) == 0) {?>
        <div><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_no_themes'];?>
</div>
    <?php } else { ?>
        <table cellspacing="1" cellpadding="0" width="100%" class="list_table check_areas">
            <tr>
                <th width="200"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_image'];?>
</th>
                <th><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_theme_info'];?>
</th>
                <th width="70"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_enabled'];?>
</th>
            </tr>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['themes']->value, 'theme', false, NULL, 'row', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['theme']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
                <?php $_smarty_tpl->_assignInScope('index', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index'] : null));
?>
                <?php $_smarty_tpl->_assignInScope('theme_info', $_smarty_tpl->tpl_vars['themes']->value[$_smarty_tpl->tpl_vars['index']->value]);
?>
                <tr>
                    <td valign="top">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/themes/<?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_folder'];?>
/about/screenshot.gif" class="fancybox"
                           title="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['theme_info']->value['theme_name'], ENT_QUOTES, 'UTF-8', true);?>
"><img
                                    src="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/themes/<?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_folder'];?>
/about/thumbnail.gif"
                                    border="0"/></a>
                    </td>
                    <td valign="top" class="pad_left">
                        <div>
                            <span class="bold"><?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_name'];?>
</span>
                            <span class="pad_right_large"><?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_version'];?>
</span>
                            [<a href="about.php?theme_id=<?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_id'];?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_about'], 'UTF-8');?>
</a>]
                        </div>
                        <?php if ($_smarty_tpl->tpl_vars['theme_info']->value['uses_swatches'] == "yes") {?>
                            <div><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_available_swatches_c'];?>
 <span
                                        class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['theme_info']->value['available_swatches'];?>
</span></div>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['theme_info']->value['author']) {?>
                            <div><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_author_c'];?>
 <?php echo $_smarty_tpl->tpl_vars['theme_info']->value['author'];?>
</div><?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['theme_info']->value['description']) {?><p><?php echo $_smarty_tpl->tpl_vars['theme_info']->value['description'];?>
</p><?php }?>
                    </td>
                    <td valign="top" align="center" class="check_area">
                        <input type="checkbox" name="is_enabled[]" value="<?php echo $_smarty_tpl->tpl_vars['theme_info']->value['theme_folder'];?>
"
                               <?php if ($_smarty_tpl->tpl_vars['theme_info']->value['is_enabled'] == 'yes') {?>checked="checked"<?php }?> />
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

            <?php echo smarty_function_template_hook(array('location'=>"admin_settings_themes_bottom"),$_smarty_tpl);?>

        </table>
    <?php }?>

    <p>
        <input type="submit" name="update" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_update'];?>
"/>
        <input type="submit" name="refresh_theme_list" class="blue" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_refresh_theme_list'];?>
"/>
    </p>
</form>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
