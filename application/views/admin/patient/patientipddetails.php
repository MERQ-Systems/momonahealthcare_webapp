<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$genderList = $this->customlib->getGender();
?>
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"> <?php echo $this->lang->line('ipd') . " " . $this->lang->line('patient'); ?></h3>
                     
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('ipd_patient', 'can_add')) { ?>                 
                                <a data-toggle="modal" onclick="holdModal('myModal')" id="addp" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>  <?php echo $this->lang->line('add') . " " . $this->lang->line('patient') ?></a> 
                            <?php } ?>
                            <?php if ($this->rbac->hasPrivilege('discharged_patients', 'can_view')) { ?>
                                <a  href="<?php echo base_url() ?>admin/patient/discharged_patients" class="btn btn-primary btn-sm"><i class="fa fa-reorder"></i> <?php echo $this->lang->line('discharged') . " " . $this->lang->line('patient'); ?></a> 
                            <?php } ?>

                        </div>    
                    </div><!-- /.box-header -->

                    <?php
                    if (isset($resultlist)) {
                        ?>
                        <div class="box-body">

                            <div class="download_label"><?php echo $this->lang->line('ipd') . " " . $this->lang->line('patient'); ?></div>

                            <table class="table table-striped table-bordered table-hover example" cellspacing="0" width="100%">
                                <thead>
                                    <tr>

                                        <th><?php echo $this->lang->line('name') ?></th>
                                        <th><?php echo $this->lang->line('ipd_no'); ?></th>
                                        <th><?php echo $this->lang->line('patient') . " " . $this->lang->line('id'); ?></th>
                                        <th><?php echo $this->lang->line('gender'); ?></th>
                                        <th><?php echo $this->lang->line('phone'); ?></th>
                                        <th><?php echo $this->lang->line('consultant'); ?></th>
                                        <th><?php echo $this->lang->line('bed'); ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('charges') . " (" . $currency_symbol . ")"; ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('payment') . " (" . $currency_symbol . ")"; ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('due') . " " . $this->lang->line('payment') . " (" . $currency_symbol . ")"; ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('credit_limit') . " (" . $currency_symbol . ")"; ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    if (empty($resultlist)) {
                                        ?>
                                        <?php
                                    } else {
                                        $count = 1;
                                        $class = "";
                                        foreach ($resultlist as $patient) {

                                            $payment = $patient["payment"];
                                            $credit_limit = $patient["credit_limit"];
                                            $charge = $patient["charges"];
                                            $bill = $patient['charges'] - $patient['payment'];
                                            if ($bill >= $credit_limit) {
                                                $color = "alert alert-danger";
                                            }
                                            ?>
                                            <tr class="<?php echo $class; ?>">

                                                <td>

                                                    <a href="<?php echo base_url(); ?>admin/patient/ipdprofile/<?php echo $patient['id']; ?>/<?php echo $patient['ipdid']; ?>"><?php echo $patient['patient_name']; ?></a>
                                                    <div class="rowoptionview">       
                                                        <?php if ($this->rbac->hasPrivilege('consultant_register', 'can_add')) { ?>
                                                            <a href="#" onclick="add_instruction('<?php echo $patient['id'] ?>')" class="btn btn-default btn-xs"  data-toggle="tooltip" title="<?php echo $this->lang->line('consultant') . " " . $this->lang->line('instruction'); ?>" >
                                                                <i class="fa fa-user-md"></i>
                                                            </a>                                     
                                                        <?php } ?>
                                                        <?php if ($this->rbac->hasPrivilege('ipd_patient', 'can_view')) { ?>
                                                            <a href="<?php echo base_url(); ?>admin/patient/ipdprofile/<?php echo $patient['id'] ?>/<?php echo $patient['ipdid']; ?>" class="btn btn-default btn-xs"  data-toggle="tooltip" title="<?php echo $this->lang->line('show'); ?>" >
                                                                <i class="fa fa-reorder"></i>
                                                            </a>

                                                        <?php } ?>

                                                    </div>  
                                                </td>
                                                <td><?php echo $patient["ipd_no"] ?></td>
                                                <td><?php echo $patient["patient_unique_id"] ?></td>
                                                <td><?php echo $patient['gender']; ?></td>
                                                <td><?php echo $patient['mobileno']; ?></td>
                                                <td><?php echo $patient['name'] . " " . $patient['surname']; ?></td>
                                                <td><?php echo $patient['bed_name'] . " - " . $patient['bedgroup_name'] . " - " . $patient['floor_name']; ?></td>
                                                <td class="text-right"><?php echo number_format($patient["charges"], 2, '.', '');?> </td>
                                                <td class="text-right"><?php echo $patient['payment'] ?></td>
                                                <td class="text-right"><?php echo $patient['charges'] - $patient['payment'] ?></td>
                                                <td class="text-right"><?php echo $patient['credit_limit'] ?></td>
                                            </tr>
                                            <?php
                                            $count++;
                                        }
                                    }
                                    ?>
                                </tbody>
                            </table>
                        </div>
                        <?php
                    }
                    ?>
                </div>  
            </div>
        </div> 
    </section>
</div>
<div class="modal fade" id="myModal"  role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close pt4" data-dismiss="modal">&times;</button>
                <div class="row">
                    <div class="col-sm-6 col-xs-6">
                        <div class="form-group15">
                            <div>
                                <select onchange="get_PatientDetails(this.value)" class="form-control select2" <?php
                                if ($disable_option == true) {
                                    echo "disabled";
                                }
                                ?> style="width:100%" id="addpatient_id" name='' >
                                    <option value=""><?php echo $this->lang->line('select') . " " . $this->lang->line('patient') ?></option>
                                    <?php foreach ($patients as $dkey => $dvalue) { ?>
                                        <option value="<?php echo $dvalue["id"]; ?>" <?php
                                        if ((isset($patient_select)) && ($patient_select == $dvalue["id"])) {
                                            echo "selected";
                                        }
                                        ?>><?php echo $dvalue["patient_name"] . " (" . $dvalue["patient_unique_id"] . ")" ?>
                                        </option>   <?php } ?>
                                </select>
                            </div>
                            <span class="text-danger"><?php echo form_error('refference'); ?></span>
                        </div>
                    </div><!--./col-sm-6 col-xs-8 -->
                    <div class="col-sm-4 col-xs-5">
                        <div class="form-group15">
                            <?php if ($this->rbac->hasPrivilege('patient', 'can_add')) { ?>
                                <a data-toggle="modal" id="addpip" onclick="holdModal('myModalpa')" class="modalbtnpatient"><i class="fa fa-plus"></i>  <?php echo $this->lang->line('new') . " " . $this->lang->line('patient') ?></a> 
<?php } ?> 
                        </div>
                    </div>
                </div><!--./row--> 
            </div>
            <form id="formadd" accept-charset="utf-8" action="<?php echo base_url("admin/patient/add_inpatient") ?>" enctype="multipart/form-data" method="post">
                <div class="modal-body pt0 pb0">
                    <div class="">


                        <input  id="patientuniqueid" name="patientunique_id" placeholder="" type="hidden" class="form-control"  value="" />
                        <input name="patient_id" id="patient_id" type="hidden" class="form-control" />
                        <div class="row row-eq">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div id="ajax_load"></div>
                                <div class="row ptt10" id="patientDetails" style="display:none">

                                    <div class="col-md-9 col-sm-9 col-xs-9">

                                        <ul class="singlelist">
                                            <li class="singlelist24bold">
                                                <span id="listname"></span></li>
                                            <li>
                                                <i class="fas fa-user-secret" data-toggle="tooltip" data-placement="top" title="Guardian"></i>
                                                <span id="guardian"></span>
                                            </li>
                                        </ul>   
                                        <ul class="multilinelist">   
                                            <li>
                                                <i class="fas fa-venus-mars" data-toggle="tooltip" data-placement="top" title="Gender"></i>
                                                <span id="genders" ></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-tint" data-toggle="tooltip" data-placement="top" title="Blood Group"></i>
                                                <span id="blood_group"></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-ring" data-toggle="tooltip" data-placement="top" title="Marital Status"></i>
                                                <span id="marital_status"></span>
                                            </li> 
                                        </ul>  
                                        <ul class="singlelist">  
                                            <li>
                                                <i class="fas fa-hourglass-half" data-toggle="tooltip" data-placement="top" title="Age"></i>
                                                <span id="age"></span>
                                            </li>    

                                            <li>
                                                <i class="fa fa-phone-square" data-toggle="tooltip" data-placement="top" title="Phone"></i> 
                                                <span id="listnumber"></span>
                                            </li>
                                            <li>
                                                <i class="fa fa-envelope" data-toggle="tooltip" data-placement="top" title="Email"></i>
                                                <span id="email"></span>
                                            </li>
                                            <li>
                                                <i class="fas fa-street-view" data-toggle="tooltip" data-placement="top" title="Address"></i>
                                                <span id="address" ></span>
                                            </li>

                                            <li>
                                                <b><?php echo $this->lang->line('any_known_allergies') ?> </b> 
                                                <span id="allergies" ></span>
                                            </li>
                                            <li>
                                                <b><?php echo $this->lang->line('remarks') ?> </b> 
                                                <span id="note"></span>
                                            </li>    
                                        </ul>                               
                                    </div><!-- ./col-md-9 -->
                                    <div class="col-md-3 col-sm-3 col-xs-3"> 
                                        <div class="pull-right">                                          
                                            <?php
                                            $file = "uploads/patient_images/no_image.png";
                                            ?>        
                                            <img class="profile-user-img img-responsive" src="<?php echo base_url() . $file.img_time(); ?>" id="image" alt="User profile picture">
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
                                            <input name="height" type="text" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-sm-2 col-xs-4">
                                        <div class="form-group">
                                            <label for="pwd"><?php echo $this->lang->line('weight'); ?></label> 
                                            <input name="weight" type="text" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-sm-2 col-xs-4">
                                        <div class="form-group">
                                            <label for="pwd"><?php echo $this->lang->line('bp'); ?></label> 
                                            <input name="bp" type="text" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="email"><?php echo $this->lang->line('symtoms'); ?></label> 
                                            <textarea style="height: 28px;" name="symptoms" class="form-control" ><?php echo set_value('address'); ?></textarea>
                                        </div> 
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="pwd"><?php echo $this->lang->line('note'); ?></label> 
                                            <textarea name="note" rows="3" class="form-control" ><?php echo set_value('note'); ?></textarea>
                                        </div>
                                    </div>     
                                </div><!--./row--> 
                            </div><!--./col-md-8--> 
                            <div class="col-lg-4 col-md-4 col-sm-4 col-eq ptt10">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label><?php echo $this->lang->line('admission') . " " . $this->lang->line('date'); ?></label><small class="req"> *</small>
                                            <input id="admission_date" name="appointment_date" placeholder="" type="text" class="form-control datetime"   />
                                            <span class="text-danger"><?php echo form_error('appointment_date'); ?></span>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
                                            <?php echo $this->lang->line('case'); ?></label>
                                            <div><input class="form-control" type='text' name='case' />
                                            </div>
                                            <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
<?php echo $this->lang->line('casualty'); ?></label>
                                            <div>
                                                <select name="casualty" id="casualty" class="form-control">

                                                    <option value="<?php echo $this->lang->line('yes') ?>"><?php echo $this->lang->line('yes') ?></option>
                                                    <option selected="" value="<?php echo $this->lang->line('no') ?>"><?php echo $this->lang->line('no') ?></option>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                    </div> 
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
<?php echo $this->lang->line('old') . " " . $this->lang->line('patient'); ?></label>
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
                                            <label for="exampleInputFile">
                                                    <?php echo $this->lang->line('organisation'); ?></label>
                                            <div><select class="form-control" name='organisation' >
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>
                                                    <?php foreach ($organisation as $orgkey => $orgvalue) {
                                                        ?>
                                                        <option value="<?php echo $orgvalue["id"]; ?>"><?php echo $orgvalue["organisation_name"] ?></option>   
<?php } ?>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('organisation_name'); ?></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
<?php echo $this->lang->line('credit_limit') . " (" . $currency_symbol . ")"; ?></label>
                                            <div><input class="form-control" type='text' name='credit_limit' value="<?php echo $setting[0]['credit_limit']; ?>"/>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
<?php echo $this->lang->line('refference'); ?></label>
                                            <div><input class="form-control" type='text' name='refference' />
                                            </div>
                                            <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
                                                <?php echo $this->lang->line('consultant') . " " . $this->lang->line('doctor'); ?><small class="req"> *</small></label>
                                            <div>
                                                <select class="form-control select2" <?php
                                                if ($disable_option == true) {
                                                    echo "disabled";
                                                }
                                                ?> style="width: 100%" id='consultant_doctor' name='consultant_doctor'  >
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>
                                                    <?php foreach ($doctors as $dkey => $dvalue) {
                                                        ?>
                                                        <option value="<?php echo $dvalue["id"]; ?>" <?php
                                                                if ((isset($doctor_select)) && ($doctor_select == $dvalue["id"])) {
                                                                    echo "selected";
                                                                }
                                                                ?>><?php echo $dvalue["name"] . " " . $dvalue["surname"] ?></option>   
                                                <?php } ?>
                                                </select>
<?php if ($disable_option == true) { ?>
                                                    <input type="hidden" name="consultant_doctor" value="<?php echo $doctor_select ?>">
<?php } ?>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="exampleInputFile">
                                                    <?php echo $this->lang->line('bed') . " " . $this->lang->line('group'); ?></label>
                                            <div>
                                                <select class="form-control" name='bed_group_id' onchange="getBed(this.value)">
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
                                            <label for="exampleInputFile">
                                                    <?php echo $this->lang->line('bed') . " " . $this->lang->line('number'); ?></label><small class="req"> *</small> 
                                            <div><select class="form-control select2" style="width: 100%" name='bed_no' id='bed_no'>
                                                    <option value=""><?php echo $this->lang->line('select') ?></option>
                                                </select>
                                            </div>
                                            <span class="text-danger"><?php echo form_error('bed_no'); ?></span></div>
                                    </div>  
                                </div><!--./row-->    
                            </div><!--./col-md-4-->
                        </div><!--./row-->
                    </div>
                </div><!--./row-->
                <div class="box-footer">
                    <div class="pull-right">
                        <button type="submit" id="formaddbtn" data-loading-text="<?php echo $this->lang->line('processing') ?>" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                    </div>
                </div>
            </form>  
        </div>
    </div>    
</div>

<!-- revisit -->
<div class="modal fade" id="revisitModal" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="box-title"><?php echo $this->lang->line('patient') . " " . $this->lang->line('information'); ?></h4> 
            </div>
            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 paddlr">
                        <form id="formrevisit"   accept-charset="utf-8"  enctype="multipart/form-data" method="post" class="ptt10">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>
<?php echo $this->lang->line('patient') . " " . $this->lang->line('id'); ?></label> 
                                        <input id="revisit_id" disabled name="patient_id" placeholder="" type="text" class="form-control"  value="<?php echo set_value('roll_no'); ?>" />
                                        <span class="text-danger"><?php echo form_error('patient_id'); ?></span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('name'); ?></label><small class="req"> *</small> 
                                        <input id="revisit_name" name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('name'); ?>" />
                                        <input type="hidden" name="id" id="pid">
                                        <span class="text-danger"><?php echo form_error('name'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('phone'); ?></label>
                                        <input id="revisit_contact" autocomplete="off" name="contact" placeholder="" type="text" class="form-control"  value="<?php echo set_value('contact'); ?>" />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('appointment') . " " . $this->lang->line('date'); ?></label>
                                        <input id="revisit_date" name="appointment_date" placeholder="" type="text" class="form-control"   />
                                        <span class="text-danger"><?php echo form_error('appointment_date'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('case'); ?></label>
                                        <div><input class="form-control" type='text' id="revisit_case" name='revisit_case' />
                                        </div>
                                        <span class="text-danger"><?php echo form_error('case'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('casualty'); ?></label>
                                        <div>
                                            <select name="casualty" id="revisit_casualty" class="form-control">
                                                <option value=""><?php echo $this->lang->line('select') ?></option>
                                                <option value="yes"><?php echo $this->lang->line('yes') ?></option>
                                                <option value="no"><?php echo $this->lang->line('no') ?></option>
                                            </select>
                                        </div>
                                        <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                </div> 
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('old') . " " . $this->lang->line('patient'); ?></label>
                                        <div>
                                            <select name="old_patient" class="form-control">
                                                <option value=""><?php echo $this->lang->line('select') ?></option>
                                                <option value="yes"><?php echo $this->lang->line('yes') ?></option>
                                                <option value="no"><?php echo $this->lang->line('no') ?></option>
                                            </select>
                                        </div>
                                        <span class="text-danger"><?php echo form_error('case'); ?></span></div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="email"><?php echo $this->lang->line('symtoms'); ?></label> 
                                        <textarea name="symptoms" id="revisit_symptoms" class="form-control" ><?php echo set_value('address'); ?></textarea>
                                    </div> 
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="email"><?php echo $this->lang->line('any_known_allergies'); ?></label> 
                                        <textarea name="known_allergies" id="revisit_allergies" class="form-control" ><?php echo set_value('address'); ?></textarea>
                                    </div> 
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="email"><?php echo $this->lang->line('address'); ?></label> 
                                        <textarea name="address" id="revisit_address" class="form-control" ><?php echo set_value('address'); ?></textarea>
                                    </div> 
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('note'); ?></label> 
                                        <textarea name="note" id="revisit_note" class="form-control" ><?php echo set_value('note'); ?></textarea>
                                    </div>
                                </div>   
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('refference'); ?></label>
                                        <div><input class="form-control" id="revisit_refference" type='text' name='refference' />
                                        </div>
                                        <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
                                                <?php echo $this->lang->line('consultant') . " " . $this->lang->line('doctor'); ?></label>
                                        <div><select class="form-control select2" <?php
                                                if ($disable_option == true) {
                                                    echo "disabled";
                                                }
                                                ?> name='consultant_doctor' id="revisit_doctor">
                                                <option value=""><?php echo $this->lang->line('select') ?></option>
                                                        <?php foreach ($doctors as $dkey => $dvalue) {
                                                            ?>
                                                    <option value="<?php echo $dvalue["id"]; ?>" <?php
                                                if ((isset($doctor_select)) && ($doctor_select == $dvalue["id"])) {
                                                    echo "selected";
                                                }
                                                ?>><?php echo $dvalue["name"] . " " . $dvalue["surname"] ?></option>   
<?php } ?>
                                            </select>
<?php if ($disable_option == true) { ?>
                                                <input type="hidden" name="consultant_doctor" value="<?php echo $doctor_select ?>">
<?php } ?>
                                        </div>
                                        <span class="text-danger"><?php echo form_error('refference'); ?></span></div>
                                </div>  
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('amount'); ?></label> 
                                        <input name="amount" type="text" class="form-control" id="revisit_amount" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('tax'); ?></label> 
                                        <input type="text" name="tax" id="revisi_tax" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('payment') . " " . $this->lang->line('mode'); ?></label> 
                                        <select name="payment_mode" id="revisit_payment" class="form-control">
                                            <option value=""><?php echo $this->lang->line('select') ?></option>
<?php foreach ($payment_mode as $payment_key => $payment_value) {
    ?>
                                                <option value="<?php echo $payment_key ?>"><?php echo $payment_value ?></option>
<?php } ?>
                                        </select>
                                    </div>
                                </div>
                            </div><!--./row-->   
                            <button type="submit" class="btn btn-info pull-right"><?php $this->lang->line('save'); ?></button>
                        </form>                       
                    </div><!--./col-md-12--> 
                </div><!--./row--> 
            </div>
        </div>
    </div>    
</div>
<!-- dd -->
<div class="modal fade" id="myModaledit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="box-title"><?php $this->lang->line('patient') . " " . $this->lang->line('information'); ?></h4> 
            </div>
            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 paddlr">
                        <form id="formedit" accept-charset="utf-8"  enctype="multipart/form-data" method="post"  class="ptt10">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('name'); ?></label><small class="req red"> *</small> 
                                        <input id="patient_name" name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('name'); ?>" />
                                        <input type="hidden" id="updateid" name="updateid">
                                        <input type="hidden" id="opdid" name="opdid">
                                        <span class="text-danger"><?php echo form_error('name'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('guardian_name'); ?></label>
                                        <input type="text" id="guardian_name" name="guardian_name" value="" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label> <?php echo $this->lang->line('gender'); ?></label><small class="req"> *</small> 
                                        <select class="form-control" id="gender" name="gender">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($genderList as $key => $value) {
                                                ?>
                                                <option value="<?php echo $key; ?>" <?php if (set_value('gender') == $key) echo "selected"; ?>><?php echo $value; ?></option>
    <?php
}
?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('gender'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('marital_status'); ?></label>
                                        <select name="marital_status" id="marital_status" class="form-control">
                                            <option value=""><?php echo $this->lang->line('select') ?></option>
<?php foreach ($marital_status as $mkey => $mvalue) {
    ?>
                                                <option value="<?php echo $mkey ?>"><?php echo $mvalue ?></option>
<?php } ?>
                                        </select>
                                    </div>
                                </div> 
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="pwd"><?php echo $this->lang->line('phone'); ?></label>
                                        <input id="contact" autocomplete="off" name="contact" placeholder="" type="text" class="form-control"  value="<?php echo set_value('contact'); ?>" />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('patient') . " " . $this->lang->line('photo'); ?></label>
                                        <div><input class="filestyle form-control" type='file' name='file' id="file" size='20' />
                                            <input type="hidden" name="patient_photo" id="patient_photo">
                                        </div>
                                        <span class="text-danger"><?php echo form_error('file'); ?></span>
                                    </div>
                                </div>  
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('email'); ?></label>
                                        <input type="text" id="email" value="<?php echo set_value('email'); ?>" name="email" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label> <?php echo $this->lang->line('blood_group'); ?></label><small class="req"> *</small> 
                                        <select class="form-control" id="bloodgroup" name="blood_group">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($bloodgroup as $key => $value) {
                                                ?>
                                                <option value="<?php echo $value; ?>" <?php if (set_value('gender') == $key) echo "selected"; ?>><?php echo $value; ?></option>
    <?php
}
?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('gender'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('age'); ?></label>
                                        <div style="clear: both;overflow: hidden;">
                                            <input type="text" placeholder="<?php echo $this->lang->line('year') ?>" name="age" id="age" class="form-control" value="<?php echo set_value('age'); ?>" style="width: 40%; float: left;">
                                            <input type="text" placeholder="Month" name="month"  id="month"value="<?php echo set_value('month'); ?>" class="form-control" style="width: 56%;float: left; margin-left: 5px;">
                                        </div>
                                    </div>
                                </div>                                   
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('height'); ?></label>
                                        <input type="text" id="height" name="height" value="<?php echo set_value('height'); ?>" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('weight'); ?></label>
                                        <input type="text" id="weight" name="weight" value="<?php echo set_value('weight'); ?>" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
                                                <?php echo $this->lang->line('organisation'); ?></label>
                                        <div><select class="form-control" name='organisation' >
                                                <option value=""><?php echo $this->lang->line('select') ?></option>
<?php foreach ($organisation as $orgkey => $orgvalue) {
    ?>
                                                    <option value="<?php echo $orgvalue["id"]; ?>"><?php echo $orgvalue["organisation_name"] ?></option>   
<?php } ?>
                                            </select>
                                        </div>
                                        <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="exampleInputFile">
<?php echo $this->lang->line('credit_limit'); ?></label>
                                        <div><input type="text" name="credit_limit" id="credit_limit" class="form-control">
                                        </div>
                                        <span class="text-danger"><?php echo form_error('refference'); ?></span>
                                    </div>
                                </div>
                            </div><!--./row-->   
                            <button type="submit" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                        </form>                       
                    </div><!--./col-md-12-->       
                </div><!--./row--> 
            </div>
        </div>
    </div>    
</div>

<div class="modal fade" id="add_instruction" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="box-title"><?php echo $this->lang->line('consultant') . " " . $this->lang->line('instruction'); ?></h4> 
            </div>
            <form id="consultant_register"  accept-charset="utf-8"  enctype="multipart/form-data" method="post" class="">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10">
                        <div class="row">
                            <div class="col-sm-4">
                                <input name="patient_id" placeholder="" id="ins_patient_id"  type="hidden" class="form-control"   />
                            </div>
                            <div class="col-md-12">
                                <table class="table table-striped table-bordered table-hover" id="tableID">
                                    <tr>
                                        <th><?php echo $this->lang->line('applied') . " " . $this->lang->line('date'); ?><small class="req red" style="color:red;"> *</small></th>
                                        <th><?php echo $this->lang->line('consultant'); ?><small class="req red" style="color:red;"> *</small></th>
                                        <th><?php echo $this->lang->line('instruction'); ?>
                                            <small class="req red" style="color:red;"> *</small>
                                        </th>
                                        <th><?php echo $this->lang->line('instruction') . " " . $this->lang->line('date'); ?>
                                            <small class="req red" style="color:red;"> *</small>
                                        </th>
                                    </tr>
                                    <tr id="row0">
                                        <td><input type="text" name="date[]" value="<?php echo set_value('date', date($this->customlib->getHospitalDateFormat(true, true))); ?>" class="form-control datetime"></td>
                                        <td><select name="doctor[]" <?php
                                                if ($disable_option == true) {
                                                    echo "disabled";
                                                }
                                                ?> class="form-control select2" style="width: 100%">
                                                <option value=""><?php echo $this->lang->line('select') ?></option>
<?php foreach ($doctors as $key => $value) {
    ?>
                                                    <option value="<?php echo $value["id"] ?>" <?php
    if ((isset($doctor_select)) && ($doctor_select == $value["id"])) {
        echo "selected";
    }
    ?>><?php echo $value["name"] . " " . $value["surname"] ?></option>
<?php } ?>
                                            </select></td>
                                        <td><textarea name="instruction[]" style="height:28px" class="form-control"></textarea></td>
                                        <td><input type="text"  name="insdate[]" value="<?php echo set_value('date', date($this->customlib->getHospitalDateFormat())); ?>" class="form-control date"></td>
                                        <td><button type="button" onclick="add_more()" style="color: #2196f3" class="closebtn"><i class="fa fa-plus"></i></button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>     
                <div class="box-footer">
                    <button type="submit" id="consultant_registerbtn" data-loading-text="<?php echo $this->lang->line('processing') ?>"class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div>
    </div>
</div>   

<!-- Modal -->


<script type="text/javascript">

    $(function () {
        //Initialize Select2 Elements
        $('.select2').select2()
    });
    $(function () {
        $('#easySelectable').easySelectable();
        
    });

    function add_more() {

        var table = document.getElementById("tableID");
        var table_len = (table.rows.length);
        var id = parseInt(table_len);

        var div = "<td><input type='text' name='date[]' class='form-control datetime'></td><td><select name='doctor[]' class='select2' style='width:100%'><option value=''><?php echo $this->lang->line('select') ?></option><?php foreach ($doctors as $key => $value) { ?><option value='<?php echo $value["id"] ?>'><?php echo $value["name"] . ' ' . $value["surname"] ?></option><?php } ?></select></td><td><textarea name='instruction[]' style='height:28px;' class='form-control'></textarea></td><td><input type='text' name='insdate[]' class='form-control date'></td>";

        var row = table.insertRow(table_len).outerHTML = "<tr id='row" + id + "'>" + div + "<td><button type='button' onclick='delete_row(" + id + ")' class='closebtn'><i class='fa fa-remove'></i></button></td></tr>";

        $('.select2').select2();
    }

    function delete_row(id) {
        var table = document.getElementById("tableID");
        var rowCount = table.rows.length;
        $("#row" + id).html("");
    }
</script>
<script type="text/javascript">
    
    (function ($) {
        //selectable html elements
        $.fn.easySelectable = function (options) {
            var el = $(this);
            var options = $.extend({
                'item': 'li',
                'state': true,
                onSelecting: function (el) {

                },
                onSelected: function (el) {

                },
                onUnSelected: function (el) {

                }
            }, options);
            el.on('dragstart', function (event) {
                event.preventDefault();
            });
            el.off('mouseover');
            el.addClass('easySelectable');
            if (options.state) {
                el.find(options.item).addClass('es-selectable');
                el.on('mousedown', options.item, function (e) {
                    $(this).trigger('start_select');
                    var offset = $(this).offset();
                    var hasClass = $(this).hasClass('es-selected');
                    var prev_el = false;
                    el.on('mouseover', options.item, function (e) {
                        if (prev_el == $(this).index())
                            return true;
                        prev_el = $(this).index();
                        var hasClass2 = $(this).hasClass('es-selected');
                        if (!hasClass2) {
                            $(this).addClass('es-selected').trigger('selected');
                            el.trigger('selected');
                            options.onSelecting($(this));
                            options.onSelected($(this));
                        } else {
                            $(this).removeClass('es-selected').trigger('unselected');
                            el.trigger('unselected');
                            options.onSelecting($(this))
                            options.onUnSelected($(this));
                        }
                    });
                    if (!hasClass) {
                        $(this).addClass('es-selected').trigger('selected');
                        el.trigger('selected');
                        options.onSelecting($(this));
                        options.onSelected($(this));
                    } else {
                        $(this).removeClass('es-selected').trigger('unselected');
                        el.trigger('unselected');
                        options.onSelecting($(this));
                        options.onUnSelected($(this));
                    }
                    var relativeX = (e.pageX - offset.left);
                    var relativeY = (e.pageY - offset.top);
                });
                $(document).on('mouseup', function () {
                    el.off('mouseover');
                });
            } else {
                el.off('mousedown');
            }
        };
    })(jQuery);

</script>
<script type="text/javascript">
    $(document).ready(function (e) {
        $("#formadd").on('submit', (function (e) {

            $("#formaddbtn").button('loading');
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/add_inpatient',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {

                    if (data.status == "fail") {

                        var message = "";
                        $.each(data.error, function (index, value) {

                            message += value;
                        });
                        errorMsg(message);
                    } else {

                        successMsg(data.message);
                        window.location.reload(true);
                    }
                    $("#formaddbtn").button('reset');
                },
                error: function () {

                }
            });
        }));
    });

    $(document).ready(function (e) {
        $("#formrevisit").on('submit', (function (e) {
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/add_revisit',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {

                    if (data.status == "fail") {

                        var message = "";
                        $.each(data.error, function (index, value) {

                            message += value;
                        });
                        errorMsg(message);
                    } else {

                        successMsg(data.message);
                        window.location.reload(true);
                    }

                },
                error: function () {
                   
                }
            });
        }));
    });
    /**/

    $(document).ready(function (e) {
        $("#formedit").on('submit', (function (e) {

            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/update',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {

                    if (data.status == "fail") {

                        var message = "";
                        $.each(data.error, function (index, value) {

                            message += value;
                        });
                        errorMsg(message);
                    } else {

                        successMsg(data.message);
                        window.location.reload(true);
                    }

                },
                error: function () {
                   
                }
            });
        }));
    });

    /**/
    $(document).ready(function (e) {
        $("#formaddip").on('submit', (function (e) {
            $("#formaddipbtn").button('loading');
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/addpatient',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {
                    if (data.status == "fail") {
                        var message = "";
                        $.each(data.error, function (index, value) {
                            message += value;
                        });
                        errorMsg(message);
                    } else {
                        successMsg(data.message);
                        window.location.reload(true);
                    }
                    $("#formaddipbtn").button('reset');
                },
                error: function () {
                    
                }
            });
        }));
    });

    function get_PatientDetails(id) {        
        var base_url = "<?php echo base_url(); ?>backend/images/loading.gif";
        $("#ajax_load").html("<center><img src='" + base_url + "'/>");
        $.ajax({
            url: '<?php echo base_url(); ?>admin/patient/patientDetails',
            type: "POST",
            data: {id: id},
            dataType: 'json',
            success: function (res) {
                if (res) {
                    $("#ajax_load").html("");
                    $("#patientDetails").show();
                    $('#patientuniqueid').val(res.patient_unique_id);
                    $('#patient_id').val(res.id);
                    $('#listname').html(res.patient_name);
                    $('#guardian').html(res.guardian_name);
                    $('#listnumber').html(res.mobileno);
                    $('#email').html(res.email);
                    if (res.age == "") {
                        $("#age").html("");
                    } else {
                        $("#age").html(res.age + " Years " + res.month + " Month (" + res.dob + ")");
                    }
                    $('#doctname').val(res.name + " " + res.surname);
                    $("#bp").html(res.bp);
                    $("#symptoms").html(res.symptoms);
                    $("#known_allergies").html(res.known_allergies);
                    $("#address").html(res.address);
                    $("#note").html(res.note);
                    $("#height").html(res.height);
                    $("#weight").html(res.weight);
                    $("#genders").html(res.gender);
                    $("#marital_status").html(res.marital_status);
                    $("#blood_group").html(res.blood_group);
                    $("#allergies").html(res.known_allergies);
                    $("#image").attr("src", '<?php echo base_url() ?>' + res.image);                   
                } else {
                    $("#ajax_load").html("");
                    $("#patientDetails").hide();
                }
            }
        });
    }
    
    function getRecord(id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/patient/getIpdDetails',
            type: "POST",
            data: {recordid: id},
            dataType: 'json',
            success: function (data) {
                $("#patientid").val(data.patient_unique_id);
                $("#patient_name").val(data.patient_name);
                $("#contact").val(data.mobileno);
                $("#email").val(data.email);
                $("#age").val(data.age);
                $("#bloodgroup").val(data.blood_group);
                $("#guardian_name").val(data.guardian_name);
                $("#appointment_date").val(data.appointment_date);
                $("#case").val(data.case_type);
                $("#symptoms").val(data.symptoms);
                $("#known_allergies").val(data.known_allergies);
                $("#refference").val(data.refference);
                $("#credit_limit").val(data.credit_limit);
                $("#amount").val(data.amount);
                $("#tax").val(data.tax);
                $("#opdid").val(data.opdid);
                $("#address").val(data.address);
                $("#note").val(data.note);
                $("#height").val(data.height);
                $("#weight").val(data.weight);
                $("#updateid").val(id);
                $('select[id="gender"] option[value="' + data.gender + '"]').attr("selected", "selected");
                $('select[id="marital_status"] option[value="' + data.marital_status + '"]').attr("selected", "selected");
                $('select[id="consultant_doctor"] option[value="' + data.cons_doctor + '"]').attr("selected", "selected");
                $(".select2").select2().select2('val', data.cons_doctor);
                $('select[id="payment_mode"] option[value="' + data.payment_mode + '"]').attr("selected", "selected");
                $('select[id="casualty"] option[value="' + data.casualty + '"]').attr("selected", "selected");
            },
        })
    }

    function getRevisitRecord(id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/patient/getDetails',
            type: "POST",
            data: {recordid: id},
            dataType: 'json',
            success: function (data) {
                $("#revisit_id").val(data.patient_unique_id);
                $("#revisit_name").val(data.patient_name);
                $("#revisit_contact").val(data.mobileno);
                $("#revisit_date").val(data.appointment_date);
                $("#revisit_case").val(data.case_type);
                $("#pid").val(id);
                $("#revisit_allergies").val(data.known_allergies);
                $("#revisit_refference").val(data.refference);
                $("#revisit_amount").val(data.amount);
                $("#revisit_symptoms").val(data.symptoms);
                $("#revisi_tax").val(data.tax);
                $("#revisit_address").val(data.address);
                $("#revisit_note").val(data.note);
                $('select[id="revisit_doctor"] option[value="' + data.cons_doctor + '"]').attr("selected", "selected");
                $('select[id="revisit_payment"] option[value="' + data.payment_mode + '"]').attr("selected", "selected");
                $('select[id="revisit_casualty"] option[value="' + data.casualty + '"]').attr("selected", "selected");
            },
        })
    }

    function add_instruction(id) {
        $("#ins_patient_id").val(id);
        holdModal('add_instruction');
    }

    $(document).ready(function (e) {
        $("#consultant_register").on('submit', (function (e) {
            $("#consultant_registerbtn").button('loading');
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/patient/add_consultant_instruction',
                type: "POST",
                data: new FormData(this),
                dataType: 'json',
                contentType: false,
                cache: false,
                processData: false,
                success: function (data) {
                    if (data.status == "fail") {
                        var message = "";
                        $.each(data.error, function (index, value) {
                            message += value;
                        });
                        errorMsg(message);
                    } else {
                        successMsg(data.message);
                        window.location.reload(true);
                    }
                    $("#consultant_registerbtn").button('reset');
                },
                error: function () {
                    
                }
            });
        }));
    });

    function getBed(bed_group, bed = '') {
        var div_data = "";
        $('#bed_no').html("<option value='l'><?php echo $this->lang->line('loading') ?></option>");     

        $.ajax({
            url: '<?php echo base_url(); ?>admin/setup/bed/getbedbybedgroup',
            type: "POST",
            data: {bed_group: bed_group, active: 'yes'},
            dataType: 'json',
            success: function (res) {
                $.each(res, function (i, obj)
                {
                    var sel = "";
                    if ((bed != '') && (bed == obj.id)) {
                        sel = "selected";
                    }
                    div_data += "<option value=" + obj.id + " " + sel + ">" + obj.name + "</option>";
                });
                $("#bed_no").html("<option value=''>Select</option>");
                $('#bed_no').append(div_data);
                $("#bed_no").select2().select2('val', bed);
            }
        });
    }

    function add_inpatient(bed, bedgroup) {
        $('select[name="bed_group_id"] option[value="' + bedgroup + '"]').attr("selected", "selected");
        getBed(bedgroup, bed);
        holdModal('myModal');
    }

    function holdModal(modalId) {
        $('#' + modalId).modal({
            backdrop: 'static',
            keyboard: false,
            show: true
        });
    }

    $(document).ready(function () {
        $('.detail_popover').popover({
            placement: 'right',
            trigger: 'hover',
            container: 'body',
            html: true,
            content: function () {
                return $(this).closest('a').find('.fee_detail_popover').html();
            }
        });
    });

</script>                                                      
<?php $this->load->view('admin/patient/patientaddmodal') ?>