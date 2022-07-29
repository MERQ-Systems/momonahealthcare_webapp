<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:33:46
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step2.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd746a3ddba6_68129765',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '76cde71ba17dcc4cc6bde0795be7fbf34178b4fc' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step2.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd746a3ddba6_68129765 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_clients_dropdown')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.clients_dropdown.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


  <table cellpadding="0" cellspacing="0" class="margin_bottom_large">
  <tr>
    <td width="45"><a href="../"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_forms.gif" border="0" width="34" height="34" /></a></td>
    <td class="title">
      <a href="../"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_forms'];?>
</a> <span class="joiner">&raquo;</span>
      <a href="./"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_add_form'];?>
</a> <span class="joiner">&raquo;</span>
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_external_form'];?>

    </td>
  </tr>
  </table>

  <table cellpadding="0" cellspacing="0" width="100%" class="add_form_nav margin_bottom_large">
  <tr>
    <td class="selected"><a href="step1.php"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_start'];?>
</a></td>
    <td class="selected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_info'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_test_submission'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_database_setup'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_field_types'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_finalize_form'];?>
</td>
  </tr>
  </table>

  <div>
    <div class="subtitle underline" style="position:relative">
      <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['phrase_form_info_2'], 'UTF-8');?>

    </div>

    <?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


    <form method="post" id="add_form" name="add_form" action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" onsubmit="return rsv.validate(this, rules)">
      <?php echo $_smarty_tpl->tpl_vars['page_values']->value['hidden_fields'];?>

      <input type="hidden" id="form_type" value="external" />
      <input type="hidden" id="submission_type" value="<?php echo $_smarty_tpl->tpl_vars['submission_type']->value;?>
" />

      <table width="100%" class="list_table">
      <tr>
        <td class="pad_left_small" width="200"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_name'];?>
</td>
        <td><input type="text" name="form_name" id="form_name" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['page_values']->value['form_name'], ENT_QUOTES, 'UTF-8', true);?>
" style="width: 99%" /></td>
      </tr>
      <?php if ($_smarty_tpl->tpl_vars['submission_type']->value == "code") {?>
      <tbody>
        <tr>
          <td class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_is_multi_page_form_q'];?>
</td>
          <td>
            <input type="radio" name="is_multi_page_form" class="is_multi_page_form" id="impf1" value="yes"
              <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "yes") {?>checked<?php }?> />
              <label for="impf1"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_yes'];?>
</label>
            <input type="radio" name="is_multi_page_form" class="is_multi_page_form" id="impf2" value="no"
              <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "no") {?>checked<?php }?> />
              <label for="impf2"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_no'];?>
</label>
          </td>
        </tr>
      </tbody>
      <?php }?>
      <tr>
        <td valign="top" class="pad_left_small">
          <?php if ($_smarty_tpl->tpl_vars['submission_type']->value == "direct") {?>
            <input type="hidden" name="is_multi_page_form" value="no" />
            <?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_url'];?>

          <?php } else { ?>
            <span id="form_label_single" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "yes") {?>style="display:none"<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_url'];?>
</span>
            <span id="form_label_multiple" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "no") {?>style="display:none"<?php }?>><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_urls'];?>
</span>
          <?php }?>
        </td>
        <td>
          <?php if ($_smarty_tpl->tpl_vars['submission_type']->value == "direct") {?>
            <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
              <td><input type="text" name="form_url" id="form_url" value="<?php echo $_smarty_tpl->tpl_vars['page_values']->value['form_url'];?>
" style="width: 98%" /></td>
              <td width="60"><input type="button" class="check_url" id="check_url__form_url" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_check_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></td>
            </tr>
            </table>
          <?php } else { ?>
            <div id="form_url_single" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "yes") {?>style="display:none"<?php }?>>
              <table width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td><input type="text" name="form_url" id="form_url" value="<?php echo $_smarty_tpl->tpl_vars['page_values']->value['form_url'];?>
" style="width: 98%" /></td>
                <td width="60"><input type="button" class="check_url" id="check_url__form_url" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_check_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></td>
              </tr>
              </table>
            </div>
            <div id="form_url_multiple" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['is_multi_page_form'] == "no") {?>style="display:none"<?php }?>>
              <div class="sortable multi_page_form_list" id="<?php echo $_smarty_tpl->tpl_vars['sortable_id']->value;?>
">
                <ul class="header_row">
                  <li class="col1"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_page'];?>
</li>
                  <li class="col2"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_url'];?>
</li>
                  <li class="col3"></li>
                  <li class="col4 colN del"></li>
                </ul>
                <div class="clear"></div>
                <ul class="rows">
                  <?php $_smarty_tpl->_assignInScope('previous_item', '');
?>
                  <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['page_values']->value['multi_page_form_urls'], 'i', false, NULL, 'row', array (
  'iteration' => true,
  'last' => true,
  'total' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration'] == $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['total'];
?>
                    <?php $_smarty_tpl->_assignInScope('count', (isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['iteration'] : null));
?>
                    <li class="sortable_row<?php if ((isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['last']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['last'] : null)) {?> rowN<?php }?>">
                      <div class="row_content">
                        <div class="row_group<?php if ((isset($_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['last']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_row']->value['last'] : null)) {?> rowN<?php }?>">
                          <input type="hidden" class="sr_order" value="<?php echo $_smarty_tpl->tpl_vars['count']->value;?>
" />
                          <ul>
                            <li class="col1 sort_col"><?php echo $_smarty_tpl->tpl_vars['count']->value;?>
</li>
                            <li class="col2"><input type="text" name="multi_page_urls[]" id="mp_url_<?php echo $_smarty_tpl->tpl_vars['count']->value;?>
" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['i']->value['form_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></li>
                            <li class="col3"><input type="button" class="check_url" id="check_url__mp_url_<?php echo $_smarty_tpl->tpl_vars['count']->value;?>
" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_check_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></li>
                            <li class="col4 colN del"></li>
                          </ul>
                          <div class="clear"></div>
                        </div>
                      </div>
                      <div class="clear"></div>
                    </li>
                  <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

                  <?php if (count($_smarty_tpl->tpl_vars['page_values']->value['multi_page_form_urls']) == 0) {?>
                    <li class="sortable_row">
                      <div class="row_content">
                        <div class="row_group rowN">
                          <input type="hidden" class="sr_order" value="1" />
                          <ul>
                            <li class="col1 sort_col">1</li>
                            <li class="col2"><input type="text" name="multi_page_urls[]" id="mp_url_0" /></li>
                            <li class="col3"><input type="button" class="check_url" id="check_url__mp_url_0" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_check_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></li>
                            <li class="col4 colN del"></li>
                          </ul>
                          <div class="clear"></div>
                        </div>
                      </div>
                      <div class="clear"></div>
                    </li>
                  <?php }?>
                </ul>
              </div>
              <div class="clear"></div>
              <div>
                <a href="#" onclick="return mf_ns.add_multi_page_form_page()"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_add_row'];?>
</a>
              </div>
            </div>
          <?php }?>
        </td>
      </tr>
      <?php if ($_smarty_tpl->tpl_vars['submission_type']->value == "direct") {?>
      <tr>
        <td valign="top" class="pad_left_small"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_redirect_url'];?>
</td>
        <td>
          <table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td><input type="text" name="redirect_url" id="redirect_url" value="<?php echo $_smarty_tpl->tpl_vars['page_values']->value['redirect_url'];?>
" style="width: 98%" /></td>
            <td width="60"><input type="button" class="check_url" id="check_url__redirect_url" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['LANG']->value['phrase_check_url'], ENT_QUOTES, 'UTF-8', true);?>
" /></td>
          </tr>
          </table>
          <div class="medium_grey">
            <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_2_text_2'];?>

          </div>
        </td>
      </tr>
      <?php }?>

      <tr>
        <td class="pad_left_small" valign="top"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_who_can_access'];?>
</td>
        <td>

          <table cellspacing="1" cellpadding="0" >
          <tr>
            <td>
              <input type="radio" name="access_type" id="at1" value="admin" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['access_type'] == 'admin') {?>checked<?php }?> />
                <label for="at1"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_admin_only'];?>
</label>
            </td>
          </tr>
          <tr>
            <td>
              <input type="radio" name="access_type" id="at2" value="public" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['access_type'] == 'public') {?>checked<?php }?> />
                <label for="at2"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_public'];?>
 <span class="light_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_all_clients_have_access'];?>
</span></label>
            </td>
          </tr>
          <tr>
            <td>
              <input type="radio" name="access_type" id="at3" value="private" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['access_type'] == 'private') {?>checked<?php }?> />
                <label for="at3"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_private'];?>
 <span class="light_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_only_specific_clients_have_access'];?>
</span></label>
            </td>
          </tr>
          </table>

          <div id="custom_clients" <?php if ($_smarty_tpl->tpl_vars['page_values']->value['access_type'] != 'private') {?>style="display:none"<?php }?> class="margin_top">
            <table cellpadding="0" cellspacing="0" class="subpanel">
            <tr>
              <td class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_available_clients'];?>
</td>
              <td></td>
              <td class="medium_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_selected_clients'];?>
</td>
            </tr>
            <tr>
              <td>
                <?php echo smarty_function_clients_dropdown(array('name_id'=>"available_client_ids[]",'multiple'=>"true",'multiple_action'=>"hide",'clients'=>$_smarty_tpl->tpl_vars['selected_client_ids']->value,'size'=>"4",'style'=>"width: 220px"),$_smarty_tpl);?>

              </td>
              <td align="center" valign="middle" width="100">
                <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_add_uc_rightarrow'];?>
"
                  onclick="ft.move_options(this.form['available_client_ids[]'], this.form['selected_client_ids[]']);" /><br />
                <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_remove_uc_leftarrow'];?>
"
                  onclick="ft.move_options(this.form['selected_client_ids[]'], this.form['available_client_ids[]']);" />
              </td>
              <td>
                <?php echo smarty_function_clients_dropdown(array('name_id'=>"selected_client_ids[]",'multiple'=>"true",'multiple_action'=>"show",'clients'=>$_smarty_tpl->tpl_vars['selected_client_ids']->value,'size'=>"4",'style'=>"width: 220px"),$_smarty_tpl);?>

              </td>
            </tr>
            </table>
          </div>

        </td>
      </tr>
      </table>

      <?php if ($_smarty_tpl->tpl_vars['submission_type']->value == "direct") {?>
        <p>
          <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_form_contains_file_fields'];?>

          <input type="radio" name="uploading_files" id="uploading_files1" value="yes" <?php if ($_smarty_tpl->tpl_vars['uploading_files']->value == "yes") {?>checked<?php }?> />
            <label for="uploading_files1"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_yes'];?>
</label>
          <input type="radio" name="uploading_files" id="uploading_files2" value="no" <?php if ($_smarty_tpl->tpl_vars['uploading_files']->value == "no") {?>checked<?php }?> />
            <label for="uploading_files2"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_no'];?>
</label>
        </p>
      <?php }?>

      <p>
        <input type="submit" name="submit" class="next_step" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_next_step_rightarrow'];?>
" />
      </p>

    </form>

  </div>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
