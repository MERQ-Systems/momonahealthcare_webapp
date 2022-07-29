<?php
if (!empty($sectionList)) {
    foreach ($sectionList as $section_key => $section_value) {
        ?>
             <li class='option'><label class='checkbox'><input type='checkbox'  name='symptoms_title' value='<?php echo $section_value->symptoms_title."\n".$section_value->description ; ?>'> <?php echo $section_value->symptoms_title ?></label></li>
        <?php
    }
}
?>
<script type="text/javascript">
	
	$("input[name=symptoms_title]").change(function() {
  updateAllChecked();
});

$("input[name=addall]").change(function() {
  if (this.checked) {
    $("input[name=symptoms_title]").prop('checked', true).change();
  } else {
    $("input[name=symptoms_title]").prop('checked', false).change();
  }
});

function updateAllChecked() {

  $('#symptoms_description').val('');
  $('#esymptoms').val('');
  $('#move_ipd_symptoms').val('');
  $("input[name=symptoms_title]").each(function() {
    if (this.checked) {
      let old_text = $('#symptoms_description').val() ? $('#symptoms_description').val() + '\n\n' : '';
      let new_visit_symptoms = $('#esymptoms').val() ? $('#esymptoms').val() + '\n\n' : '';
      let symptoms_text = $('#move_ipd_symptoms').val() ? $('#move_ipd_symptoms').val() + '\n\n' : '';
     // let eold_text = $('#esymptoms').val() ? $('#esymptoms').val() + '\n\n' : '';
      $('#symptoms_description').val(old_text + $(this).val());
      $('#esymptoms').val(new_visit_symptoms + $(this).val());
      $('#move_ipd_symptoms').val(symptoms_text + $(this).val());
    }
  })
}
</script>