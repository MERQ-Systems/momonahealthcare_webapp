<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:33:00
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd743c2968e3_25384740',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3a68934f4222581f2f4ce06eca27ef8f798f753c' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/forms/add/index.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd743c2968e3_25384740 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
echo smarty_function_ft_include(array('file'=>'header.tpl'),$_smarty_tpl);?>


  <table cellpadding="0" cellspacing="0" class="margin_bottom_large">
  <tr>
    <td width="45"><a href="../"><img src="<?php echo $_smarty_tpl->tpl_vars['images_url']->value;?>
/icon_forms.gif" border="0" width="34" height="34" /></a></td>
    <td class="title"><a href="../"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_forms'];?>
</a> <span class="joiner">&raquo;</span> <?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_add_form'];?>
</td>
  </tr>
  </table>

  <?php if ($_smarty_tpl->tpl_vars['max_forms_reached']->value) {?>
    <div class="notify margin_bottom_large">
      <div style="padding:6px">
        <?php echo $_smarty_tpl->tpl_vars['notify_max_forms_reached']->value;?>

      </div>
    </div>
  <?php } else { ?>

	  <div class="margin_bottom_large">
	    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_choose_form_type'];?>

	  </div>

	  <form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post">
	    <table width="100%">
	      <tr>
	        <td width="49%" valign="top">
	          <div class="grey_box add_form_select">
	            <span style="float:right"><input type="submit" name="internal" class="blue bold" value="<?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
" /></span>
	            <div class="bold"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_internal'];?>
</div>
	            <div class="medium_grey">
	              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_internal_form_desc'];?>

	            </div>
	          </div>
	        </td>
	        <td width="2%"> </td>
	        <td width="49%" valign="top">
	          <div class="grey_box add_form_select margin_bottom_large">
	            <span style="float:right"><input type="button" id="select_external" name="external" class="blue bold" value="<?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_select'], 'UTF-8');?>
" /></span>
	            <div class="bold"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_external'];?>
</div>
	            <div class="medium_grey">
	              <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_external_form_desc'];?>

	            </div>
	          </div>
	        </td>
	      </tr>
	    </table>
	    <?php echo smarty_function_template_hook(array('location'=>"add_form_page"),$_smarty_tpl);?>

	  </form>

	  <div id="add_external_form_dialog" class="hidden">
	    <table width="100%">
	    <tr>
	      <td valign="top" width="65"><span class="margin_top_large popup_icon popup_type_info"></span></td>
	      <td>
	        <p>
	          <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_1_text_1'];?>

	        </p>
	        <ul>
	          <li><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_1_text_2'];?>
</li>
	          <li><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_step_1_text_3'];?>
</li>
	        </ul>
	        <p>
	          <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_add_form_help_link'];?>

	        </p>
	      </td>
	    </tr>
	    </table>
	  </div>

  <?php }?>

<?php echo smarty_function_ft_include(array('file'=>'footer.tpl'),$_smarty_tpl);?>

<?php }
}
