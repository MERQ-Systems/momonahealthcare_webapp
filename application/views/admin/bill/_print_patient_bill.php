<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php $currency_symbol = $this->customlib->getHospitalCurrencyFormat(); ?>
<div class="print-area">
<div class="row">
        <div class="col-md-12">
                        <?php if (!empty($print_details[0]['print_header'])) { ?>
                        <div class="pprinta4">
                            <img src="<?php
                            if (!empty($print_details[0]['print_header'])) {
                                echo base_url() . $print_details[0]['print_header'].img_time();
                            }
                            ?>" class="img-responsive">
                        </div>
                    <?php } ?>
              <div class="card">
                <div class="card-body">  
                    

                 <table class="noborder_table" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <th><?php
                            echo $this->lang->line('case_id'); ?></th>
                        <td><?php echo $case_id;?>  </td>
                        <th><?php echo $this->lang->line('appointment_date'); ?></th>
                        <td ><?php if($patient['appointment_date'] !='' && $patient['appointment_date']!='0000-00-00'){
                            echo $this->customlib->YYYYMMDDHisTodateFormat($patient['appointment_date'],$this->customlib->getHospitalTimeFormat());
                        } ?>
                        </td>
                    </tr> 
                    <tr>
                        <th><?php echo $this->lang->line('name'); ?></th>
                        <td ><?php echo composePatientName($patient['patient_name'],$patient['patient_id']); ?></td>
                        <th><?php echo $this->lang->line('guardian_name'); ?></th>
                        <td ><?php echo $patient['guardian_name']; ?></td>
                    </tr>
                    <tr>
                        <th><?php echo $this->lang->line('gender'); ?></th>
                        <td ><?php echo $patient['gender']; ?></td>
                        <th><?php echo $this->lang->line('age'); ?></th>
                        <td>
                            <?php echo $this->customlib->getPatientAge($patient['age'],$patient['month'],$patient['day']); ?>   
                        </td>
                    </tr>
                    <tr>
                        <th><?php echo $this->lang->line('phone'); ?></th>
                        <td ><?php echo $patient['mobileno']; ?></td>
                        <th><?php
                            echo $this->lang->line('credit_limit') . " (" . $currency_symbol . ")";
                            ;
                            ?></th>
                        <td ><?php echo $patient['credit_limit']; ?>
                        </td>
                    </tr>
                    <?php 
                    if($patient['ipdid']!='' && $patient['ipdid']!=0){?>
                    <tr>
                      
                        <th><?php echo $this->lang->line('ipd_no'); ?></th>
                        <td ><?php
                            if($patient['ipdid']!='' && $patient['ipdid']!=0){
                                echo $this->customlib->getSessionPrefixByType('ipd_no').$patient['ipdid'];
                            }
                            
                             if ($patient['discharged'] == 'yes') {
                                 echo " <span class='label label-warning'>" . $this->lang->line("discharged") . "</span>";
                             }
                            ?>
                        </td>
                    </tr>
                <?php } ?>
                    <?php 
                    if($patient['opdid']!='' && $patient['opdid']!=0){?>
                    <tr>
                        <th><?php echo $this->lang->line('opd_no'); ?></th>
                        <td ><?php
                            if($patient['opdid']!='' && $patient['opdid']!=0){
                                echo $this->customlib->getSessionPrefixByType('opd_no').$patient['opdid'];
                            }
                            ?>
                        </td>
                    </tr>
                <?php } ?>
                 <?php if($patient['ipdid'] !='' && $patient['ipdid'] !=0){?>
                    <tr>
                        <th><?php
                            echo $this->lang->line('admission_date');
                            ;
                            ?></th>
                        <td ><?php if($patient['date']!='' && $patient['date']!='0000-00-00'){
                            echo $this->customlib->YYYYMMDDTodateFormat($patient['date']);
                        } ?>
                        </td>
                        <th><?php
                            echo $this->lang->line('bed');
                            ;
                            ?></th>
                        <td ><?php echo $patient['bed_name'] . " - " . $patient['bedgroup_name'] . " - " . $patient['floor_name'] ?>
                        </td>
                    </tr> 
                    
                     <?php } ?>  
                    
                </tbody>
            </table>
                 
                       
<?php 
$total_amount=0;
$amount_paid=0;
if(!empty($opd_data)){
?>
    <h4><?php echo $this->lang->line('opd_charges'); ?></h4>
    <table class="noborder_table" >
    <thead>
        <tr class="border_top border_bottom">
        <th width="20%"><?php echo $this->lang->line('service'); ?></th>
        <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
        <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
        <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
        <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
        <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
    </tr>
    </thead>
    <?php 
    foreach ($opd_data as $opd_key => $opd_value) {
        $total_amount+=$opd_value['amount'];
    ?>
    <tr>
        <td width="20%"><?php echo $opd_value['name'];?></td>
        <td width="20%"><?php echo $currency_symbol.$opd_value['apply_charge'];?></td>
        <td width="10%"><?php echo $opd_value['qty']." ".$opd_value['unit'];?></td>
        <td width="15%">0.00</td>
        <td class="text-right"><?php echo $opd_value['tax'];?></td>
        <td class="text text-right"><?php echo $currency_symbol.$opd_value['amount'];?></td>
    </tr>
    <?php } ?>
</table>
    <?php 
}

if(!empty($ipd_data)){ ?>

    <h4><?php echo $this->lang->line('ipd_charges'); ?></h4>
    <table class="noborder_table">
    <thead>
        <tr class="border_top border_bottom">
            <th width="20%"><?php echo $this->lang->line('service'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <?php 
    foreach ($ipd_data as $ipd_key => $ipd_value) {
        $total_amount+=$ipd_value['amount'];
    ?>
    <tr class="no-line">
        <td width="20%"><?php echo $ipd_value['name'];?></td>
        <td width="20%"><?php echo $currency_symbol.$ipd_value['apply_charge'];?></td>
        <td width="10%"><?php echo $ipd_value['qty']." ".$ipd_value['unit'];?></td>
        <td width="15%">0.00</td>
        <td class="text-right"><?php echo $ipd_value['tax'];?></td>
        <td class="text text-right"><?php echo $currency_symbol.$ipd_value['amount'];?></td>
      </tr>
    <?php
    }
    ?>
</table>
    <?php 
}

//=========Pharmacy==========
if(!empty($pharmacy_data)){
    ?>
      <h4><?php echo $this->lang->line('pharmacy_bill'); ?></h4>
    <table class="noborder_table">
    <thead>
        <tr class="border_top border_bottom">
            <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <?php 
    foreach ($pharmacy_data as $pharmacy_key => $pharmacy_value) {
         $total_amount+=$pharmacy_value->net_amount;
    ?>
    <tr>
        <td width="20%"><?php echo $pharmacy_bill_prefix.$pharmacy_value->id;?></td>
        <td width="20%"><?php echo  $currency_symbol.$pharmacy_value->total;?></td>
        <td width="10%">1</td>
        <td width="15%"><?php echo "(".$pharmacy_value->discount_percentage."%) ".$currency_symbol.$pharmacy_value->discount;?></td>
        <td class="text-right"><?php echo $pharmacy_value->tax;?></td>
        <td class="text text-right"><?php echo  $currency_symbol.$pharmacy_value->net_amount;?></td>  
    </tr>       
    <?php
    }
    ?>
</table>
    <?php
}

//====================Pathology Billing================

if(!empty($pathology_data)){
    ?>
     <h4><?php echo $this->lang->line('pathology_bill'); ?></h4>
    <table class="noborder_table">
    <thead>
          <tr class="border_top border_bottom">
            <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
        <?php 
        foreach ($pathology_data as $pathology_key => $pathology_value) {
          $total_amount+=$pathology_value->net_amount;
        ?>
        <tr>
            <td width="20%"><?php echo $pathology_bill_prefix.$pathology_value->id;?></td>
            <td width="20%"><?php echo  $currency_symbol.$pathology_value->total;?></td>
            <td width="10%">1</td>
            <td width="15%"><?php  echo "(".$pathology_value->discount_percentage."%) ". $currency_symbol.$pathology_value->discount;?></td>
            <td class="text-right"><?php echo $currency_symbol.$pathology_value->tax;?></td>
            <td class="text-right"><?php echo $currency_symbol.$pathology_value->net_amount;?></td>
        </tr>       
    <?php
    }
    ?>
    </tbody>
  </table>
    <?php
}      

//====================Radiology Billing================

if(!empty($radiology_data)){
    ?>
     <h4><?php echo $this->lang->line('radiology_bill'); ?></h4>
    <table class="noborder_table">
    <thead>
        <tr class="border_top border_bottom">
            <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
        <?php 
        foreach ($radiology_data as $radiology_key => $radiology_value) {
           $total_amount+=$radiology_value->net_amount;
        ?>
        <tr>
            <td width="20%"><?php echo $radiology_bill_prefix.$radiology_value->id;?></td>
            <td width="20%"><?php echo  $currency_symbol.$radiology_value->total;?></td>
            <td width="10%">1</td>
            <td width="15%"><?php  echo "(".$radiology_value->discount_percentage."%) ". $currency_symbol.$radiology_value->discount;?></td>
            <td class="text-right"><?php echo $currency_symbol.$radiology_value->tax;?></td>
            <td class="text-right"><?php echo $currency_symbol.$radiology_value->net_amount;?></td>
        </tr>             
        <?php
        }
        ?>
    </tbody>
  </table>
    <?php
}      

//====================Blood Issue================

if(!empty($bloodissue_data)){
    ?>
     <h4><?php echo $this->lang->line('blood_issue'); ?></h4>
    <table class="noborder_table">
    <thead>
        <tr class="border_top border_bottom">
            <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
        <?php 
        foreach ($bloodissue_data as $blood_issue_key => $blood_issue_value) {
        $total_amount+=$blood_issue_value->net_amount;
   
        $discount_amount=calculatePercent($blood_issue_value->standard_charge,$blood_issue_value->discount_percentage);
        ?>
        <tr>
            <td width="20%"><?php echo $blood_bank_bill_prefix.$blood_issue_value->id;?></td>
            <td width="20%"><?php echo  $currency_symbol.$blood_issue_value->standard_charge;?></td>
            <td width="10%">1</td>
            <td width="15%"><?php echo "(".$blood_issue_value->discount_percentage."%) ". $discount_amount;?></td>
            <td class="text-right"><?php echo "(".$blood_issue_value->tax_percentage."%) ". $currency_symbol.calculatePercent(($blood_issue_value->standard_charge-$discount_amount),$blood_issue_value->tax_percentage);
               ?></td>
            <td class="text-right"><?php echo $currency_symbol.$blood_issue_value->net_amount;?></td>
        </tr>
        <?php
        }
        ?>
    </tbody>
  </table>
    <?php
    }      
    if(!empty($transaction_data)){
    ?>
    <h4><?php echo $this->lang->line('transactions'); ?></h4>
    <table class="noborder_table">
    <thead>
        <tr class="border_top border_bottom">
            <th><?php echo $this->lang->line('transaction_id'); ?></th>
            <th><?php echo $this->lang->line('payment_date'); ?></th>
            <th><?php echo $this->lang->line('payment_mode'); ?></th>
            <th class="text text-right"><?php echo $this->lang->line('amount'); ?></th> 
        </tr>
    </thead>
    <tbody>
        <?php
        foreach ($transaction_data as $transaction_key => $transaction_value) {
        $amount_paid+=$transaction_value->amount;
        ?>
        <tr>
            <td><?php echo $transaction_prefix.$transaction_value->id;?></td>
            <td><?php echo $this->customlib->YYYYMMDDHisTodateFormat($transaction_value->payment_date);?></td>
            <td><?php echo $this->lang->line(strtolower($transaction_value->payment_mode));?></td>
            <td class="text text-right"><?php echo $currency_symbol.$transaction_value->amount;?></td>
        </tr>
        <?php
        }
        ?>
    </tbody>
</table>
    <?php
    }
    ?>
    <table class="noborder_table">
        <tbody>
            <tr>
                <th style="width:70%" class="text text-right"><?php echo $this->lang->line('grand_total'); ?>:</th>
                <td class="text text-right"><?php echo $currency_symbol.amountFormat($total_amount); ?></td>
            </tr>
            <tr>
                <th class="text text-right"><?php echo $this->lang->line('amount_paid'); ?>:</th>
                <td class="text text-right"><?php echo $currency_symbol.amountFormat($amount_paid); ?></td>
            </tr>
            <tr>
                <th class="text text-right"><?php echo $this->lang->line('balance_amount'); ?>:</th>
                <td class="text text-right"><?php echo $currency_symbol.amountFormat(($total_amount-$amount_paid));?></td>
            </tr>
        </tbody>
    </table>
                </div>
            </div>
        </div>
    </div>
</div>