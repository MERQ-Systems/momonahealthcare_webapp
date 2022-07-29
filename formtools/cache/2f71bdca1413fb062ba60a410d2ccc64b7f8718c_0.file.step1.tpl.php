<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:33:38
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step1.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd7462945b12_35506181',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '2f71bdca1413fb062ba60a410d2ccc64b7f8718c' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/step1.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd7462945b12_35506181 (Smarty_Internal_Template $_smarty_tpl) {
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

  <table cellpadding="0" cellspacing="0" width="100%" class="add_form_nav margin_bottom_large">
  <tr>
    <td class="selected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_start'];?>
</td>
    <td class="unselected"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_form_info'];?>
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

  <div class="subtitle underline">1. <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['phrase_getting_started'], 'UTF-8');?>
</div>

  <p>
    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_choose_integration_method'];?>

  </p>

  <form method="post" action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
">
    <table width="100%">
      <tr>
        <td width="49%" valign="top">
          <div id="direct_box" class="<?php if ($_smarty_tpl->tpl_vars['form_info']->value['submission_type'] == "direct") {?>blue_box<?php } else { ?>grey_box<?php }?>">
            <span style="float:right"><input type="submit" class="blue bold" value="<?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
" name="direct" /></span>
            <div class="bold"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_1_direct'];?>
</div>
            <div class="medium_grey">&#8212; <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_2'];?>
</div>
            <br />
            <div>
              <a href="#" onclick="return page_ns.show_section('method1_benefits')"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_benefits'];?>
</a> |
              <a href="#" onclick="return page_ns.show_section('method1_drawbacks')"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_drawbacks'];?>
</a>
            </div>
          </div>
        </td>
        <?php if ($_smarty_tpl->tpl_vars['has_api']->value) {?>
        <td width="2%"> </td>
        <td width="49%" valign="top">
          <div id="select_box" class="<?php if ($_smarty_tpl->tpl_vars['form_info']->value['submission_type'] == "code") {?>blue_box<?php } else { ?>grey_box<?php }?>">
            <span style="float:right"><input type="submit" class="blue bold" value="<?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
" name="code" /></span>
            <div class="bold"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_2_code'];?>
</div>
            <div class="medium_grey">&#8212; <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_3_text_3'];?>
</div>
            <br />
            <div>
              <a href="#" onclick="return page_ns.show_section('method2_benefits')"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_benefits'];?>
</a> |
              <a href="#" onclick="return page_ns.show_section('method2_drawbacks')"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_drawbacks'];?>
</a>
            </div>
          </div>
        </td>
        <?php }?>
      </tr>
      <tr>
        <td colspan="3">

          <div class="margin_top_large">
            <div class="box" id="method1_benefits" style="display:none">
              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_direct_submission_benefits'];?>

            </div>

            <div class="box" id="method1_drawbacks" style="display:none">
              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_direct_submission_drawbacks'];?>

            </div>

            <div class="box" id="method2_benefits" style="display:none">
              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_code_submission_benefits'];?>

            </div>

            <div class="box" id="method2_drawbacks" style="display:none">
              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_code_submission_drawbacks'];?>

            </div>
          </div>

        </td>
      </tr>
    </table>
  </form>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
