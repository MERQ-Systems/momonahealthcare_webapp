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
                     <table class="printablea4" cellspacing="0" width="100%">
                        <tr>
                            <td width="33%" align="left"><?php echo $this->lang->line('recept')."# ".$result["id"]; ?></td>
                            <td width="33%" align="center"><?php echo $this->lang->line('bill')." ".$this->lang->line('no')."# ".$this->customlib->getSessionPrefixByType('radiology_billing').$result["id"]; ?></td>
                            <td width="33%" align="right"><?php echo $this->lang->line('date').": ".date($this->customlib->getHospitalDateFormat(true, false), strtotime($result["date"])); ?></td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                     <table class="printablea4" cellspacing="0" width="100%">
                        <tr>
                            <th width="10%"><?php echo $this->lang->line('patient')." ".$this->lang->line('id'); ?></th>
                            <td width="10%"><?php echo $result["patient_unique_id"]; ?></td>
                            <th width="10%"><?php echo $this->lang->line('name'); ?></th>
                            <td width="10%"><?php echo $result["patient_name"]; ?></td>
                            <th width="10%"><?php echo $this->lang->line('gender'); ?></th>
                            <td width="10%" align=""><?php echo $result["gender"] ; ?></td>
                            <th width="10%"><?php echo $this->lang->line('age'); ?></th>
                            <td width="10%" align=""><?php if (!empty($result['age'])) {
                               echo $result["age"]." ". $this->lang->line('years') ;
                            }  ?></td>
                        </tr>
                        <tr>
                            <th width="10%"><?php echo $this->lang->line('doctor'); ?></th>
                            <td width="10%" align=""><?php echo $result["doctor_name"]; ?></td> 
                            <th width="10%"><?php echo $this->lang->line('phone'); ?></th>
                            <td width="10%" align=""><?php echo $result["mobileno"] ; ?></td> 
                            <th width="10%"><?php echo $this->lang->line('email'); ?></th>
                            <td width="10%" align=""><?php echo $result["email"] ; ?></td>
                            <th width="10%"><?php echo $this->lang->line('address'); ?></th>
                            <td width="10%" align=""><?php echo $result["address"] ; ?></td> 
                        </tr> 
                        <tr>
                            <th width="10%"><?php echo $this->lang->line('blood_group'); ?></th>
                            <td width="10%" align=""><?php echo $result["blood_group"] ; ?></td> 
                        </tr> 
                        
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('test') . " " . $this->lang->line('name'); ?></th> 
                            <th><?php echo $this->lang->line('short') . " " . $this->lang->line('name'); ?></th>
                            <th><?php echo $this->lang->line('report') . " " . $this->lang->line('date'); ?></th>
                            <th class=""><?php echo $this->lang->line('amount'); ?></th>
                        </tr>
                       
                            <?php
                            foreach ($detail as $bill) {
                                ?>
                                <tr>
                                    <td width="20%"><?php echo $bill["test_name"]; ?></td>
                                    <td><?php echo $bill["short_name"]; ?></td>
                                    <td><?php echo date($this->customlib->getHospitalDateFormat(true,false), strtotime($bill["reporting_date"])); ?></td>
                                    <td class=""><?php echo $bill["apply_charge"]; ?></td>
                                </tr>
                            <?php
                            }
                            ?>
                       
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
            <table align="" class="printablea4" style="width: 40%; float: right;">
                
                        <?php if (!empty($result["total"])) {?>
                            <tr>

                                <th style="width: 30%;"><?php echo $this->lang->line('total') . " (" . $currency_symbol . ")"; ?></th>

                                <td align="right"><?php echo $result["total"]; ?></td>
                            </tr>
                        <?php }?>
                        <?php if (!empty($result["discount"])) {
    ?>
                            <tr>
                                <th><?php
echo $this->lang->line('discount') . " (" . $currency_symbol . ")";

    ?></th>

                                <td align="right"><?php echo $result["discount"]; ?></td>

                            </tr>
                        <?php }?>
                        <?php if (!empty($result["tax"])) {
    ?>
                            <tr>
                                <th><?php
echo $this->lang->line('tax') . " (" . $currency_symbol . ")";

    ?></th>

                                <td align="right"><?php echo $result["tax"]; ?></td>

                            </tr>
                        <?php }?>
                        <?php
                        if ((!empty($result["discount"])) && (!empty($result["tax"]))) {
                            if (!empty($result["net_amount"])) {
                                ?>
                        <tr>
                            <th><?php echo $this->lang->line('net_amount') . " (" . $currency_symbol . ")"; ?></th>

                            <td align="right"><?php echo $result["net_amount"]; ?></td>
                        </tr>
                                <?php
                        }
                        }
                        ?>
                        <?php if (!empty($result["total_deposit"])) {
                                ?>
                        <tr>
                            <th><?php echo $this->lang->line("paid_amount"); ?></th>

                            <td align="right"><?php echo $result["total_deposit"]; ?></td>
                        </tr>
                        <?php
                        } ?>
                        <tr>
                            <th><?php echo $this->lang->line("balance_amount"); ?></th>

                            <td align="right"><?php echo $result["net_amount"] - $result["total_deposit"] ; ?></td>
                        </tr>

                        <?php if (!empty($result["note"])) {?>
                         
                        <?php }

if (!$print) {
    ?>
                            <tr id="generated_by">

                                <th><?php echo $this->lang->line('collected_by'); ?></th>

                                <td align="right"><?php echo $result["generated_byname"]; ?></td>
                            </tr>
                        <?php
}
?>
                    </table>
                   
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px"> 
                    <table class="printablea4" width="100%" style="width:30%; float: right;">
                       
                        <?php if (($print) != 'yes') { ?>
                            <tr id="generated_by">

                                <th><?php echo $this->lang->line('collected_by'); ?></th>

                                <td align="right"><?php echo $result["generated_byname"]; ?></td>
                            </tr>
                        <?php } ?>
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
<script type="text/javascript">
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