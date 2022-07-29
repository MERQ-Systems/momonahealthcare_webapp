<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$genderList = $this->customlib->getGender();
?>
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"> <?php echo $this->lang->line('patient_login_credential'); ?></h3>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                        <table class="table table-striped table-bordered table-hover ajaxlist" cellspacing="0" width="100%" data-export-title="<?php echo $this->lang->line('patient_login_credential'); ?>">
                            <thead>
                                <tr>
                                    <th><?php echo $this->lang->line('patient_id'); ?></th>
                                    <th><?php echo $this->lang->line('patient_name'); ?></th>
                                    <th><?php echo $this->lang->line('username'); ?></th>
                                    <th class="text-right"><?php echo $this->lang->line('password'); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                              
                            </tbody>
                        </table>
                    </div>
                </div>                                                    
            </div>                                                                                                                                          
        </div>  
    </section>
</div>
<!-- //========datatable start===== -->
<script type="text/javascript">
( function ( $ ) {
    
    'use strict';
    $(document).ready(function () {
        initDatatable('ajaxlist','admin/patient/getcredentialdatatable',[],[],100);
    });
} ( jQuery ) )
</script>
<!-- //========datatable end===== -->
