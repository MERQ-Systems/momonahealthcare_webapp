/**
 * Contains all JS for the file upload module.
 */

$(function () {
	var supportsMultiFileUpload = 'multiple' in document.createElement('input');

	// in case the user's using a really old browser, disable the multiple option on the file buttons. This allows
	// the fields to continue to store multiple files - except they are only added to one by one for this particular
	// user
	if (!supportsMultiFileUpload) {
		$(".cf_file_upload_btn").each(function () {
			$(this).attr('name', $(this).attr('name').replace(/\[]$/, ''));
			$(this).removeAttr("multiple");
		});
	}

	var updateDeleteSelectedBtn = function (group, enabled) {
		var btn = $(group).find(".cf_file_delete_selected");
		if (enabled) {
			btn.removeAttr("disabled");
		} else {
			btn.attr("disabled", "disabled");
		}
	};

	$(".cf_delete_file,.cf_file_delete_selected").each(function () {
		var group = $(this).closest(".cf_file");
		var is_multiple = group.hasClass("cf_file_multiple");
		var field_id = group.find(".cf_file_field_id").val();

		$(this).bind("click", function () {
			var files = [];
			var num_files = group.find(".cf_file_row_cb").length;

			// users may downgrade a multiple file upload field to a single one, leaving file fields with multiple
			// files still in them. In that case we allow deleting new files, but not adding any more
			if (is_multiple || num_files > 1) {
				group.find(".cf_file_row_cb:checked").each(function () {
					files.push($(this).val());
				});
			} else {
				var file = group.find(".cf_file_row_cb");
				if (file) {
					files.push(file.val());
				}
			}
			return files_ns.delete_submission_files(field_id, files, false);
		});
	});

	$(".cf_file_toggle_all").each(function () {
		$(this).bind("click", function (e) {
			var group = $(this).closest(".cf_file");
			var cbs = group.find(".cf_file_row_cb");
			cbs.each(function () {
				this.checked = e.target.checked;
			});
			updateDeleteSelectedBtn(group, e.target.checked);
		});
	});

	$(".cf_file_row_cb").bind("click", function () {
		var group = $(this).closest(".cf_file");

		var num_checked = 0;
		var num_unchecked = 0;
		$(group).find(".cf_file_row_cb").each(function () {
			if (this.checked) {
				num_checked++;
			} else {
				num_unchecked++;
			}
		});

		if (num_checked > 0 && num_unchecked === 0) {
			$(group).find(".cf_file_toggle_all").attr("checked", "checked");
		} else {
			$(group).find(".cf_file_toggle_all").removeAttr("checked");
		}

		updateDeleteSelectedBtn(group, num_checked > 0);
	});
});


// ------------------------------------------------------------------------------------------------

var files_ns = {};
files_ns.confirm_delete_dialog = $("<div id=\"confirm_delete_dialog\"></div>");


/**
 * Checks the file field has a value in it. This is used instead of the default RSV "required" rule
 * because if a file's already uploaded, it needs to pass validation.
 */
files_ns.check_required = function () {
	var errors = [];
	for (var i = 0; i < rsv_custom_func_errors.length; i++) {
		if (rsv_custom_func_errors[i].func == "files_ns.check_required") {
			var field_id = rsv_custom_func_errors[i].field_id;
			var id_field = $("#cf_file_" + field_id);
			var has_file = id_field.hasClass("cf_file_has_items");
			var is_multiple = id_field.hasClass("cf_file_multiple");
			var field = document.edit_submission_form[rsv_custom_func_errors[i].field + (is_multiple ? '[]' : '')];
			if (!has_file && !field.value) {
				errors.push([field, rsv_custom_func_errors[i].err]);
			}
		}
	}
	if (errors.length) {
		return errors;
	}
	return true;
};


/**
 * Deletes a submission file.
 *
 * @param field_id
 * @param force_delete boolean
 */
files_ns.delete_submission_files = function (field_id, files, force_delete) {
	var page_url = g.root_url + "/modules/field_type_file/actions.php";
	var data = {
		action: "delete_submission_files",
		field_id: field_id,
		files: files,
		form_id: $("#form_id").val(),
		submission_id: $("#submission_id").val(),
		return_vars: { target_message_id: "file_field_" + field_id + "_message_id", field_id: field_id },
		force_delete: force_delete
	};

	if (!force_delete) {
		ft.create_dialog({
			dialog: files_ns.confirm_delete_dialog,
			popup_type: "warning",
			title: g.messages["phrase_please_confirm"],
			content: files.length === 1 ? g.messages["confirm_delete_submission_file"] : g.messages["confirm_delete_submission_files"],
			buttons: [{
				"text": g.messages["word_yes"],
				"click": function () {
					ft.dialog_activity_icon($("#confirm_delete_dialog"), "show");
					$.ajax({
						url: page_url,
						data: data,
						type: "GET",
						dataType: "json",
						success: files_ns.delete_files_response,
						error: ft.error_handler
					});
				}
			},
			{
				"text": g.messages["word_no"],
				"click": function () {
					$(this).dialog("close");
				}
			}]
		});
	} else {
		$.ajax({
			url: page_url,
			data: data,
			type: "GET",
			dataType: "json",
			success: files_ns.delete_files_response,
			error: ft.error_handler
		});
	}

	return false;
};


/**
 * Handles the successful response for deleting a file/files. If any of the files couldn't be deleted, the user is
 * provided some details, plus the option of updating the database record to just remove the reference.
 */
files_ns.delete_files_response = function (data) {
	ft.dialog_activity_icon($("#confirm_delete_dialog"), "hide");
	$("#confirm_delete_dialog").dialog("close");

	if (data.success) {
		var group = $("#cf_file_" + data.field_id).closest(".cf_file");
		for (var i=0; i<data.deleted_files.length; i++) {
			group.find(".cf_file_row_cb[value='" + data.deleted_files[i] + "']").closest("li").remove();
		}

		if (group.find(".cf_file_row_cb").length === 0) {
			group.removeClass("cf_file_has_items");
			group.find(".cf_file_list,.cf_file_delete_selected").hide();
			group.find(".cf_file_upload_btn").show();
		}
	}
	ft.display_message(data.target_message_id, data.success ? 1 : 0, data.message);
};
