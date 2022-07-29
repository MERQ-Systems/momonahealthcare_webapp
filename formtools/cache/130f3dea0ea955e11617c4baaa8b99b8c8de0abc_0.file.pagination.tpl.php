<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:38:03
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/pagination.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd756b703153_76842503',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '130f3dea0ea955e11617c4baaa8b99b8c8de0abc' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/pagination.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd756b703153_76842503 (Smarty_Internal_Template $_smarty_tpl) {
?>


<div class="margin_bottom_large">
  <?php if ($_smarty_tpl->tpl_vars['show_total_results']->value) {?>
    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_total_results_c'];?>
 <b><?php echo $_smarty_tpl->tpl_vars['num_results']->value;?>
</b>&nbsp;

    
    <?php echo $_smarty_tpl->tpl_vars['viewing_range']->value;?>

  <?php }?>

  <?php if ($_smarty_tpl->tpl_vars['total_pages']->value > 1) {?>
    <div id="list_nav">
      <?php if ($_smarty_tpl->tpl_vars['show_page_label']->value) {?>
        <?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_page_c'];?>

      <?php }?>

      
      <?php if ($_smarty_tpl->tpl_vars['current_page']->value != 1) {?>
        <?php $_smarty_tpl->_assignInScope('previous_page', $_smarty_tpl->tpl_vars['current_page']->value-1);
?>
        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['page_str']->value;?>
=<?php echo $_smarty_tpl->tpl_vars['previous_page']->value;
echo $_smarty_tpl->tpl_vars['query_str']->value;?>
">&laquo;</a>
      <?php }?>

      
      <?php
$__section_counter_0_saved = isset($_smarty_tpl->tpl_vars['__smarty_section_counter']) ? $_smarty_tpl->tpl_vars['__smarty_section_counter'] : false;
$__section_counter_0_loop = (is_array(@$_loop=$_smarty_tpl->tpl_vars['total_pages']->value+1) ? count($_loop) : max(0, (int) $_loop));
$__section_counter_0_start = min(1, $__section_counter_0_loop);
$__section_counter_0_total = min(($__section_counter_0_loop - $__section_counter_0_start), $__section_counter_0_loop);
$_smarty_tpl->tpl_vars['__smarty_section_counter'] = new Smarty_Variable(array());
if ($__section_counter_0_total != 0) {
for ($__section_counter_0_iteration = 1, $_smarty_tpl->tpl_vars['__smarty_section_counter']->value['index'] = $__section_counter_0_start; $__section_counter_0_iteration <= $__section_counter_0_total; $__section_counter_0_iteration++, $_smarty_tpl->tpl_vars['__smarty_section_counter']->value['index']++){
?>
        <?php $_smarty_tpl->_assignInScope('page', (isset($_smarty_tpl->tpl_vars['__smarty_section_counter']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_section_counter']->value['index'] : null));
?>

        <?php if ($_smarty_tpl->tpl_vars['page']->value >= $_smarty_tpl->tpl_vars['first_page']->value && $_smarty_tpl->tpl_vars['page']->value <= $_smarty_tpl->tpl_vars['last_page']->value) {?>
          <?php if ($_smarty_tpl->tpl_vars['page']->value == $_smarty_tpl->tpl_vars['current_page']->value) {?>
            <span id="list_current_page"><b><?php echo $_smarty_tpl->tpl_vars['page']->value;?>
</b></span>
          <?php } else { ?>
            <span class="pad_right_small"><a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['page_str']->value;?>
=<?php echo $_smarty_tpl->tpl_vars['page']->value;
echo $_smarty_tpl->tpl_vars['query_str']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['page']->value;?>
</a></span>
          <?php }?>
        <?php }?>
      <?php
}
}
if ($__section_counter_0_saved) {
$_smarty_tpl->tpl_vars['__smarty_section_counter'] = $__section_counter_0_saved;
}
?>

      
      <?php if ($_smarty_tpl->tpl_vars['current_page']->value < $_smarty_tpl->tpl_vars['total_pages']->value) {?>
        <?php $_smarty_tpl->_assignInScope('next_page', $_smarty_tpl->tpl_vars['current_page']->value+1);
?>
        <a href="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
?<?php echo $_smarty_tpl->tpl_vars['page_str']->value;?>
=<?php echo $_smarty_tpl->tpl_vars['next_page']->value;
echo $_smarty_tpl->tpl_vars['query_str']->value;?>
">&raquo;</a>
      <?php }?>

    </div>

  <?php }?>

</div><?php }
}
