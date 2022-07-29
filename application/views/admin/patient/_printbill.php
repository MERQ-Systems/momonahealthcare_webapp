<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php 
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();

?>
 
<div class="print-area">
<div class="row">
        <div class="col-md-12">

              <?php if (!empty($print_details[0]['print_header'])) { ?>
                        <div class="pprinta4">
                            <img src="<?php
                            if (!empty($print_details[0]['print_header'])) {
                                echo base_url() . $print_details[0]['print_header'].img_time();
                            }
                            ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php } ?>
              <div class="card">
                <div class="card-body">  
                    <div class="row">
                            <div class="col-md-12" style="padding-top:10px">
                     <table class="noborder_table">

                           <tr>
                            <th><?php echo $this->lang->line("opd_id"); ?></th>
                            <td><?php echo $opd_prefix.$result["opd_details_id"];?></td>
                            <th><?php echo $this->lang->line("checkup_id") ; ?></th>
                            <td><?php echo $checkup_prefix.$result["id"] ?></td>
                             <th><?php echo $this->lang->line("appointment_date") ; ?></th>
                            <td><?php echo $this->customlib->YYYYMMDDHisTodateFormat($result["appointment_date"]); ?></td>
                            
                        </tr>
                        <tr>
                            <th><?php echo $this->lang->line("patient_name"); ?></th>
                            <td><?php echo $result["patient_name"].' ('. $result["patient_id"] .')' ?></td>
                            <th><?php echo $this->lang->line("weight") ; ?></th>
                            <td><?php echo $result["weight"] ?></td>
                             <th><?php echo $this->lang->line("bp") ; ?></th>
                            <td><?php echo $result["bp"] ?></td>
                        </tr>
                        <tr>
                            <th><?php echo $this->lang->line("age"); ?></th>
                            
                            <td>
                                <?php
                    echo $this->customlib->getPatientAge($result['age'],$result['month'],$result['day']);
                                 ?>
                            </td>
                            <th><?php echo $this->lang->line("gender"); ?></th>
                            <td><?php echo $result["gender"] ?></td>
                            <th><?php echo $this->lang->line("height") ; ?></th>
                            <td><?php echo $result["height"] ?></td>
                        </tr>


                        <tr>

                            <th><?php echo $this->lang->line('consultant_doctor'); ?></th>
                            <td><?php echo $result["name"] . " " . $result["surname"].' ('. $result["employee_id"] .')' ?></td>
                            <th><?php echo $this->lang->line("address"); ?></th>
                            <td><?php echo $result["address"] ?></td>
                            <th><?php echo $this->lang->line("blood_group"); ?></th>
                            <td><?php echo $blood_group_name; ?></td>
                        </tr>
                         <tr>
                            <th><?php echo $this->lang->line('known_allergies');?></th>
                            <td><?php echo $result["known_allergies"]; ?></td>
                             <th><?php echo $this->lang->line('pulse');?></th>
                            <td><?php echo $result["pulse"]; ?></td>
                             <th><?php echo $this->lang->line('temperature');?></th>
                            <td><?php echo $result["temperature"]; ?></td> 
                        </tr>
                    </table>
                </div>
                    </div>
    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                    <h4 class="font-bold"><?php echo $this->lang->line("payment_details"); ?></h4>
                    <?php 
if (!empty($charge)) {
   ?>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="print-table">
                             <thead>
                                <tr class="line">
                                   <td><strong>#</strong></td>
                                   <td class=""><strong><?php echo $this->lang->line('description');?></strong></td>
                                   <td class=""><strong><?php echo $this->lang->line('tax').' ('.'%'.')';?></strong></td>
                                
                                   <td class="text-right"><strong><?php echo $this->lang->line('amount').' ('.$currency_symbol.')';?></strong></td>
                                </tr>
                             </thead>
                             <tbody>
                                <tr>
                                   <td>1</td>
                                   <td><strong><?php   echo $charge->charge_name ?></strong><br>
                                    <?php echo $charge->note;?>
                                  </td>
                                 
                                   <td class=""><?php 
                                   if($charge->tax>0)
                                    { 
                                      $tax=(($charge->apply_charge*$charge->tax)/100);  
                                    }else{ $tax=0; 
                                    } echo amountFormat($tax)." (".$charge->tax."%)";?></td>
                                   <td class="text-right"><?php echo $charge->amount;?></td>
                                </tr>
                                <tr>
                                   
                                   <td colspan="3" class="text-right thick-line"><strong><?php echo $this->lang->line('net_amount');?></strong></td>
                                   <td class="text-right thick-line"><strong><?php echo $currency_symbol.$charge->apply_charge; ?></strong></td>
                                </tr>
                                <tr>
                                   
                                   <td colspan="3" class="text-right no-line"><strong><?php echo $this->lang->line('tax');?></strong></td>
                                   <td class="text-right no-line"><strong><?php 
                                   if($charge->tax>0){
                                     $tax_amt = ($charge->apply_charge*$charge->tax/100);
                                   }else{
                                      $tax_amt = 0;
                                   }
                                  
                                   $total = ($charge->amount);
                                   echo $currency_symbol.amountFormat($tax_amt); ?></strong></td>
                                </tr>
                                <tr>  
                                  
                                   <td colspan="3" class="text-right no-line"><strong><?php echo $this->lang->line('total');?></strong></td>
                                   <td class="text-right no-line"><strong><?php 
                                   echo $currency_symbol.amountFormat($total); ?></strong></td>
                                </tr>
                                   <tr>                                  
                                   <td colspan="3" class="text-right no-line">
                                    <strong><?php echo $this->lang->line('paid_amount');?></strong></td>
                                   <td class="text-right no-line"><strong><?php 
                                $amount_paid=(!isset($transaction) || empty($transaction)) ? 0:  $transaction->amount;
                                   
                                   echo $currency_symbol.amountFormat($amount_paid); ?></strong></td>
                                </tr>
                                    <tr>                                  
                                   <td colspan="3" class="text-right no-line">
                                    <strong><?php echo $this->lang->line('balance_amount');?></strong></td>
                                   <td class="text-right no-line"><strong><?php 
                                $amount_paid=(!isset($transaction) || empty($transaction)) ? 0:  $transaction->amount;
                                   
                                   echo $currency_symbol.amountFormat($total-$amount_paid); ?></strong></td>
                                </tr>

                             </tbody>
                          </table>
                        </div>
                    </div>

   <?php
}
                     ?>

                  
                </div>
            </div>
            
        </div>
    </div>
    <div class="col-md-12">
            <p>
                        <?php
                        if (!empty($print_details[0]['print_footer'])) {
                            echo $print_details[0]['print_footer'];
                        }
                        ?>                          
                        </p>
    </div>
</div>