<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:32:29
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/header.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd741d65bda7_22040027',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '95f4e74d791f17b792a7fe891973cecf6a0d0db1' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/header.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd741d65bda7_22040027 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
?>
<!DOCTYPE html>
<html dir="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['special_text_direction'];?>
">
<head>
    <?php if (!$_smarty_tpl->tpl_vars['swatch']->value) {
$_smarty_tpl->_assignInScope('swatch', "green");
}?>
    <title><?php echo $_smarty_tpl->tpl_vars['head_title']->value;?>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="shortcut icon" href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/images/favicon.ico">
    <?php echo smarty_function_template_hook(array('location'=>"head_top"),$_smarty_tpl);?>

    <?php echo '<script'; ?>
>
        //<![CDATA[
        var g = {
            root_url: "<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
",
            error_colours: ["ffbfbf", "ffb5b5"],
            notify_colours: ["c6e2ff", "97c7ff"],
            js_debug:       <?php echo $_smarty_tpl->tpl_vars['g_js_debug']->value;?>

            };
        //]]>
    <?php echo '</script'; ?>
>
    <link type="text/css" rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/global/css/main.css?v=3_0_3">
    <link type="text/css" rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/css/styles.css?v=3_0_3">
    <link type="text/css" rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/css/swatch_<?php echo $_smarty_tpl->tpl_vars['swatch']->value;?>
.css?v=3_0_3">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/css/smoothness/jquery-ui-1.8.6.custom.css" rel="stylesheet" type="text/css"/>
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/global/scripts/jquery.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/scripts/jquery-ui.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/global/scripts/general.js?v=3_0_15"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['g_root_url']->value;?>
/global/scripts/rsv.js?v=3_0_15"><?php echo '</script'; ?>
>
    <?php echo $_smarty_tpl->tpl_vars['head_string']->value;?>

    <?php echo $_smarty_tpl->tpl_vars['head_js']->value;?>

    <?php echo $_smarty_tpl->tpl_vars['head_css']->value;?>

    <?php echo smarty_function_template_hook(array('location'=>"head_bottom"),$_smarty_tpl);?>

</head>
<body>
<div id="container">
    <div id="header">
        <?php if ($_smarty_tpl->tpl_vars['is_logged_in']->value && isset($_smarty_tpl->tpl_vars['settings']->value['program_version'])) {?>
            <div style="float:right; display: flex">
                <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/images/account_section_left_<?php echo $_smarty_tpl->tpl_vars['swatch']->value;?>
2x.png" border="0" height="25" width="8"/>
                <div id="account_section">
                    <?php if ($_smarty_tpl->tpl_vars['settings']->value['release_type'] == "alpha") {?>
                        <b><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
-alpha-<?php echo $_smarty_tpl->tpl_vars['settings']->value['release_date'];?>
</b>
                    <?php } elseif ($_smarty_tpl->tpl_vars['settings']->value['release_type'] == "beta") {?>
                        <b><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
-beta-<?php echo $_smarty_tpl->tpl_vars['settings']->value['release_date'];?>
</b>
                    <?php } else { ?>
                        <b><?php echo $_smarty_tpl->tpl_vars['settings']->value['program_version'];?>
</b>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['account']->value['account_type'] == "admin" && !$_smarty_tpl->tpl_vars['g_hide_upgrade_link']->value) {?>
                        <span class="delimiter">|</span>
                        <a href="#" onclick="return ft.check_updates()" class="update_link"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_update'];?>
</a>
                    <?php }?>
                </div>
                <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/images/account_section_right_<?php echo $_smarty_tpl->tpl_vars['swatch']->value;?>
2x.png" border="0" height="25" width="8"/>
            </div>
        <?php }?>

        <span style="float:left; padding-top: 4px">
      <?php if (isset($_smarty_tpl->tpl_vars['settings']->value) && isset($_smarty_tpl->tpl_vars['settings']->value['logo_link'])) {?>
            <a href="<?php echo $_smarty_tpl->tpl_vars['settings']->value['logo_link'];?>
"><?php }?><img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
/images/logo_<?php echo $_smarty_tpl->tpl_vars['swatch']->value;?>
2x.png" border="0"
                                                      width="220" height="67" />
                <?php if (isset($_smarty_tpl->tpl_vars['settings']->value) && isset($_smarty_tpl->tpl_vars['settings']->value['logo_link'])) {?></a><?php }?>
    </span>
    </div>
    <div id="content">
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td width="180" valign="top">
                    <div id="left_nav">
                        <?php echo smarty_function_ft_include(array('file'=>"menu.tpl"),$_smarty_tpl);?>

                    </div>
                </td>
                <td valign="top">
                    <div style="width:740px">
<?php }
}
