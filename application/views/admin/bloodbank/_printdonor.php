<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$amount=0;

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
                ?>" class="img-responsive">
            </div>
            <?php } ?>
            <div class="card">
                <div class="card-body">  
                    <div class="row">
                        <table class="print-table">
                            <tbody>
                                <tr class="no-line"> 
                                    <th><?php echo $this->lang->line('donor_name'); ?></th>
                                    <td><span> <?php echo $result['donor_name']; ?></span></td>
                                    <th><?php echo $this->lang->line('age'); ?></th>
                                    <td><span><?php echo $this->customlib->getAgeBydob($result['date_of_birth']); ?></span></td>
                                </tr> 
                                <tr class="no-line"> 
                                    <th><?php echo $this->lang->line('blood_group'); ?></th>
                                    <td><span ><?php echo $result['blood_group_name']; ?></span></td>
                                    <th><?php echo $this->lang->line('gender'); ?></th>
                                    <td><span ><?php echo $result['gender']; ?></span></td>
                                </tr>
                                <tr class="no-line"> 
                                    <th><?php echo $this->lang->line('father_name'); ?></th>
                                    <td><span ><?php echo $result['father_name']; ?></span></td>
                                    <th><?php echo $this->lang->line('contact_no'); ?></th>
                                    <td><span ><?php echo $result['contact_no']; ?></span></td>
                                </tr>
                                <tr class="no-line"> 
                                    <th><?php echo $this->lang->line('address'); ?></th>
                                    <td><span ><?php echo $result['address']; ?></span></td>
                                </tr>
                                <tr class="no-line"> 
                                    <?php
                                        if (!empty($fields)) {
                                            foreach ($fields as $fields_key => $fields_value) { ?>
                                            <th><?php echo $fields_value->name; ?></th>
                                            <td><?php echo $result[$fields_value->name]; ?></td>
                                    <?php } } ?>
                                
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <table class="print-table">
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('bags'); ?></th>
                                        <th><?php echo $this->lang->line('donate_date'); ?></th>             
                                        <th><?php echo $this->lang->line('standard_charge').' ('.$currency_symbol.')'; ?></th>
                                        <th><?php echo $this->lang->line('apply_charge').' ('.$currency_symbol.')'; ?></th>
                                        <th><?php echo $this->lang->line('discount').' (%)'; ?></th>
                                        <th><?php echo $this->lang->line('tax').' (%)'; ?></th>
                                        <th><?php echo $this->lang->line('net_amount').' ('.$currency_symbol.')'; ?></th>
                                        <th><?php echo $this->lang->line('payment_date'); ?></th>  
                                        <th><?php echo $this->lang->line('note'); ?></th>                          
                                        <th><?php echo $this->lang->line('payment_mode'); ?></th>

                                        <th><?php echo $this->lang->line('paid_amount').' ('.$currency_symbol.')'; ?></th>              
                                    </tr>
                                </thead>
                                <tbody>
                                <?php          
                                    $count = 1;
                                    foreach ($bloodbatch as $detail) {
                                ?> 
                                    <tr>
                                        <td><?php echo $this->customlib->bag_string($detail->bag_no,$detail->volume,$detail->unit_name); ?></td>
                                        <td><?php echo date($this->customlib->getHospitalDateFormat(), strtotime($detail->donate_date)) ?></td>                 
                                        <td><?php echo $detail->standard_charge; ?></td>
                                        <td><?php echo $detail->apply_charge; ?></td>
                                        <td>
                                            <?php 
                                                $discount_amt=calculatePercent( $detail->apply_charge,$detail->discount_percentage);
                                                echo "(".$detail->discount_percentage."%) ".calculatePercent( $detail->apply_charge,$detail->discount_percentage); 
                                            ?>
                                        </td>
                                        <td>
                                            <?php echo "(".$detail->tax_percentage."%) ".calculatePercent(($detail->apply_charge-$discount_amt),$detail->tax_percentage); ?>
                                        </td>
                                        <!-- <td><?php echo $detail->amount; ?></td> -->
                                         <td class="text-right"><?php $netamount =    $detail->standard_charge + calculatePercent(($detail->apply_charge-$discount_amt),$detail->tax_percentage) ; echo amountFormat($netamount); ?></td>
                                        <td><?php echo $this->customlib->YYYYMMDDTodateFormat($detail->payment_date); ?></td>
                                         <td><?php echo $detail->note ?></td>
                                        <td><?php echo $this->lang->line(strtolower($detail->payment_mode))."<br>";
                                                if($detail->payment_mode == "Cheque"){
                                                    if($detail->cheque_no!=''){
                                                        echo $this->lang->line('cheque_no') . ": ".$detail->cheque_no;       
                                                        echo "<br>";
                                                    }
                                                    if($detail->cheque_date!='' && $detail->cheque_date!='0000-00-00'){
                                                        echo $this->lang->line('cheque_date') .": ".$this->customlib->YYYYMMDDTodateFormat($detail->cheque_date);
                                                    }
                                                }
                                            ?>             
                                        </td>
                                        <td class="text-right"><?php echo $detail->amount ?></td>          
                                    </tr>
                                    <?php } ?>
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