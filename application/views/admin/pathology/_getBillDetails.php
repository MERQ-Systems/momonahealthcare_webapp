<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$amount=0;
?>

<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
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
                    <div class="row">
                        <div class="col-md-6">
                           
                            <p><span class="font-bold"><?php echo $this->lang->line('bill_no'); ?>: </span> <?php echo $bill_prefix.$result->id; ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('patient'); ?>:</span> <?php echo composePatientName($result->patient_name,$result->patient_id); ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('case_id'); ?> :</span> <?php echo $result->case_reference_id; ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('age'); ?> :</span> <?php echo $this->customlib->getPatientAge($result->age,$result->month,$result->day); ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('gender'); ?> :</span> <?php echo $result->gender; ?></p>  
                            <?php  if (!empty($fields)) {
                                foreach ($fields as $fields_key => $fields_value) {
                                    $display_field = $result->{"$fields_value->name"};
                                    if ($fields_value->type == "link") {
                                        $display_field = "<a href=" . $result->{"$fields_value->name"} . " target='_blank'>" . $result->{"$fields_value->name"} . "</a>";
                                    }
                                    ?>
                                    <p><span class="font-bold"><?php echo $fields_value->name .": " ?></span><?php echo $display_field ;?></p>
                                <?php }
                            }?>
                        </div>

                        <div class="col-md-6 text-right">
                          <p><span class="font-bold"><?php echo $this->lang->line('date'); ?>: </span> <?php echo $this->customlib->YYYYMMDDHisTodateFormat($result->date); ?></p>              
                            
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="print-table">
                             <thead>
                                <tr class="line">
                                   <td><strong>#</strong></td>
                                   <td class="text-left"><strong><?php echo $this->lang->line('test_name'); ?></strong></td>
                                   <td class="text-center"><strong><?php echo $this->lang->line('date'); ?></strong></td>
                                   <td class="text-center"><strong><?php echo $this->lang->line('tax'); ?> (%)</strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('amount').' ('. $currency_symbol .')'; ?></strong></td>
                                </tr>
                             </thead>
                             <tbody>
                                <?php 
                      $row_counter=1;
                      $tax_amt=0;
                        foreach ($result->pathology_report as $report_key=> $report_value) {

                            $amount+=$report_value->apply_charge;
                            if($report_value->tax_percentage>0){
                                $tax=($report_value->apply_charge*$report_value->tax_percentage/100);
                            }else{
                                $tax=0;
                            }
                            $tax_amt +=$tax;

                            ?>
                        <tr>
                                <td><?php echo $row_counter; ?></td>
                                <td><strong><?php echo $report_value->test_name; ?></strong>
                                  <br/>
                                  <?php echo "(".$report_value->short_name.")"; ?>
                                </td>
                               
                                <td class="text-center"><?php echo  $this->customlib->YYYYMMDDTodateFormat($report_value->reporting_date); ?></td>
                                <td class="text-right"><?php echo amountFormat($tax)." (".$report_value->tax_percentage."%)"; ?></td>
                                <td class="text-right"><?php echo amountFormat($report_value->apply_charge); ?></td>
                             
                        </tr>
                               
                        <?php
                    $row_counter++;
                        }
                        ?>
                                
                                <tr>
                                   <td colspan="3" class="thick-line"></td>
                                   <td class="text-right thick-line"><strong><?php echo $this->lang->line('total'); ?></strong></td>
                                   <td class="text-right thick-line"><strong><?php echo $currency_symbol . "" . amountFormat($amount); ?></strong></td>
                                </tr>
                                <tr>
                                   <td colspan="3" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('discount'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" . amountFormat($result->discount); ?></strong></td>
                                </tr>
                                <tr>
                                   <td colspan="3" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('tax'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" . amountFormat($tax_amt); ?></strong></td>
                                </tr>
                                <tr>
                                   <td colspan="3" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('paid'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" . amountFormat($result->total_deposit); ?></strong></td>
                                </tr>
                                  <tr>
                                   <td colspan="3" class="no-line"></td>
                                   <td class="text-right no-line"><strong><?php echo $this->lang->line('total_due'); ?></strong></td>
                                   <td class="text-right no-line"><strong><?php echo $currency_symbol . "" . amountFormat(($amount-$result->discount)+$tax_amt-$result->total_deposit); ?></strong></td>
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