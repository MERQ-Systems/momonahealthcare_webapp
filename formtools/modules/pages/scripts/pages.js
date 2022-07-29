/**
 * Contains all the relevant JS for the Pages module admin section.
 */
var pages_ns = {};
pages_ns.current_editor = null; // this is overwritten by the page. Values: "codemirror", "tinymce"
pages_ns.tinymce_available = false;

$(function() {
  pages_ns.tinymce_available = $("#tinymce_available").val() === "yes";

  if ($("#wysiwyg_content").length && pages_ns.tinymce_available) {

    tinymce.init({
      selector: "#wysiwyg_content",
      skin: "lightgray",
      toolbar: "bold italic underline strikethrough | bullist numlist | outdent indent | blockquote hr | undo redo link unlink | fontselect fontsizeselect | forecolor backcolor | subscript superscript code",
      plugins: "hr link textcolor lists",
      branding: false,
      menubar: false,
      elementpath: false,
      statusbar: true,
      resize: true
    });

  }
});


pages_ns.toggle_access_type = function(form_type) {
  switch (form_type) {
    case "admin":
    case "public":
      $("#custom_clients").hide();
      break;
    case "private":
      $("#custom_clients").show();
      break;
  }
}

pages_ns.toggle_wysiwyg_field = function(is_checked) {
  if (is_checked) {
    pages_ns.enable_editor("tinymce");
  } else {
    pages_ns.enable_editor("codemirror");
  }
};


/**
 * Whenever the user changes the content type (HTML, PHP or Smarty), the appropriate editor - Code Mirror
 * or TinyMCE needs to be shown & the content copied over. Also, the "Use WYSIWYG Editor" button may
 * or may not be relevant.
 */
pages_ns.change_content_type = function(content_type) {
  var is_html = content_type == "html";

  var useTinyMce = $("#uwe").attr("checked");

  // the "Use WYSIWYG editor" checkbox is only enabled if the user is entering HTML
  $("#uwe").attr("disabled", !is_html);

  // if the user just switched to HTML and the "Use WYWIWYG" editor is checked, display tinyMCE
  if (is_html && useTinyMce && pages_ns.current_editor != "tinymce") {
    pages_ns.enable_editor("tinymce");
  }
  if (!is_html && pages_ns.current_editor != "codemirror") {
    pages_ns.enable_editor("codemirror");
  }

  if (!useTinyMce) {
    if (content_type === "html") {
      html_editor.setOption("mode", "xml");
    } else if (content_type === "php") {
      html_editor.setOption("mode", "text/x-php");
    } else if (content_type === "php") {
      html_editor.setOption("mode", "smarty");
    }
  }
};


/**
 * This function handles toggling between editors. Basically it checks that the latest content
 * is always inserted into the appropriate editor.
 *
 * @param string editor "tinymce" or "codemirror"
 */
pages_ns.enable_editor = function(editor) {
  if (editor == "tinymce") {
    $("#wysiwyg_div").show();
    $("#codemirror_div").hide();
    if (pages_ns.tinymce_available) {
      tinymce.get("wysiwyg_content").setContent(html_editor.getValue());
    }
  } else {
	  // update the CodeMirror content
    if (pages_ns.tinymce_available) {
      html_editor.setValue(tinymce.get("wysiwyg_content").getContent());
    }
    $("#wysiwyg_div").hide();
    $("#codemirror_div").show();

    html_editor.refresh();
  }
  pages_ns.current_editor = editor;
};


pages_ns.delete_page = function(page_id) {
  ft.create_dialog({
    title: g.messages["phrase_please_confirm"],
    content: g.messages["confirm_delete_page"],
    popup_type: "warning",
    buttons: [
      {
        text:  g.messages["word_yes"],
        click: function() {
          window.location = 'index.php?delete=' + page_id;
        }
      },
      {
        text:  g.messages["word_no"],
        click: function() {
          $(this).dialog("close");
        }
      }
    ]
  });

  return false;
};
