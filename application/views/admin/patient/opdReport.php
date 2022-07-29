<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><?php echo $this->lang->line('opd_report'); ?></h3>
                    </div>
                    <form id="form1" action="" method="post" class="">
                        <div class="box-body row">
                            <?php echo $this->customlib->getCSRF(); ?>
                            <div class="col-sm-6 col-md-3" >
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('search_type'); ?></label><small class="req"> *</small>
                                    <select class="form-control" name="search_type" onchange="showdate(this.value)"> 
                                        <option value=""><?php echo $this->lang->line('select'); ?></option> 
                                        <?php foreach ($searchlist as $key => $search) {
                                            ?>
                                            <option value="<?php echo $key ?>" <?php
                                            if ((isset($search_type)) && ($search_type == $key)) {
                                                echo "selected";
                                            }
                                            ?>><?php echo $search ?></option>
                                                <?php } ?>
                                    </select>
                                </div>
                                <span class="text-danger" id="error_search_type"><?php echo form_error('search_type'); ?></span>
                            </div>

                            <div class="col-sm-6 col-md-3"  >
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('doctor'); ?></label>
                                  

                                     <select class="form-control" name="doctor" onchange="showdate(this.value)">
                                        <option value=""><?php echo $this->lang->line('select') ?></option> 
                                        <?php foreach ($doctorlist as $key => $value) {
                                            ?>
                                            <option value="<?php echo $value['id'] ?>" <?php
                                            if ((isset($doctor_type)) && ($doctor_type == $key)) {
                                                echo "selected";
                                            }
                                            ?>><?php echo $value["name"] . " " . $value["surname"]. " (". $value['employee_id'] . ")"; ?></option>
                                                <?php } ?>
                                    </select>
                                    <span class="text-danger" id="error_doctor"><?php echo form_error('doctor'); ?></span>
                                </div>
                            </div> 

                           
                            <div class="col-sm-6 col-md-3">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('from_age'); ?></label>

                                    <select name="from_age" id="from_age" class="form-control" >
                                        <option value=""><?php echo $this->lang->line('select') ?></option> 
                                        <?php foreach($agerange as $key=>$value){ ?>
                                            <option value="<?php echo $key; ?>"<?php
                                            if ((isset($from_age)) && ($from_age == $key)) {
                                                    echo "selected";
                                                }
                                                ?>><?php echo $value; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-3">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('to_age'); ?></label>
                                    <select name="to_age" id="to_age" class="form-control" >
                                           <option value=""><?php echo $this->lang->line('select') ?></option> 
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="box-body row">
                            <div class="col-sm-6 col-md-3" >
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('gender'); ?></label>
                                    <select class="form-control"  name="gender" style="width: 100%">
                                        <option value=""><?php echo $this->lang->line('select') ?></option>
                                        <?php foreach($gender as $key => $value ){ ?>
                                         <option value="<?php echo $key; ?>"><?php echo $value ; ?></option>
                                     <?php } ?>
                                          
                                    </select>
                                    <span class="text-danger" id="error_collect_staff"><?php echo form_error('doctor'); ?></span>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3">
                                 <div class="form-group">
                                   <label><?php echo $this->lang->line('symptoms'); ?></label>
                                    <select name="symptoms" id="symptoms" class="form-control">                                   
                                         <option value="">Select</option>
                                        <?php foreach($classification as $row){ ?>
                                        <optgroup label="<?php echo $row['symptoms_type']; ?>">
                                           <?php  
                                      
                                          if(array_key_exists($row['id'],$symptoms) )
                                          {
                                               foreach($symptoms[$row['id']] as $sym_row){ 
                                               ;
                                              ?>
                                              <option value="<?php echo $sym_row['description']; ?>"> <?php echo $sym_row['symptoms_title'] ?></option>
                                        <?php 
                                         } } ?>
                                         
                                        </optgroup>
                                    <?php } ?>
                                  </select>
                               </div> 
                            </div>
                            <div class="col-sm-6 col-md-3">
                                 <div class="form-group">
                                   <label><?php echo $this->lang->line('findings'); ?></label>
                                    <select name="findings" id="findings" class="form-control">    
                                         <option value="">Select</option>
                                        <?php foreach($category as $cat_row){ ?>
                                        <optgroup label="<?php echo $cat_row['category']; ?>">
                                         
                                          <?php  
                                      
                                          if(array_key_exists($cat_row['id'],$findings) )
                                          {
                                               foreach($findings[$cat_row['id']] as $findings_row){  ?>
                                              <option value="<?php echo $findings_row['description']; ?>"> <?php echo $findings_row['name'] ?></option>
                                        <?php 
                                         } } ?>
                                         
                                        </optgroup>
                                    <?php } ?>
                                  </select>
                               </div> 
                            </div>
                        </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-sm-6 col-md-3" id="fromdate" style="display: none">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('date_from'); ?></label>
                                    <input id="date_from" name="date_from" placeholder="" type="text" class="form-control date" value="<?php echo set_value('date_from', date($this->customlib->getHospitalDateFormat())); ?>"  />
                                    <span class="text-danger"><?php echo form_error('date_from'); ?></span>
                                </div>
                            </div> 
                            <div class="col-sm-6 col-md-3" id="todate" style="display: none">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('date_to'); ?></label>
                                    <input id="date_to" name="date_to" placeholder="" type="text" class="form-control date" value="<?php echo set_value('date_to', date($this->customlib->getHospitalDateFormat())); ?>"  />
                                    <span class="text-danger"><?php echo form_error('date_to'); ?></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <button type="submit" name="search" value="search_filter" class="btn btn-primary btn-sm checkbox-toggle pull-right"><i class="fa fa-search"></i> <?php echo $this->lang->line('search'); ?></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
                    <div class="box border0 clear">
                        <div class="box-header ptbnull">
                        </div>
                        <div class="box-body table-responsive">
                            <div class="download_label"><?php echo $this->lang->line('opd_report'); ?></div>
                            <table class="table table-striped table-bordered table-hover allajaxlist" data-export-title="<?php echo $this->lang->line('opd_report'); ?>">
                                <thead>
                                    <tr>
                                        <th width="8%"><?php echo $this->lang->line('date'); ?></th>
                                        <th><?php echo $this->lang->line('opd_no'); ?></th>
                                        <th><?php echo $this->lang->line('checkup_id'); ?></th>
                                        <th><?php echo $this->lang->line('patient_name'); ?></th>
                                        <th width="7%"><?php echo $this->lang->line('age'); ?></th>
                                        <th><?php echo $this->lang->line('gender'); ?></th>
                                        <th><?php echo $this->lang->line('mobile_number'); ?></th>
                                        <th><?php echo $this->lang->line('guardian_name'); ?></th>
                                        <th><?php echo $this->lang->line('doctor_name'); ?></th>
                                        <th ><?php echo $this->lang->line('symptoms'); ?></th>
                                        <th ><?php echo $this->lang->line('findings'); ?></th>
                                       
                                         <?php 
                                        if (!empty($fields)) {
                                            foreach ($fields as $fields_key => $fields_value) {
                                                ?>
                                                <th><?php echo $fields_value->name; ?></th>
                                                <?php
                                            } 
                                            }
                                        ?>                               
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                  </tbody>  
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
</section>
</div>

<script type="text/javascript">
    $(document).ready(function (e) {
          emptyDatatable('allajaxlist', 'data');
    });

    function showdate(value) 
    {
       
        if (value == 'period') {
            $('#fromdate').show();
            $('#todate').show();
        } else {
            $('#fromdate').hide();
            $('#todate').hide();
        }
    }
</script>
<script type="text/javascript">
    $("#from_age").change(function(){
        var dosage_opt="<option value=''><?php echo $this->lang->line('select') ?></option>";
        var from_age =$("#from_age").val();
        var sss='<?php echo json_encode($agerange); ?>';
        var aaa=JSON.parse(sss);        
        $.each(aaa, function(key, item) 
        {      
            if(parseInt(from_age) < key){   
                dosage_opt+="<option value='"+key+"'>"+item+"</option>";
            }
        });
        $("#to_age").html(dosage_opt);     
    });
</script>

<script>
( function ( $ ) {
    'use strict';

    $(document).ready(function () {
       $('#form1').on('submit', (function (e) {
        e.preventDefault();
        var search= 'search_filter';
        var formData = new FormData(this);
        formData.append('search', 'search_filter');
        $.ajax({
            url: '<?php echo base_url(); ?>admin/patient/checkvalidation',
            type: "POST",
            data: formData,
            dataType: 'json',
            contentType: false,
            cache: false,
            processData: false,
            success: function (data) {
            
                if (data.status == "fail") {
                   $.each(data.error, function(key, value) {
                        $('#error_' + key).html(value);
                    });
                } else {
                    $("#error_search_type").html('');
                    $("#error_collect_staff").html('');
                    initDatatable('allajaxlist', 'admin/patient/opdreports/',data.param,[],100);
                }
            }
        });
        }
       ));
   });

} ( jQuery ) );
</script>