<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:37:18
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step3.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd753e4a9099_34257991',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'c0b2a3c5b42181a6b3f4d0898fbf18dabb608f03' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step3.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd753e4a9099_34257991 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
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

  <table cellpadding="0" cellspacing="0" width="100%" class="add_form_nav">
  <tr>
    <td class="selected"><a href="step1.php"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_start'];?>
</a></td>
    <td class="selected"><a href="step2.php"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_info'];?>
</a></td>
    <td class="selected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_test_submission'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_database_setup'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_field_types'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_finalize_form'];?>
</td>
  </tr>
  </table>

  <br />

  <div class="subtitle underline"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['phrase_test_submission_3'], 'UTF-8');?>
</div>

  <?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


  <div class="pad_bottom">
    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_1'];?>

  </div>

  <?php if ($_smarty_tpl->tpl_vars['form_info']->value['submission_type'] == "direct") {?>

    <p>
      <b>1</b>. <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_2_para_2'];?>

      <br />
      <textarea style="color: #336699; width: 100%; height: 65px"><?php echo $_smarty_tpl->tpl_vars['form_tag']->value;?>

<?php echo $_smarty_tpl->tpl_vars['hidden_fields']->value;?>
</textarea>
    </p>

    <p>
      <b>2</b>. <?php echo $_smarty_tpl->tpl_vars['direct_form_para_2']->value;?>

    </p>

    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_initialized'] == "no") {?>
      <div class="incomplete">
        <div style="padding-bottom: 5px;"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_awaiting_form_submission'];?>
</div>
        <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
          <input type="hidden" name="submission_type" value="direct" />
          <input type="hidden" name="form_id" value="<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
"/>
          <input type="submit" name="refresh" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_refresh_page'];?>
" />
        </form>
      </div>
    <?php } elseif ($_smarty_tpl->tpl_vars['form_info']->value['is_initialized'] == "yes") {?>
      <p>
        <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_resend_test_submission'];?>
"
          onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?uninitialize=1'" />
      </p>
      <p>
        <input type="button" name="submit" class="next_step" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_next_step_rightarrow'];?>
"
          onclick="window.location='step4.php?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
'"/>
      </p>
    <?php }?>

  <?php } else { ?>

    <p>
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_4'];?>

    </p>

    <ul>
      <li><a href="http://docs.formtools.org/tutorials/api_v2_single_page_form/" target="_blank"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_adding_single_page_form'];?>
</a></li>
      <li><a href="http://docs.formtools.org/tutorials/api_v2_multi_page_form/" target="_blank"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_adding_multi_page_form'];?>
</a></li>
    </ul>

    <p>
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_5'];?>

    </p>

    <code id="highlight-code" class="highlight-code"></code>

    <?php echo '<script'; ?>
>
    var html_editor = new CodeMirror($("#highlight-code")[0], {
      mode: "text/x-php",
      readOnly: "nocursor",
      value: '$fields = $api->initFormPage(<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
, "initialize");'
    });
    <?php echo '</script'; ?>
>

    <p>
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_7'];?>

    </p>

    <code><pre class="green">
    "finalize" => true</pre></code>

    <p>
      <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_6'];?>

    </p>

    <?php if ($_smarty_tpl->tpl_vars['form_info']->value['is_initialized'] == "no") {?>
      <div class="incomplete">
        <div style="padding-bottom: 5px;"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_awaiting_form_submission'];?>
</div>
        <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
          <input type="hidden" name="submission_type" value="code" />
          <input type="hidden" name="form_id" value="<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
" />
          <input type="submit" name="refresh" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_refresh_page'];?>
" />
        </form>
      </div>
    <?php } elseif ($_smarty_tpl->tpl_vars['form_info']->value['is_initialized'] == "yes") {?>
      <p>
        <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_resend_test_submission'];?>
"
          onclick="window.location='<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?uninitialize=1'" />
      </p>
      <p>
        <input type="button" name="submit" class="next_step" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_next_step_rightarrow'];?>
"
          onclick="window.location='step4.php?form_id=<?php echo $_smarty_tpl->tpl_vars['form_id']->value;?>
'"/>
      </p>
    <?php }?>

  <?php }?>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
