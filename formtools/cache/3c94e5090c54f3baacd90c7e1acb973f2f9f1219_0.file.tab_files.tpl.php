<?php
/* Smarty version 3.1.31, created on 2022-07-24 16:39:05
  from "/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_files.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_62dd75a9672fe0_38153031',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3c94e5090c54f3baacd90c7e1acb973f2f9f1219' => 
    array (
      0 => '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/themes/default/admin/settings/tab_files.tpl',
      1 => 1571535471,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_62dd75a9672fe0_38153031 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_function_ft_include')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.ft_include.php';
if (!is_callable('smarty_function_template_hook')) require_once '/home/momonahealthcare.merqconsultancy.org/public_html/formtools/global/smarty_plugins/function.template_hook.php';
?>
<div class="subtitle underline margin_top_large"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['LANG']->value['word_files'], 'UTF-8');?>
</div>

<?php echo smarty_function_ft_include(array('file'=>'messages.tpl'),$_smarty_tpl);?>


<div class="margin_bottom_large">
    <?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_default_file_settings_page'];?>

</div>

<form action="<?php echo $_smarty_tpl->tpl_vars['same_page']->value;?>
" method="post" name="file_upload_settings_form">
    <input type="hidden" name="page" value="files"/>

    <table cellpadding="0" cellspacing="1" class="list_table" width="100%">
        <tr>
            <td width="120" class="pad_left"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_upload_folder_path'];?>
</td>
            <td>
                <input type="hidden" name="original_file_upload_dir" value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['file_upload_dir'];?>
"/>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td><input type="text" name="file_upload_dir" id="file_upload_dir"
                                   value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['file_upload_dir'];?>
" style="width: 98%"/></td>
                        <td width="180">
                            <input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_test_folder_permissions'];?>
"
                                   onclick="ft.test_folder_permissions($('#file_upload_dir').val(), 'permissions_result')"
                                   style="width: 180px;"/>
                        </td>
                    </tr>
                </table>
                <div id="permissions_result"></div>
            </td>
        </tr>
        <tr>
            <td class="pad_left"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_upload_folder_url'];?>
</td>
            <td>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td><input type="text" name="file_upload_url" id="file_upload_url"
                                   value="<?php echo $_smarty_tpl->tpl_vars['settings']->value['file_upload_url'];?>
" style="width: 98%"/></td>
                        <?php if ($_smarty_tpl->tpl_vars['allow_url_fopen']->value) {?>
                            <td width="150"><input type="button" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_confirm_folder_url_match'];?>
"
                                                   onclick="ft.test_folder_url_match($('#file_upload_dir').val(), $('#file_upload_url').val(), 'folder_match_message_id')"
                                                   style="width: 180px;"/></td>
                        <?php }?>
                    </tr>
                </table>
                <div id="folder_match_message_id"></div>
            </td>
        </tr>
        <tr>
            <td class="pad_left"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_max_file_size'];?>
</td>
            <td>
                <select name="file_upload_max_size">
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 20) {?>
                        <option value="20"   <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 20) {?>selected<?php }?>>20 KB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 50) {?>
                        <option value="50"   <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 50) {?>selected<?php }?>>50 KB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 100) {?>
                        <option value="100"  <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 100) {?>selected<?php }?>>100 KB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 200) {?>
                        <option value="200"  <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 200) {?>selected<?php }?>>200 KB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 300) {?>
                        <option value="300"  <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 300) {?>selected<?php }?>>300 KB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 500) {?>
                        <option value="500"  <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 500) {?>selected<?php }?>>1/2 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 1000) {?>
                        <option value="1000" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 1000) {?>selected<?php }?>>1 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 2000) {?>
                        <option value="2000" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 2000) {?>selected<?php }?>>2 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 3000) {?>
                        <option value="3000" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 3000) {?>selected<?php }?>>3 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 5000) {?>
                        <option value="5000" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 5000) {?>selected<?php }?>>5 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value >= 10000) {?>
                        <option value="10000" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == 10000) {?>selected<?php }?>>10 MB</option><?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['max_filesize']->value > 5000) {?>
                        <option value="<?php echo $_smarty_tpl->tpl_vars['max_filesize']->value;?>
" <?php if ($_smarty_tpl->tpl_vars['settings']->value['file_upload_max_size'] == $_smarty_tpl->tpl_vars['max_filesize']->value) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['max_filesize']->value/1000;?>
 MB</option><?php }?>
                </select>
                <span class="pad_left light_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_php_ini_max_allowed_upload_size_c'];?>
 <?php echo $_smarty_tpl->tpl_vars['max_filesize']->value/1000;?>
 MB</span>

            </td>
        </tr>
        <tr>
            <td class="pad_left"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_permitted_file_types'];?>
</td>
            <td>

                <table cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="90" class="subpanel">
                            <div class="bold nowrap"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['phrase_images_media'];?>
</div>
                            <input type="checkbox" name="file_upload_filetypes[]" value="bmp" id="bmp"
                                   <?php if (in_array("bmp",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="bmp">bmp</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="gif" id="gif"
                                   <?php if (in_array("gif",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="gif">gif</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="jpg,jpeg" id="jpg"
                                   <?php if (in_array("jpg",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="jpg">jpg / jpeg</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="png" id="png"
                                   <?php if (in_array("png",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="png">png</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="avi" id="avi"
                                   <?php if (in_array("avi",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="avi">avi</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="mp3" id="mp3"
                                   <?php if (in_array("mp3",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="mp3">mp3</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="mp4" id="mp4"
                                   <?php if (in_array("mp4",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="mp4">mp4</label>
                        </td>
                        <td valign="top" width="90" class="subpanel">
                            <div class="bold nowrap"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_web'];?>
</div>
                            <input type="checkbox" name="file_upload_filetypes[]" value="css" id="css"
                                   <?php if (in_array("css",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="css">css</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="js" id="js"
                                   <?php if (in_array("js",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="js">js</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="html,htm" id="html"
                                   <?php if (in_array("html",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="html">htm / html</label>
                        </td>
                        <td valign="top" width="90" class="subpanel">
                            <div class="bold nowrap"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_data'];?>
</div>
                            <input type="checkbox" name="file_upload_filetypes[]" value="doc" id="doc"
                                   <?php if (in_array("doc",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="doc">doc</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="rtf" id="rtf"
                                   <?php if (in_array("rtf",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="rtf">rtf</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="txt" id="txt"
                                   <?php if (in_array("txt",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="txt">txt</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="pdf" id="pdf"
                                   <?php if (in_array("pdf",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="pdf">pdf</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="xml" id="xml"
                                   <?php if (in_array("xml",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="xml">xml</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="csv" id="csv"
                                   <?php if (in_array("csv",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="csv">csv</label><br/>
                        </td>
                        <td valign="top" width="90" class="subpanel">
                            <div class="bold nowrap"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_misc'];?>
</div>
                            <input type="checkbox" name="file_upload_filetypes[]" value="zip" id="zip"
                                   <?php if (in_array("zip",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="zip">zip</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="tar,tar.gz" id="tar"
                                   <?php if (in_array("tar",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="tar">tar / tar.gz</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="swf" id="swf"
                                   <?php if (in_array("swf",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="swf">swf</label><br/>
                            <input type="checkbox" name="file_upload_filetypes[]" value="fla" id="fla"
                                   <?php if (in_array("fla",$_smarty_tpl->tpl_vars['file_upload_filetypes']->value)) {?>checked="checked"<?php }?> />
                            <label for="fla">fla</label>
                        </td>
                    </tr>
                </table>

                <div class="pad_left_small pad_top">
                    <div><?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_other_c'];?>
<input type="text" name="file_upload_filetypes_other"
                                                    value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['other_filetypes']->value, ENT_QUOTES, 'UTF-8', true);?>
" style="width: 480px"/></div>
                    <div class="pad_top_small medium_grey"><?php echo $_smarty_tpl->tpl_vars['LANG']->value['text_file_extension_info'];?>
</div>
                </div>

            </td>
        </tr>
        <?php echo smarty_function_template_hook(array('location'=>"admin_settings_files_bottom"),$_smarty_tpl);?>

    </table>

    <p>
        <input type="submit" name="update_files" value="<?php echo $_smarty_tpl->tpl_vars['LANG']->value['word_update'];?>
"/>
    </p>
</form>
<?php }
}
