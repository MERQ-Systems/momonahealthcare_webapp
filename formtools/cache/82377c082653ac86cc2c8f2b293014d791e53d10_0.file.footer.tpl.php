<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:32:29
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/footer.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd741d6813d6_71837402',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '82377c082653ac86cc2c8f2b293014d791e53d10' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/footer.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd741d6813d6_71837402 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_show_page_load_time')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.show_page_load_time.php';
?>

      </div>
    </td>
  </tr>
  </table>

</div>


<?php if ($_smarty_tpl->tpl_vars['footer_text']->value != '' || $_smarty_tpl->tpl_vars['g_enable_benchmarking']->value) {?>
  <div class="footer">
    <?php echo $_smarty_tpl->tpl_vars['footer_text']->value;?>

    <?php echo smarty_function_show_page_load_time(array(),$_smarty_tpl);?>

  </div>
<?php }?>

</body>
</html>
<?php }
}
