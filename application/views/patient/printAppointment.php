<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('bill'); ?></title>
        <style type="text/css">
            .printablea4{width: 100%;}
            .printablea4>tbody>tr>th,
            .printablea4>tbody>tr>td{padding:2px 0; line-height: 1.42857143;vertical-align: top; font-size: 12px;}
        </style>
    </head>
    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="" >
                    <?php if (!empty($print_details[0]['print_header'])) {
    ?>
                        <div class="pprinta4">
                            <img src="<?php
if (!empty($print_details[0]['print_header'])) {
        echo base_url() . $print_details[0]['print_header'].img_time();
    }
    ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php }?>

                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                   <form id="view" accept-charset="utf-8" method="get" class="pt5 pb5">
              <div class="table-responsive">
                <table class="table mb0 table-striped table-bordered examples" style="text-align:left; width:100%">
                <tr>
                  <th width="20%"><?php echo $this->lang->line('patient_name'); ?></th>
                  <td width="35%"><span id='patient_name_view'><?php echo $result['patients_name']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('appointment_no'); ?></th>
                  <td width="35%"><span id="appointmentno"><?php echo $result['appointment_no']?></span>
                  </td>
                </tr>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('appointment_date'); ?></th>
                  <td width="35%"><span id='dating'><?php echo $result['date']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('gender'); ?></th>
                  <td width="35%"><span id="genders"><?php echo $result['patients_gender']?></span>
                  </td>
                </tr>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('email'); ?></th>
                  <td width="35%"><span id='emails_view'><?php echo $result['patient_email']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('phone'); ?></th>
                  <td width="35%"><span id="phones_view"><?php echo $result['patient_mobileno']?></span>
                  </td>
                </tr>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('doctor'); ?></th>
                  <td width="35%"><span id='doctors'><?php echo composeStaffNameByString($result['name'],$result['surname'],$result['employee_id']);?></span></td>
                  <th width="20%"><?php echo $this->lang->line('message'); ?></th>
                  <td width="35%"><span id="messages"><?php echo $result['message']?></span>
                  </td>
                </tr>

                 <tr>
                  <th width="20%"><?php echo $this->lang->line('amount'); ?></th>
                  <td width="35%"><span id='pay_amount'><?php echo $currency_symbol.$result['amount']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('payment_mode'); ?></th>
                  <td width="35%"><span id="payment_mode"><?php echo $this->lang->line(strtolower($result['payment_mode']))?></span>
                  </td>
                </tr>
                <?php 
                if($result['payment_mode']=='Cheque'){
                	?>
                	<tr  id="payrow" style="display:none">
                  <th width="20%"><?php echo $this->lang->line('cheque_no'); ?></th>
                  <td width="35%"><span id='spn_chequeno'><?php echo $result['cheque_no']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('cheque_date'); ?></th>
                  <td width="35%"><span id="spn_chequedate"><?php echo $this->customlib->YYYYMMDDHisTodateFormat($result['cheque_date'], $this->customlib->getHospitalTimeFormat()); ?></span>
                  </td>
                </tr>
                <tr id="paydocrow" style="display:none">
                   <th><?php echo $this->lang->line('document'); ?></th>
                  <td id='spn_doc'><span ><?php echo $result['appointment_no']?></span></td>
                </tr>
                	<?php
                }
                ?>
                 
                <?php if ($this->module_lib->hasActive('live_consultation')) { ?>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('live_consultation'); ?></th>
                  <td width="35%"><span id="liveconsult"><?php echo $this->lang->line($result['live_consult']); ?></span>
                  </td>
                  <th width="20%"><?php echo $this->lang->line('status'); ?></th>
                  <td width="35%"><span id='status' style="text-transform: capitalize;"><?php echo $result['appointment_status']?></span></td>
                </tr>
                <?php } ?>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('shift'); ?></th>
                  <td width="35%"><span id="global_shift_view"><?php echo $result['global_shift_name']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('slot'); ?></th>
                  <td width="35%"><span id='doctor_shift_view' style="text-transform: capitalize;"><?php echo $result['doctor_shift_name']?></span></td>
                </tr>
                <tr>
                  <th width="20%"><?php echo $this->lang->line('source'); ?></th>
                  <td width="35%"><span id="source"><?php echo $result['source']?></span></td>
                  <th width="20%"><?php echo $this->lang->line('transaction_id'); ?></th>
                  <td width="35%"><span id="trans_id"><?php echo $result['transaction_id']?></span></td>
                  
                </tr>  
                <tr>
                  
                   <th width="20%"><?php echo $this->lang->line('appointment_priority'); ?></th>
                  <td width="35%"><span id="priority"><?php echo $result['appoint_priority']?></span></td>
                </tr>  

                 <div class="" id="customfield" ></div> 

                </table >
                  <table class="table mb0 table-striped table-bordered examples" id="field_data">
                    <?php
                        if (!empty($fields)) {
                            foreach ($fields as $fields_key => $fields_value) {
                                ?>

                            <tr><th width="20%"><?php echo $fields_value->name.': '; ?></th>
                            <td width="35%"> <?php echo $result["$fields_value->name"]; ?></td>
                            <th width="20%"></th>
                            <td width="35%"></td></tr>
                    <?php } } ?>
                  </table>                
              </div>
            </form>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <p><?php
if (!empty($print_details[0]['print_footer'])) {
    echo $print_details[0]['print_footer'];
}
?></p>
                </div>
            </div>
            <!--/.col (left) -->
        </div>
    </div>
</html>
