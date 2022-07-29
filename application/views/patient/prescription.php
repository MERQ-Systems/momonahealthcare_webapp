<link rel="stylesheet" href="<?php echo base_url(); ?>backend/dist/css/sh-print.css">
<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>

<div class="print-area">
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('prescription'); ?></title>
    </head>

    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="pprinta4">
                <?php  if (!empty($print_details['print_header'])) { ?>
                    <img src="<?php
                    if (!empty($print_details['print_header'])) {
                        echo base_url() . $print_details['print_header'].img_time();
                    }
                    ?>" style="height:100px; width:100%;" class="img-responsive">
                <?php }?>
                    <div style="height: 10px; clear: both;"></div>
                </div> 
                <div class="">
                    <?php
                    $date = $result->presdate;
                    ?>
                    <table width="100%" class="printablea4">
                        <tr>
                            <td><b><?php echo $this->lang->line('prescription'); ?> <?php echo $this->customlib->getPatientSessionPrefixByType('opd_prescription').$result->prescription_id; ?></b></td> <td></td>
                            <td class="text-right"></td> 
                            <td class="text-right"><b><?php echo $this->lang->line('date'); ?> : <?php
                                if (!empty($result->presdate)) {
                                    echo $this->customlib->YYYYMMDDTodateFormat($date);
                                }
                                ?></b>
                            </td>
                        </tr>

                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                    <table width="100%" class="printablea4">
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("opd_id"); ?></th>
                            <td width="25%"><?php echo $this->customlib->getPatientSessionPrefixByType('opd_no') .$result->opd_detail_id ; ?></td>
                            <th width="25%"><?php echo $this->lang->line("checkup_id"); ?></th>
                            <td width="25%"><?php echo $this->customlib->getPatientSessionPrefixByType('checkup_id') .$result->visitid ; ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("patient_name"); ?></th>
                            <td width="25%"><?php echo composePatientName($result->patient_name,$result->id); ?></td>
                            <th width="25%"><?php echo $this->lang->line("age"); ?></th>
                            <td><?php
                                echo $this->customlib->getPatientAge($result->age,$result->month,$result->day);
                                ?></td>
                        </tr>
                        <tr>                            
                            <th width="25%"><?php echo $this->lang->line("gender"); ?></th>
                            <td><?php echo $result->gender ?></td>
                            <th width="25%"><?php echo $this->lang->line("weight"); ?></th>
                            <td><?php echo $result->weight ?></td>
                        </tr>
                        <tr>                            
                            <th width="25%"><?php echo $this->lang->line("bp"); ?></th>
                            <td><?php echo $result->bp ?></td>
                            <th width="25%"><?php echo $this->lang->line("height"); ?></th>
                            <td><?php echo $result->height ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("phone"); ?></th>
                            <td width="25%"><?php echo $result->mobileno ?></td>   
                            <th width="25%"><?php echo $this->lang->line("email"); ?></th>
                            <td width="25%"><?php echo $result->email ?></td>
                        </tr>
                        <tr>                            
                            <th width="25%"><?php echo $this->lang->line("known_allergies"); ?></th>
                            <td><?php echo $result->known_allergies ?></td>                        
                            <th width="25%"><?php echo $this->lang->line("blood_group"); ?></th>
                            <td><?php echo $result->blood_group_name ?></td>
                        </tr>
                        <tr>                            
                            <th width="25%"><?php echo $this->lang->line("pulse"); ?></th>
                            <td><?php echo $result->pulse ?></td>                        
                            <th width="25%"><?php echo $this->lang->line("temperature"); ?></th>
                            <td><?php echo $result->temperature ?></td>
                        </tr>
                        <tr> 
                            <th><?php echo $this->lang->line('consultant_doctor'); ?></th><td><?php echo composeStaffNameByString($result->name, $result->surname, $result->doctor_id); ?></td>
                        </tr>
                        
                    </table>
                    <hr> 
                    <?php if($result->is_finding_print=='yes'){ $colspan = 6 ; $width = '50%'; }else{ $colspan = 12; $width = '100%';
                    
                    } ?>
                    <table width="100%" class="printablea4">

                        <tr>
<?php 
if($result->symptoms !=""){
    ?>
 <td colspan="<?php echo $colspan; ?>" width="<?php echo $width; ?>"><b><?php echo $this->lang->line("symptoms"); ?></b>:<br><?php echo nl2br($result->symptoms)  ?>
                        </td>
    <?php
}
?>
                            <?php 
                            if(trim($result->finding_description) !=''){
                            if($result->is_finding_print=='yes'){ ?> 
                                <td>                      
                            <b><?php echo $this->lang->line("finding"); ?></b>:<br>
                            <?php echo nl2br($result->finding_description)  ?>
                        </td>
                            <?php }} ?>
                        </tr>
                    </table>

                    <?php if(trim($result->finding_description) !='' || $result->symptoms !=''){
                     if($result->is_finding_print =='yes'){ ?>
                        <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                     <?php } } ?>

                    <table width="100%" class="printablea4">
                        <tr>
                            <td style="margin-bottom: 0;"><?php echo $result->header_note ?></td>
                        </tr>
                    </table>

               
                    <h4><?php echo $this->lang->line("medicines"); ?></h4>
                    <table class="table table-striped table-hover">                        
                        <tr>
                            <th width="2%" class="text text-left">#</th>
                            <th width="13%" class="text text-left"><?php echo $this->lang->line("medicine_category"); ?></th>
                            <th width="11%" class="text text-center"><?php echo $this->lang->line("medicine"); ?></th> 
                            <th width="13%" class="text text-center"><?php echo $this->lang->line("dosage"); ?></th>
                            <th width="13%" class="text text-center"><?php echo $this->lang->line("dose_interval"); ?></th>
                            <th width="13%" class="text text-center"><?php echo $this->lang->line("dose_duration"); ?></th> 
                            <th width="35%" class="text text-center"><?php echo $this->lang->line("instruction"); ?></th> 
                        </tr>

                        <?php $medsl =''; foreach ($result->medicines as $pkey => $pvalue) { $medsl++;
                              ?>
                            <tr>
                                <td class="text text-left"><?php echo $medsl; ?></td>
                                <td class="text text-left"><?php echo $pvalue->medicine_category; ?></td>
                                <td class="text text-center"><?php echo $pvalue->medicine_name; ?></td>
                                <td class="text text-center"><?php echo $pvalue->dosage." ".$pvalue->unit; ?></td>
                                <td class="text text-center"><?php echo $pvalue->dose_interval_name; ?></td>
                                <td class="text text-center"><?php echo $pvalue->dose_duration_name; ?></td>
                                <td class="text text-center"><?php echo $pvalue->instruction; ?></td>
                            </tr>  
                        <?php } ?>
                    </table>
                    
                    <?php if(!empty($result->tests)){

                         $r=$p=0;
                        foreach ($result->tests as $test_key => $test_value) {
                            if($test_value->test_name != ""){
                                $p=1;
                            }
                        }
                        foreach ($result->tests as $test_key => $test_value) {
                            if($test_value->radio_test_name != ""){
                                $r=1;
                            }
                        }
                     ?> 
                    <table width="100%" class="table table-striped table-hover">
                        <tr>
                           <?php 
                            if($p==1){
                                ?>
                                <th><?php echo $this->lang->line("pathology_test");  ?></th>
                                <?php
                            }
                            ?>
                            <?php 
                            if($r==1){
                                ?>
                                <th><?php echo $this->lang->line("radiology_test"); ?></th>
                                <?php
                            }
                            ?>
                        </tr>
                        <tr>
                            <?php 
                            if($p==1){
                                ?>
                            <td ><?php $sl=''; foreach ($result->tests as $test_key => $test_value) {  ?>
                                <table >   
                                    <?php if($test_value->test_name != ""){ $sl++;?> <tr>
                                    <td><?php echo $sl.'. '.$test_value->test_name." (".$test_value->short_name.")"; ?></td>   </tr>        
                                    <?php } ?>                             
                                </table>    
                                <?php } ?>
                            </td>
                            <?php }
                            if($r==1){
                                ?>
                            <td><?php $slradiology=''; foreach ($result->tests as $test_key => $test_value) {  ?>
                                <table>   
                                    <?php if($test_value->test_name == ""){ $slradiology++;?> <tr>
                                    <td><?php echo $slradiology.'. '.$test_value->radio_test_name." (".$test_value->radio_short_name.")"; ?></td> </tr>                                 
                                    <?php } ?>                             
                                </table>   
                                <?php } ?>
                            </td>
                             <?php } ?>
                        </tr>
                    </table>
                    <br>
                    <?php } ?>                     
                  
                    <table width="100%" class="printablea4">
                        <tr>
                            <td><?php echo $result->footer_note; ?></td>
                        </tr>
                    </table>

                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top:0px" />
                    <table width="100%" class="printablea4">
                        <tr>
                            <td><?php
                                if (!empty($print_details['print_footer'])) {
                                    echo $print_details['print_footer'];
                                }
                                ?></td>
                        </tr>   
                    </table>
                </div>
            </div>
            <!--/.col (left) -->
        </div>
    </div>
</div>