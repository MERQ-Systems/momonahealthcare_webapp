<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php 
if($charge->opd_id != "" && $charge->opd_id !=0)
{
$patient_name=$charge->opd_patient_name;
$patient_id=$charge->opd_patient_id;
$case_reference_id=$charge->opd_case_reference_id;
}else{
$patient_name=$charge->ipd_patient_name;
$patient_id=$charge->ipd_patient_id;
$case_reference_id=$charge->ipd_case_reference_id;
}
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
                        <div class="col-md-6">
                            <p><?php echo $this->lang->line('patient');?>: <?php echo composePatientName($patient_name,$patient_id); ?></p>
                            <p><?php echo $this->lang->line('case_id');?>: <?php echo $case_reference_id; ?></p>
                        </div>

                        <div class="col-md-6 text-right">
                          
                            <p><span class="text-muted"><?php echo $this->lang->line('date');?>: </span> <?php echo $this->customlib->YYYYMMDDHisTodateFormat($charge->date,$this->customlib->getHospitalTimeFormat()); ?></p>              
                            
                        </div>
                    </div>

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
                                   <td><strong><?php echo $charge->charge_name ?></strong><br>
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
                             </tbody>
                          </table>
                        </div>
                    </div>

                  
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