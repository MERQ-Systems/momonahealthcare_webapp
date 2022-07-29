<?php $currency_symbol = $this->customlib->getHospitalCurrencyFormat(); ?>

        <div class="row">
            <div class="col-md-12">
            
                        <?php 
$total_amount=0;
$amount_paid=0;
$amount_refund = 0;
if(!empty($opd_data)){
 
    ?>
    <h4><?php echo $this->lang->line('opd_charges'); ?></h4>
<div class="table-responsive">    
<table class="table table-hover">
    <thead>
        <tr>
            <th width="20%"><?php echo $this->lang->line('service'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th width="15%" class="text-right"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right" width="15%"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
    <?php 
    foreach ($opd_data as $opd_key => $opd_value) {
        $total_amount+=$opd_value['amount'];
 ?>
      <tr>
         
          <td width="20%">
<?php echo $opd_value['name'];?>
              
          </td>
          <td width="20%">
<?php echo $currency_symbol.$opd_value['apply_charge'];?>
          </td>
          <td width="10%">
              
<?php echo $opd_value['qty']." ".$opd_value['unit'];?>
          </td>
          <td width="15%" class="text-right">0.00</td>
          <td class=" text-right">
            <?php echo $opd_value['tax'];?>

          </td>
          
           <td class="text text-right">
      
<?php echo $currency_symbol.$opd_value['amount'];?>
          </td>
      </tr>

      <?php

    }
       ?>
   </tbody>
</table>
</div>
    <?php 
}

if(!empty($ipd_data)){
 
    ?>
    <h4><?php echo $this->lang->line('ipd_charges'); ?></h4>
<div class="table-responsive">    
<table class="table table-hover">
    <thead>
        <tr>
        <th><?php echo $this->lang->line('service'); ?></th>
        <th><?php echo $this->lang->line('charge'); ?></th>
        <th ><?php echo $this->lang->line('qty'); ?></th>
        <th width="15%" class="text-right"><?php echo $this->lang->line('discount'); ?></th>
        <th class="text-right" width="15%"><?php echo $this->lang->line('tax'); ?></th>
        <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
    </tr>
    </thead>
    <tbody>
    <?php 
    foreach ($ipd_data as $ipd_key => $ipd_value) {
        $total_amount+=$ipd_value['amount'];
 ?>
      <tr>
         
          <td width="20%">
<?php echo $ipd_value['name'];?>
              
          </td>
          <td width="20%">
<?php echo $currency_symbol.$ipd_value['apply_charge'];?> 
          </td>
          <td width="10%">
              
<?php echo $ipd_value['qty']." ".$ipd_value['unit'];?>
          </td>
          <td width="15%" class="text-right">0.00</td>
          <td class="text text-right" width="15%">
            <?php echo $ipd_value['tax'];?>

          </td>
          
           <td class="text text-right">
      
<?php echo $currency_symbol.$ipd_value['amount'];?>
          </td>
      </tr>

      <?php

    }
       ?>
   </tbody>
</table>
</div>
    <?php 
}

//=========Pharmacy==========
if(!empty($pharmacy_data)){
    ?>
      <h4><?php echo $this->lang->line('pharmacy_bill'); ?></h4>
<div class="table-responsive">      
<table class="table table-hover">
    <thead>
        <tr>
           <th><?php echo $this->lang->line('bill_no'); ?></th>
           <th><?php echo $this->lang->line('charge'); ?></th>
           <th><?php echo $this->lang->line('qty'); ?></th>
           <th class="text-right" width="15%"><?php echo $this->lang->line('discount'); ?></th>
           <th class="text-right" width="15%"><?php echo $this->lang->line('tax'); ?></th>
           <th class="text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
    <?php 
    foreach ($pharmacy_data as $pharmacy_key => $pharmacy_value) {
         $total_amount+=$pharmacy_value->net_amount;
       ?>
       <tr>
       <td width="20%" class="white-space-nowrap">
           
            <?php echo $pharmacy_bill_prefix.$pharmacy_value->id;?>       
       </td>
         <td width="20%">
            <?php echo  $currency_symbol.$pharmacy_value->total;?>
           
       </td>
        <td width="15%" >1</td>
         <td>
           
            <?php echo "(".$pharmacy_value->discount_percentage."%) ".$currency_symbol.$pharmacy_value->discount;?>
       </td>
         <td width="15%" class="text text-right">
           
            <?php echo $pharmacy_value->tax;?>
       </td>
        <td class="text text-right">
            <?php echo  $currency_symbol.$pharmacy_value->net_amount;?>
           
       </td>
       
        </tr>
            
       <?php
    }

    ?>
</tbody>
</table>
</div>
    <?php
}

?>
<?php
//====================Pathology Billing================

if(!empty($pathology_data)){
    ?>
     <h4><?php echo $this->lang->line('pathology_bill'); ?></h4>
<div class="table-responsive">     
<table class="table table-hover">
    <thead>
        <tr>
            <th><?php echo $this->lang->line('bill_no'); ?></th>
            <th><?php echo $this->lang->line('charge'); ?></th>
            <th><?php echo $this->lang->line('qty'); ?></th>
            <th class="text-right" width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right" width="15%"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
      <?php 
        foreach ($pathology_data as $pathology_key => $pathology_value) {
          $total_amount+=$pathology_value->net_amount;
      ?>
        <tr>
            <td width="20%" class="white-space-nowrap"><?php echo $pathology_bill_prefix.$pathology_value->id;?></td>
            <td width="20%"><?php echo  $currency_symbol.$pathology_value->total;?></td>
            <td width="10%">1</td>
            <td width="15%"  class="text text-right"><?php  echo "(".$pathology_value->discount_percentage."%) ". $currency_symbol.$pathology_value->discount;?></td>
            <td width="15%" class="text text-right"><?php echo $currency_symbol.$pathology_value->tax;?></td>
            <td class="text text-right"><?php echo $currency_symbol.$pathology_value->net_amount;?></td>
        </tr>
       <?php
    }
    ?>
    </tbody>
  </table>
</div>  
    <?php
}      

//====================Radiology Billing================

if(!empty($radiology_data)){
    ?>
     <h4><?php echo $this->lang->line('radiology_bill'); ?></h4>
<div class="table-responsive">     
<table class="table table-hover">
    <thead>
        <tr>
             <th><?php echo $this->lang->line('bill_no'); ?></th>
            <th><?php echo $this->lang->line('charge'); ?></th>
            <th><?php echo $this->lang->line('qty'); ?></th>
            <th class="text-right" width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text-right" width="15%"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
      <?php 
    foreach ($radiology_data as $radiology_key => $radiology_value) {
           $total_amount+=$radiology_value->net_amount;
      ?>
       <td width="20%" class="white-space-nowrap">  <?php echo $radiology_bill_prefix.$radiology_value->id;?> </td>
        <td width="20%"> <?php echo  $currency_symbol.$radiology_value->total;?> </td>
        <td width="10%" >  1     </td>
        <td width="15%" class="text text-right"> <?php  echo "(".$radiology_value->discount_percentage."%) ". $currency_symbol.$radiology_value->discount;?>            
       </td>
        <td class="text text-right" width="15%" ><?php echo $currency_symbol.$radiology_value->tax;?> </td>
       <td class="text text-right" > <?php echo $currency_symbol.$radiology_value->net_amount;?> </td>
       <?php

    }
    ?>
    </tbody>
  </table>
</div>  
    <?php
}      

//====================Blood Issue================

if(!empty($bloodissue_data)){
    ?>
     <h4><?php echo $this->lang->line('blood_issue'); ?></h4>
<div class="table-responsive">     
<table class="table table-hover">
    <thead>
        <tr>
            <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
            <th width="20%"><?php echo $this->lang->line('charge'); ?></th>
            <th width="10%"><?php echo $this->lang->line('qty'); ?></th>
            <th class="text text-right" width="15%"><?php echo $this->lang->line('discount'); ?></th>
            <th class="text text-right"  width="15%"><?php echo $this->lang->line('tax'); ?></th>
            <th class="text text-right"><?php echo $this->lang->line('amount'); ?></th>
        </tr>
    </thead>
    <tbody>
      <?php 
    foreach ($bloodissue_data as $blood_issue_key => $blood_issue_value) {
        $total_amount+=$blood_issue_value->net_amount;
   
$discount_amount=calculatePercent($blood_issue_value->standard_charge,$blood_issue_value->discount_percentage);
      ?>
      <tr>
       <td width="20%"> <?php echo $blood_bank_bill_prefix.$blood_issue_value->id;?>  </td>
         <td width="20%"> <?php echo  $currency_symbol.$blood_issue_value->standard_charge;?> </td>
       <td width="10%">  1    </td>
       <td width="15%" class="text text-right">  <?php  echo "(".$blood_issue_value->discount_percentage."%) ". $discount_amount;?></td>
       <td width="15%" class="text text-right">
        <?php 
           echo "(".$blood_issue_value->tax_percentage."%) ". $currency_symbol.calculatePercent(($blood_issue_value->standard_charge-$discount_amount),$blood_issue_value->tax_percentage);
           ?>
      </td>
      <td class="text text-right">  <?php echo $currency_symbol.$blood_issue_value->net_amount;?>  </td>
   </tr>
       <?php

    }
    ?>
  


    </tbody>
  </table>
</div>  
    <?php
}  ?>

<?php    
    if(!empty($transaction_data)){
        ?>
 <h4><?php echo $this->lang->line('transactions'); ?></h4>
<div class="table-responsive"> 
<table class="table table-hover">
    <thead>
        <tr>
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
            <td width="20%" class="white-space-nowrap"><?php echo $transaction_prefix.$transaction_value->id;?></td>
            <td width="30%"><?php echo $this->customlib->YYYYMMDDHisTodateFormat($transaction_value->payment_date);?></td>
            <td><?php echo $this->lang->line(strtolower($transaction_value->payment_mode));?></td>
               <td class="text text-right"><?php echo $currency_symbol.$transaction_value->amount;?></td>
           </tr>

            <?php
        }
        ?>
    </tbody>
</table>
</div>
        <?php
    
}
 ?>

<?php    
    if(!empty($refund_data)){
        ?>
 <h4><?php echo $this->lang->line('refund'); ?></h4>
<div class="table-responsive"> 
<table class="table table-hover">
    <thead>
        <tr>
            <th><?php echo $this->lang->line('transaction_id'); ?></th>
            <th><?php echo $this->lang->line('payment_date'); ?></th>
            <th><?php echo $this->lang->line('payment_mode'); ?></th>
            <th class="text text-right"><?php echo $this->lang->line('amount'); ?></th>
           
        </tr>
    </thead>
    <tbody>
            <?php
            
    foreach ($refund_data as $transaction_key => $transaction_value) {
        $amount_refund+=$transaction_value->amount;
            ?>
            <tr>
            <td width="20%" class="white-space-nowrap"><?php echo $transaction_prefix.$transaction_value->id;?></td>
            <td width="30%"><?php echo $this->customlib->YYYYMMDDHisTodateFormat($transaction_value->payment_date);?></td>
            <td><?php echo $this->lang->line(strtolower($transaction_value->payment_mode));?></td>
               <td class="text text-right"><?php echo $currency_symbol.$transaction_value->amount;?></td>
           </tr>

            <?php
        }
        ?>
    </tbody>
</table>
</div>
        <?php
    
}
 ?>

                         <!-- ====transaction data========= -->
    
<div class="row">
    <div class="col-md-6">
        
    </div>
  <div class="col-md-6">
           <p class="lead"><?php echo $this->lang->line('amount_summary'); ?></p>
                  <div class="table-responsive">
                    <table class="table table-hover">
                      <tbody>
                        <tr>
                        <th style="width:50%"><?php echo $this->lang->line('grand_total'); ?>:</th>
                        <td class="text text-right"><?php echo $currency_symbol.amountFormat($total_amount); ?></td>
                      </tr>
                    
                      <tr>
                        <th><?php echo $this->lang->line('amount_paid'); ?>:</th>
                        <td class="text text-right"><?php echo $currency_symbol.amountFormat($amount_paid); ?></td>
                      </tr>

                      <tr>
                        <th><?php echo $this->lang->line('refund_amount'); ?>:</th>
                        <td class="text text-right"><?php echo $currency_symbol.amountFormat($amount_refund); ?></td>
                      </tr>

                      <tr>
                        <th><?php echo $this->lang->line('balance_amount'); ?>:</th>
                        <td class="text text-right"><?php echo $currency_symbol.amountFormat(($total_amount-$amount_paid+$amount_refund));?></td>
                      </tr>
                    </tbody></table>
                  </div>
                </div>
</div>                  
                    </div>
                </div>   