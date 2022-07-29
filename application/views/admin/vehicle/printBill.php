<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('bill'); ?></title>
        <style type="text/css">
            .printablea4{width: 100%;}
            /*.printablea4 p{margin-bottom: 0;}*/
            .printablea4>tbody>tr>th,
            .printablea4>tbody>tr>td{padding:2px 0; line-height: 1.42857143;vertical-align: top; font-size: 12px;}
        </style>
    </head>
    <div id="html-2-pdfwrapper">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="">
                    <?php if (!empty($print_details[0]['print_header'])) { ?>
                        <div class="pprinta4">
                            <img src="<?php
                            if (!empty($print_details[0]['print_header'])) {
                                echo base_url() . $print_details[0]['print_header'].img_time();
                            }
                            ?>" class="img-responsive" style="height:100px; width: 100%;">
                        </div>
                    <?php } ?>
                    <table width="100%" class="printablea4">
                        <tr>
                            <td align="text-left"><h5><?php echo $this->lang->line('bill_no'); ?> <?php echo $this->customlib->getSessionPrefixByType('ambulance_call_billing').$result["id"] ?></h5>
                            </td>
                            <td class="text-right"><h5><?php echo $this->lang->line('date') . " : "; ?><?php echo date($this->customlib->getHospitalDateFormat(true, true), strtotime($result['date'])) ?></h5>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr> 
                            <th width="20%"><?php echo $this->lang->line('patient_name'); ?></th>
                            <td width="25%"><?php echo composePatientName($result['patientname'],$result['patient_id']); ?></td>
                            <th width="25%"><?php echo $this->lang->line('driver_name'); ?></th>
                            <td width="30%" align="left"><?php echo $result["driver"]; ?></td>
                        </tr>
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('vehicle_number'); ?></th>
                            <td width="25%"><?php echo $result["vehicle_no"]; ?></td>
                            <th width="25%"><?php echo $this->lang->line('vehicle_model'); ?></th>
                            <td width="30%" align="left"><?php echo $result['vehicle_model']; ?></td> 
                        </tr>
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('case_id'); ?></th>
                            <td width="25%"><?php echo $result["case_reference_id"]; ?></td>
                            <th width="20%"><?php echo $this->lang->line('charge_category'); ?></th>
                            <td width="25%"><?php echo $result["charge_category_name"]; ?></td>
                        </tr>
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('charge_name'); ?></th>
                            <td width="25%"><?php echo $result["charge_name"]; ?></td>
                            <th width="20%"><?php echo $this->lang->line('collected_by'); ?></th>
                            <td width="25%"><?php echo composeStaffNameByString($result['name'], $result['surname'], $result['employee_id']); ?></td>
                        </tr>
                        <?php
                        if($print=='no'){

                          if (!empty($fields)) {
                    foreach ($fields as $fields_key => $fields_value) {
                        $display_field = $result["$fields_value->name"];
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $result["$fields_value->name"] . " target='_blank'>" . $result["$fields_value->name"] . "</a>";

                        }
                         ?>
                <tr>
                    <th width="10%"><?php echo $fields_value->name; ?></th> 
                    <td width="10%"><?php echo $display_field; ?></td>
                </tr>
                  <?php  }
                }
            }else{
                if (!empty($print_fields)) {
                    foreach ($print_fields as $fields_key => $fields_value) {

                        $display_field = $result["$fields_value->name"];
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $result["$fields_value->name"] . " target='_blank'>" . $result["$fields_value->name"] . "</a>";

                        }
                         ?>
                <tr>
                    <th width="10%"><?php echo $fields_value->name; ?></th> 
                    <td width="10%"><?php echo $display_field; ?></td>
                </tr>
                  <?php  }
                }
            }
                ?> 
                    </table>                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" style="width: 30%; float: right;">
                        <?php if (!empty($result["standard_charge"])) { ?>
                            <tr>
                                <th style="padding-bottom: 5px;"><?php echo $this->lang->line('standard_charge') . " (" . $currency_symbol . ")"; ?></th>
                                <td align="right" style="padding-bottom: 5px;"><?php echo number_format((float)$result["standard_charge"], 2, '.', ''); ?></td>
                            </tr>
                        <?php } ?>
                        
                        <?php if (!empty($result["amount"])) { ?>
                            <tr>
                                <th style="padding-bottom: 5px;"><?php echo $this->lang->line('amount') . " (" . $currency_symbol . ")"; ?></th>
                                <td align="right" style="padding-bottom: 5px;"><?php echo $result["amount"]; ?></td>
                            </tr>
                        <?php } ?>
                   
                        <?php if (!empty($result["tax_percentage"])) { ?>
                            <tr>
                                <th><?php
                                    echo $this->lang->line('tax') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>
                                <td align="right"><?php echo "(".$result["tax_percentage"]."%) ".calculatePercent($result["standard_charge"], $result["tax_percentage"]); ?></td>
                            </tr>
                        <?php } ?>
                        
                        <?php
                        if (!empty($result["net_amount"])) {
                       
                                ?>
                                <tr>
                                    <th><?php
                                        echo $this->lang->line('net_amount') . " (" . $currency_symbol . ")";            
                                        ?></th>
                                    <td align="right"><?php echo $result["net_amount"]; ?></td>
                                </tr>
                                <?php    
                        }
                        ?> 
                            <?php
                        if (!empty($result["total_paid"])) {
                       
                                ?>
                                <tr>
                                    <th><?php
                                        echo $this->lang->line('paid_amount') . " (" . $currency_symbol . ")";          
                                        ?></th>
                                    <td align="right"><?php echo $result["total_paid"]; ?></td>
                                </tr>
                                <?php
    
                        }
                        ?> 

                                <tr>
                                    <th><?php
                                        echo $this->lang->line('due_amount') . " (" . $currency_symbol . ")";
                                        ?></th>
                                    <td align="right"><?php echo amountFormat($result["net_amount"]-$result["total_paid"]); ?></td>
                                </tr>                  
                     
                    </table>
                         <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">  
                         <div class="table-responsive">          
                     <table class="" style="width: 100%; ">
                      <?php if (!empty($result["note"])) { ?>                            
                          <tr>
                                <td width="60%"><?php echo $this->lang->line('note'); ?>: <?php echo $result["note"]; ?></td>                 
                        <?php } ?>                        
                </table>
            </div>
                <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                </div>
            </div>
            <!--/.col (left) -->
        </div>
            <div class="row">
                <div class="col-md-12">                     
                    <p><?php
                        if (!empty($print_details[0]['print_footer'])) {
                            echo $print_details[0]['print_footer'];
                        }
                        ?></p>
                </div>
            </div>
    </div>
</html>

<script type="text/javascript">
    function delete_bill(id) {
        if (confirm('<?php echo $this->lang->line('delete_confirm'); ?>')) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/vehicle/deleteCallAmbulance/' + id,
                success: function (res) {
                    successMsg('<?php echo $this->lang->line('delete_message'); ?>');
                    window.location.reload(true);
                },
                error: function () {
                    alert("Fail")
                }
            });
        }
    } 
	
    function printData(id) {
        var base_url = '<?php echo base_url() ?>';
        $.ajax({
            url: base_url + 'admin/vehicle/getBillDetails/' + id,
            type: 'POST',
            data: {id: id, print: 'yes'},
            success: function (result) {
                popup(result);
            }
        });
    }

    function popup(data)
    {
        var base_url = '<?php echo base_url() ?>';
        var frame1 = $('<iframe />');
        frame1[0].name = "frame1";
        frame1.css({"position": "absolute", "top": "-1000000px"});
        $("body").append(frame1);
        var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
        frameDoc.document.open();
        //Create a new HTML document.
        frameDoc.document.write('<html>');
        frameDoc.document.write('<head>');
        frameDoc.document.write('<title></title>');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/bootstrap/css/bootstrap.min.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/dist/css/font-awesome.min.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/dist/css/ionicons.min.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/dist/css/AdminLTE.min.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/dist/css/skins/_all-skins.min.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/plugins/iCheck/flat/blue.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/plugins/morris/morris.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/plugins/jvectormap/jquery-jvectormap-1.2.2.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/plugins/datepicker/datepicker3.css">');
        frameDoc.document.write('<link rel="stylesheet" href="' + base_url + 'backend/plugins/daterangepicker/daterangepicker-bs3.css">');
        frameDoc.document.write('</head>');
        frameDoc.document.write('<body>');
        frameDoc.document.write(data);
        frameDoc.document.write('</body>');
        frameDoc.document.write('</html>');
        frameDoc.document.close();
        setTimeout(function () {
            window.frames["frame1"].focus();
            window.frames["frame1"].print();
            frame1.remove();
        }, 500);
        return true;
    }
</script>