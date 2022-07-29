<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('bill'); ?></title>     
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
                            <td align="text-left"><h5><b><?php echo $this->lang->line('bill'); ?></b>: <?php echo $this->customlib->getPatientSessionPrefixByType('ambulance_call_billing').$id ?></h5>
                            </td>
                            <td align="right"><h5><b><?php echo $this->lang->line('date'); ?> <?php echo date($this->customlib->getHospitalDateFormat(true, true), strtotime($result['date'])) ?></h5>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr> 
                            <th width="20%"><?php echo $this->lang->line('patient_name'); ?></th>
                            <td width="25%"><?php echo composePatientName($result['patient'],$result['patient_id']); ?></td>
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
                            <td width="25%"><?php echo composeStaffNameByString($result['staff_name'], $result['staff_surname'], $result['staff_employee_id']); ?></td>
                        </tr>
                        <?php

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

                ?> 
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" style="width: 30%; float: right;">

                        <?php if (!empty($result["amount"])) { ?>
                            <tr>
                                <th class="mb10"><?php echo $this->lang->line('amount') . " (" . $currency_symbol . ")"; ?></th>
                                <td align="right" class="mb10"><?php echo $result["amount"]; ?></td>
                            </tr>
                        <?php } ?>
                   
                        <?php if (!empty($result["tax_percentage"])) { ?>
                            <tr>
                                <th class="mb10"><?php
                                    echo $this->lang->line('tax') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>
                                <td class="mb10" align="right"><?php echo  "(".$result["tax_percentage"]."%) ".calculatePercent($result["standard_charge"], $result["tax_percentage"]); ?></td>
                            </tr>
                        <?php } ?>
                              <?php
                        if (!empty($result["net_amount"])) {
                      

                                ?>
                                <tr>
                                    <th class="mb10"><?php
                                        echo $this->lang->line('net_amount') . " (" . $currency_symbol . ")";
                                        ;
                                        ?></th>
                                    <td class="mb10" align="right"><?php echo $result["net_amount"]; ?></td>
                                </tr>
                                <?php
    
                        }
                        ?>

                              <?php if (!empty($result["paid_amount"])) { ?>
                            <tr>
                                <th class="mb10"><?php
                                    echo $this->lang->line('paid_amount') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>
                                <td class="mb10" align="right"><?php echo  $result["paid_amount"]; ?></td>
                            </tr>
                        <?php } ?>

                     <tr>
                                <th class="mb10"><?php
                                    echo $this->lang->line('due_amount') . " (" . $currency_symbol . ")";
                                    ;
                                    ?></th>
                                <td class="mb10" align="right"><?php echo  amountFormat($result["net_amount"]-$result["paid_amount"]); ?></td>
                            </tr>
                     
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                     <div class="table-responsive">       
                    <table style="width: 100%;">
                        <tr>
                        <?php if (!empty($result["note"])) { ?>
                             <td width="60%"><?php echo $this->lang->line('note') ." : ".$result["note"]; ?></td>
                         
                        <?php } ?>

                       
                        </tr>
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
    function printData(id) {
        var base_url = '<?php echo base_url() ?>';
        $.ajax({
            url: base_url + 'patient/dashboard/getBillDetailsAmbulance/' + id,
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