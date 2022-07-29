<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('bill'); ?></title>
        <style type="text/css">
            .printablea4{width: 100%;}
            /*.printablea4 p{margin-bottom: 0;}*/
            .printablea4>tbody>tr>th,
            .printablea4>tbody>tr>td{padding:5px; line-height: 1.42857143;vertical-align: top; font-size: 12px;}
        </style>
    </head>
    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="">
                    <?php if (!empty($print_details[0]['print_header'])) { ?>
                        <div class="pprinta4">
                            <img src="<?php
                            if (!empty($print_details[0]['print_header'])) {
                                echo base_url() . $print_details[0]['print_header'].img_time();
                            }
                            ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php } ?>
                    <table width="100%" class="printablea4">
                        <tr>
                            <td align="text-left"><h5><label><?php echo $this->lang->line('purchase_no'); ?> </label> : <?php echo $this->customlib->getSessionPrefixByType('purchase_no').$result["id"] ?></h5>
                            </td>
                            <td align="text-left"><h5><label><?php echo $this->lang->line('bill_no'); ?> </label> :  <?php echo $result["invoice_no"] ?></h5>
                            </td>
                            <td align="right"><h5><label><?php echo $this->lang->line('date')?> </label> : <?php echo 
$this->customlib->YYYYMMDDHisTodateFormat($result['date'], $this->customlib->getHospitalTimeFormat());?></h5>
                            </td>
                        </tr>
                    </table>
                    <hr class="dividerhrmb10">
                    <div class="table-responsive">
                        <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                            <tr>
                                <th width="20%"><?php echo $this->lang->line('supplier_name'); ?></th>
                                <td width="25%"><?php echo $detail[0]["medicine_category"]; ?></td>
                                <th width="25%"><?php echo $this->lang->line('contact_no'); ?></th>
                                <td width="30%" align="left"><?php echo $result["contact"]; ?></td>
                            </tr>
                            <tr>
                                <th width="20%"><?php echo $this->lang->line('contact_person'); ?></th>
                                <td width="25%"><?php echo $result["supplier_person"]; ?></td>
                                <th width="25%"><?php echo $this->lang->line('address'); ?></th>
                                <td width="30%" align="left"><?php echo $result['address']; ?></td> 
                            </tr> 
                        </table>
                     </div>   
                    <hr class="dividerhrmb10">
                    <div class="table-responsive">
                       <table class="printablea4" id="testreport" width="100%">
                        <tr>
                            <th><?php echo $this->lang->line('medicine_category'); ?></th>
                            <th width=""><?php echo $this->lang->line('medicine_name'); ?></th> 
                            <th><?php echo $this->lang->line('batch_no'); ?></th>
                            <th><?php echo $this->lang->line('expiry_date'); ?></th>
                            <th style="text-align: right;"><?php echo $this->lang->line('mrp'). ' (' . $currency_symbol . ')'; ?></th>
                            <th style="text-align: right;"><?php echo $this->lang->line('batch_amount'). ' (' . $currency_symbol . ')'; ?></th> 
                            <th style="text-align: right;"><?php echo $this->lang->line('sale_price'). ' (' . $currency_symbol . ')'; ?></th>
                            <th style="text-align: right";><?php echo $this->lang->line('packing_qty'); ?></th>
                            <th style="text-align: right;"><?php echo $this->lang->line('quantity'); ?></th>
                            <th style="text-align: right;"><?php echo $this->lang->line('tax'); ?> (%)</th>
                            <th style="text-align: right;"><?php echo $this->lang->line('purchase_price') . ' (' . $currency_symbol . ')'; ?></th>
                            <th style="text-align: right;"><?php echo $this->lang->line('amount') . ' (' . $currency_symbol . ')'; ?></th>
                        </tr>
                        <?php
                        $j = 0;
                        foreach ($detail as $bill) {
                            ?>
                            <tr>
                                <td width=""><?php echo $bill["medicine_category"]; ?></td>
                                <td width=""><?php echo $bill["medicine_name"]; ?></td>
                                <td><?php echo $bill["batch_no"]; ?></td>
                                <td><?php echo $this->customlib->getMedicine_expire_month($bill['expiry']); ?></td>
                                <td align="right"><?php echo $bill['mrp']; ?></td>
                                <td align="right"><?php echo $bill['batch_amount']; ?></td>
                                <td align="right"><?php echo number_format($bill['sale_rate'],2); ?></td>
                                <td align="right"><?php echo $bill['packing_qty']; ?></td>
                                <td align="right"><?php echo $bill["quantity"]; ?></td>
                                <td align="right"><?php echo $bill["tax"]; ?></td>
                                <td align="right"><?php echo number_format($bill['purchase_price'],2); ?></td>
                                <td align="right"><?php echo number_format($bill["amount"], 2); ?></td>
                            </tr>
                            <?php
                            $j++;
                        }
                        ?>

                    </table> 
                </div>
                    <hr class="dividerhrmb10">
                    <table class="printablea4" id="testreport" width="100%">
                    <tr>
                        <td>
                            
                             <?php if (!empty($result["note"])) { ?>
                            <p><label><?php echo $this->lang->line('note') ?></label> : <?php echo  $result["note"]; ?></p>
                        <?php } ?>
                        <p>
                            <label><?php echo $this->lang->line('payment_mode');?> </label> : 
                            <?php 
                            echo $this->lang->line(strtolower($result["payment_mode"]));

                             ?>
                        </p>

                        <?php 
if($result['payment_mode'] == "Cheque"){
?>
    <p><label><?php echo $this->lang->line('cheque_no');?> </label> : <?php echo $result["cheque_no"]; ?> <?php if($print == 'no'){ ?><span><a href="<?php echo site_url('admin/pharmacy/downloadcheque/'.$result["id"]); ?>" class='btn btn-default btn-xs' data-toggle='tooltip' title='<?php echo $this->lang->line("download"); ?>'><i class="fa fa-download"></i></a></span><?php } ?></p>
    <p><label><?php echo $this->lang->line('date');?> </label> : <?php echo $this->customlib->YYYYMMDDTodateFormat($result["cheque_date"]); ?></p>
<?php
    
}

                         ?>
                        <?php 
if($result["payment_note"] != ""){
?>
 <p><label> <?php echo $this->lang->line('payment_note');?> </label>: <?php echo $result["payment_note"] ?></p>
<?php
}
                         ?>
                        
                        </td>
                        <td width="30%">
                        
                        
                        <table class="printablea4" width="100%" style="float:right;">
                        <?php if (!empty($result["total"])) { ?>
                            <tr>

                                <th width="35%"><?php echo $this->lang->line('total') . " (" . $currency_symbol . ")"; ?></th>

                                <td align="right" width="65%"><?php echo number_format($result["total"],2) ; ?></td>
                            </tr>
                        <?php } ?>
                        <?php if (!empty($result["discount"])) { ?>
                            <tr>
                                <th><?php
                                    echo $this->lang->line('discount') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>

                                <td align="right"><?php echo number_format($result["discount"],2) ; ?></td>

                            </tr>
                        <?php } ?>
                        <?php if (!empty($result["tax"])) { ?>
                            <tr>
                                <th><?php
                                    echo $this->lang->line('tax') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>

                                <td align="right"><?php echo number_format($result['tax'],2); ?></td>

                            </tr>
                        <?php } ?>
                        <?php
                        if ((!empty($result["discount"])) || (!empty($result["tax"]))) {
                            if (!empty($result["net_amount"])) {
                                ?>
                                <tr>
                                    <th><?php
                                        echo $this->lang->line('net_amount') . " (" . $currency_symbol . ")";
                                        ;
                                        ?></th>

                                    <td align="right"><?php echo number_format($result["net_amount"],2); ?></td>

                                </tr>
                                <?php
                            }
                        }
                        ?>
                       
                        </table>
                        
                        
                        </td>
                        </tr>
                    </table>
                  
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