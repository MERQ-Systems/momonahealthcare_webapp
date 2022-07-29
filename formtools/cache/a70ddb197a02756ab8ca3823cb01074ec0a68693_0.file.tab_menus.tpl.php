<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:39:27
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_menus.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd75bfa9acc4_57608336',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a70ddb197a02756ab8ca3823cb01074ec0a68693' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_menus.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd75bfa9acc4_57608336 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
?>
    <div class="subtitle underline margin_top_large"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_menus'], 'UTF-8');?>
</div>

    <?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


    <div class="pad_bottom_large">
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_edit_client_menu_page'];?>

    </div>

    <?php echo smarty_function_template_hook(array('location'=>"admin_settings_menus_top"),$_smarty_tpl);?>


    <?php echo $_smarty_tpl->tpl_vars['pagination']->value;?>


    <table class="list_table" cellspacing="1" cellpadding="0">
    <tr>
      <th><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_menu'];?>
</th>
      <th><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_menu_type'];?>
</th>
      <th><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_account_sp'];?>
</th>
      <th class="edit"></th>
      <th class="del"></th>
    </tr>

    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['menus']->value, 'menu', false, NULL, 'row', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['menu']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
      <?php $_smarty_tpl->_assignInScope('index', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index'] : null));
?>
      <?php $_smarty_tpl->_assignInScope('menu_info', $_smarty_tpl->tpl_vars['menus']->value[$_smarty_tpl->tpl_vars['index']->value]);
?>
      <?php $_smarty_tpl->_assignInScope('menu_id', $_smarty_tpl->tpl_vars['menu_info']->value['menu_id']);
?>
      <tr>
        <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['menu_info']->value['menu'];?>
</td>
        <td class="pad_left_small">
          <?php if ($_smarty_tpl->tpl_vars['menu_info']->value['menu_type'] == "admin") {?>
            <span class="light_green"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_admin_menu'];?>
</span>
          <?php } else { ?>
            <span class="blue"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_client_menu'];?>
</span>
          <?php }?>
        </td>
        <td class="pad_left_small">
          <?php if ($_smarty_tpl->tpl_vars['menu_info']->value['menu_type'] == "admin") {?>
            <?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_administrator'];?>

          <?php } else { ?>
            <?php if (count($_smarty_tpl->tpl_vars['menu_info']->value['account_info']) == 0) {?>
              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_no_clients'];?>

            <?php } elseif (count($_smarty_tpl->tpl_vars['menu_info']->value['account_info']) == 1) {?>
              <?php echo $_smarty_tpl->tpl_vars['menu_info']->value['account_info'][0]['first_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['menu_info']->value['account_info'][0]['last_name'];?>

            <?php } else { ?>
              <select>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['menu_info']->value['account_info'], 'account', false, NULL, 'account_row', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['account']->value) {
?>
                  <option><?php echo $_smarty_tpl->tpl_vars['account']->value['first_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['account']->value['last_name'];?>
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
        <td class="edit">
          <?php if ($_smarty_tpl->tpl_vars['menu_info']->value['menu_type'] == "admin") {?>
            <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?page=edit_admin_menu&menu_id=<?php echo $_smarty_tpl->tpl_vars['menu_id']->value;?>
"></a>
          <?php } else { ?>
            <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?page=edit_client_menu&menu_id=<?php echo $_smarty_tpl->tpl_vars['menu_id']->value;?>
"></a>
          <?php }?>
        </td>
        <td<?php if ($_smarty_tpl->tpl_vars['menu_info']->value['menu_type'] != "admin") {?> class="del"<?php }?>>
          <?php if ($_smarty_tpl->tpl_vars['menu']->value['menu_type'] == "client") {?>
            <a href="#" onclick="return page_ns.delete_menu(<?php echo $_smarty_tpl->tpl_vars['menu_id']->value;?>
)"></a>
          <?php }?>
        </td>
      </tr>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

    </table>

    <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
      <input type="hidden" name="page" value="edit_client_menu" />
      <p>
        <input type="submit" name="create_new_menu" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_create_new_menu'];?>
" />
      </p>
    </form>
<?php }
}
