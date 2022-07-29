<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:38:08
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/modules/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd7570646617_89124200',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '1f6f66cc738c1c2d26ab33b3017e26987d930b95' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/modules/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd7570646617_89124200 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


<table cellpadding="0" cellspacing="0" height="35">
    <tr>
        <td width="45"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_modules.gif" width="34" height="34"/></td>
        <td class="title"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_modules'];?>
</td>
    </tr>
</table>

<?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


<div id="search_form" class=" margin_bottom_large">
    <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
        <table cellspacing="2" cellpadding="0" id="search_form_table">
            <tr>
                <td class="blue" width="70"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_search'];?>
</td>
                <td>
                    <input type="text" size="20" name="keyword" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['search_criteria']->value['keyword'], ENT_QUOTES, 'UTF-8', true);?>
"/>
                    <input type="checkbox" id="status_enabled" name="status[]" value="enabled"
                           <?php if (in_array("enabled",$_smarty_tpl->tpl_vars['search_criteria']->value['status'])) {?>checked<?php }?> />
                    <label for="status_enabled"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_enabled'];?>
</label>
                    <input type="checkbox" id="status_disabled" name="status[]" value="disabled"
                           <?php if (in_array("disabled",$_smarty_tpl->tpl_vars['search_criteria']->value['status'])) {?>checked<?php }?> />
                    <label for="status_disabled"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_disabled'];?>
</label>

                    <input type="submit" name="search_modules" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_search'];?>
" class="margin_left"/>
                    <input type="button" name="reset" onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?reset=1'"
                            <?php if (count($_smarty_tpl->tpl_vars['modules']->value) < $_smarty_tpl->tpl_vars['num_modules']->value) {?>
                                value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_show_all'];?>
 (<?php echo $_smarty_tpl->tpl_vars['num_modules']->value;?>
)" class="bold"
                            <?php } else { ?>
                                value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_show_all'];?>
" class="light_grey" disabled
                            <?php }?> />
                </td>
            </tr>
        </table>
    </form>
</div>

<?php if (count($_smarty_tpl->tpl_vars['modules']->value) == 0) {?>
    <div class="notify yellow_bg">
        <div style="padding: 8px">
            <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_no_modules_found'];?>

        </div>
    </div>
    <p>
        <input type="button" onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?refresh_module_list'" class="blue"
               value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_refresh_module_list'], ENT_QUOTES, 'UTF-8', true);?>
"/>
    </p>
<?php } else { ?>

    <?php echo $_smarty_tpl->tpl_vars['pagination']->value;?>

    <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post" class="check_areas" id="modules_form">
        <input type="hidden" name="module_ids_in_page" value="<?php echo $_smarty_tpl->tpl_vars['module_ids_in_page']->value;?>
"/>

        <?php $_smarty_tpl->_assignInScope('table_group_id', "1");
?>

        
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['modules']->value, 'module', false, NULL, 'row', array (
  'index' => true,
  'iteration' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['module']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
            <?php $_smarty_tpl->_assignInScope('index', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index'] : null));
?>
            <?php $_smarty_tpl->_assignInScope('count', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration'] : null));
?>
            <?php $_smarty_tpl->_assignInScope('module_id', $_smarty_tpl->tpl_vars['modules']->value[$_smarty_tpl->tpl_vars['index']->value]['module_id']);
?>
            <?php $_smarty_tpl->_assignInScope('module', $_smarty_tpl->tpl_vars['modules']->value[$_smarty_tpl->tpl_vars['index']->value]);
?>

            
            <?php if ($_smarty_tpl->tpl_vars['count']->value == 1 || $_smarty_tpl->tpl_vars['count']->value != 1 && (($_smarty_tpl->tpl_vars['count']->value-1)%$_smarty_tpl->tpl_vars['settings']->value['num_modules_per_page'] == 0)) {?>

                <?php if ($_smarty_tpl->tpl_vars['table_group_id']->value == "1") {?>
                    <?php $_smarty_tpl->_assignInScope('style', "display: block");
?>
                <?php } else { ?>
                    <?php $_smarty_tpl->_assignInScope('style', "display: none");
?>
                <?php }?>

                <div id="page_<?php echo $_smarty_tpl->tpl_vars['table_group_id']->value;?>
" style="<?php echo $_smarty_tpl->tpl_vars['style']->value;?>
">

                <table class="list_table" cellspacing="1" cellpadding="0">
                <tr>
                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "module_name-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=module_name-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "module_name-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=module_name-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=module_name-DESC");
?>
                    <?php }?>
                    <th<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> class="over"<?php }?>>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_module'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>
                    <th class="pad_left pad_right"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_version'];?>
</th>

                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "is_enabled-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=is_enabled-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "is_enabled-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=is_enabled-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=is_enabled-DESC");
?>
                    <?php }?>
                    <th width="70"<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> class="over"<?php }?>>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_enabled'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>
                    <th width="70"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
</th>
                    <th width="70" class="del2"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_uninstall'], 'UTF-8');?>
</th>
                </tr>
            <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['module']->value['is_installed'] == "no" || $_smarty_tpl->tpl_vars['module']->value['needs_upgrading']) {?>
            <tr class="selected_row_color">
                <?php } else { ?>
            <tr>
        <?php }?>
            <td class="pad_left_small pad_right_large" valign="top">
                <div>
                    <span class="bold pad_right_large"><?php echo $_smarty_tpl->tpl_vars['module']->value['module_name'];?>
</span>
                    [<a href="about.php?module_id=<?php echo $_smarty_tpl->tpl_vars['module']->value['module_id'];?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_about'], 'UTF-8');?>
</a>]
                </div>
                <?php if ($_smarty_tpl->tpl_vars['module']->value['module_folder'] === "core_field_types") {?>
                    <div class="error">
                        <div style="padding: 8px">
                            This module is no longer needed in Form Tools 3.
                            Please uninstall the module, then delete the <b><?php echo $_smarty_tpl->tpl_vars['g_root_dir']->value;?>
/modules/core_field_types/</b>
                            folder on your server.
                        </div>
                    </div>
                <?php } else { ?>
                    <?php if (!$_smarty_tpl->tpl_vars['module']->value['is_valid']) {?>
                        <div class="error">
                            <div style="padding: 8px">
                                This module is not compatible with Form
                                Tools 3. Please update it to the latest version.
                            </div>
                        </div>
                    <?php } else { ?>
                        <div class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['module']->value['description'];?>
</div>
                    <?php }?>
                <?php }?>
            </td>
            <td valign="top" align="center">
                <?php if ($_smarty_tpl->tpl_vars['module']->value['is_valid']) {
echo $_smarty_tpl->tpl_vars['module']->value['version'];
}?>
            </td>
            <td valign="top" align="center" <?php if ($_smarty_tpl->tpl_vars['module']->value['is_installed'] == "yes") {?>class="check_area"<?php }?>>
                <?php if ($_smarty_tpl->tpl_vars['module']->value['is_valid']) {?>
                    <?php if ($_smarty_tpl->tpl_vars['module']->value['is_installed'] == "no") {?>
                        <input type="hidden" class="module_id" value="<?php echo $_smarty_tpl->tpl_vars['module']->value['module_id'];?>
"/>
                        <input type="hidden" class="module_folder" value="<?php echo $_smarty_tpl->tpl_vars['module']->value['module_folder'];?>
"/>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?install=<?php echo $_smarty_tpl->tpl_vars['module']->value['module_id'];?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_install'], 'UTF-8');?>
</a>
                    <?php } else { ?>
                        <input type="checkbox" name="is_enabled[]" value="<?php echo $_smarty_tpl->tpl_vars['module']->value['module_id'];?>
"
                               <?php if ($_smarty_tpl->tpl_vars['module']->value['is_enabled'] == 'yes') {?>checked<?php }?> />
                    <?php }?>
                <?php }?>
            </td>
            <td valign="top" align="center">
                <?php if ($_smarty_tpl->tpl_vars['module']->value['is_enabled'] == "yes" && $_smarty_tpl->tpl_vars['module']->value['is_valid']) {?>
                    <?php if ($_smarty_tpl->tpl_vars['module']->value['needs_upgrading']) {?>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?upgrade=<?php echo $_smarty_tpl->tpl_vars['module_id']->value;?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_upgrade'], 'UTF-8');?>
</a>
                    <?php } else { ?>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/modules/<?php echo $_smarty_tpl->tpl_vars['module']->value['module_folder'];?>
/"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
</a>
                    <?php }?>
                <?php }?>
            </td>
            <td valign="top" class="del2" align="center">
                <?php if ($_smarty_tpl->tpl_vars['module']->value['is_installed'] == "yes") {?>
                    <a href="#"
                       onclick="return mm.uninstall_module(<?php echo $_smarty_tpl->tpl_vars['module']->value['module_id'];?>
)"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_uninstall'], 'UTF-8');?>
</a>
                <?php }?>
            </td>
            </tr>

            <?php if ($_smarty_tpl->tpl_vars['count']->value != 1 && ($_smarty_tpl->tpl_vars['count']->value%$_smarty_tpl->tpl_vars['settings']->value['num_modules_per_page']) == 0) {?>
                </table></div>
                <?php $_smarty_tpl->_assignInScope('table_group_id', $_smarty_tpl->tpl_vars['table_group_id']->value+1);
?>
            <?php }?>

        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>


        
        <?php if ((count($_smarty_tpl->tpl_vars['modules']->value)%$_smarty_tpl->tpl_vars['settings']->value['num_modules_per_page']) != 0) {?>
            </table></div>
        <?php }?>

        <p>
            <input type="submit" name="enable_modules" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_update'];?>
"/>
            <input type="button" onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?refresh_module_list'" class="blue"
                   value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_refresh_module_list'], ENT_QUOTES, 'UTF-8', true);?>
"/>
        </p>
    </form>
<?php }?>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
