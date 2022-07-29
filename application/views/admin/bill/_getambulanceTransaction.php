<?php $currency_symbol = $this->customlib->getHospitalCurrencyFormat(); ?>
<div class="row">
       <?php if ($this->rbac->hasPrivilege('ambulance_billing_payment', 'can_add')) { ?>
    <div class="col-lg-12 col-md-12 col-sm-12">
        <form id="add_partial_payment_ambulance" action="<?php echo site_url('admin/vehicle/partialbill')?>" accept-charset="utf-8" method="post" class="ptt10" >
            <input type="hidden" name="billing_id" value="<?php echo $billing_id;?>">
             <input type="hidden" name="net_amount" id="net_amount" class="form-control" value="<?php echo $balance_amount ; ?>" >
                     <input type="hidden" name="patient_id" id="patient_id" class="form-control" value="<?php echo $patient_id ; ?>" >
            <div class="row"> 
                <div class="col-md-6">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('date'); ?></label><small class="req"> *</small> 
                        <input type="text" name="payment_date" id="date" class="form-control datetime">
                        <span class="text-danger"><?php echo form_error('apply_charge'); ?></span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('amount') . " (" . $currency_symbol . ")"; ?></label><small class="req"> *</small> 
                        <input type="text" name="payment_amount" id="amount" class="form-control">
                        <span class="text-danger"><?php echo form_error('payment_amount'); ?></span>
                    </div>
                </div>
            </div>
            <div class="row">                       
                <div class="col-md-6">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('payment_mode'); ?></label> 
                        <select class="form-control payment_mode" name="payment_mode">
                            <?php foreach ($payment_mode as $key => $value) { ?>
                                <option value="<?php echo $key ?>" <?php
                                    if ($key == 'cash') {
                                        echo "selected";
                                    }
                                    ?>><?php echo $value ?>
                                </option>
                            <?php } ?>
                        </select>    
                        <span class="text-danger"><?php echo form_error('apply_charge'); ?></span>
                    </div>
                </div>
            </div>
            <div class="row cheque_div" style="display: none;">          
                <div class="col-md-4">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('cheque_no'); ?></label><small class="req"> *</small> 
                        <input type="text" name="cheque_no" id="cheque_no" class="form-control">
                        <span class="text-danger"><?php echo form_error('cheque_no'); ?></span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('cheque_date'); ?></label><small class="req"> *</small> 
                        <input type="text" name="cheque_date" id="cheque_date" class="form-control date">
                        <span class="text-danger"><?php echo form_error('cheque_date'); ?></span>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('attach_document'); ?></label>
                        <input type="file"  class=" form-control filestyle"   name="document">
                        <span class="text-danger"><?php echo form_error('document'); ?></span> 
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label><?php echo $this->lang->line('note'); ?></label> 
                        <textarea  name="note" id="note" class="form-control"></textarea>
                        
                    </div>
                </div>
            </div>
            <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
        </form>
    </div>
<?php } ?>
</div>
<h4><?php echo $this->lang->line('transaction_history'); ?></h4>
<hr>
<?php if(!empty($transaction)){ ?>
    <div class="table-responsive">
        <table class="table table-hover">            
            <thead>
                <tr>
                    <th><?php echo $this->lang->line('transaction_id'); ?></th>
                    <th><?php echo $this->lang->line('date'); ?></th>
                    <th><?php echo $this->lang->line('mode'); ?></th>
                    <th><?php echo $this->lang->line('note'); ?></th>
                    <th><?php echo $this->lang->line('amount'); ?></th>
                    <th><?php echo $this->lang->line('action'); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($transaction as $transaction_key => $transaction) { ?>
                    <tr>
                        <td><?php echo $this->customlib->getSessionPrefixByType('transaction_id').$transaction->id; ?></td>
                        <td><?php echo $this->customlib->YYYYMMDDHisTodateFormat($transaction->payment_date,$time_format); ?></td>
                         <td><?php echo $this->lang->line(strtolower($transaction->payment_mode))."<br>";

                            if($transaction->payment_mode== "Cheque"){
                                                             if($transaction->cheque_no!=''){
                                       echo $this->lang->line('cheque_no') . ": ".$transaction->cheque_no;
                                      
                                    echo "<br>";
                                }
                                    if($transaction->cheque_date!='' && $transaction->cheque_date!='0000-00-00'){
                                       echo $this->lang->line('cheque_date') .": ".$this->customlib->YYYYMMDDTodateFormat($transaction->cheque_date);
                                   }
                                       

                                     }
                                                        ?></td>
                        <td><?php echo $transaction->note; ?></td>
                         <td><?php echo $transaction->amount; ?></td>

                        <td>
                            <?php if ($transaction->payment_mode == "Cheque" && $transaction->attachment != "")  {
    ?>
    <a href='<?php echo site_url('admin/transaction/download/'.$transaction->id);?>' class='btn btn-default btn-xs'  title='<?php echo $this->lang->line('download'); ?>'><i class='fa fa-download'></i></a>
    <?php
}
         ?>

                            <a href='javascript:void(0)' data-loading-text='<i class="fa fa-circle-o-notch fa-spin"></i>' data-record-id="<?php echo $transaction->id;?>" class='btn btn-default btn-xs print_ambulance_receipt'  data-toggle='tooltip' title='<?php echo $this->lang->line('print'); ?>'><i class='fa fa-print'></i></a>
                           
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
<?php } ?>