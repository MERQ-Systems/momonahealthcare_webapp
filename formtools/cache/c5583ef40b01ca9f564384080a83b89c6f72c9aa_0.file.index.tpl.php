<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:39:05
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd75a9633206_16593456',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'c5583ef40b01ca9f564384080a83b89c6f72c9aa' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd75a9633206_16593456 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


  <table cellpadding="0" cellspacing="0" height="35" class="margin_bottom_large">
  <tr>
    <td width="45"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_settings.gif" width="34" height="34" /></td>
    <td class="title"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_settings'];?>
</td>
  </tr>
  </table>

  <?php echo smarty_function_ft_include(array('file'=>'tabset_open.tpl'),$_smarty_tpl);?>


    <?php if ($_smarty_tpl->tpl_vars['page']->value == "main") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_main.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "accounts") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_accounts.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "files") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_files.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "menus") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_menus.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "add_menu") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_add_menu.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "edit_client_menu") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_edit_client_menu.tpl'),$_smarty_tpl);?>

    <?php } elseif ($_smarty_tpl->tpl_vars['page']->value == "edit_admin_menu") {?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_edit_admin_menu.tpl'),$_smarty_tpl);?>

    <?php } else { ?>
      <?php echo smarty_function_ft_include(array('file'=>'admin/settings/tab_main.tpl'),$_smarty_tpl);?>

    <?php }?>

  <?php echo smarty_function_ft_include(array('file'=>'tabset_close.tpl'),$_smarty_tpl);?>


<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);
}
}
