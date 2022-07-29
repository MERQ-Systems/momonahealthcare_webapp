<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="">
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
                    <table width="100%" class="printablea4">
                        <tr>
                            <td width="77%" align="text-left"><h5><?php echo $this->lang->line('bill_no') ?> : <?php echo $this->customlib->getSessionPrefixByType('pharmacy_billing').$result["id"] ?></h5>
                            </td>
                            <td width="23%" ><h5><?php echo $this->lang->line('date') . " : "; ?><?php echo date($this->customlib->getHospitalDateFormat(true, true), strtotime($result['date'])) ?></h5>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <th width="10%"><?php echo $this->lang->line('name'); ?></th>
                            <td width="10%"><?php echo $result["patient_name"]." (".$result["patient_unique_id"].")"; ?></td>
                            <th width="10%"><?php echo $this->lang->line('phone'); ?></th>
                            <td width="10%"><?php echo $result["mobileno"]; ?></td>
                            <th width="10%"><?php echo $this->lang->line('doctor'); ?></th>
                            <td width="10%"><?php echo $result["doctor_name"]; ?></td>
                        </tr>
                        <?php  if (!empty($fields)) {
                            foreach ($fields as $fields_key => $fields_value) {
                                ?>
                                <tr>
                                    <th width="10%"><?php echo $fields_value->name; ?></th> 
                                    <td width="10%"><?php echo $result[$fields_value->name]; ?></td>
                                </tr>
                            <?php }
                        }?>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" id="testreport" width="100%">
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('medicine_category'); ?></th>

                             <th width="20%"><?php echo $this->lang->line('medicine_name'); ?></th>

                            <th><?php echo $this->lang->line('batch_no'); ?></th>
                            <th><?php echo $this->lang->line('unit'); ?></th>
                            <th><?php echo $this->lang->line('expiry_date'); ?></th>
                            <th><?php echo $this->lang->line('quantity'); ?></th>
                            <th style=""><?php echo $this->lang->line('tax'); ?></th>

                            <th style="text-align: right;"><?php echo $this->lang->line('amount') . ' (' . $currency_symbol . ')'; ?></th>
                        </tr>
                        <?php
$j = $total_tax=0;
foreach ($detail as $bill) {
    if($bill['tax']>0){
         $tax=(($bill["sale_price"]*$bill['tax'])/100)*$bill["quantity"];
    }else{
         $tax=0;
    }

    $total_tax+=$tax;
   
    
    ?>
                            <tr>
                                <td width="20%"><?php echo $bill["medicine_category"]; ?></td>
                                <td width="20%"><?php echo $bill["medicine_name"]; ?></td>
                                <td><?php echo $bill["batch_no"]; ?></td>
                                <td><?php echo $bill["unit"]; ?></td>
                                <td><?php echo $this->customlib->getMedicine_expire_month($bill['expiry']); ?></td>
                                <td><?php echo $bill["quantity"]; ?></td>
                                <td align=""><?php echo amountFormat($tax)." (".$bill['tax']."%)"; ?></td>
                                <td align="right"><?php echo amountFormat($bill["sale_price"] * $bill["quantity"]); ?></td>
                            </tr>
                            <?php
$j++;
}
?>

                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <div class="row">
                    <div class="col-md-6">
                    <table align="" class="printablea4" >
                        <?php if (!empty($result["note"])) {?>
                        <tr>
                            <th><?php echo $this->lang->line('note'); ?></th>
                            <td><?php echo $result["note"]; ?></td>
                        </tr>
                        <?php }

if (!$print) {
    ?>
                            <tr id="generated_by">
                                <th><?php echo $this->lang->line('collected_by'); ?></th>
                                <td><?php echo composeStaffNameByString($result['name'], $result['surname'], $result['employee_id']); ?></td>
                            </tr>
                        <?php
}
?>
                    </table>
                    </div>
                    <div class="col-md-6">
                    <table align="" class="printablea4" style="float: right;">
                        <?php if (!empty($result["total"])) {?>
                            <tr>

                                <th style="width: 50%;"><?php echo $this->lang->line('total') . " (" . $currency_symbol . ")"; ?></th>

                                <td align="right"><?php echo amountFormat($result["total"]); ?></td>
                            </tr>
                        <?php }?>
                        <?php if (!empty($result["discount"])) {
    ?>
                            <tr>
                                <th><?php
echo $this->lang->line('discount') . " (" . $currency_symbol . ")";

    ?></th>

                                <td align="right"><?php echo amountFormat($result["discount"]); ?></td>

                            </tr>
                        <?php }?>
                        <?php if (!empty($total_tax)) {
    ?>
                            <tr>
                                <th><?php
echo $this->lang->line('tax') . " (" . $currency_symbol . ")";

    ?></th>

                                <td align="right"><?php echo amountFormat($total_tax); ?></td>

                            </tr>
                        <?php }?>
                     
                        <?php
if ((!empty($result["discount"])) && (!empty($result["tax"]))) {
    if (!empty($result["net_amount"])) {
        ?>
                                <tr>
                                    <th><?php
echo $this->lang->line('net_amount') . " (" . $currency_symbol . ")";

        ?></th>

                                    <td align="right"><?php echo amountFormat($result["net_amount"]); ?></td>

                                </tr>
                                <?php
}
}
?>
                            <tr>
                                <th><?php echo $this->lang->line('paid_amount') . " (" . $currency_symbol . ")";  ?></th>
                                <td align="right"><?php echo amountFormat($result["paid_amount"]); ?></td>

                            </tr>
                            <tr>
                                <th><?php echo $this->lang->line('refund_amount') . " (" . $currency_symbol . ")";  ?></th>
                                <td align="right"><?php echo amountFormat($result["refund_amount"]); ?></td>

                            </tr>
                        <tr>
                                    <th><?php
echo $this->lang->line('due_amount') . " (" . $currency_symbol . ")";

        ?></th>

                                    <td align="right">
                                        <?php 
                                         echo amountFormat( ($result["net_amount"] + $result["refund_amount"] )-$result['paid_amount']); 
                                   ?></td>

                                </tr>
                        
                    </table>
                    </div>
                    </div>
    
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