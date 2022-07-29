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
                            <?php  if (!empty($fields)) {
                                foreach ($fields as $fields_key => $fields_value) {
                                    $display_field = $result->{"$fields_value->name"};
                                    if ($fields_value->type == "link") {
                                        $display_field = "<a href=" . $result->{"$fields_value->name"} . " target='_blank'>" . $result->{"$fields_value->name"} . "</a>";
                                    }
                                    ?>
                                    <p><?php echo $fields_value->name .": ".$display_field ;?></p>
                                <?php }
                            }?>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="print-table">
                             <thead>
                                <tr class="line">
                                   <td><strong>#</strong></td>
                                   <td class="text-left"><strong><?php echo $this->lang->line('customer_type'); ?></strong></td>
                                   <td class="text-center"><strong><?php echo $this->lang->line('operation_name'); ?></strong></td>
                                   <td class="text-center"><strong><?php echo $this->lang->line('date'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('operation_type'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('assistant_consultant').' 1'; ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('assistant_consultant').' 2'; ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('anesthetist'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('anaethesia_type'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('ot_technician'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('ot_assistant'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('result'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('remark'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('generated_by'); ?></strong></td>
                                </tr>
                             </thead>
                             <tbody>
                                <?php 
                      $row_counter=1;
                      $tax_amt=0;
                        foreach ($ot_details as $ot_details_value) { ?>
                        <tr>
                                <td><strong><?php echo $ot_details_value->customer_type; ?></strong>
                                  <br/>
                                  <?php echo "(".$ot_details_value->operation_name.")"; ?>
                                </td>
                               
                                <td class="text-center"><?php echo  $this->customlib->YYYYMMDDTodateFormat($ot_details_value->date); ?></td>                    
                             
                        </tr>
                               
                        <?php
                    $row_counter++;
                        }
                        ?>                              
                              
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