{ft_include file='messages.tpl'}

<form action="{$samepage}" method="post" onsubmit="return rsv.validate(this, rules)">
    <input type="hidden" name="export_group_id" value="{$export_group_info.export_group_id}"/>

    <table cellspacing="1" cellpadding="2" border="0" width="100%" class="edit_export_group_table">
        <tr>
            <td width="130" class="medium_grey">{$L.phrase_export_group_name}</td>
            <td>
                <input type="text" name="group_name" value="{$export_group_info.group_name|escape}" style="width:100%"
                       maxlength="255"/>
            </td>
        </tr>
        <tr>
            <td class="medium_grey">{$L.word_visibility}</td>
            <td>
                <input type="radio" name="visibility" value="show" id="st1"
                       {if $export_group_info.visibility == "show"}checked{/if} />
                <label for="st1" class="green">{$LANG.word_show}</label>
                <input type="radio" name="visibility" value="hide" id="st2"
                       {if $export_group_info.visibility == "hide"}checked{/if} />
                <label for="st2" class="red">{$L.word_hide}</label>
            </td>
        </tr>
        <tr>
            <td valign="top" class="medium_grey">{$L.word_icon}</td>
            <td>
                <input type="hidden" name="icon" id="icon" value="{$export_group_info.icon}"/>
                <ul class="icon_list">
                    <li class="no_icon"></li>
                    {foreach from=$icons item=icon name=i}
                        {assign var=index value=$smarty.foreach.i.iteration}
                        <li {if $export_group_info.icon == $icon}class="selected"{/if}><img
                                    src="{$g_root_url}/modules/export_manager/images/icons/{$icon}"/></li>
                    {/foreach}
                </ul>
            </td>
        </tr>
        <tr>
            <td valign="top" class="medium_grey">{$L.word_action}</td>
            <td>

                <div>
                    <input type="radio" name="action" value="file" id="action1"
                           {if $export_group_info.action == "file"}checked{/if}
                           onclick="page_ns.change_action_type(this.value)"/>
                    <label for="action1">{$L.phrase_generate_file}</label>
                </div>
                <div>
                    <input type="radio" name="action" value="new_window" id="action2"
                           {if $export_group_info.action == "new_window"}checked{/if}
                           onclick="page_ns.change_action_type(this.value)"/>
                    <label for="action2">{$L.phrase_open_in_new_window}</label>
                </div>
                <div>
                    <input type="radio" name="action" value="popup" id="action3"
                           {if $export_group_info.action == "popup"}checked{/if}
                           onclick="page_ns.change_action_type(this.value)"/>
                    <label for="action3">{$L.phrase_display_popup}</label>
                    <span class="light_grey">&#8212;</span>
                    {$L.word_height_c}
                    <input type="text" name="popup_height" value="{$export_group_info.popup_height}"
                           style="width:40px"/>px
                    <span class="light_grey">&#8212;</span>
                    {$L.word_width_c}
                    <input type="text" name="popup_width" value="{$export_group_info.popup_width}" style="width:40px"/>px
                </div>
            </td>
        </tr>
        <tr>
            <td class="medium_grey">{$L.phrase_action_button_text}</td>
            <td>
                <input type="text" name="action_button_text" maxlength="100" style="width:100%"
                       value="{$export_group_info.action_button_text|escape}"/>
            </td>
        </tr>
        <tr>
            <td class="medium_grey">{$L.phrase_content_type}</td>
            <td>
                <input type="radio" name="content_type" id="ct1" value="html"
                    {if $export_group_info.content_type === 'html'}checked="checked"{/if} />
                    <label for="ct1">HTML</label>
                <input type="radio" name="content_type" id="ct2" value="text"
                    {if $export_group_info.content_type === 'text'}checked="checked"{/if} />
                    <label for="ct2">Text</label>
            </td>
        </tr>
        <tr>
            <td valign="top" class="medium_grey">{$L.word_headers}</td>
            <td>

                <div class="editor_wrapper">
                    <textarea name="headers" id="headers"
                              {if $export_group_info.action == "file"}disabled{/if}>{$export_group_info.headers}</textarea>
                </div>

                <script>
					var html_editor = new CodeMirror.fromTextArea(document.getElementById("headers"), {literal}{{/literal}
						mode: "smarty"
                        {literal}});{/literal}
                </script>

            </td>
        </tr>
        <tr>
            <td valign="top" class="medium_grey">{$L.phrase_smarty_template}</td>
            <td>
                <div class="editor_wrapper">
                    <textarea name="smarty_template"
                              id="smarty_template">{$export_group_info.smarty_template}</textarea>
                </div>

                <script>
					var html_editor = new CodeMirror.fromTextArea(document.getElementById("smarty_template"), {literal}{{/literal}
						mode: "smarty"
                        {literal}});{/literal}
                </script>
            </td>
        </tr>
    </table>

    <p>
        <input type="submit" name="update_export_group" value="{$LANG.word_update}"/>
    </p>

</form>
