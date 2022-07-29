<link rel="stylesheet" href="<?php echo base_url(); ?>backend/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<script src="<?php echo base_url(); ?>backend/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<link href="<?php echo base_url(); ?>backend/multiselect/css/jquery.multiselect.css" rel="stylesheet">
<script src="<?php echo base_url(); ?>backend/multiselect/js/jquery.min.js"></script>
<script src="<?php echo base_url(); ?>backend/multiselect/js/jquery.multiselect.js"></script>

<script type="text/javascript">
$('#pathologyOpt').multiselect({
    columns: 1,
    placeholder: 'Select Pathology',
    search: true
});

 $('#radiologyOpt').multiselect({
    columns: 1,
    placeholder: 'Select Radiology',
    search: true
});
    
</script>  
<script type="text/javascript">
    function delete_prescription(id, ipdid) {       
        if (confirm('<?php echo $this->lang->line('delete_confirm')?>')) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/prescription/deleteipdPrescription/' + id + '/' + ipdid,
                success: function (res) {
                    window.location.reload(true);
                },
                error: function () {
                    alert("Fail")
                }
            });

        }
    }
</script>
<script type="text/javascript">

    $(function () {
        $("#compose-textarea,#compose-textareaold").wysihtml5({
            toolbar: {
                "image": false,
            }
        });
        $('.select2').select2();
    });

    function geteditMedicineName(id, selectid = '', dosage = '') {       
        var category_selected = $("#editmedicine_cat" + id).val();
        var arr = category_selected.split('-');
        var category_set = arr[0];
        div_data = '';
        $("#editsearch-query" + id).html("<option value='l'><?php echo $this->lang->line('loading') ?></option>");
        $('#editsearch-query' + id).select2("val", +id);
        $.ajax({
            type: "POST",
            url: base_url + "admin/pharmacy/get_medicine_name",
            data: {'medicine_category_id': category_selected},
            dataType: 'json',
            success: function (res) {               
                $.each(res, function (i, obj)
                {
                    var sel = "";

                    div_data += "<option '" + sel + "' value='" + obj.medicine_name + "'>" + obj.medicine_name + "</option>";
                });
                $("#editsearch-query" + id).html("<option value=''>Select</option>");
                $('#editsearch-query' + id).append(div_data);
                $('#editsearch-query' + id).select2().select2("val", selectid);
                geteditMedicineDosage(id, dosage);
            }
        });
    }
    ;

    function geteditMedicineDosage(id, selectid = '') {       
        var category_selected = $("#editmedicine_cat" + id).val();
        var arr = category_selected.split('-');
        var category_set = arr[0];
        div_data = '';

        $("#editsearch-dosage" + id).html("<option value='l'><?php echo $this->lang->line('loading') ?></option>");
        $('#editsearch-dosage' + id).select2().select2("val", +id);

        $.ajax({
            type: "POST",
            url: base_url + "admin/pharmacy/get_medicine_dosage",
            data: {'medicine_category_id': category_selected},
            dataType: 'json',
            success: function (res) {
                console.log(res);
                $.each(res, function (i, obj)
                {
                    var sel = "";
                    div_data += "<option '" + sel + "' value='" + obj.dosage + "'>" + obj.dosage + "</option>";

                });
                $("#editsearch-dosage" + id).html("<option value=''>Select</option>");
                $('#editsearch-dosage' + id).append(div_data);                
                $('#editsearch-dosage' + id).select2().select2("val", selectid);               
            }
        });
    }
    ;

    function edit_more() {

        var table = document.getElementById("edittableID");
        var table_len = (table.rows.length);
        var id = parseInt(table_len);
        var div = "<div id=row1><div class=col-sm-3><select class='form-control select2' onchange='geteditMedicineName(" + id + ")' name='medicine_cat[]'  id='editmedicine_cat" + id + "'><option value='<?php echo set_value('medicine_category_id'); ?>'><?php echo $this->lang->line('select') ?></option><?php foreach ($medicineCategory as $dkey => $dvalue) { ?><option value='<?php echo $dvalue["id"]; ?>'><?php echo $dvalue["medicine_category"] ?></option><?php } ?></select></div><div class=col-sm-3><div class=form-group><select  class='form-control select2'  name='medicine[]' id='editsearch-query" + id + "'><option value='l'><?php echo $this->lang->line('select') ?></option></select></div><div id='editsuggesstion-box" + id + "'></div></div><div class=col-sm-3><div class=form-group><select class=form-control name='dosage[]' id='editsearch-dosage" + id + "' ><option value='l'><?php echo $this->lang->line('select') ?></option><?php foreach ($dosage as $dkey => $dosagevalue) { ?><option value='<?php echo $dosagevalue["dosage"]; ?>'><?php echo $dosagevalue["dosage"] ?></option><?php } ?></select><input type=hidden class=form-control value='0' name='prescription_id[]' /></div></div><div class=col-sm-3><div class=form-group><textarea name='instruction[]' style='height:28px;' class=form-control id=description></textarea></div></div></div>";

        var row = table.insertRow(table_len).outerHTML = "<tr id='row" + id + "'><td>" + div + "</td><td valign='middle'><div class=form-group><button type='button' onclick='delete_row(" + id + ")' class='modaltableclosebtn'><i class='fa fa-remove'></i></button></div></td></tr>";
        $(".select2").select2();
    }

</script>

 <form id="update_prescription" accept-charset="utf-8"  enctype="multipart/form-data" method="post" class="">
                <div class="">
                    <div class="row">
                    <div class="col-sm-9 col-md-9 col-lg-9">
                    <div class="ptt10">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('header_note'); ?></label> 
                                    <textarea name="header_note" class="form-control" id="compose-textarea" style="height:50px"><?php echo strip_tags($result["header_note"]) ?></textarea>
                                    <input type="hidden" name="ipd_id" value="<?php echo $result['ipd_id'] ?>">

                                </div> 
                            </div>
                              <hr/>
                        <?php
                         foreach ($prescription_list as $pkey => $pvalue) {
                            ?>
                            <input type="hidden" name="previous_pres_id[]" value="<?php echo $pvalue['id'] ?>">
                            <input type="hidden" name="visit_id" value="<?php echo $pvalue['basic_id'] ?>">
                        <?php } ?>
                        <table style="width: 100%;" id="edittableID">

                            <?php
                            $i = 0;
                            foreach ($prescription_list as $key => $value) {
                                ?>
                                <script type="text/javascript">
                                    geteditMedicineName('<?php echo $i ?>', '<?php echo $value['medicine'] ?>', '<?php echo $value['dosage'] ?>');
                                </script>
                                <tr id="row<?php echo $i ?>">
                                    <td>      
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                               
                                               <?php if($i == 0){ ?>
                                                <label><?php echo $this->lang->line('medicine') . " " . $this->lang->line("category"); ?></label><small class="req"> *</small>
                                                <?php } ?> 
                                                <select class="form-control select2" style="width: 100%" name='medicine_cat[]' onchange="geteditMedicineName(0)"  id="editmedicine_cat<?php echo $i ?>">
                                                    <option value="<?php echo set_value('medicine_category_id'); ?>"><?php echo $this->lang->line('select') ?>
                                                    </option>
                                                    <?php foreach ($medicineCategory as $dkey => $dvalue) {
                                                        ?>
                                                        <option value="<?php echo $dvalue["id"]; ?>" <?php
                                                        if ($value['medicine_category_id'] == $dvalue["id"]) {
                                                            echo "selected";
                                                        }
                                                        ?>><?php echo $dvalue["medicine_category"] ?>
                                                        </option>   
    <?php } ?>
                                                </select>
                                            </div>
                                        </div>                              
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                   <?php if($i == 0){ ?>
                                            
                                                <label>
    <?php echo $this->lang->line('medicine'); ?></label> 
<?php } ?>
                                                <select   class="form-control select2" style="width: 100%"  name="medicine[]" id="editsearch-query<?php echo $i ?>">
                                                    <option value="l"><?php echo $this->lang->line('select') ?></option>
                                                </select>
                                      
                                                <input type="hidden" value="<?php echo $value['id'] ?>" name="prescription_id[]" class="form-control" id="report_type" />
                                                  <input type="hidden" name="ipd_no_value" value="<?php echo $result['ipd_no'] ?>">
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                   <?php if($i == 0){ ?>
                                          
                                                <label><?php echo $this->lang->line('dosage'); ?></label> 
                                                <?php } ?>     
                                                <select   class="form-control select2" style="width: 100%"  name="dosage[]" id="editsearch-dosage<?php echo $i ?>">
                                                    <option value="l"><?php echo $this->lang->line('select') ?></option>
                                                </select>

                                            </div> 
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                         <?php if($i == 0){ ?>
                                          
                                                <label><?php echo $this->lang->line('instruction'); ?></label>
                                                <?php } ?> 
                                                <textarea name="instruction[]" class="form-control" style="height: 28px;" id="instruction[]"><?php echo $value['instruction'] ?></textarea>

                                            </div> 
                                        </div>
                                    </td>
                                    <?php if ($i != 0) { ?>
                                        <td valign="top"><button type='button' onclick="delete_row('<?php echo $i ?>')" class='modaltableclosebtn'><i class='fa fa-remove'></i></button></td>
                                    <?php } else { ?>
                                        <td valign="middle"><button type="button" onclick="edit_more()" style="color: #2196f3;    padding-top: 10px;" class="modaltableclosebtn"><i class="fa fa-plus"></i></button>
                                        </td>
                                <?php } ?>
                                </tr>
                                <?php
                                $i++;
                            }
                            ?>
                        </table>
                            <hr/>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('footer_note'); ?></label> 
                                <textarea name="footer_note" class="form-control" id="compose-textareaold" style="height:50px"><?php echo strip_tags($result["footer_note"])  ?></textarea>
                            </div> 
                        </div> 
                        </div>
                    </div> 
                </div>
                <div class="col-sm-3 col-md-3 col-lg-3">
                    <div class="col-sm-12">
                        <div class="form-group">
                        <label><?php echo $this->lang->line('pathology'); ?></label>

                              <?php 
                                    $prespathoarray[]='';
                                    $prespatho_array[]=''; 
                                    foreach($prescription_pathology as $pres_list_value){
                                        $prespatho_array[] = $pres_list_value;
                                    } $prespathoarray[] = $prespatho_array;  ?> 

                             <select class="" style="width: 100%" name='pathology[]' multiple onchange=""  id="pathologyOpt">
                                <?php  foreach ($pathology as $dkey => $dvalue) {   ?>
                                    <option value="<?php echo $dvalue["id"]; ?>"<?php
                                        if ((isset($prescription_pathology)) && ( in_array($dvalue["id"], $prespathoarray[1])))                              
                                        { echo "selected"; }?>>                                     
                                            <?php echo $dvalue["test_name"]  ?>            
                                    </option>   
                                <?php } ?> 
                             </select>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                        <label><?php echo $this->lang->line('radiology'); ?></label>
                           
                                 <?php 
                                    $presradioarray[]='';
                                    $presradio_array[]=''; 
                                    foreach($prescription_radiology as $pres_list_value){
                                        $presradio_array[] = $pres_list_value;
                                    } $presradioarray[] = $presradio_array;  ?> 

                            <select class="" style="width: 100%" name='radiology[]' multiple onchange=""  id="radiologyOpt">
                                <?php  foreach ($radiology as $dkey => $dvalue) {   ?>
                                    <option value="<?php echo $dvalue["id"]; ?>"<?php
                                        if ((isset($prescription_radiology)) && ( in_array($dvalue["id"], $presradioarray[1])))                              
                                        { echo "selected"; }?>>                                     
                                            <?php echo $dvalue["test_name"]  ?>            
                                    </option>   
                                <?php } ?> 
                             </select>
                        </div>
                    </div>
                    <div class="col-sm-12">
                     <div class="ptt10">
                        <label for="exampleInputEmail1"><?php echo $this->lang->line('notification')." ".$this->lang->line('to'); ?></label>
                             <?php
                                foreach ($roles as $role_key => $role_value) {
                                            $userdata = $this->customlib->getUserData();
                                            $role_id = $userdata["role_id"];
                                            ?>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="visible[]" value="<?php echo $role_value['id']; ?>" <?php
                                            if ($role_value["id"] == $role_id) {
                                                echo "checked ";
                                            }
                                        ?>  <?php echo set_checkbox('visible[]', $role_value['id'], false) ?> /> <b><?php echo $role_value['name']; ?></b> </label>
                                    </div>
                                    <?php } ?>

                     </div>
                 </div>
                </div>
                </div>  
                </div> <!--./modal-body--> 
             <div class="box-footer row">
                <div class="pull-right">
                    <button type="submit" class="btn btn-info"><?php echo $this->lang->line('save'); ?></button>

                </div>
            </div>
    </form>

<script type="text/javascript">
    $(document).ready(function (e) {
    $("#update_prescription").on('submit', (function (e) {
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/update_ipdprescription',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {
                    if (data.status == "fail") {
                        var message = "";
                        $.each(data.error, function (index, value) {
                            message += value;
                        });
                        errorMsg(message);
                    } else {
                        successMsg(data.message);
                        window.location.reload(true);
                    }
                },
                error: function () { 

                }
            });
        }));
    });
</script>