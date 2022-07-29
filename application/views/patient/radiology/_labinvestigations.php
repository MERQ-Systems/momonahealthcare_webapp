<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">

<div class="print-area">
<div class="row">
        <div class="col-12">          
            <div class="card">
                <div class="card-body"> 
                    <div class="row">
                        <div class="col-md-12">                          
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
                        foreach ($result->radiology_parameter as $parameter_key=> $parameter_value) {
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
                           <?php echo $parameter_value->radiology_report_value." ".$parameter_value->unit_name;?>
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
                </div>
            </div>             
        </div>
    </div>
</div>
<script>
   $(document).ready(function(){
$("#modal_head").html("<?php echo $result->test_name.' ('.$result->short_name.' )'; ?>");

});
</script>