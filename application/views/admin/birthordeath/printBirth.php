<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('birth_record'); ?></title>
        <style type="text/css">
            body{font-size: 12px;}
            .printablea4{width: 100%;}

            .printablea4 table tr th,
            .printablea4 table tr td{vertical-align: top; font-size: 12px;}
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
                            <td style="padding-top: 5px; font-size: 12px;"><?php echo $this->lang->line('reference_no') . ": " . $this->customlib->getSessionPrefixByType('birth_record_reference_no').$result['id']; ?></td>
                            <td style="padding-top: 5px; text-align: right;font-size: 12px;" align="result"><?php echo $this->lang->line('birth_date') . " : "; ?><?php echo $this->customlib->YYYYMMDDHisTodateFormat($result['birth_date']); ?>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <th width="20%"><?php echo $this->lang->line('child_name'); ?></th>
                                        <td width="25%" ><?php echo $result["child_name"]; ?></td>
                                    </tr>
                                    <tr>
                                        <th valign="top" width="20%"><?php echo $this->lang->line('gender'); ?></th>
                                        <td valign="top" width="25%"><?php echo $result["gender"]; ?></td>
                                        <th valign="top" width="25%"><?php echo $this->lang->line('weight'); ?></th>
                                        <td valign="top" width="30%" align="left"><?php echo $result['weight']; ?></td>
                                    </tr>
                                    <tr>
                                        <th width="25%"><?php echo $this->lang->line('mother_name'); ?></th>
                                        <td width="30%" align="left"><?php echo $result["patient_name"]. ' ('.$result["patient_id"].')'; ?></td>
                                        <th width="20%"><?php echo $this->lang->line('case_id'); ?></th>
                                        <td width="25%"><?php echo $result["case_reference_id"]; ?></td>
                                    </tr>
                                    <tr>
                                        <th width="20%"><?php echo $this->lang->line('father_name'); ?></th>
                                        <td width="25%"><?php echo $result["father_name"]; ?></td>
                                        <th width="25%"><?php echo $this->lang->line('address'); ?></th>
                                        <td width="30%" align="left"><?php echo $result['address']; ?></td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" valign="top" width="20%">
                                <?php
$picdemo = "uploads/patient_images/no_image.png";
if ($result['child_pic'] !== $picdemo) {
    ?>
                                    <img  style="height: 60px;" class="" src="<?php echo base_url() . $result['child_pic'].img_time() ?>" id="image" alt="User profile picture">
                                <?php }?>
                            </td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table cellspacing="0" cellpadding="0">

                     <?php  if (!empty($fields)) {
                                foreach ($fields as $fields_key => $fields_value) {
                                    $display_field = $result["$fields_value->name"];
                                    if ($fields_value->type == "link") {
                                        $display_field = "<a href=" . $result["$fields_value->name"] . " target='_blank'>" . $result["$fields_value->name"] . "</a>";

                                    }
                                    ?>
                                <tr>
                                    <th width="1%"><?php echo $fields_value->name; ?></th> 
                                    <td width="1%"><?php echo $display_field; ?></td>
                                </tr>

                        <?php }
                    }?>

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