<table class="table table-striped table-bordered noborder">
    <tbody>
        <tr>   
            <th width="25%"><?php echo $this->lang->line('bill_no'); ?></th>
            <td width="25%"><?php echo $this->customlib->getSessionPrefixByType('pathology_billing') .$result->pathology_bill_id; ?></td>
            <th width="25%"><?php echo $this->lang->line('patient'); ?></th>
            <td width="25%"><?php echo composePatientName($result->patient_name,$result->patient_id); ?></td>
        </tr>
        <tr>
            <th width="25%"><?php echo $this->lang->line('approve_date'); ?></th>
            <td width="25%"><?php echo $this->customlib->YYYYMMDDTodateFormat($result->parameter_update); ?></td>
            <th width="25%"><?php echo $this->lang->line('report_collection_date'); ?>:</th>
            <td width="25%"><?php echo $this->customlib->YYYYMMDDTodateFormat($result->collection_date); ?></td>    
        </tr>
        <tr>
            <th width="25%"><?php echo $this->lang->line('test_name'); ?></th>
            <td width="25%"><?php echo $result->test_name; ?></td>
            <th width="25%"><?php echo $this->lang->line('expected_date'); ?></th>
            <td width="25%"><?php echo $this->customlib->YYYYMMDDTodateFormat($result->reporting_date); ?></td>  
        </tr>
        <tr>
            <th width="25%"><?php echo $this->lang->line('collection_by'); ?></th>
            <td width="25%"><?php echo composeStaffNameByString($result->collection_specialist_staff_name,$result->collection_specialist_staff_surname,$result->collection_specialist_staff_employee_id); ?></td>  
            <th width="25%"><?php echo $this->lang->line('pathology_center'); ?></th>
            <td width="25%"><?php echo $result->pathology_center ?></td>   
        </tr>
    </tbody>
</table>
                    <div class="row">
                        <div class="col-md-12">   
                                             <h4 class="text-center">
      <strong><?php echo $result->test_name; ?></strong>
      <br/>
      <?php echo "(".$result->short_name.")"; ?>
</h4>           
                            <table class="table table-hover">
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
                        foreach ($result->pathology_parameter as $parameter_key=> $parameter_value) {
                            ?>                        
                        <tr>
                            <td><?php echo $row_counter; ?></td>
                            <td class="text-left">
                              <strong><?php echo $parameter_value->parameter_name; ?></strong>                                  
                              </td> 
                            <td class="text-center">
                            <strong>
                          <?php echo $parameter_value->reference_range." ".$parameter_value->unit_name; ?>
                            </strong>                                  
                              </td>
                             <td class="text-right">    
                           <?php echo $parameter_value->pathology_report_value." ".$parameter_value->unit_name;?>
                             </td>                             
                        </tr>
                               
                        <?php
                    $row_counter++;
                        }
                        ?>
                                
                             </tbody>
                          </table>
                        </div>
                    </div>
               

<script>
   $(document).ready(function(){
$("#modal_head").html("<?php echo $result->test_name.' ('.$result->short_name.')'; ?>");

});
</script>