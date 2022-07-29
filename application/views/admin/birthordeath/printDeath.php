<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('birth_record'); ?></title>
        <style type="text/css">
            .printablea4{width: 100%;}
            .printablea4>tbody>tr>th,
            .printablea4>tbody>tr>td{padding:2px 0; line-height: 1.42857143;vertical-align: top; font-size: 12px;}
        </style>
    </head>
    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="">
                    <?php if (!empty($print_details[0]['print_header'])) {
    ?>
                        <div class="pprinta4">
                            <img src="<?php
if (!empty($print_details[0]['print_header'])) {
        echo base_url() . $print_details[0]['print_header'].img_time();
    }
    ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php }?>
                    <table width="100%" class="printablea4">
                        <tr>
                            <td align="text-left"><h5><?php echo $this->lang->line("reference_no") .": ". $prefix.$result["id"] ?></h5>
                            </td>
                            <td align="right"><h5><?php echo $this->lang->line('death_date') . " : "; ?><?php echo $this->customlib->YYYYMMDDHisTodateFormat($result['death_date']); ?></h5>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('patient') . " " . $this->lang->line('name'); ?></th>
                            <td width="25%"><?php echo composePatientName($result["patient_name"],$result["patient_id"]); ?></td>
                            <th width="20%"><?php echo $this->lang->line("case_id"); ?></th>
                            <td width="25%"><?php echo $result["case_reference_id"]; ?></td>
                            
                        </tr>
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('address'); ?></th>
                            <td width="25%"><?php echo $result["address"]; ?></td>
                            <th width="25%"><?php echo $this->lang->line('report'); ?></th>
                            <td width="30%" align="left"><?php echo $result['death_report']; ?></td>
                        </tr>
                        <tr>
                            <th width="25%"><?php echo $this->lang->line('gender'); ?></th>
                            <td width="30%" align="left"><?php echo $result["gender"]; ?></td>
                            <th width="25%"><?php echo $this->lang->line('guardian_name'); ?></th>
                            <td width="30%" align="left"><?php echo $result['guardian_name']; ?></td>
                        </tr>

                        <?php  if (!empty($fields)) {
                                foreach ($fields as $fields_key => $fields_value) {
                                    $display_field = $result["$fields_value->name"];
                                    if ($fields_value->type == "link") {
                                        $display_field = "<a href=" . $result["$fields_value->name"] . " target='_blank'>" . $result["$fields_value->name"] . "</a>";

                                    }
                                    ?>
                                <tr>
                                    <th style="font-size: 13px;"><?php echo $fields_value->name; ?></th> 
                                    <td width="10%"><?php echo $display_field; ?></td>
                                </tr>

                        <?php } } ?>
                    </table>

                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    
                    <p><?php
if (!empty($print_details[0]['print_footer'])) {
    echo $print_details[0]['print_footer'];
}
?></p>
                </div>
            </div>
            <!--/.col (left) -->
        </div>
    </div>
</html>