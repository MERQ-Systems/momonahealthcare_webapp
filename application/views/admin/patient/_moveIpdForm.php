<?php  
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
     <div class="">     	
         <input type="hidden" name="patient_id" value="<?php echo $patient['patient_id']?>">
         <input type="hidden" name="case_reference_id" value="<?php echo $patient['case_reference_id']?>">
         <input type="hidden" name="opd_id" value="<?php echo $patient['opdid']?>">
              
                        <div class="row row-eq">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div id="ajax_load"></div>
                                <div class="row ptt10" id="patientDetails">

                                    <div class="col-md-9 col-sm-9 col-xs-9">

                                        <ul class="singlelist">
                                            <li class="singlelist24bold">
                                                <span><?php                                                 
                                                echo composePatientName($patient['patient_name'],$patient['patient_id']);                                               
                                                
                                                ?></span></li>
                                            <li>
                                                <i class="fas fa-user-secret" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('guardian'); ?>"></i>
                                                <span><?php echo $patient['guardian_name'] ?></span>
                                            </li>
                                        </ul>   
                                        <ul class="multilinelist">   
                                            <li>
                                                <i class="fas fa-venus-mars" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('gender'); ?>"></i>
                                                <span ><?php echo $patient['gender'] ?></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-tint" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('blood_group'); ?>"></i>
                                                <span ><?php echo $patient['blood_group_name'] ?></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-ring" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('marital_status'); ?>"></i>
                                                <span><?php echo $patient['marital_status'] ?></span>
                                            </li> 
                                        </ul>  
                                        <ul class="singlelist">  
                                            <li>
                                                <i class="fas fa-hourglass-half" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('age'); ?>"></i>
                                                <span ><?php $dob = $patient['dob']; echo $this->customlib->getAgeBydob($dob);?></span>
                                            </li>    

                                            <li>
                                                <i class="fa fa-phone-square" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('phone'); ?>"></i> 
                                                <span><?php echo $patient['mobileno'] ?></span>
                                            </li>
                                            <li>
                                                <i class="fa fa-envelope" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('email'); ?>"></i>
                                                <span ><?php echo $patient['email'] ?></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-street-view" data-toggle="tooltip" data-placement="top" title="<?php echo $this->lang->line('address'); ?>"></i>
                                                <span><?php echo $patient['address'] ?></span>
                                            </li>

                                            <li>
                                                <b><?php echo $this->lang->line('any_known_allergies') ?> </b> 
                                                <span><?php echo $patient['known_allergies'] ?></span>
                                            </li>
                                            <li>
                                                <b><?php echo $this->lang->line('remarks') ?> </b> 
                                                <span><?php echo $patient['note'] ?></span>
                                            </li>
                                            <li>
                                                <b><?php echo $this->lang->line('tpa_id') ?> </b> 
                                                <span><?php echo $patient['insurance_id'] ?></span>
                                            </li>
                                            <li>
                                                <b><?php echo $this->lang->line('tpa_validity') ?> </b> 
                                                <span><?php echo $this->customlib->YYYYMMDDTodateFormat($patient['insurance_validity']); ?></span>
                                            </li>
                                            <li>
                                                <b><?php echo $this->lang->line('national_identification_number') ?> </b> 
                                                <span><?php echo $patient['identification_number'] ?></span>
                                            </li>
                                        </ul>                               
                                    </div><!-- ./col-md-9 -->
                                    <div class="col-md-3 col-sm-3 col-xs-3"> 
                                        <div class="pull-right">  
                                            <?php
                                            if($patient['patient_image'] !=''){
                                              $file = $patient['patient_image'];
                                            }else{
                                              $file = "uploads/patient_images/no_image.png";
                                            }
                                            ?>        
                                            <img class="profile-user-img img-responsive" src="<?php echo base_url() . $file.img_time() ?>" id="image" alt="User profile picture">
                                        </div>           
                                    </div><!-- ./col-md-3 --> 
                                </div>

                               <div class="row">
                                        <div class="col-md-12"> 
                                            <div class="dividerhr"></div>
                                        </div><!--./col-md-12-->
                                        <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('height'); ?></label> 
                                                <input name="height" type="text" value="<?php echo $patient['height']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('weight'); ?></label> 
                                                <input name="weight" type="text" value="<?php echo $patient['weight']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('bp'); ?></label> 
                                                <input name="bp" type="text"  value="<?php echo $patient['bp']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                         <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('pulse'); ?></label> 
                                                <input name="pulse" type="text" value="<?php echo $patient['pulse']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('temperature'); ?></label> 
                                                <input name="temperature" type="text" value="<?php echo $patient['temperature']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-sm-2 col-xs-4">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('respiration'); ?></label> 
                                                <input name="respiration" type="text" value="<?php echo $patient['respiration']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                   <div class="col-sm-3 col-xs-4">
                                    
                                        <div class="form-group">
                                                <label for="act">
                                                    <?php echo $this->lang->line('symptoms_type'); ?></label>
                                                <div><select  name='symptoms_type'  id="act"  class="form-control select2 act"  style="width:100%" >
                                                        <option value=""><?php echo $this->lang->line('select') ?></option>
                                 <?php foreach ($symptomsresulttype as $dkey => $dvalue) {
                                                            ?>
                <option value="<?php echo $dvalue["id"]; ?>" <?php echo  set_select('symptoms_type', $dvalue["id"], ($patient['symptoms_type'] == $dvalue["id"]) ? TRUE :FALSE); ?>><?php echo $dvalue["symptoms_type"] ;?></option>

                                                    <?php } ?>
                                                    </select>
                                                </div>
                                                <span class="text-danger"><?php echo form_error('symptoms_type'); ?></span>
                                            </div>
                                        </div>
                                        
                                          <input name="rows[]" type="hidden" value="1">
                                            <div class="col-sm-3 col-xs-4">
                                                <label for="filterinput"> 
                                                    <?php echo $this->lang->line('symptoms_title'); ?></label>
                                                <div id="dd" class="wrapper-dropdown-3">
                                                    <input class="form-control filterinput" type="text">
                                                    <ul class="dropdown scroll150 section_ul">
                                                        <li><label class="checkbox"><?php echo $this->lang->line('select'); ?></label></li>
                                                    </ul>
                                                </div>
                                            </div>

                                       <div class="col-sm-6 col-xs-4">
                                            <div class="form-group">
                                                <label><?php echo $this->lang->line('symptoms_description') ; ?></label>
                                                <textarea class="form-control" id="move_ipd_symptoms" name="symptoms" ><?php echo $patient['symptoms']; ?></textarea> 
                                            </div> 
                                        </div>
                                       
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="pwd"><?php echo $this->lang->line('note'); ?></label> 
                                                <textarea name="note" rows="3" class="form-control" ><?php echo set_value('note'); ?></textarea>
                                            </div>
                                        </div>
                                    <div class="">
                                        <?php
                                        echo display_custom_fields('ipd');
                                        ?>
                                    </div>      
                                </div><!--./row--> 
                            </div><!--./col-md-8--> 
                            <div class="col-lg-4 col-md-4 col-sm-4 col-eq ptt10">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label><?php echo $this->lang->line('admission_date'); ?></label><small class="req"> *</small>
                                            <input id="admission_date" name="appointment_date" placeholder="" type="text" class="form-control datetime"    value="<?php echo $this->customlib->YYYYMMDDHisTodateFormat($patient['appointment_date'])?>" />
                                            <span class="text-danger"><?php echo form_error('appointment_date'); ?></span>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="case">
<?php echo $this->lang->line('case'); ?></label>
                                            <div><input class="form-control" type='text' name='case'  value="<?php echo $patient['case_type']; ?>"/>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="casualty">
<?php echo $this->lang->line('casualty'); ?></label>
                                            <div>
                                                <select name="casualty" id="casualty" class="form-control">

                <option value="Yes" <?php echo ($patient['casualty']=="Yes") ? "selected":"" ?>><?php echo $this->lang->line('yes') ?></option>
                <option value="No" <?php echo  ($patient['casualty']=="No") ? "selected":""?>><?php echo $this->lang->line('no') ?></option>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                    </div> 
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="old_patient">
<?php echo $this->lang->line('old_patient'); ?></label>
                                            <div>
                                                <select name="old_patient" class="form-control">

                                                    <option value="<?php echo $this->lang->line('yes') ?>"><?php echo $this->lang->line('yes') ?></option>
                                                    <option selected="" value="<?php echo $this->lang->line('no') ?>"><?php echo $this->lang->line('no') ?></option>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="organisation">
                                                    <?php echo $this->lang->line('tpa'); ?></label>
                                            <div><select class="form-control" name='organisation' id='organisation'>
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>
                                                    <?php foreach ($organisation as $orgkey => $orgvalue) {
                                                        ?>
                <option value="<?php echo $orgvalue["id"]; ?>" <?php echo set_select('organisation', $orgvalue["id"], ($patient['organisation_id'] == $orgvalue["id"]) ? true : false); ?>><?php echo $orgvalue["organisation_name"] ?></option>   
<?php } ?>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('organisation_name'); ?></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="credit_limit">
<?php echo $this->lang->line('credit_limit') . " (" . $currency_symbol . ")"; ?></label>
                                            <div><input class="form-control" type='text' name='credit_limit' value="<?php echo $setting[0]['credit_limit']; ?>"/>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="refference"><?php echo $this->lang->line('reference'); ?></label>
                                            <div><input class="form-control" type='text' name='refference' value="<?php echo $patient['refference']; ?>" />
                                            </div>
                                            <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="consultant_doctor">
                                                <?php echo $this->lang->line('consultant_doctor'); ?><small class="req"> *</small></label>
                                            <div>
                                                <select class="form-control select2"  style="width: 100%" id='consultant_doctor' name='consultant_doctor' >
                                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                                    <?php foreach ($doctors as $dkey => $dvalue) {
                                                        ?>
                     <option value="<?php echo $dvalue["id"]; ?>" <?php echo set_select('consultant_doctor', $dvalue["id"], ($patient['cons_doctor'] == $dvalue["id"]) ? true : false); ?>><?php echo $dvalue["name"] . " " . $dvalue["surname"]." (". $dvalue["employee_id"] .")" ?></option>  

                       
                                                <?php } ?>
                                                </select>

                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="bed_group_id">
                                                    <?php echo $this->lang->line('bed_group'); ?></label>
                                            <div>
                                                <select class="form-control" name='bed_group_id' onchange="getBed(this.value,'','yes')">
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>
<?php foreach ($bedgroup_list as $key => $bedgroup) {
    ?> 
                                                        <option value="<?php echo $bedgroup["id"] ?>"><?php echo $bedgroup["name"] . " - " . $bedgroup["floor_name"] ?></option>
<?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                    </div>  

                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="bed_no">
                                                    <?php echo $this->lang->line('bed_number'); ?></label><small class="req"> *</small> 
                                            <div><select class="form-control select2" style="width: 100%" name='bed_no' id='bed_no'>
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>

                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('bed_no'); ?></span></div>
                                    </div> 
                                        <?php if ($this->module_lib->hasActive('live_consultation')) { ?>
                                       <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="live_consult">
                                                <?php echo $this->lang->line('live_consultation'); ?></label>
                                                <div>
                                                    <select name="live_consult" id="live_consult" class="form-control">
                                                <option value="yes" <?php echo ($patient['live_consult']=="yes") ? "selected":"" ?>><?php echo $this->lang->line('yes') ?></option>
                                                <option value="no" <?php echo  ($patient['live_consult']=="no") ? "selected":""?>><?php echo $this->lang->line('no') ?></option>
                                                       <!--  <option value="yes" ><?php echo $this->lang->line('yes') ?></option>
                                                        <option value="no" selected><?php echo $this->lang->line('no') ?></option> -->
                                                    </select>
                                                </div>
                                                <span class="text-danger"><?php echo form_error('live_consult'); ?></span>
                                            </div>
                                        </div> 
                                    <?php } ?>
                                </div><!--./row-->    
                            </div><!--./col-md-4-->
                        </div><!--./row--> 

                    </div>