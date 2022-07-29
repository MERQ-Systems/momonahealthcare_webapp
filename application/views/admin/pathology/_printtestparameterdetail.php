<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">

<div class="print-area">
<div class="row">
        <div class="col-12">
           <?php if (!empty($print_details[0]['print_header'])) { ?>
                        <div class="pprinta4">
                            <img src="<?php
                            if (!empty($print_details[0]['print_header'])) {
                                echo base_url() . $print_details[0]['print_header'].img_time();
                            }
                            ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php } ?>
            <div class="card">
                <div class="card-body">  
                    <div class="row">
                        <div class="col-md-6">                       
                              
                            <p><span class="font-bold"><?php echo $this->lang->line('bill_no'); ?>: </span> <?php echo $this->customlib->getSessionPrefixByType('pathology_billing').$head_result->id; ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('patient'); ?>:</span> <?php echo composePatientName($head_result->patient_name,$head_result->patient_id); ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('case_id'); ?> :</span> <?php echo $head_result->case_reference_id; ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('age'); ?> :</span> <?php echo $this->customlib->getPatientAge($head_result->age,$head_result->month,$head_result->day); ?></p>
                            <p><span class="font-bold"><?php echo $this->lang->line('gender'); ?> :</span> <?php echo $head_result->gender; ?></p>
                             <p><span class="font-bold"><?php echo $this->lang->line('doctor_name'); ?> :</span> <?php echo $head_result->doctor_name; ?></p>                
                            
                        </div>
                          <div class="col-md-6 text-right">                                             
                         <p><span class="font-bold"><?php echo $this->lang->line('date'); ?>: </span> <?php echo $this->customlib->YYYYMMDDHisTodateFormat($head_result->date, $this->customlib->getHospitalTimeFormat()); ?></p>                               
                        </div>                       
                    </div>
                    <?php foreach($result as $row){ ?>
                    <div class="row">
                        <div class="col-md-12">
                           <h4 class="text-center">
      <strong><?php echo $row['test_name']; ?></strong>
      <br/>
      <?php echo "(".$row['short_name'].")"; ?>
</h4>
                               <table class="print-table">
                             <thead>
                                <tr class="line">
                                   <td><strong>#</strong></td>
                                   <td class="text-left"><strong><?php echo $this->lang->line('test_parameter_name'); ?></strong></td>                                
                                   <td class="text-center"><strong><?php echo $this->lang->line('reference_range'); ?></strong></td>
                                   <td class="text-right"><strong><?php echo $this->lang->line('report_value'); ?></strong></td>
                                </tr>
                             </thead>
                             <tbody>
                                <?php
                      $row_counter=1;
                        foreach ($result[$row['id']]['pathology_parameter'] as $parameter_key=> $parameter_value) {
                              $row_cls="";
                  if($parameter_value->reference_range < $parameter_value->pathology_report_value)
                    {
                      $row_cls="bold";
                    }
                            ?>                        
                         <tr class="<?php echo $row_cls;?>">
                            <td><?php echo $row_counter; ?></td>
                            <td class="text-left"><?php echo $parameter_value->parameter_name; ?><br/>
                              <div class="bill_item_footer text-muted"><label><?php if($parameter_value->description !=''){ echo $this->lang->line('description').': ';} ?></label> <?php echo $parameter_value->description; ?></div></td> 
                            <td class="text-center"><?php echo $parameter_value->reference_range." ".$parameter_value->unit_name; ?></td>
                            <td class="text-right"><?php echo $parameter_value->pathology_report_value." ".$parameter_value->unit_name;?></td>                             
                        </tr>                               
                        <?php
                    $row_counter++;
                        }
                        ?>
                                
                             </tbody>
                          </table>
                        </div>
                    </div>
                  <?php } ?>
                </div>
            </div>
          <div style="clear:both"></div>
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