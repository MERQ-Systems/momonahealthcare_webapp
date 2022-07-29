<?php 
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>  

      
                    
                <div class="row">
                    
                <div class="">
                   
                    <div class="col-md-12 col-lg-10 col-sm-9">
                        

                            <table class="print-table" style="text-align: left; padding-top: 10px; width: 100%;">
                                <tbody>
                                    <tr>
                                        <th width="30%"><?php echo $this->lang->line('case_reference_no'); ?></th>
                                        <td ><?php echo $case_id;?>  </td>
                                       
                                         <th ><?php
                                            echo $this->lang->line('appointment_date');
                                            ;
                                            ?></th>
                                        <td ><?php if($result['appointment_date']!='' && $result['appointment_date']!='0000-00-00'){
                                            echo $this->customlib->YYYYMMDDHisTodateFormat($result['appointment_date']);
                                        } ?>
                                        </td>
                                    </tr> 
                                    <tr>
                                        <th ><?php echo $this->lang->line('name'); ?></th>
                                        <td><?php echo $result['patient_name'] ?></td>
                                       
                                        <th ><?php echo $this->lang->line('guardian_name'); ?></th>
                                        <td ><?php echo $result['guardian_name']; ?></td>
                                    </tr>
                                    <tr>
                                        <th ><?php echo $this->lang->line('gender'); ?></th>
                                        <td ><?php echo $result['gender']; ?></td>
                                        
                                        <th ><?php echo $this->lang->line('age'); ?></th>
                                        <td >
                                            <?php
                                             if (!empty($result['dob'])) {
                                                echo $this->customlib->getAgeBydob($result['dob']);
                                             } 
                                            ?>   
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('phone'); ?></th>
                                        <td ><?php echo $result['mobileno']; ?></td>
                                        
                                    <?php 
                                    if($result['ipdid']!='' && $result['ipdid']!=0){?>
                                   
                                      
                                        <th ><?php echo $this->lang->line('ipd_no'); ?></th>
                                        <td ><?php
                                            if($result['ipdid']!='' && $result['ipdid']!=0){
                                                echo $this->customlib->getPatientSessionPrefixByType('ipd_no').$result['ipdid'];
                                            }
                                            
                                            ?>
                                        </td>
                                   
                                <?php } ?>
                                 </tr>
                                      <tr>
                                    <?php 
                                    if($result['opdid']!='' && $result['opdid']!=0){?>
                                
                                        
                                      
                                        <th ><?php echo $this->lang->line('opd_no'); ?></th>
                                        <td ><?php
                                            if($result['opdid']!='' && $result['opdid']!=0){
                                                echo $this->customlib->getSessionPrefixByType('opd_no').$result['opdid'];
                                            }
                                             
                                            ?>
                                        </td>
                                   
                                <?php } ?>
                                   
                                        <th ><?php
                                            echo $this->lang->line('admission_date');
                                            ;
                                            ?></th>
                                        <td ><?php if($result['date']!='' && $result['date']!='0000-00-00'){
                                            echo $this->customlib->YYYYMMDDHisTodateFormat($result['date']);
                                        } ?>
                                        </td>
                                       </tr>
                                       <tr>
                                   
                                        <th ><?php echo $this->lang->line('discharge_date'); ?></th>
                                        <td >
                                            <?php if((!empty($discharge_card)) && $discharge_card['discharge_date']!=''){ echo $this->customlib->YYYYMMDDHisTodateFormat($discharge_card['discharge_date']); }   ?>
                                        </td>
                                       

                                   
                                        <th ><?php echo $this->lang->line('patient_discharge'); ?></th>
                                        <td ><?php  echo  $this->customlib->discharge_status($discharge_card['discharge_status']);  ?>
                                        </td>
                                         </tr> 
                                    <tr>
                                    
                                        <th ><?php echo $this->lang->line('death_date'); ?></th>
                                        <td >
                                            <?php if((!empty($discharge_card)) && $discharge_card['death_date']!=''){ echo $this->customlib->YYYYMMDDHisTodateFormat($discharge_card['death_date']); }   ?>
                                        </td>
                                        <th ><?php echo $this->lang->line('death_report'); ?></th>
                                        <td >
                                            <?php if(!empty($deathrecord)){ echo $deathrecord['death_report'];  } ?>
                                        </td>
                                       
                                         </tr> 
                                    <tr>
                                   
                                        <th><?php echo $this->lang->line('Referral_Date'); ?></th>
                                        <td >
                                            <?php if((!empty($discharge_card)) && $discharge_card['refer_date']!=''){ echo $this->customlib->YYYYMMDDHisTodateFormat($discharge_card['refer_date']); }   ?>
                                        </td>
                                       

                                    
                                        <th ><?php echo $this->lang->line('referral_hospital_name'); ?></th>
                                        <td >
                                            <?php if((!empty($discharge_card)) && $discharge_card['refer_to_hospital']!=''){ echo $discharge_card['refer_to_hospital']; }   ?>
                                        </td>
                                       
                                        </tr>
                                    <tr>
                                   
                                        <th ><?php echo $this->lang->line('reason_for_referral'); ?></th>
                                        <td >
                                            <?php if((!empty($discharge_card)) && $discharge_card['reason_for_referral']!=''){ echo $discharge_card['reason_for_referral']; }   ?>
                                        </td>
                                       

                                    </tr>
                                    <?php 
                                    if(!empty($discharge_card['field_data'])){
                                    foreach ($discharge_card['field_data'] as $key => $value) {
                                        ?><tr> <th><?php echo $value['name']; ?></th><td><?php echo $value['field_value']; ?></td></tr>
                                        <?php
                                    }}
                                    ?>
                                    
          
                                </tbody>
                            </table>
                            <table class="print-table" style="text-align: left; padding-top: 10px;">
                                <tbody>
                                    <tr>
                                        <th><?php echo $this->lang->line('investigation'); ?></th>
                                        <th><?php echo $this->lang->line('treatment_at_home'); ?></th>
                                    </tr>
                                     <tr>
                                        <td><?php if(!empty($discharge_card)){ echo $discharge_card['investigations'];  } ?></td>
                                        <td><?php if(!empty($discharge_card)){ echo $discharge_card['treatment_home'];  } ?></td>
                                    </tr>
                                <tbody>
                            </table>
                      
                    </div>           
                </div>
                    </div>

                 
 <script type="text/javascript">
    
$('#allpayments_print').html(' <a href="javascript:void(0);"   class="print_dischargecard" data-recordId="<?php echo $discharge_card['id'];?>" data-case_id="<?php echo $case_id; ?>" ><i class="fa fa-print"></i> </a> ');

</script> 