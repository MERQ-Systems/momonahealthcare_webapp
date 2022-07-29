<style type="text/css">
    @media print
    {
        .no-print, .no-print *
        {
            display: none !important;
        }
    }
</style>
<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"> <?php echo $this->lang->line('income_group_report'); ?></h3>
                        <div class="box-tools pull-right">

                        </div>

                    </div>
                    <div class="box-body">
                        <form role="form" id="form"  method="post" class="" action="<?php echo site_url('admin/income/getgroupreportparam') ?>" >
                            <div class="row">
                                <?php echo $this->customlib->getCSRF(); ?>
                                <div class="col-sm-6 col-md-3" >
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('search_type'); ?></label>
                                        <select class="form-control" name="search_type" onchange="showdate(this.value)">
                                            <option value=""><?php echo $this->lang->line('select') ?></option>
                                            <?php foreach ($searchlist as $key => $search) {
                                                ?>
                                                <option value="<?php echo $key ?>" <?php
                                                    if ((isset($search_type)) && ($search_type == $key)) {
                                                            echo "selected";
                                                        }
                                                        ?>><?php echo $search ?></option>
                                                    <?php }?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('search_type'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3" id="fromdate" style="display: none">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('date_from'); ?></label><small class="req"> *</small>
                                        <input id="date_from" name="date_from" placeholder="" type="text" class="form-control date" value="<?php echo set_value('date_from', date($this->customlib->getHospitalDateFormat())); ?>"  />
                                        <span class="text-danger"><?php echo form_error('date_from'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3" id="todate" style="display: none">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('date_to'); ?></label><small class="req"> *</small>
                                        <input id="date_to" name="date_to" placeholder="" type="text" class="form-control date" value="<?php echo set_value('date_to', date($this->customlib->getHospitalDateFormat())); ?>"  />
                                        <span class="text-danger"><?php echo form_error('date_to'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3" >
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('search_income_head'); ?></label>
                                        <select class="form-control" name="head" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php foreach ($headlist as $heads) {
    ?>
                                                <option value="<?php echo $heads['id'] ?>" <?php
if ((isset($head_id)) && ($head_id == $heads['id'])) {

        echo "selected";
    }
    ?>><?php echo $heads['income_category'] ?></option>
                                                    <?php }?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('search_type'); ?></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <button type="submit" name="search" value="search_filter" class="btn btn-primary btn-sm checkbox-toggle pull-right"><i class="fa fa-search"></i> <?php echo $this->lang->line('search'); ?></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="box border0 clear">
                            <div class="box-header ptbnull">
                            </div>
                        </div>
                        <div class="table-responsive mailbox-messages">
                            <div class="download_label"><?php echo $this->lang->line('income_group_report'); ?></div>
                            <table class="table table-striped table-bordered table-hover income-list" data-export-title="<?php echo $this->lang->line('income') . " " . $this->lang->line('group') . " " . $this->lang->line('report'); ?>">
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('income_head'); ?></th>
                                        <th><?php echo $this->lang->line('income_id'); ?></th>
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <th><?php echo $this->lang->line('date'); ?></th>
                                        <th><?php echo $this->lang->line('invoice_number'); ?></th>
                                        <?php 
                                        if (!empty($fields)) {
                                            foreach ($fields as $fields_key => $fields_value) {
                                                ?>
                                                <th><?php echo $fields_value->name; ?></th>
                                                <?php
                                            } 
                                        }
                                        ?>
                                        <th class="text text-right"><?php echo $this->lang->line('amount'); ?> <span><?php echo "(" . $currency_symbol . ")"; ?></span></th>
                                         
                                    </tr>
                                </thead>
                                <tbody>
                                 </tbody>
                            </table>
                        </div><!-- /.mail-box-messages -->
                    </div><!-- /.box-body -->
                </div>
            </div>
            <div class="col-md-8">

            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">

    $(document).ready(function () {
        $('#postdate').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true
        });
        $("#btnreset").click(function () {
            $("#form1")[0].reset();
        });
    });

    var base_url = '<?php echo base_url() ?>';
    function printDiv(elem) {
        Popup(jQuery(elem).html());
    }

    function Popup(data)
    {

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

<script>
    $(document).ready(function () {
        $('.detail_popover').popover({
            placement: 'right',
            trigger: 'hover',
            container: 'body',
            html: true,
            content: function () {
                return $(this).closest('td').find('.fee_detail_popover').html();
            }
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function (e) {

        showdate('<?php echo $search_type; ?>');
    });

    function showdate(value) {

        if (value == 'period') {
            $('#fromdate').show();
            $('#todate').show();
        } else {
            $('#fromdate').hide();
            $('#todate').hide();
        }
    }
</script>
<script>
$(document).ready(function() {
     emptyDatatable('income-list','data');
});
</script>  

<script type="text/javascript">
$(document).ready(function(){ 
$(document).on('submit','#form',function(e){
    e.preventDefault(); // avoid to execute the actual submit of the form.
   
    var $this = $(this).find("button[type=submit]:focus");  
    var form = $(this);
    var url = form.attr('action');
    var form_data = form.serializeArray();
    $.ajax({
           url: url,
           type: "POST",
           dataType:'JSON',
           data: form_data, // serializes the form's elements.
              beforeSend: function () {
                $('[id^=error]').html("");
                $this.button('loading');
               },
              success: function(response) { // your success handler
               
                if(!response.status){
                    $.each(response.error, function(key, value) {
                    $('#error_' + key).html(value);
                    });
                }else{
                 
                   initDatatable('income-list','admin/income/dtincomegroupreport',response.params);
                }
              },
             error: function() { // your error handler
                 $this.button('reset');
             },
             complete: function() {
               $this.button('reset');
             }
         });

        });

    });
     
</script>