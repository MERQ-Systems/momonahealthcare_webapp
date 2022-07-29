{ft_include file='modules_header.tpl'}

<table cellpadding="0" cellspacing="0">
    <tr>
        <td width="45"><img src="images/file_upload_icon.png" width="34" height="34" /></td>
        <td class="title">
            <a href="../../admin/modules">{$LANG.word_modules}</a>
            <span class="joiner">&raquo;</span>
            {$L.module_name}
        </td>
    </tr>
</table>

{ft_include file="messages.tpl"}

<div class="margin_bottom_large">
    {$intro_desc}
</div>

<p>
    {$L.text_reset_field_type_desc}
</p>

<form action="{$same_page}" method="post">
    <p>
        <input type="submit" name="reset_field_type" value="{$L.phrase_reset_field_type}" />
    </p>
</form>

{ft_include file='modules_footer.tpl'}
