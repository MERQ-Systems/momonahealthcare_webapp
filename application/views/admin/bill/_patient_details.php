<?php 
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
if(!empty($result)){
?> 
<div class="box-body pb0 clear">
    <div class="col-lg-2 col-md-2 col-sm-3 text-center">
        <?php
        $image = $result['image'];
        if ($image != '') {
            $file = $result['image'];
        } else {
            $file = "uploads/patient_images/no_image.png";
        }
        ?>
        <img width="115" height="115" class="" src="<?php echo base_url() . $file.img_time() ?>" alt="No Image">
        <div class="editviewdelete-icon pt8">
        </div> 
        <div>
            <button class="btn btn-primary btn-sm showbill" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> Please wait..." data-case-id="<?php echo $case_id;?>"><?= $this->lang->line("bill_summary"); ?></button>
        </div> 
    </div>
    <div class="col-md-10 col-lg-10 col-sm-9">
        <div class="table-responsive">
            <table class="table table-striped mb0 font13">
                <tbody>
                    <tr>
                        <th class="bozerotop"><?php
                            echo $this->lang->line('case_id'); ?></th>
                        <td class="bozerotop"><?php echo $case_id;?>  </td>
                         <th class="bozerotop"><?php
                            echo $this->lang->line('appointment_date');
                            ;
                            ?></th>
                        <td class="bozerotop"><?php if($result['appointment_date'] !='' && $result['appointment_date']!='0000-00-00'){
                            echo $this->customlib->YYYYMMDDHisTodateFormat($result['appointment_date'],$this->customlib->getHospitalTimeFormat());
                        } ?>
                        </td>
                    </tr> 
                    <tr>
                        <th class="bozerotop"><?php echo $this->lang->line('name'); ?></th>
                        <td class="bozerotop"><?php echo composePatientName($result['patient_name'],$result['patient_id']); ?></td>
                        <th class="bozerotop"><?php echo $this->lang->line('guardian_name'); ?></th>
                        <td class="bozerotop"><?php echo $result['guardian_name']; ?></td>
                    </tr>
                    <tr>
                        <th class="bozerotop"><?php echo $this->lang->line('gender'); ?></th>
                        <td class="bozerotop"><?php echo $result['gender']; ?></td>
                        <th class="bozerotop"><?php echo $this->lang->line('age'); ?></th>
                        <td class="bozerotop">
                            <?php
                            
                            echo $this->customlib->getPatientAge($result['age'],$result['month'],$result['day']);
                            ?>   
                        </td>
                    </tr>
                    <tr>
                        <th class="bozerotop"><?php echo $this->lang->line('phone'); ?></th>
                        <td class="bozerotop"><?php echo $result['mobileno']; ?></td>
                        <th class="bozerotop"><?php
                            echo $this->lang->line('credit_limit') . " (" . $currency_symbol . ")";
                            ;
                            ?></th>
                        <td class="bozerotop"><?php echo $result['credit_limit']; ?>
                        </td>
                    </tr>
                    <?php 
                    if($result['ipdid']!='' && $result['ipdid']!=0){?>
                    <tr>
                      
                        <th class="bozerotop"><?php echo $this->lang->line('ipd_no'); ?></th>
                        <td class="bozerotop"><?php
                            if($result['ipdid']!='' && $result['ipdid']!=0){
                                echo $this->customlib->getSessionPrefixByType('ipd_no').$result['ipdid'];
                            }
                            
                             if ($result['discharged'] == 'yes') {
                                 echo " <span class='label label-warning'>" . $this->lang->line("discharged") . "</span>";
                             }
                            ?>
                        </td>
                    </tr>
                <?php } ?>
                    <?php 
                    if($result['opdid']!='' && $result['opdid']!=0){?>
                    <tr>
                        <th class="bozerotop"><?php echo $this->lang->line('opd_no'); ?></th>
                        <td class="bozerotop"><?php
                            if($result['opdid']!='' && $result['opdid']!=0){
                                echo $this->customlib->getSessionPrefixByType('opd_no').$result['opdid'];
                            }
                            ?>
                        </td>
                    </tr>
                <?php } ?>
                 <?php if($result['ipdid'] !='' && $result['ipdid'] !=0){?>
                    <tr>
                        <th class="bozerotop"><?php
                            echo $this->lang->line('admission_date');
                            ;
                            ?></th>
                        <td class="bozerotop"><?php if($result['date']!='' && $result['date']!='0000-00-00'){
                            echo $this->customlib->YYYYMMDDTodateFormat($result['date']);
                        } ?>
                        </td>
                        <th class="bozerotop"><?php
                            echo $this->lang->line('bed');
                            ;
                            ?></th>
                        <td class="bozerotop"><?php echo $result['bed_name'] . " - " . $result['bedgroup_name'] . " - " . $result['floor_name'] ?>
                        </td>
                    </tr> 
                    <tr>
                     <?php } ?>  
                    </tr>
                </tbody>
            </table>
        </div>
    </div>           
</div>
<?php } ?>