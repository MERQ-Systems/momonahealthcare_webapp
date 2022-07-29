<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>

<style type="text/css">
    @media print {
        .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12 {
            float: left;
        }
        .col-sm-12 {
            width: 100%;
        }
        .col-sm-11 {
            width: 91.66666667%;
        }
        .col-sm-10 {
            width: 83.33333333%;
        }
        .col-sm-9 {
            width: 75%;
        }
        .col-sm-8 {
            width: 66.66666667%;
        }
        .col-sm-7 {
            width: 58.33333333%;
        }
        .col-sm-6 {
            width: 50%;
        }
        .col-sm-5 {
            width: 41.66666667%;
        }
        .col-sm-4 {
            width: 33.33333333%;
        }
        .col-sm-3 {
            width: 25%;
        }
        .col-sm-2 {
            width: 16.66666667%;
        }
        .col-sm-1 {
            width: 8.33333333%;
        }
        .col-sm-pull-12 {
            right: 100%;
        }
        .col-sm-pull-11 {
            right: 91.66666667%;
        }
        .col-sm-pull-10 {
            right: 83.33333333%;
        }
        .col-sm-pull-9 {
            right: 75%;
        }
        .col-sm-pull-8 {
            right: 66.66666667%;
        }
        .col-sm-pull-7 {
            right: 58.33333333%;
        }
        .col-sm-pull-6 {
            right: 50%;
        }
        .col-sm-pull-5 {
            right: 41.66666667%;
        }
        .col-sm-pull-4 {
            right: 33.33333333%;
        }
        .col-sm-pull-3 {
            right: 25%;
        }
        .col-sm-pull-2 {
            right: 16.66666667%;
        }
        .col-sm-pull-1 {
            right: 8.33333333%;
        }
        .col-sm-pull-0 {
            right: auto;
        }
        .col-sm-push-12 {
            left: 100%;
        }
        .col-sm-push-11 {
            left: 91.66666667%;
        }
        .col-sm-push-10 {
            left: 83.33333333%;
        }
        .col-sm-push-9 {
            left: 75%;
        }
        .col-sm-push-8 {
            left: 66.66666667%;
        }
        .col-sm-push-7 {
            left: 58.33333333%;
        }
        .col-sm-push-6 {
            left: 50%;
        }
        .col-sm-push-5 {
            left: 41.66666667%;
        }
        .col-sm-push-4 {
            left: 33.33333333%;
        }
        .col-sm-push-3 {
            left: 25%;
        }
        .col-sm-push-2 {
            left: 16.66666667%;
        }
        .col-sm-push-1 {
            left: 8.33333333%;
        }
        .col-sm-push-0 {
            left: auto;
        }
        .col-sm-offset-12 {
            margin-left: 100%;
        }
        .col-sm-offset-11 {
            margin-left: 91.66666667%;
        }
        .col-sm-offset-10 {
            margin-left: 83.33333333%;
        }
        .col-sm-offset-9 {
            margin-left: 75%;
        }
        .col-sm-offset-8 {
            margin-left: 66.66666667%;
        }
        .col-sm-offset-7 {
            margin-left: 58.33333333%;
        }
        .col-sm-offset-6 {
            margin-left: 50%;
        }
        .col-sm-offset-5 {
            margin-left: 41.66666667%;
        }
        .col-sm-offset-4 {
            margin-left: 33.33333333%;
        }
        .col-sm-offset-3 {
            margin-left: 25%;
        }
        .col-sm-offset-2 {
            margin-left: 16.66666667%;
        }
        .col-sm-offset-1 {
            margin-left: 8.33333333%;
        }
        .col-sm-offset-0 {
            margin-left: 0%;
        }
        .visible-xs {
            display: none !important;
        }
        .hidden-xs {
            display: block !important;
        }
        table.hidden-xs {
            display: table;
        }
        tr.hidden-xs {
            display: table-row !important;
        }
        th.hidden-xs,
        td.hidden-xs {
            display: table-cell !important;
        }
        .hidden-xs.hidden-print {
            display: none !important;
        }
        .hidden-sm {
            display: none !important;
        }
        .visible-sm {
            display: block !important;
        }
        table.visible-sm {
            display: table;
        }
        tr.visible-sm {
            display: table-row !important;
        }
        th.visible-sm,
        td.visible-sm {
            display: table-cell !important;
        }
    }

    .printablea4{width: 100%;}
    .printablea4>tbody>tr>th,
    .printablea4>tbody>tr>td{padding:2px 0; line-height: 1.42857143;vertical-align: top; font-size: 12px;}
</style>


<!-- <div class="print-area"> -->
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
                            <th><?php echo $this->lang->line('prescription'); ?>: <?php echo $this->customlib->getSessionPrefixByType('ipd_prescription').$result->prescription_id; ?></th> <td></td>
                            <th class="text-right"></th>
                            <th class="text-right"><?php echo $this->lang->line('date'); ?> : <?php
                                if (!empty($result->presdate)) {
                                    echo $this->customlib->YYYYMMDDTodateFormat($date);
                                }
                                ?>
                            </th>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                    <table width="100%" class="printablea4">
                        <tr>
                            <th width=""><?php echo $this->lang->line("patient_name"); ?></th>
                            <td width=""><?php echo composePatientName($result->patient_name,$result->id); ?></td>
                            <th width=""><?php echo $this->lang->line("age"); ?></th>
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
                            <th width="25%"><?php echo $this->lang->line("phone"); ?></th>
                            <td><?php echo $result->mobileno ?></td>
                        </tr>
                        <tr>        
                            <th width="25%"><?php echo $this->lang->line("blood_group"); ?></th>
                            <td width="25%"><?php echo $result->blood_group_name ?></td>
                            <th width="25%"><?php echo $this->lang->line("pulse"); ?></th>
                            <td><?php echo $result->pulse; ?></td>
                        </tr>
                        <tr>        
                            <th width="25%"><?php echo $this->lang->line("height"); ?></th>
                            <td width="25%"><?php echo $result->height ?></td>
                            <th><?php echo $this->lang->line('temperature'); ?></th>
                            <td><?php echo $result->temperature; ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("email"); ?></th>
                            <td width="25%"><?php echo $result->email ?></td>
                            <th><?php echo $this->lang->line('consultant_doctor'); ?></th>
                            <td><?php echo composeStaffNameByString($result->name,$result->surname,$result->employee_id); ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("generated_by"); ?></th>
                            <td width="25%"><?php echo composeStaffNameByString($result->staff_name,$result->staff_surname,$result->staff_employee_id); ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line("prescribe_by"); ?></th>
                            <td width="25%"><?php echo composeStaffNameByString($result->priscribe_by_name,$result->priscribe_by_surname,$result->priscribe_by_employee_id); ?></td>
                        </tr>
                    </table>
                    <hr> 
                    <?php if($result->is_finding_print=='yes'){ $colspan = 6 ; $width = '50%'; }else{ $colspan = 12; $width = '100%';
                    
                    } ?>

 <?php
                    if($result->symptoms !='' && trim($result->finding_description) != ''){
                        
$width = '50%';
                    }else{
                        
$width = '100%';
                    }

                    ?>
                    <table width="100%" class="printablea4">
                        <tr>
                            <?php if($result->symptoms !=''){ ?>
                                <td width="<?php echo $width; ?>">
                                    <b><?php echo $this->lang->line("symptoms"); ?></b>:<br><?php echo nl2br($result->symptoms)  ?>
                                </td>
                            <?php } ?>

                            <?php if(trim($result->finding_description) != ''){ ?>
                           
                           <td width="<?php echo $width; ?>">                   
                                <b><?php echo $this->lang->line("finding"); ?></b>:<br>
                                <?php echo nl2br($result->finding_description); ?>
                            </td>
                            <?php 
                        }
                         ?>
                        </tr>
                    </table>  
                    
                    <?php if(trim($result->finding_description) !='' || $result->symptoms !=''){ ?>
                      <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                    <?php } ?>

                    <table width="100%" class="printablea4">
                        <tr>
                            <td style="margin-bottom: 0;"><?php echo $result->header_note ?></td>
                        </tr>
                    </table>
               
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px" />
                    <h4><?php echo $this->lang->line("medicines"); ?></h4>

                    <table class="table table-striped table-hover">                        
                            <tr>
                                <th width="2%" class="text text-left">#</th>
                                <th width="13%" class="text text-left"><?php echo $this->lang->line("medicine_category"); ?></th>
                                <th width="11%" class="text text-center"><?php echo $this->lang->line("medicine"); ?></th> 
                                <th width="13%" class="text text-center"><?php echo $this->lang->line("dosage"); ?></th>
                                <th width="13%" class="text text-center"><?php echo $this->lang->line("dose_interval"); ?></th>
                                <th width="13%" class="text text-center"><?php echo $this->lang->line("dose_duration"); ?></th> 
                                <th width="20%" class="text text-center"><?php echo $this->lang->line("instruction"); ?></th> 
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
                            if($test_value->test_name == ""){
                                $r=1;
                            }
                        }
                    ?>    
                    <table class="table table-striped table-hover" width="100%">
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
                                    <?php if($test_value->test_name == ""){ $slradiology++; ?> <tr>
                                    <td><?php echo $slradiology.'. '.$test_value->radio_test_name." (".$test_value->radio_short_name.")"; ?></td> </tr>                                 
                                    <?php } ?>                             
                                </table>   
                                <?php } ?>
                            </td>
                        <?php } ?>
                        </tr>
                    </table>
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
</html>