<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<div class="content-wrapper" style="min-height: 946px;">   

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><?php echo $this->lang->line('staff_payroll'); ?></h3>             
                    </div>
                    <form id='form1' action="<?php echo site_url('admin/payroll') ?>"  method="post" accept-charset="utf-8">
                        <div class="box-body">
                            <div class="row"> 
                               <?php  if($this->session->flashdata('msg')){ ?> <div>  <?php echo $this->session->flashdata('msg') ?> </div> <?php $this->session->unset_userdata('msg'); }   ?>
                                <?php echo $this->customlib->getCSRF(); ?>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">
                                            <?php echo $this->lang->line("staff_role"); ?>
                                        </label>
                                        <select  onchange="getEmployeeName(this.value)" id="role" name="role" class="form-control" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($classlist as $key => $class) {

                                                if (isset($_POST["role"])) {
                                                    $role_selected = $_POST["role"];
                                                } else {
                                                    $role_selected = '';
                                                }
                                                ?>
                                                <option value="<?php echo $class["type"] ?>" 
                                                <?php
                                                if ($class["type"] == $role_selected) {
                                                    echo "selected";
                                                }
                                                ?> ><?php print_r($class["type"]) ?></option>
                                                        <?php
                                                    }
                                                    ?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('role'); ?></span>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('month') ?></label>

                                        <select autofocus="" id="class_id" name="month" class="form-control" >
                                            <option value="select"><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            if (isset($month)) {
                                                $month_selected = date("F", strtotime($month));
                                            } else {
                                                $month_selected = date("F", strtotime("-1 month"));
                                            }
                                            foreach ($monthlist as $m_key => $month_value) {
                                                ?>
                                                <option value="<?php echo $m_key ?>" <?php
                                                if ($month_selected == $m_key) {
                                                    echo "selected =selected";
                                                }
                                                ?>><?php echo $this->lang->line(strtolower($month_value)); ?></option>
                                                        <?php
                                                    }
                                                    ?>    

                                        </select>
                                        <span class="text-danger"><?php echo form_error('month'); ?></span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('year'); ?></label>
                                        <?php
                                        if (isset($year)) {
                                            $selected_year = $year;
                                        } else {
                                            $selected_year = date('Y');
                                        }
                                        ?>
                                        <select autofocus="" id="class_id" name="year" class="form-control" >
                                            <option value="select"><?php echo $this->lang->line('select'); ?></option>
                                            <option  <?php
                                            if (date("Y", strtotime("-1 year")) == $selected_year) {
                                                echo "selected";
                                            }
                                            ?> value="<?php echo date("Y", strtotime("-1 year")) ?>"><?php echo date("Y", strtotime("-1 year")) ?></option>
                                            <option <?php
                                            if (date("Y") == $selected_year) {
                                                echo "selected";
                                            }
                                            ?>  value="<?php echo date("Y") ?>"><?php echo date("Y") ?></option>
                                        </select>

                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" name="search" value="search" class="btn btn-primary btn-sm pull-right checkbox-toggle"><i class="fa fa-search"></i> <?php echo $this->lang->line('search'); ?></button>
                        </div>

                    </form>

                    <?php
                    if (isset($resultlist)) {
                        ?>
                        <div class="ptbnull"></div>  
                        <div class="box border0 clear">
                            <div class="box-body table-responsive">

                                <div class="download_label"><?php echo $this->lang->line('staff_list'); ?></div>
                                <table class="table table-striped table-bordered table-hover example">
                                    <thead>
                                        <tr>
                                            <th><?php echo $this->lang->line('staff_id'); ?></th>
                                            <th><?php echo $this->lang->line('staff_name'); ?></th>
                                            <th><?php echo $this->lang->line('staff_role'); ?></th>
                                            <th><?php echo $this->lang->line('staff_department'); ?></th>
                                            <th><?php echo $this->lang->line('staff_designation'); ?></th>
                                            <th><?php echo $this->lang->line('staff_phone'); ?></th>
                                            <th><?php echo $this->lang->line('status'); ?></th>
                                            <th class="text-right noExport"><?php echo $this->lang->line('action'); ?></th>
                                        </tr>
                                    </thead>            
                                    <tbody>    
                                        <?php
                                        $count = 1;
                                        foreach ($resultlist as $staff) {
                                            $status = $staff["status"];

                                            if ($staff["status"] == "paid") {
                                                $label = "class='label label-success'";
                                                $wstatus = $payroll_status[$staff["status"]];
                                            } else if ($staff["status"] == "generated") {
                                                $label = "class='label label-warning'";
                                                $wstatus = $payroll_status[$staff["status"]];
                                            } else {
                                                $label = "class='label label-default'";
                                                $wstatus = $payroll_status["not_generate"];
                                            }
                                            ?>
                                            <tr>
                                                <td><?php echo $staff['employee_id']; ?></td>
                                                <td><?php echo $staff['name'] . " " . $staff['surname']; ?></td>
                                                <td><?php echo $staff['user_type']; ?></td>
                                                <td><?php echo $staff['department']; ?></td>
                                                <td><?php echo $staff['designation']; ?></td>
                                                <td><?php echo $staff['contact_no']; ?></td>
                                                <td><small <?php echo $label; ?>><?php echo $wstatus; ?></small></td>
                                                <?php if ($status == "paid") { ?>

                                                    <td class="pull-right no-print">
                                                        <?php
                                                        if ($this->rbac->hasPrivilege('staff_payroll', 'can_add')) {
                                                            ?>
                                                            <a class="btn btn-default btn-xs" onclick="return confirm('<?php echo $this->lang->line('are_you_sure_you_want_to_revert_this_record') ?>')" href="<?php echo base_url() . "admin/payroll/revertpayroll/" . $staff["payslip_id"] . "/" . $month_selected . "/" . date("Y") . "/" . $role_selected ?>" title="Revert">
                                                                <i class="fa fa-undo"> </i>
                                                            </a>
                                                        <?php } ?>
                                                        <a href="#" onclick="getPayslip('<?php echo $staff["payslip_id"]; ?>')"  role="button" class="btn btn-primary btn-xs checkbox-toggle edit_setting" data-toggle="tooltip" title="<?php echo $this->lang->line('payslip_view'); ?>" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> Processing"><?php echo $this->lang->line('view'); ?> <?php echo $this->lang->line('staff_payslip'); ?></a>


                                                    <?php } ?></td>
                                                <?php if ($status == "generated") { ?>

                                                    <td class="pull-right no-print">
            <a href="<?php echo site_url('admin/payroll/edit/'.$staff["payslip_id"]) ?>" class="btn btn-default btn-xs"  data-toggle="tooltip" title="<?php echo $this->lang->line('edit') ?>">
                                                                <i class="fa fa-pencil"> </i>
                                                            </a>
                                                        <?php
                                                        if ($this->rbac->hasPrivilege('staff_payroll', 'can_delete')) {
                                                            ?>
                                                            <a href="<?php echo base_url() ?>admin/payroll/deletepayroll/<?php echo $staff["payslip_id"] . "/" . $month_selected . "/" . date("Y") . "/" . $role_selected ?>" class="btn btn-default btn-xs" onclick="return confirm('<?php echo $this->lang->line('are_you_sure_you_want_to_revert_this_record') ?>')" data-toggle="tooltip" title="<?php echo $this->lang->line('revert') ?>">
                                                                <i class="fa fa-undo"> </i>
                                                            </a>
                                                            <?php
                                                        }
                                                        if ($this->rbac->hasPrivilege('staff_payroll', 'can_add')) {
                                                            ?>
                                                            <a href="#" onclick="getRecord('<?php echo $staff["id"] ?>', '<?php echo $year ?>')" role="button" class="btn btn-primary btn-xs checkbox-toggle edit_setting" data-toggle="tooltip" title="<?php echo $this->lang->line('proceed_to_payment'); ?>" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> Processing"><?php echo $this->lang->line('proceed_to_pay'); ?></a>

                                                            <?php
                                                        }
                                                    }
                                                    ?></td>

                                                <?php if ($staff["payslip_id"] == 0) { ?>

                                                    <td class="pull-right no-print">
                                                        <?php
                                                        if ($this->rbac->hasPrivilege('staff_payroll', 'can_add')) {
                                                            ?>
                                                            <a class="btn btn-primary btn-xs checkbox-toggle edit_setting" role="button" href="<?php echo base_url() . "admin/payroll/create/" .strtolower($month_selected) . "/" . $year . "/" . $staff["id"] ?>"><?php echo $this->lang->line('generate'); ?> <?php echo $this->lang->line('staff_payroll'); ?></a>
                                                        <?php } ?>
                                                    </td>
                                                <?php } ?>
                                            </tr>
                                            <?php
                                        }
                                        $count++;
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>  
                    <?php
                }
                ?>
            </div>
            <form action="<?php echo base_url('admin/payroll/create') ?>" method="post" id="formsubmit">
                <input type="hidden" name="month" id="month">
                <input type="hidden" name="year" id="year">
                <input type="hidden" name="staffid" id="staffid">
            </form>
        </div> 

    </section>
</div>

<div id="payslipview"  class="modal fade" role="dialog">

    <div class="modal-dialog modal-dialog2 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('details'); ?>   <span id="print"></span></h4>
            </div>
            <div class="modal-body" id="testdata">


            </div>
        </div>
    </div>
</div>


<div id="proceedtopay" class="modal fade " role="dialog">
    <div class="modal-dialog modal-dialog2 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('proceed_to_pay'); ?></h4>
            </div>
            <div class="modal-body">

                <div class="row">
                    <form role="form" id="schsetting_form" action="<?php echo site_url('admin/payroll/paymentSuccess') ?>" enctype="multipart/form-data">

                        <div class="form-group  col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1">
                                <?php echo $this->lang->line('staff'); ?> <?php echo $this->lang->line('Name'); ?></label>
                            <input type="text" name="emp_name" readonly class="form-control" id="emp_name">

                        </div>
                        <div class="form-group  col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1"><?php echo $this->lang->line('payment'); ?> <?php echo $this->lang->line('amount').' ('.$currency_symbol.')'; ?></label>
                            <input type="text" name="amount" readonly class="form-control" id="amount">
                        </div>

                        <div class="form-group  col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1">
                                <?php echo $this->lang->line("month") ?> <?php echo $this->lang->line('year'); ?></label> 
                            <input id="monthid" name="month" readonly placeholder="" type="text" class="form-control" />
                            <input  name="paymentmonth" placeholder="" type="hidden" class="form-control" />
                            <input name="paymentyear" placeholder="" type="hidden" class="form-control" />
                            <input name="paymentid" placeholder="" type="hidden" class="form-control" />

                            <input name="staff_id" placeholder="" type="hidden" class="form-control" />
                            <input name="staff_role" placeholder="" type="hidden" class="form-control" />
                           <!-- <input name="staff_name" placeholder="" type="text" class="form-control" /> -->
                        </div>
                        <div class="form-group col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1"><?php echo $this->lang->line('payment'); ?> <?php echo $this->lang->line('mode'); ?></label><span class="req"> *</span><br/><span id="remark">
                            </span>
                            <select name="payment_mode" id="payment_mode"  class="form-control payment_mode">
                                <option value=""><?php echo $this->lang->line('select'); ?></option>
                                <?php
                                foreach ($payment_mode as $pkey => $pvalue) {
                                    ?>
                                    <option value="<?php echo $pkey ?>"><?php echo $pvalue ?></option>
                                    <?php
                                }
                                ?>

                            </select>
                            <span class="text-danger"><?php echo form_error('payment_mode'); ?></span>
                        </div>

                        <div class="cheque_div" style="display: none;">
                           
                             <div class="col-md-4">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('cheque_no'); ?></label><small class="req"> *</small> 
                                    <input type="text" name="cheque_no" id="cheque_no" class="form-control">
                                    <span class="text-danger"><?php echo form_error('cheque_no'); ?></span>
                                </div> 
                            </div>
                              <div class="col-md-4">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('cheque_date'); ?></label><small class="req"> *</small> 
                                    <input type="text" name="cheque_date" id="cheque_date" class="form-control date">
                                    <span class="text-danger"><?php echo form_error('cheque_date'); ?></span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label><?php echo $this->lang->line('attach_document'); ?></label>
                                    <input type="file" class="filestyle form-control"   name="document">
                                    <span class="text-danger"><?php echo form_error('document'); ?></span> 
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1"><?php echo $this->lang->line('payment'); ?> <?php echo $this->lang->line('date'); ?></label><br/><span id="remark"> </span>
                            <input type="text" name="payment_date" id="payment_date" class="form-control date" value="<?php echo date($this->customlib->getHospitalDateFormat()) ?>">
                        </div>

                        <div class="form-group col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <label for="exampleInputEmail1"><?php echo $this->lang->line('note'); ?></label><br/><span id="remark"> </span>
                            <textarea name="remarks" class="form-control" ></textarea>
                        </div>

                        <div class="clearfix"></div>
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <button type="submit" class="btn btn-primary submit_schsetting pull-right" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> Processing"><i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                        </div>


                    </form>                  
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">


    function getRecord(id, year) {

        $('input[name="amount"]').val('');
        $('input[name="emp_name"]').val('');
        $('input[name="paymentid"]').val('');
        $('input[name="paymentmonth"]').val('');
        $('input[name="paymentyear"]').val('');
        $('#monthid').val('');

        var month = '<?php echo $month_selected ?>';
        var base_url = '<?php echo base_url() ?>';
        $.ajax({
            url: base_url + 'admin/payroll/paymentRecord',
            type: 'POST',
            data: {staffid: id, month: month, year: year},
            dataType: "json",
            success: function (result) {
                $('input[name="amount"]').val(result.result.net_salary);
                $('input[name="emp_name"]').val(result.result.name + ' ' + result.result.surname + ' (' + result.result.employee_id + ')');
                $('input[name="paymentid"]').val(result.result.id);
                $('input[name="paymentmonth"]').val(month);
                $('input[name="paymentyear"]').val(year);
                $('input[name="staff_id"]').val(id);
                $('input[name="staff_role"]').val(result.result.role);
                $('#monthid').val(month + '-' + year);
            }
        });


        $('#proceedtopay').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });

    }
    ;


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

    function getPayslip(id) {



        var base_url = '<?php echo base_url() ?>';
        $.ajax({
            url: base_url + 'admin/payroll/payslipView',
            type: 'POST',
            data: {payslipid: id},
            success: function (result) {
                $("#print").html("<a href='#' data-toggle='tooltip' class='pull-right modal-title moprint' onclick='printData(" + id + ")'  title='<?php echo $this->lang->line('print') ?>'><i class='fa fa-print'></i></a>");
                $("#testdata").html(result);

            }
        });



        $('#payslipview').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });

    }
    ;

    function printData(id) {

        var base_url = '<?php echo base_url() ?>';
        $.ajax({
            url: base_url + 'admin/payroll/payslipView',
            type: 'POST',
            data: {payslipid: id},
            success: function (result) {

                $("#testdata").html(result);
                popup(result);
            }
        });
    }
    function getEmployeeName(role) {

        var base_url = '<?php echo base_url() ?>';
        $("#name").html("<option value=''>select</option>");
        var div_data = "";
        $.ajax({
            type: "POST",
            url: base_url + "admin/staff/getEmployeeByRole",
            data: {'role': role},
            dataType: "json",
            success: function (data) {
                $.each(data, function (i, obj)
                {
                    div_data += "<option value='" + obj.name + "'>" + obj.name + "</option>";
                });

                $('#name').append(div_data);
            }
        });
    }
    function create(id) {

        var month = '<?php
                                if (isset($_POST["month"])) {
                                    echo $_POST["month"];
                                }
                                ?>';
        var year = '<?php
                                if (isset($_POST["year"])) {
                                    echo $_POST["year"];
                                }
                                ?>';

        $("#month").val(month);
        $("#year").val(year);
        $("#staffid").val(id);
        $("#formsubmit").submit();


    }


    $(document).on('submit', '#schsetting_form', function (e) {
            e.preventDefault();
       
        $.ajax({
            url: '<?php echo site_url("admin/payroll/paymentSuccess") ?>',
            type: "POST",
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            cache: false,
            processData: false,  
            success: function (data) {


                if (data.status == "fail") {
                    var message = "";
                    $.each(data.error, function (index, value) {

                        message += value;
                    });
                    errorMsg(message);
                } else {
                    successMsg(data.message);
                    window.location.reload(true);
                }

                $this.button('reset');
            }
        });
    });

    function getSectionByClass(class_id, section_id) {
        if (class_id != "" && section_id != "") {
            $('#section_id').html("");
            var base_url = '<?php echo base_url() ?>';
            var div_data = '<option value=""><?php echo $this->lang->line('select'); ?></option>';
            $.ajax({
                type: "GET",
                url: base_url + "sections/getByClass",
                data: {'class_id': class_id},
                dataType: "json",
                success: function (data) {
                    $.each(data, function (i, obj)
                    {
                        var sel = "";
                        if (section_id == obj.section_id) {
                            sel = "selected";
                        }
                        div_data += "<option value=" + obj.section_id + " " + sel + ">" + obj.section + "</option>";
                    });
                    $('#section_id').append(div_data);
                }
            });
        }
    }

    $(document).ready(function () {
        var class_id = $('#class_id').val();
        var section_id = '<?php echo set_value('section_id') ?>';
        getSectionByClass(class_id, section_id);
        $(document).on('change', '#class_id', function (e) {
            $('#section_id').html("");
            var class_id = $(this).val();
            var base_url = '<?php echo base_url() ?>';
            var div_data = '<option value=""><?php echo $this->lang->line('select'); ?></option>';
            $.ajax({
                type: "GET",
                url: base_url + "sections/getByClass",
                data: {'class_id': class_id},
                dataType: "json",
                success: function (data) {
                    $.each(data, function (i, obj)
                    {
                        div_data += "<option value=" + obj.section_id + ">" + obj.section + "</option>";
                    });
                    $('#section_id').append(div_data);
                }
            });
        });
    });
</script>

<script type="text/javascript">
    $(document).on('change','.payment_mode',function(){
      var mode=$(this).val();
      if(mode == "Cheque"){
        $('.cheque_div').css("display", "block");
      }else{
        $('.cheque_div').css("display", "none");
      }
    });

</script>