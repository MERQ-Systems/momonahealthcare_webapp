{ft_include file='modules_header.tpl'}

  <table cellpadding="0" cellspacing="0">
  <tr>
    <td width="45"><a href="./"><img src="images/icon_pages.gif" border="0" width="34" height="34" /></a></td>
    <td class="title">
      <a href="../../admin/modules">{$LANG.word_modules}</a>
      <span class="joiner">&raquo;</span>
      <a href="./">{$L.module_name}</a>
      <span class="joiner">&raquo;</span>
      {$L.phrase_add_page}
    </td>
  </tr>
  </table>

  {ft_include file='messages.tpl'}

  <form action="edit.php" method="post" name="pages_form" onsubmit="return rsv.validate(this, rules)">
    <input type="hidden" name="use_wysiwyg_hidden" id="use_wysiwyg_hidden" value="" />
    <input type="hidden" id="tinymce_available" value="{$tinymce_available}" />

    <table cellspacing="1" cellpadding="1" border="0" width="100%">
    <tr>
      <td width="140" valign="top">{$L.phrase_page_name}</td>
      <td>
      	<input type="text" name="page_name" value="" style="width:200px" maxlength="50" autofocus />
      	<div class="light_grey">{$L.text_page_name_desc}</div>
      </td>
    </tr>
    <tr>
      <td>{$L.phrase_page_heading}</td>
      <td><input type="text" name="heading" value="" style="width:100%" /></td>
    </tr>
    <tr>
      <td>Content Type</td>
      <td>
      	<input type="radio" name="content_type" value="html" id="ct1" onclick="pages_ns.change_content_type(this.value)" checked />
      	  <label for="ct1">{$LANG.word_html}</label>
      	<input type="radio" name="content_type" value="php" id="ct2" onclick="pages_ns.change_content_type(this.value)" />
      	  <label for="ct2">{$L.word_php}</label>
      	<input type="radio" name="content_type" value="smarty" id="ct3" onclick="pages_ns.change_content_type(this.value)" />
      	  <label for="ct3">{$L.word_smarty}</label>
      </td>
    </tr>
    <tr>
      <td valign="top">{$L.phrase_page_content}</td>
      <td>
        {* onload we show the tinyMCE field by default IFF it's available. Otherwise show codemirror *}
      	<div id="wysiwyg_div" {if $tinymce_available == "no"}style="display: none"{/if}>
      	  <textarea name="wysiwyg_content" id="wysiwyg_content" style="width:100%; height:300px"></textarea>
      	</div>

      	<div id="codemirror_div" {if $tinymce_available == "yes"}style="display: none"{/if}>
      	  <div style="border: 1px solid #999999; padding: 3px">
      	    <textarea name="codemirror_content" id="codemirror_content" style="width:100%; height:300px"></textarea>
      	  </div>

      	  <script>
      	  var html_editor = new CodeMirror.fromTextArea(document.getElementById("codemirror_content"), {literal}{{/literal}
            mode: "xml"
      	  {literal}});{/literal}
      	  </script>
      	</div>

        {if $tinymce_available == "yes"}
      	  <input type="checkbox" id="uwe" name="use_wysiwyg" checked onchange="pages_ns.toggle_wysiwyg_field(this.checked)" />
      	    <label for="uwe">Use WYSIWYG editor</label>
      	  <br />
      	{/if}
      	<br />
      </td>
    </tr>
    <tr>
      <td valign="top">Who can access?</td>
      <td>
      	<table cellspacing="1" cellpadding="0" >
      	<tr>
      	  <td>
      	    <input type="radio" name="access_type" id="at1" value="admin" checked onclick="pages_ns.toggle_access_type(this.value)" />
      	      <label for="at1">{$LANG.phrase_admin_only}</label>
      	  </td>
      	</tr>
      	<tr>
      	  <td>
      	    <input type="radio" name="access_type" id="at2" value="public" onclick="pages_ns.toggle_access_type(this.value)" />
      	      <label for="at2">{$LANG.word_public} <span class="light_grey">{$LANG.phrase_all_clients_have_access}</span></label>
      	  </td>
      	</tr>
      	<tr>
      	  <td>
      	    <input type="radio" name="access_type" id="at3" value="private" onclick="pages_ns.toggle_access_type(this.value)" />
      	      <label for="at3">{$LANG.word_private} <span class="light_grey">{$LANG.phrase_only_specific_clients_have_access}</span></label>
      	  </td>
      	</tr>
      	</table>

      	<div id="custom_clients" class="margin_top" style="display:none">
      	  <table cellpadding="0" cellspacing="0" width="100%" class="list_table">
      	  <tr>
      	    <td class="medium_grey">{$LANG.phrase_available_clients}</td>
      	    <td></td>
      	    <td class="medium_grey">{$LANG.phrase_selected_clients}</td>
      	  </tr>
      	  <tr>
      	    <td>
      	      {clients_dropdown name_id="available_client_ids[]" multiple="true" multiple_action="hide"
      		      clients=[] size="4" style="width: 240px"}
      	    </td>
      	    <td align="center" valign="middle" width="100">
      	      <input type="button" value="{$LANG.word_add_uc_rightarrow}"
                onclick="ft.move_options(this.form['available_client_ids[]'], this.form['selected_client_ids[]']);" /><br />
      	      <input type="button" value="{$LANG.word_remove_uc_leftarrow}"
                onclick="ft.move_options(this.form['selected_client_ids[]'], this.form['available_client_ids[]']);" />
      	    </td>
      	    <td>
      	      {clients_dropdown name_id="selected_client_ids[]" multiple="true" multiple_action="show"
                clients=[] size="4" style="width: 240px"}
      	    </td>
      	  </tr>
      	  </table>
      	</div>

      	<div class="light_grey">
      	  Note that pages still need to be assigned to a client via their menu or a hardcoded link in order to be seen. This
      	  setting is for security purposes only.
      	</div>

      </td>
    </tr>
    </table>

    <p>
      <input type="submit" name="add_page" value="{$LANG.word_update|upper}" />
    </p>

  </form>

{ft_include file='modules_footer.tpl'}
