<?php 
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
if (!empty($charges_detail)) {
?> 
                                 <div class="box-tools pull-right box-miustop">
                                        <a href="javascript:void(0);" data-loading-text='' data-caseid='<?php echo $charges_detail[0]["case_reference_id"]; ?>' data-module='ipd' data-totalamount='' data-record-id='<?php echo $charges_detail[0]["ipd_id"]; ?>'  data-toggle='tooltip' title=''    class="btn btn-primary btn-sm add_payment"  ><i class="fa fa-money"></i> <?php echo $this->lang->line('add_payment'); ?></a>
                                         <a href="javascript:void(0);" data-loading-text='' data-case_id='<?php echo $charges_detail[0]["case_reference_id"]; ?>' data-module_type='ipd_id' data-record-id='<?php echo $charges_detail[0]["ipd_id"]; ?>'  data-toggle='tooltip' title=''    class="btn btn-primary btn-sm view_payment"  ><i class="fa fa-money"></i> <?php echo $this->lang->line('view_payments'); ?></a>
                                        <a href="javascript:void(0);"   class="btn btn-primary btn-sm text-right view_generate_bill"  data-toggle="tooltip" title="" data-module_type='ipd_opd' data-case_id='<?php echo $charges_detail[0]["case_reference_id"]; ?>'><i class="fas fa-exchange-alt"></i> <?php echo $this->lang->line('generate_bill'); ?></a>
 </div><!--./impbtnview20-->
                                
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover example"> 
                                        <thead>
                                        <th><?php echo $this->lang->line('date'); ?></th>
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <th><?php echo $this->lang->line('charge_type'); ?></th>
                                        <th><?php echo $this->lang->line('charge_category'); ?></th>
                                         <th><?php echo $this->lang->line('qty'); ?></th>
                                         <th><?php echo $this->lang->line('tax'); ?></th>                         
                                        <th class="text-right"><?php echo $this->lang->line('amount'). ' (' . $currency_symbol . ')'; ?></th>                                      
                                        <th class="text-right"><?php echo $this->lang->line('action') ?></th>
                                        </thead>
                                        <tbody>
                                         <?php 
                                            $total =$amount=$total_tax =0;
                                            if (!empty($charges_detail)) {
                                                foreach ($charges_detail as $charges_key => $charges_value) {
                                                   $total += $charges_value["apply_charge"];
                                                    $amount += $charges_value["amount"];
                                                     $tax=0;
                                                    if($charges_value["tax"]>0){
                                                        $tax=($charges_value["apply_charge"]*$charges_value["tax"])/100;
                                                    }
                                                    ?>  
                                                    <tr>                                                       
                                                        <td><?php if($charges_value['date']!='' && $charges_value['date']!='0000-00-00'){ echo $this->customlib->YYYYMMDDTodateFormat($charges_value['date']); } ?></td>
                                                        <td class="">
                                                            <?php echo $charges_value["name"]; ?>
                                                             <div class="bill_item_footer text-muted"> <?php echo $charges_value["note"]; ?></div>
                                                        </td>
                                                        <td style="text-transform: capitalize;"><?php echo $charges_value["charge_type"] ?></td>
                                                        <td style="text-transform: capitalize;"><?php echo $charges_value["charge_category_name"] ?></td>
                                                           <td style="text-transform: capitalize;"><?php echo $charges_value['qty']." ".$charges_value["unit"]; ?></td>
                                                        <td ><?php echo amountFormat($tax)."(".$charges_value["tax"]."%)"; ?></td>
                                                        <td class="text-right"><?php echo amountFormat($charges_value["amount"]) ?></td>                                                        
                                                        <td class="text-right"> 
    <a href="javascript:void(0);" class="btn btn-default btn-xs print_charge" data-toggle="tooltip" title="" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i>"  data-record-id="<?php echo $charges_value['id']; ?>" data-moduletype='ipd'  data-original-title="<?php echo $this->lang->line('print'); ?>">
    <i class="fa fa-print"></i>
    </a>                                                            
                                                        </td>                                                     
                                                    </tr>
                                                    <?php
                                                }
                                            }
                                             $total_tax+=$tax;
                                            ?>  

                                        </tbody>
                                        <tr class="box box-solid total-bg">
                                            <td colspan='5' class="text-right"></td>                                
                                            <td><?php echo $this->lang->line('tax') . " : " . $currency_symbol . "" . amountFormat($total_tax) ?></td>                                          
                                            <td><?php echo $this->lang->line('net_amount') . " : " . $currency_symbol . "" . amountFormat($total) ?></td>
                                            <td><?php echo $this->lang->line('total') . " : " . $currency_symbol . "" . amountFormat($amount) ?></td>
                                        </tr>
                                    </table>
                                </div> 
                                <?php } ?>