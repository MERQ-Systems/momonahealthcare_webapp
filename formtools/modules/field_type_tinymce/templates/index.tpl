{ft_include file='modules_header.tpl'}

<table cellpadding="0" cellspacing="0">
    <tr>
        <td width="45"><img src="images/tinymce.png" width="34" height="34"/></td>
        <td class="title">
            <a href="../../admin/modules">{$LANG.word_modules}</a>
            <span class="joiner">&raquo;</span>
            {$L.module_name}
        </td>
    </tr>
</table>

{ft_include file="messages.tpl"}

<div class="margin_bottom_large">
    Use the fields below to configure the default settings for the TinyMCE field type.
</div>

<form action="{$same_page}" method="post">

    <table cellspacing="0" cellpadding="1">
        <tr>
            <td width="170" class="medium_grey">{$L.word_toolbar}</td>
            <td>
                <select name="toolbar" id="toolbar">
                    <option value="basic"
                            {if $module_settings.toolbar == "basic"}selected{/if}>{$L.word_basic}</option>
                    <option value="simple"
                            {if $module_settings.toolbar == "simple"}selected{/if}>{$L.word_simple}</option>
                    <option value="advanced"
                            {if $module_settings.toolbar == "advanced"}selected{/if}>{$L.word_advanced}</option>
                    <option value="expert"
                            {if $module_settings.toolbar == "expert"}selected{/if}>{$L.word_expert}</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="medium_grey">{$L.phrase_allow_toolbar_resizing}</td>
            <td class="subelements">
                <input type="radio" name="resizing" id="tinymce_resize1" value="yes"
                       {if $module_settings.resizing == "true"}checked{/if} /> <label
                        for="tinymce_resize1">{$LANG.word_yes}</label>
                <input type="radio" name="resizing" id="tinymce_resize2" value="no"
                       {if $module_settings.resizing == ""}checked{/if} /> <label
                        for="tinymce_resize2">{$LANG.word_no}</label>
            </td>
        </tr>
    </table>

    <p class="bold">{$L.phrase_example_editor}</p>

    <div>
        <textarea id="example" name="example" rows="8" cols="90"
                  style="width: 100%">{$L.text_example_wysiwyg}</textarea>
    </div>

    <p>
        <input type="submit" name="update" value="{$LANG.word_update|upper}"/>
    </p>

</form>

{ft_include file='modules_footer.tpl'}
