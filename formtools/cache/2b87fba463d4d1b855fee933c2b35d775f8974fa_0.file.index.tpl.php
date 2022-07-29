<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:32:34
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd74220c12a9_15808498',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '2b87fba463d4d1b855fee933c2b35d775f8974fa' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd74220c12a9_15808498 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
if (!is_callable('smarty_function_clients_dropdown')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.clients_dropdown.php';
if (!is_callable('smarty_function_display_num_form_submissions')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.display_num_form_submissions.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


<table cellpadding="0" cellspacing="0">
    <tr>
        <td width="45"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_forms.gif" width="34" height="34"/></td>
        <td class="title"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_forms'];?>
</td>
    </tr>
</table>

<?php if ($_smarty_tpl->tpl_vars['hasInvalidCacheFolder']->value) {?>
    <div class="error">
        <div style="padding: 10px">
            <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_cache_folder_problem'];?>

        </div>
    </div>
<?php }?>

<?php echo smarty_function_ft_include(array('file'=>"messages.tpl"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['num_forms']->value == 0) {?>
    <div><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_no_forms'];?>
</div>
<?php } else { ?>
    <div id="search_form" class="margin_bottom_large">

        <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">

            <table cellspacing="2" cellpadding="0" id="search_form_table">
                <tr>
                    <td class="blue" width="70"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_search'];?>
</td>
                    <?php if (count($_smarty_tpl->tpl_vars['clients']->value) > 0) {?>
                        <td>
                            <select name="client_id">
                                <option value=""
                                        <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['account_id'] == '') {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_forms_assigned_to_any_account'];?>
</option>
                                <optgroup label="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_clients'];?>
">
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['clients']->value, 'client', false, NULL, 'row', array (
  'index' => true,
  'iteration' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['client']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['client']->value['account_id'];?>
"
                                                <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['account_id'] == $_smarty_tpl->tpl_vars['client']->value['account_id']) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['client']->value['first_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['client']->value['last_name'];?>
</option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

                                </optgroup>
                            </select>
                        </td>
                    <?php }?>
                    <td>
                        <select name="status">
                            <option value=""
                                    <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['status'] == '') {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_all_statuses'];?>
</option>
                            <option value="online"
                                    <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['status'] == "online") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_online'];?>
</option>
                            <option value="offline"
                                    <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['status'] == "offline") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_offline'];?>
</option>
                            <option value="incomplete"
                                    <?php if ($_smarty_tpl->tpl_vars['search_criteria']->value['status'] == "incomplete") {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_incomplete'];?>
</option>
                        </select>
                    </td>
                    <td>
                        <input type="text" size="20" name="keyword" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['search_criteria']->value['keyword'], ENT_QUOTES, 'UTF-8', true);?>
"/>
                        <input type="submit" name="search_forms" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_search'];?>
"/>
                        <input type="button" name="reset" onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?reset=1'"
                                <?php if (count($_smarty_tpl->tpl_vars['forms']->value) < $_smarty_tpl->tpl_vars['num_forms']->value) {?>
                                    value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_show_all'];?>
 (<?php echo $_smarty_tpl->tpl_vars['num_forms']->value;?>
)" class="bold"
                                <?php } else { ?>
                                    value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_show_all'];?>
" class="light_grey" disabled="disabled"
                                <?php }?> />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <?php if (count($_smarty_tpl->tpl_vars['forms']->value) == 0) {?>
        <div class="notify yellow_bg">
            <div style="padding: 8px">
                <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_no_forms_found'];?>

            </div>
        </div>
    <?php } else { ?>

        <?php if ($_smarty_tpl->tpl_vars['max_forms_reached']->value) {?>
            <div class="notify margin_bottom_large">
                <div style="padding:6px">
                    <?php echo $_smarty_tpl->tpl_vars['notify_max_forms_reached']->value;?>

                </div>
            </div>
        <?php }?>

        <?php echo $_smarty_tpl->tpl_vars['pagination']->value;?>


        <?php echo smarty_function_template_hook(array('location'=>"admin_forms_list_top"),$_smarty_tpl);?>


        <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">

        <?php $_smarty_tpl->_assignInScope('table_group_id', "1");
?>

        
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['forms']->value, 'form_info', false, NULL, 'row', array (
  'index' => true,
  'iteration' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['form_info']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
            <?php $_smarty_tpl->_assignInScope('index', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index'] : null));
?>
            <?php $_smarty_tpl->_assignInScope('count', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration'] : null));
?>
            <?php $_smarty_tpl->_assignInScope('form_id', $_smarty_tpl->tpl_vars['form_info']->value['form_id']);
?>
            <?php $_smarty_tpl->_assignInScope('clients', $_smarty_tpl->tpl_vars['form_info']->value['client_info']);
?>

            
            <?php if ($_smarty_tpl->tpl_vars['count']->value == 1 || $_smarty_tpl->tpl_vars['count']->value != 1 && (($_smarty_tpl->tpl_vars['count']->value-1)%$_smarty_tpl->tpl_vars['settings']->value['num_forms_per_page'] == 0)) {?>

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

                <table class="list_table" width="100%" cellpadding="0" cellspacing="1">
                <tr>
                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "form_id-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_id-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "form_id-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_id-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_id-DESC");
?>
                    <?php }?>
                    <th width="30" class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_id'], 'UTF-8');?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>

                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "form_name-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_name-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "form_name-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_name-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_name-DESC");
?>
                    <?php }?>
                    <th class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_form'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>

                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "form_type-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_type-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "form_type-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_type-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=form_type-DESC");
?>
                    <?php }?>
                    <th nowrap class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_type'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>
                    <th><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_who_can_access'];?>
</th>

                    <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
                    <?php if ($_smarty_tpl->tpl_vars['order']->value == "status-DESC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=status-ASC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "status-ASC") {?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=status-DESC");
?>
                        <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('sort_order', "order=status-DESC");
?>
                    <?php }?>
                    <th width="90" class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_status'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
                    </th>
                    <th width="90"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_submissions'];?>
</th>
                    <th class="edit"></th>
                    <th class="del"></th>
                </tr>
            <?php }?>
            <tr>
                <td align="center" class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
</td>
                <td class="pad_left_small">
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['form_type'] == "external") {?>
                        <?php echo $_smarty_tpl->tpl_vars['form_info']->value['form_name'];?>

                        <a href="<?php echo $_smarty_tpl->tpl_vars['form_info']->value['form_url'];?>
" class="show_form" target="_blank"
                           title="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_open_form_in_dialog'];?>
"></a>
                    <?php } else { ?>
                        <?php echo $_smarty_tpl->tpl_vars['form_info']->value['form_name'];?>

                    <?php }?>
                </td>
                <td align="center">
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['form_type'] == "external") {?>
                        <span class="brown"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_external'];?>
</span>
                    <?php } elseif ($_smarty_tpl->tpl_vars['form_info']->value['form_type'] == "internal") {?>
                        <span class="orange"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_internal'];?>
</span>
                    <?php }?>
                    <?php echo smarty_function_template_hook(array('location'=>"admin_forms_form_type_label"),$_smarty_tpl);?>

                </td>
                <td>

                    
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == 'no') {?>

                    <?php } elseif ($_smarty_tpl->tpl_vars['form_info']->value['access_type'] == 'admin') {?>
                        <span class="medium_grey pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_admin_only'];?>
</span>
                    <?php } elseif ($_smarty_tpl->tpl_vars['form_info']->value['access_type'] == 'public') {?>

                        <?php if (count($_smarty_tpl->tpl_vars['form_info']->value['client_omit_list']) == 0) {?>
                            <span class="pad_left_small blue"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_all_clients'];?>
</span>
                        <?php } else { ?>
                            <?php echo smarty_function_clients_dropdown(array('only_show_clients'=>$_smarty_tpl->tpl_vars['form_info']->value['client_omit_list'],'display_single_client_as_text'=>true,'include_blank_option'=>true,'blank_option'=>"All clients, except:",'force_show_blank_option'=>true),$_smarty_tpl);?>

                        <?php }?>

                    <?php } else { ?>

                        <?php if (count($_smarty_tpl->tpl_vars['clients']->value) == 0) {?>
                            <span class="pad_left_small light_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_no_clients'];?>
</span>
                        <?php } elseif (count($_smarty_tpl->tpl_vars['clients']->value) == 1) {?>
                            <span class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['clients']->value[0]['first_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['clients']->value[0]['last_name'];?>
</span>
                        <?php } else { ?>
                            <select class="clients_dropdown">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['clients']->value, 'client', false, NULL, 'row2', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['client']->value) {
?>
                                    <option><?php echo $_smarty_tpl->tpl_vars['client']->value['first_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['client']->value['last_name'];?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

                            </select>
                        <?php }?>
                    <?php }?>

                </td>
                <td align="center">
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_active'] == "no") {?>
                        <?php $_smarty_tpl->_assignInScope('status', "<span style=\"color: orange\">".((string)$_smarty_tpl->tpl_vars['LANG']->value['word_offline'])."</span>");
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('status', "<span class=\"light_green\">".((string)$_smarty_tpl->tpl_vars['LANG']->value['word_online'])."</span>");
?>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == "no") {?>
                        <?php $_smarty_tpl->_assignInScope('status', "<span style=\"color: red\">".((string)$_smarty_tpl->tpl_vars['LANG']->value['word_incomplete'])."</span>");
?>
                        <?php $_smarty_tpl->_assignInScope('file', 'add/step2.php');
?>
                    <?php } else { ?>
                        <?php $_smarty_tpl->_assignInScope('file', 'edit/');
?>
                    <?php }?>

                    <?php echo $_smarty_tpl->tpl_vars['status']->value;?>


                </td>
                <td <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == "no") {?>align="center"<?php }?>>
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == "yes") {?>
                        <div class="form_info_link">
                            <a href="submissions.php?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
">
                                <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_view'], 'UTF-8');?>

                                <span class="num_submissions_box"><?php echo smarty_function_display_num_form_submissions(array('form_id'=>$_smarty_tpl->tpl_vars['form_id']->value),$_smarty_tpl);?>
</span>
                            </a>
                        </div>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] != "yes") {?>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['file']->value;?>
?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_complete'], 'UTF-8');?>
</a>
                    <?php }?>
                </td>
                <td <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == "yes") {?>class="edit"<?php }?>>
                    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_complete'] == "yes") {?>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['file']->value;?>
?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
"></a>
                    <?php }?>
                </td>
                <td class="del"><a href="delete_form.php?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
"></a></td>
            </tr>
            <?php if ($_smarty_tpl->tpl_vars['count']->value != 1 && ($_smarty_tpl->tpl_vars['count']->value%$_smarty_tpl->tpl_vars['settings']->value['num_forms_per_page']) == 0) {?>
                </table></div>
                <?php $_smarty_tpl->_assignInScope('table_group_id', $_smarty_tpl->tpl_vars['table_group_id']->value+1);
?>
            <?php }?>

        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>


        
        <?php if ((count($_smarty_tpl->tpl_vars['forms']->value)%$_smarty_tpl->tpl_vars['settings']->value['num_forms_per_page']) != 0) {?>
            </table></div>
        <?php }?>

    <?php }?>

    </form>

<?php }?>

<?php if (!$_smarty_tpl->tpl_vars['max_forms_reached']->value) {?>
    <form method="post" action="add/">
        <p>
            <input type="submit" name="new_form" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_add_form'];?>
"/>
        </p>
    </form>
<?php }?>

<?php echo smarty_function_template_hook(array('location'=>"admin_forms_list_bottom"),$_smarty_tpl);?>


<?php echo smarty_function_ft_include(array('file'=>"footer.tpl"),$_smarty_tpl);?>

<?php }
}
