<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();

if($charge->opd_id != "")
{
$patient_name=$charge->opd_patient_name;
$patient_id=$charge->opd_patient_id;
$case_reference_id=$charge->opd_case_reference_id;


}else{
$patient_name=$charge->ipd_patient_name;
$patient_id=$charge->ipd_patient_id;
$case_reference_id=$charge->ipd_case_reference_id;
}
 ?> 
<div class="print-area">
<div class="row">
        <div class="col-12">
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
                         
                            <p class="font-bold"><?php echo $patient_name; ?></p>
                            <p><?php echo $this->lang->line('checkup_id'); ?> : <?php echo $patient['id']; ?></p>
                            <p><?php echo $this->lang->line('patient_id'); ?> : <?php echo $patient_id; ?></p>
                            <p><?php echo $this->lang->line('case_id'); ?> : <?php echo $case_reference_id; ?></p>
                            
                        </div>

                        <div class="col-md-6 text-right">
                          
                            <p><span class="font-bold"><?php echo $this->lang->line('date'); ?>: </span> <?php echo $this->customlib->YYYYMMDDTodateFormat($charge->date); ?></p>              
                            
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                              <table class="print-table">
                             <thead>
                                <tr class="line">
                                   <td><strong>#</strong></td>
                                   <td class="text-left"><strong><?php echo $this->lang->line('description'); ?></strong></td>
                                
                                   <td class="text-right"><strong><?php echo $this->lang->line('amount').' ('. $currency_symbol .')'; ?></strong></td>
                                </tr>
                             </thead>
                             <tbody>
                                <tr>
                                   <td>1</td>
                                   <td><strong><?php echo $charge->charge_name ?></strong><br>
                                    <?php echo $charge->note;?>
                                  </td>
                                 
                                   <td class="text-right"><?php echo $charge->apply_charge ?></td>
                                </tr>
                                
                                <tr>
                                   <td colspan="1" class="thick-line"></td>
                                   <td class="text-right thick-line"><strong><?php echo $this->lang->line('total'); ?></strong></td>
                                   <td class="text-right thick-line"><strong><?php echo $currency_symbol . "" .$charge->apply_charge ?></strong>
                                   </td>
                                </tr>
                                 <tr>
                                   <td colspan="1" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('paid'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" .$transaction->amount; ?></strong>
                                   </td>
                                </tr>
                                   <tr>
                                   <td colspan="1" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('total_due'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" .amountFormat($charge->apply_charge-$transaction->amount); ?></strong>
                                   </td>
                                </tr>
                             </tbody>
                          </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear">
        <p>
                        <?php
                        if (!empty($print_details[0]['print_footer'])) {
                            echo $print_details[0]['print_footer'];
                        }
                        ?>                          
                        </p>
</div>
        </div>
    </div>
</div>