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
                        <h3 class="box-title"><?php echo $this->lang->line('radiology_patient_report'); ?></h3>
                    </div>
                    <form id="form1" action="" method="post">
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
                                    <span class="text-danger" id="error_search_type"><?php echo form_error('search_type'); ?></span>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-3">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('sample_collected_person_name'); ?></label>
                                    <select class="form-control select2"  name="collect_staff" style="width: 100%">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>

                                    <?php foreach ($radiologist as $dkey => $dvalue) {
                                                            ?>
                                        <option value="<?php echo $dvalue["id"]; ?>" <?php
                                                if ((isset($radiologist_select)) && ($radiologist_select == $dvalue["id"])) {
                                                    echo "selected";
                                                 }
                                            ?>><?php echo $dvalue["name"] . " " . $dvalue["surname"]." (".$dvalue["employee_id"].")" ?>
                                        </option>   
                                    <?php } ?>
                                    </select>
                                    <span class="text-danger" id="error_collect_staff"><?php echo form_error('doctor'); ?></span>
                                </div>
                            </div>

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

                             <div class="col-sm-6 col-md-3">
                                <div class="form-group">
                                    <label for="exampleInputFile">
                                        <?php echo $this->lang->line('category_name'); ?></label>
                                    <div>
                                        <select class="form-control select2" style="width: 100%" name='radiology_category_id' >
                                            <option value=""><?php echo $this->lang->line('select') ?></option>
                                            <?php foreach ($categoryName as $dkey => $dvalue) {
                                                ?>
                                                <option value="<?php echo $dvalue["id"]; ?>"><?php echo $dvalue["lab_name"] ?></option>   
                                            <?php } ?>
                                        </select>
                                    </div>
                                    <span class="text-danger"><?php echo form_error('radio_category_id'); ?></span>
                                </div>
                            </div>  

                            <div class="col-sm-6 col-md-3">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('test_name'); ?></label>
                                    <select class="form-control test_name select2" style="width:100%"  name='test_name'>
                                        <option value="<?php echo set_value('test_name_id'); ?>"><?php echo $this->lang->line('select'); ?>
                                        </option>
                                        <?php foreach ($testlist as $dkey => $dvalue) { ?>
                                            <option value="<?php echo $dvalue["id"]; ?>"><?php echo $dvalue["test_name"]." (".$dvalue["short_name"].")"; ?>
                                            </option>
                                    <?php }?>
                                </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-12">
                                    <button type="submit" name="search" value="search_filter" class="btn btn-primary btn-sm checkbox-toggle pull-right"><i class="fa fa-search"></i> <?php echo $this->lang->line('search'); ?></button>
                                </div>
                            </div>
                        </div>
                    </form>


                    <div class="box border0 clear">
                        <div class="box-header ptbnull"></div>
                        <div class="box-body table-responsive">
                            <div class="download_label"><?php echo $this->lang->line('radiology_patient_report'); ?></div>
                            <table class="table table-striped table-bordered table-hover allajaxlist" data-export-title="<?php echo $this->lang->line('radiology_patient_report'); ?>">
                                <thead>
                                    <tr>
                                        <th width="8%"><?php echo $this->lang->line("bill_no"); ?></th>
                                        <th width="8%"><?php echo $this->lang->line('date'); ?></th>
                                        <th><?php echo $this->lang->line('patient_name'); ?></th>
                                        <th><?php echo $this->lang->line('category_name'); ?></th>
                                        <th><?php echo $this->lang->line('test_name'); ?></th>
                                        <th><?php echo $this->lang->line('description'); ?></th> 
                                        <th><?php echo $this->lang->line('consultant_doctor'); ?></th>
                                        <th><?php echo $this->lang->line('sample_collected_person_name') ; ?></th>
                                         <?php 
                                        if (!empty($fields)) {
                                            foreach ($fields as $fields_key => $fields_value) {
                                                ?>
                                                <th><?php echo $fields_value->name; ?></th>
                                                <?php
                                            } 
                                        }
                                        ?>  
                                        <th><?php echo $this->lang->line('amount') . '(' . $currency_symbol . ')'; ?></th>
                                        <th><?php echo $this->lang->line('paid_amount') . '(' . $currency_symbol . ')'; ?></th>
                                        <th><?php echo $this->lang->line('balance_amount') . '(' . $currency_symbol . ')'; ?></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>   

    </section>
</div>
<script>
    $(function () {
        //Initialize Select2 Elements
        $('.select2').select2();
    });
</script>

<script type="text/javascript">
   
    function showdate(value) {
        if (value == 'period') {
            $('#fromdate').show();
            $('#todate').show();
        } else {
            $('#fromdate').hide();
            $('#todate').hide();
        }
    }
</script>
<script>
    $(document).ready(function (e) {
      
        emptyDatatable('allajaxlist', 'data');
    });
    
( function ( $ ) {
    'use strict';

    $(document).ready(function () {
       $('#form1').on('submit', (function (e) {
        e.preventDefault();
        var search= 'search_filter';
        var formData = new FormData(this);
        formData.append('search', 'search_filter');
        $.ajax({
            url: '<?php echo base_url(); ?>admin/radio/checkvalidation',
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

                    initDatatable('allajaxlist', 'admin/radio/radiologyreports/',data.param,[],100,
                        [
                            { "aTargets": [ -1, -2, -3 ] ,'sClass': 'dt-body-right'}
                        ]);
                }
            }
        });
        }
       ));
   });

} ( jQuery ) );

</script>