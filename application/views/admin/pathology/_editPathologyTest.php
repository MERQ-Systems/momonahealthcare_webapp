<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat(); 
?>
<input type="hidden" name="id" value="<?php echo $result->id;?>">
<div class="row">
    <input type="hidden" value="<?php echo $result->charge_category_id?>" name="post_charge_category_id">
    <input type="hidden" value="<?php echo $result->charge_id?>" name="post_charge_id">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="row">
            <div class="col-sm-3">
                <div class="form-group">
                    <label><?php echo $this->lang->line('test_name'); ?></label>
                    <small class="req"> *</small> 
                    <input type="text" name="test_name" class="form-control" value="<?php echo set_value('test_name',$result->test_name);?>">
                    <span class="text-danger"><?php echo form_error('test_name'); ?></span>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label><?php echo $this->lang->line('short_name'); ?></label>
                    <small class="req"> *</small> 
                    <input type="text" name="short_name" class="form-control"  value="<?php echo set_value('short_name',$result->short_name);?>">
                    <span class="text-danger"><?php echo form_error('short_name'); ?></span>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label><?php echo $this->lang->line('test_type'); ?></label>
                    
                    <input type="text" name="test_type" class="form-control"  value="<?php echo set_value('test_type',$result->test_type);?>">
                    <span class="text-danger"><?php echo form_error('test_type'); ?></span>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="exampleInputFile">
                        <?php echo $this->lang->line('category_name'); ?></label>
                    <small class="req"> *</small> 
                    <div>
                        <select class="form-control select2" style="width: 100%" name='pathology_category_id' >
                            <option value="<?php echo set_value('pathology_category_id'); ?>"><?php echo $this->lang->line('select'); ?></option>
                            <?php foreach ($categoryName as $dkey => $dvalue) {
                                ?>
                                <option value="<?php echo $dvalue["id"]; ?>" <?php echo set_select('pathology_category_id', $dvalue["id"],($result->category_id == $dvalue["id"]) ? true :false); ?>><?php echo $dvalue["category_name"] ?></option>   
                            <?php } ?>
                        </select>
                    </div>
                    <span class="text-danger"><?php echo form_error('pathology_category_id'); ?></span>
                </div>
            </div>                           
            <div class="col-sm-3">
                <div class="form-group">
                    <label><?php echo $this->lang->line('sub_category'); ?></label>
                    <input type="text" name="sub_category" class="form-control"  value="<?php echo set_value('sub_category',$result->sub_category);?>">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="Method"><?php echo $this->lang->line('method'); ?></label>
                    <input name="method" type="text" class="form-control"  value="<?php echo set_value('method',$result->method);?>"/>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label><?php echo $this->lang->line('report_days'); ?></label>
                    <input type="number" min="0" name="report_days" class="form-control"  value="<?php echo set_value('report_days',$result->report_days);?>">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="exampleInputFile"><?php echo $this->lang->line('charge_category'); ?></label>
                    <small class="req">*</small> 
                    <div>
                        <select class="form-control select2 charge_category"  name='charge_category_id' style="width: 100%">
                            <option value="<?php echo set_value('charge_category_id'); ?>"><?php echo $this->lang->line('select'); ?></option>
                            <?php foreach ($charge_category as $charge_cat_key => $charge_cat_value) {
                                ?>
                                <option value="<?php echo $charge_cat_value["id"]; ?>"  <?php echo set_select('charge_category_id', $charge_cat_value["id"],($result->charge_category_id == $charge_cat_value["id"]) ? true :false); ?>><?php echo $charge_cat_value["name"]; ?></option>   
                            <?php } ?>
                        </select>
                    </div>
                    <span class="text-danger"><?php echo form_error('charge_category_id'); ?></span>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="exampleInputFile"><?php echo $this->lang->line('charge_name'); ?></label>
                    <small class="req">*</small> 
                    <div>  
                        <select class="form-control select2 charge" style="width: 100%" name='code'  id="code" >
                            <option value=""><?php echo $this->lang->line('select') ?></option>
                        </select>
                    </div>
                    <span class="text-danger"><?php echo form_error('code'); ?></span>
                </div>
            </div> 
             <div class="col-sm-3">
                <div class="form-group"> 
                     <label for="exampleInputFile"><?php echo $this->lang->line('tax'); ?> (%)</label>
                        <div class="input-group">
                        <input type="text" class="form-control right-border-none" value="<?php echo $result->tax; ?>" readonly name="tax" id="tax"  autocomplete="off">
                        <span class="input-group-addon "> %</span>
                        </div>
                </div> 
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="exampleInputFile"><?php echo $this->lang->line('standard_charge'); ?></label><?php echo ' (' . $currency_symbol . ')'; ?>
                    <small class="req">*</small> 
                    <div>
                        <input readonly class="form-control" name='standard_charge' id="standard_charge"  value="<?php echo set_value('standard_charge',$result->standard_charge);?>">
                    </div>
                    <span class="text-danger"><?php echo form_error('code'); ?></span>
                </div>
            </div>  
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="exampleInputFile"><?php echo $this->lang->line('amount').' ('.$currency_symbol.')'; ?></label>
                    <small class="req">*</small> 
                    <div>
                        <input readonly class="form-control" name='amount' id="amount"  value="<?php echo set_value('amount',amountFormat($result->standard_charge+calculatePercent($result->standard_charge,$result->tax)));?>">

                    </div>
                    <span class="text-danger"><?php echo form_error('amount'); ?></span>
                </div>
            </div>
            <?php
            echo display_custom_fields('pathologytest', $result->id);
            ?>
        </div>
    </div><!--./row-->   
</div><!--./col-md-12-->       
<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover mb0" id="tableID">
                <thead>
                    <tr class="font13">
                        <th><?php echo $this->lang->line('test_parameter_name'); ?><small class="req"> *</small></th>
                        <th><?php echo $this->lang->line('reference_range'); ?><small class="req"> *</small></th>
                        <th><?php echo $this->lang->line('unit') ; ?><small class="req"> *</small></th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $row_count=1;
                    if(!empty($result->pathology_parameter)){
                        foreach ($result->pathology_parameter as $patho_param_key => $patho_param_value) {
                            
                         ?>
                         <input type="hidden" name="prev_inserted[]" value="<?php echo $patho_param_value->id;?>">
                    <tr id="row<?php echo $row_count; ?>">
                        <td width="35%">
                            <input type="hidden" name="total_rows[]" value="<?php echo $row_count; ?>">
                            <input type="hidden" name="inserted_id_<?php echo $row_count?>" value="<?php echo $patho_param_value->id;?>">
                            <input type="hidden" class="post_parameter_id" name="post_parameter_id" value="<?php echo $patho_param_value->pathology_parameter_id;?>">
                            <select class="form-control select2 pathology_parmeter" style="width:100%"  id="parameter_name_1" name='parameter_name_<?php echo $row_count;?>'>
                               <option value="<?php echo set_value('pathology_parameter_id'); ?>"><?php echo $this->lang->line('select'); ?></option>
                                <?php foreach ($parametername as $dkey => $dvalue) {
                                    ?>
                                    <option value="<?php echo $dvalue["id"]; ?>" <?php echo set_select('charge_category_id', $dvalue["id"],($patho_param_value->pathology_parameter_id == $dvalue["id"]) ? true :false); ?>><?php echo $dvalue["parameter_name"] ?></option>   
                                <?php } ?> 
                            </select>
                            <span class="text-danger"><?php echo form_error('parameter_name[]'); ?></span>
                        </td>
                        <td width="30%">
                            <input type="text" readonly="" name="reference_range_<?php echo $row_count;?>"  id="reference_range_<?php echo $row_count;?>" class="form-control reference_range">
                        </td>
                        <td width="30%">
                          
                            <input type="text" readonly="" name="patho_unit_<?php echo $row_count;?>"  id="patho_unit_<?php echo $row_count;?>" class="form-control patho_unit">
                       
                        </td>
                        <td>
                              <?php if ($this->rbac->hasPrivilege('pathology_parameter', 'can_delete')) { ?>
                            <button type="button" onclick="" class="closebtn delete_row" autocomplete="off"><i class="fa fa-remove"></i></button>

                             <?php } ?>
                        </td>
                    </tr>
                    <?php
                        $row_count++;
                    }
                    } 
                    ?>
                </tbody>
            </table>
            <a class="btn addplus-xs btn-info add-record mb10" data-added="0"><i class="fa fa-plus"></i> <?php echo $this->lang->line('add'); ?></a>
        </div>  
    </div><!--./col-md-12--> 
</div>