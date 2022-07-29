<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('bill'); ?></title>
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

                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <th width="15%"><?php echo $this->lang->line('name'); ?></th>
                            <td width="20%"><?php echo $result["patient_name"]; ?></td>
                            <th width="15%"><?php echo $this->lang->line('age'); ?></th>
                            <td width="20%" align="left"><?php
if (!empty($result["age"])) {
    echo $result['age'] . "  Years";
}
if (!empty($result['month'])) {
    echo $result["month"] . " Month";
}?>

                            </td>
                            <th width="10%"><?php echo $this->lang->line('gender'); ?></th>
                            <td width="20%" align="left"><?php echo $result["gender"]; ?></td>
                        </tr>
                         <tr>
                            <th width="20%"><?php echo $this->lang->line('admission') . " " . $this->lang->line('date'); ?></th>
                            <td width="25%"><?php echo date($this->customlib->getHospitalDateFormat(true, true), strtotime($result['date'])); ?></td>
                            <th><?php echo $this->lang->line('discharged') . " " . $this->lang->line('date'); ?></th>
                            <td width="30%" align="left"><?php echo date($this->customlib->getHospitalDateFormat(true, false), strtotime($result['discharge_date'])); ?></td>

                        </tr>
                        <tr>
                            <th width="20%"><?php echo $this->lang->line('diagnosis'); ?></th>
                            <td width="25%"><?php echo $result["disdiagnosis"]; ?></td>
                            <th><?php echo $this->lang->line('operation'); ?></th>
                            <td width="30%" align="left"><?php echo $result["disoperation"]; ?></td>
                        </tr>
                         <tr>
                            <th width="20%"><?php echo $this->lang->line('address'); ?></th>
                            <td width="25%"><?php echo $result['address']; ?></td>
                        </tr>
                          <tr>
                            <th><?php echo $this->lang->line('note'); ?></th>
                            <td width="30%" align="left"><?php echo nl2br($result['summary_note']); ?></td>
                        </tr>
                    </table>
                    <hr style="height: 1px; clear: both;margin-bottom: 10px; margin-top: 10px">
                    <table class="printablea4" id="testreport" width="100%">
                    <tr>
                        <th width="40%"><?php echo $this->lang->line('investigations') . " " . $this->lang->line('date'); ?></th>
                        <th><?php echo $this->lang->line('treatment_at_home'); ?></th>
                    </tr>
                    <tr>
                        <td width="40%"><?php echo nl2br($result["summary_investigations"]); ?></td>
                        <td><?php echo nl2br($result["summary_treatment_home"]); ?></td>
                    </tr>
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

  function printData(insert_id,ipdid) {
        $.ajax({
            url: '<?php echo base_url() ?>patient/dashboard/getsummaryDetails',
            type: 'POST',
            data: {id: insert_id,ipdid: ipdid,print: 'yes'},
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