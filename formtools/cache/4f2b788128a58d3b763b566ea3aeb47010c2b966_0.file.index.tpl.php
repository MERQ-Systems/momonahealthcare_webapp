<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:38:03
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/option_lists/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd756b7265f5_99054296',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4f2b788128a58d3b763b566ea3aeb47010c2b966' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/option_lists/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd756b7265f5_99054296 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


  <table cellpadding="0" cellspacing="0" class="margin_bottom_large">
  <tr>
    <td width="45"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_option_lists.gif" width="34" height="34" /></td>
    <td class="title"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_option_lists'];?>
</td>
  </tr>
  </table>

  <div>
    <?php echo $_smarty_tpl->tpl_vars['text_option_list_page']->value;?>

  </div>

  <?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


  <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
    <input type="hidden" name="page" value="views" />

    <?php if ($_smarty_tpl->tpl_vars['num_option_lists']->value == 0) {?>
      <div class="notify" class="margin_bottom_large">
        <div style="padding:8px">
          <?php echo $_smarty_tpl->tpl_vars['LANG']->value['notify_no_option_lists'];?>

        </div>
      </div>
    <?php } else { ?>
      <?php echo $_smarty_tpl->tpl_vars['pagination']->value;?>

      <table class="list_table" cellspacing="1" cellpadding="0">
      <tr>
        <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
        <?php if ($_smarty_tpl->tpl_vars['order']->value == "list_id-DESC") {?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=list_id-ASC");
?>
          <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
        <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "list_id-ASC") {?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=list_id-DESC");
?>
          <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
        <?php } else { ?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=list_id-DESC");
?>
        <?php }?>
        <th width="40" class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
          <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_id'], 'UTF-8');?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
        </th>
        <?php $_smarty_tpl->_assignInScope('up_down', '');
?>
        <?php if ($_smarty_tpl->tpl_vars['order']->value == "option_list_name-DESC") {?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=option_list_name-ASC");
?>
          <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_down.gif\" />");
?>
        <?php } elseif ($_smarty_tpl->tpl_vars['order']->value == "option_list_name-ASC") {?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=option_list_name-DESC");
?>
          <?php $_smarty_tpl->_assignInScope('up_down', "<img src=\"".((string)$_smarty_tpl->tpl_vars['theme_url']->value)."/images/sort_up.gif\" />");
?>
        <?php } else { ?>
          <?php $_smarty_tpl->_assignInScope('sort_order', "order=option_list_name-DESC");
?>
        <?php }?>
        <th class="sortable_col<?php if ($_smarty_tpl->tpl_vars['up_down']->value) {?> over<?php }?>">
          <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['sort_order']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_option_list_name'];?>
 <?php echo $_smarty_tpl->tpl_vars['up_down']->value;?>
</a>
        </th>
        <th nowrap><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_num_options'];?>
</th>
        <th width="220" nowrap><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_used_by_num_form_fields'];?>
</th>
        <th class="edit"></th>
        <th class="del"></th>
      </tr>

      <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['option_lists']->value, 'list_info', false, NULL, 'row', array (
  'index' => true,
  'iteration' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list_info']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']++;
?>
        <?php $_smarty_tpl->_assignInScope('index', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['index'] : null));
?>
        <?php $_smarty_tpl->_assignInScope('count', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration'] : null));
?>
        <?php $_smarty_tpl->_assignInScope('list_id', $_smarty_tpl->tpl_vars['list_info']->value['list_id']);
?>
        <tr>
          <td class="medium_grey" align="center"><?php echo $_smarty_tpl->tpl_vars['list_info']->value['list_id'];?>
</td>
          <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['list_info']->value['option_list_name'];?>
</td>
          <td class="pad_left_small" align="center"><?php echo $_smarty_tpl->tpl_vars['list_info']->value['num_option_list_options'];?>
</td>
          <td class="pad_left_small" align="center">
            <?php if ($_smarty_tpl->tpl_vars['list_info']->value['num_fields'] == 0) {?>
              <span class="light_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_none'];?>
</span>
              <?php $_smarty_tpl->_assignInScope('may_delete_list', "true");
?>
            <?php } else { ?>
              <select style="width:100%">
                <option value="">
                  <?php if ($_smarty_tpl->tpl_vars['list_info']->value['num_fields'] == 1) {?>
                    1 <?php echo mb_strtolower($_smarty_tpl->tpl_vars['LANG']->value['word_field'], 'UTF-8');?>

                  <?php } else { ?>
                    <?php echo $_smarty_tpl->tpl_vars['list_info']->value['num_fields'];?>
 <?php echo mb_strtolower($_smarty_tpl->tpl_vars['LANG']->value['word_fields'], 'UTF-8');?>

                  <?php }?>
                </option>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['list_info']->value['fields'], 'grouped_field');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grouped_field']->value) {
?>
                  <optgroup label="<?php echo $_smarty_tpl->tpl_vars['grouped_field']->value['form_name'];?>
">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['grouped_field']->value['fields'], 'field');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['field']->value) {
?>
                      <option value=""><?php echo $_smarty_tpl->tpl_vars['field']->value['field_title'];?>
</option>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

                  </optgroup>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

              </select>
              <?php $_smarty_tpl->_assignInScope('may_delete_list', "false");
?>
            <?php }?>
          </td>
          <td class="edit"><a href="edit.php?list_id=<?php echo $_smarty_tpl->tpl_vars['list_id']->value;?>
"></a></td>
          <td class="del"><a href="#" onclick="return sf_ns.delete_option_list(<?php echo $_smarty_tpl->tpl_vars['list_id']->value;?>
, <?php echo $_smarty_tpl->tpl_vars['may_delete_list']->value;?>
)"></a></td>
        </tr>
      <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

      </table>

    <?php }?>

    <p>
      <?php if ($_smarty_tpl->tpl_vars['num_option_lists']->value > 0) {?>
        <select name="create_option_list_from_list_id">
          <option value=""><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_new_blank_option_list'];?>
</option>
          <optgroup label="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_copy_settings_from'];?>
">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['all_option_lists']->value, 'list_info');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list_info']->value) {
?>
              <option value="<?php echo $_smarty_tpl->tpl_vars['list_info']->value['list_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['list_info']->value['option_list_name'];?>
</option>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

          </optgroup>
        </select>
      <?php }?>
      <input type="submit" name="add_option_list" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_create_new_option_list_rightarrow'];?>
" />
      <?php echo smarty_function_template_hook(array('location'=>"option_list_button_row"),$_smarty_tpl);?>

    </p>

  </form>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);
}
}
