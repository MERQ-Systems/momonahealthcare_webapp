<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$genderList = $this->customlib->getGender();
?>
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('medicines'); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('import_medicine', 'can_view')) { ?>       
                                <a href="<?php echo site_url('admin/pharmacy/exportformat') ?>">
                                    <button class="btn btn-primary btn-sm"><i class="fa fa-download"></i> <?php echo $this->lang->line('download_sample_data'); ?></button>
                                </a>
                            <?php } ?>
                        </div>
                    </div><!-- /.box-header -->
                    <div class="box-body">      
                        <?php  if ($this->session->flashdata('import_msg')) { ?> <div>  <?php echo $this->session->flashdata('import_msg') ?> </div> <?php $this->session->unset_userdata('import_msg'); }   ?>
                        <br/>           
                        <p><b><?php echo $this->lang->line('note') ?>:</b> <?php echo $this->lang->line('medicine_import_note'); ?> </p>
                        <hr/>

                    </div>
                    <div class="box-body table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="sampledata">
                            <thead>
                                <tr>
                                    <?php
                                    foreach ($fields as $key => $value) {
                                        if ($value == 'medicine_name') {
                                            $value = "medicine";
                                        }
                                        if ($value == 'medicine_company') {
                                            $value = "company";
                                        }
                                        if ($value == 'medicine_composition') {
                                            $value = "composition";
                                        }
                                        if ($value == 'medicine_group') {
                                            $value = "group";
                                        }
                                        if ($value == 'reorder_level') {
                                            $value = "re_order_level";
                                        }

                                        $add = "";
                                        if (($value == "medicine") || ($value == "company") || ($value == "composition") || ($value == "group") || ($value == "re_order_level")) {
                                            $add = "<span class=text-red>*</span> ";
                                        }
                                        ?>    
                                        <th><?php echo $add . "<span>" . $this->lang->line($value) . "</span>"; ?></th>
                                    <?php } ?>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <?php foreach ($fields as $key => $value) {
                                        ?>    
                                        <td><?php echo $this->lang->line("sample_data"); ?></td>
                                    <?php } ?>
                                </tr>
                            </tbody>

                        </table>        
                    </div>
                    <form action="<?php echo site_url('admin/pharmacy/import') ?>" id="employeeform" name="employeeform" method="post" enctype="multipart/form-data">
                        <div class="box-body">
                        
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('medicine_category'); ?></label><small class="req"> *</small>

                                        <select autofocus="" id="medicine_category_id" name="medicine_category_id" class="form-control" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($medicineCategory as $medicine) {
                                                ?>
                                                <option value="<?php echo $medicine['id'] ?>"><?php echo $medicine['medicine_category'] ?></option>
                                                <?php
                                                $count++;
                                            }
                                            ?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('medicine_category_id'); ?></span>
                                    </div>
                                    <input type="hidden" id="id" name="medicineid">
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="exampleInputFile"><?php echo $this->lang->line('select_csv_file'); ?></label><small class="req"> *</small>
                                        <div><input  class="filestyle form-control" type='file' name='file' id="file" size='20' />
                                            <span class="text-danger"><?php echo form_error('file'); ?></span></div>
                                    </div>
                                </div>
                                <div class="col-md-12 pt20">

                                    <button type="submit" class="btn btn-info btn-sm pull-right"><i class="fa fa-upload"></i> <?php echo $this->lang->line('import_medicine'); ?></button>
                                </div>     

                            </div>
                        </div>
                    </form>
                </div>                                                    
            </div>                                                                                                                  
        </div>  
    </section>
</div>
<!-- dd -->
<script type="text/javascript">
    $(function () {
        //Initialize Select2 Elements
        $('.select2').select2()
    });
    $(function () {
        $('#easySelectable').easySelectable();

    })
</script>


<script type="text/javascript">

                    (function ($) {
                        //selectable html elements
                        $.fn.easySelectable = function (options) {
                            var el = $(this);
                            var options = $.extend({
                                'item': 'li',
                                'state': true,
                                onSelecting: function (el) {

                                },
                                onSelected: function (el) {

                                },
                                onUnSelected: function (el) {

                                }
                            }, options);
                            el.on('dragstart', function (event) {
                                event.preventDefault();
                            });
                            el.off('mouseover');
                            el.addClass('easySelectable');
                            if (options.state) {
                                el.find(options.item).addClass('es-selectable');
                                el.on('mousedown', options.item, function (e) {
                                    $(this).trigger('start_select');
                                    var offset = $(this).offset();
                                    var hasClass = $(this).hasClass('es-selected');
                                    var prev_el = false;
                                    el.on('mouseover', options.item, function (e) {
                                        if (prev_el == $(this).index())
                                            return true;
                                        prev_el = $(this).index();
                                        var hasClass2 = $(this).hasClass('es-selected');
                                        if (!hasClass2) {
                                            $(this).addClass('es-selected').trigger('selected');
                                            el.trigger('selected');
                                            options.onSelecting($(this));
                                            options.onSelected($(this));
                                        } else {
                                            $(this).removeClass('es-selected').trigger('unselected');
                                            el.trigger('unselected');
                                            options.onSelecting($(this))
                                            options.onUnSelected($(this));
                                        }
                                    });
                                    if (!hasClass) {
                                        $(this).addClass('es-selected').trigger('selected');
                                        el.trigger('selected');
                                        options.onSelecting($(this));
                                        options.onSelected($(this));
                                    } else {
                                        $(this).removeClass('es-selected').trigger('unselected');
                                        el.trigger('unselected');
                                        options.onSelecting($(this));
                                        options.onUnSelected($(this));
                                    }
                                    var relativeX = (e.pageX - offset.left);
                                    var relativeY = (e.pageY - offset.top);
                                });
                                $(document).on('mouseup', function () {
                                    el.off('mouseover');
                                });
                            } else {
                                el.off('mousedown');
                            }
                        };
                    })(jQuery);
</script>
<script type="text/javascript">
            $(document).ready(function (e) {
                $("#formadd").on('submit', (function (e) {
                    e.preventDefault();
                    $("#formaddbtn").button('loading');
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/add',
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
                            $("#formaddbtn").button('reset');
                        },
                        error: function () {
                            
                        }

                    });
                }));
            });

            $(document).ready(function (e) {
                $("#formimp").on('submit', (function (e) {
                    e.preventDefault();
                    $("#formimpbtn").button('loading');
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/import',
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
                            $("#formimpbtn").button('reset');
                        },
                        error: function () {
                            
                        }

                    });
                }));
            });

            $(document).ready(function (e) {
                $("#formstock").on('submit', (function (e) {
                    e.preventDefault();
                    $("#formstockbtn").button('loading');
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/addBadStock',
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
                            $("#formstockbtn").button('reset');
                        },
                        error: function () {
                            
                        }
                    });
                }));
            });
            $(document).ready(function (e) {
                $("#formedit").on('submit', (function (e) {
                    e.preventDefault();
                    $("#formeditbtn").button('loading');
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/update',
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
                            $("#formeditbtn").button('reset');
                        },
                        error: function () {
                          
                        }
                    });
                }));
            });
            $(document).ready(function (e) {

                $('#expiry,#stockexpiry_date').datepicker({
                    format: "M/yyyy",
                    viewMode: "months",
                    minViewMode: "months",
                    autoclose: true
                });
            });

            function getRecord(id) {
                $.ajax({
                    url: '<?php echo base_url(); ?>admin/pharmacy/getDetails',
                    type: "POST",
                    data: {pharmacy_id: id},
                    dataType: 'json',
                    success: function (data) {
                        $("#id").val(data.id);
                        $("#medicines_name").val(data.medicine_name);
                        $("#medicines_category_id").val(data.medicine_category_id);
                        $("#medicine_company").val(data.medicine_company);
                        $("#medicine_composition").val(data.medicine_composition);
                        $("#medicine_group").val(data.medicine_group);
                        $("#unit").val(data.unit);
                        $("#min_level").val(data.min_level);
                        $("#reorder_level").val(data.reorder_level);
                        $("#vat").val(data.vat);
                        $("#unit_packing").val(data.unit_packing);
                        $("#supplier").val(data.supplier);
                        $("#pre_medicine_image").val(data.pre_medicine_image);
                        $("#vat_ac").val(data.vat_ac);
                        $("#updateid").val(id);
                        $("#viewModal").modal('hide');
                        $(".select2").select2().select2('val', data.medicine_category_id);
                        holdModal('myModaledit');
                    },
                });
            }
            function viewDetail(id) {              
                $.ajax({
                    url: '<?php echo base_url(); ?>admin/pharmacy/getDetails',
                    type: "POST",
                    data: {pharmacy_id: id},
                    dataType: 'json',
                    success: function (data) {
                        $.ajax({
                            url: '<?php echo base_url(); ?>admin/pharmacy/getMedicineBatch',
                            type: "POST",
                            data: {pharmacy_id: id},
                            success: function (data) {
                                $('#tabledata').html(data);
                            },
                        });
                        if (data.medicine_image != "") {
                            $("#medicine_image").attr('src', '<?php echo base_url() ?>' + data.medicine_image);
                        } else {
                            $("#medicine_image").attr('src', '<?php echo base_url() ?>uploads/medicine_images/no_medicine_image.png');

                        }

                        $("#medicine_names").html(data.medicine_name);
                        $("#medicine_category_ids").html(data.medicine_category);
                        $("#medicine_companys").html(data.medicine_company);
                        $("#medicine_compositions").html(data.medicine_composition);
                        $("#medicine_groups").html(data.medicine_group);
                        $("#units").html(data.unit);
                        $("#min_levels").html(data.min_level);
                        $("#reorder_levels").html(data.reorder_level);
                        $("#vats").html(data.vat);
                        $("#unit_packings").html(data.unit_packing);
                        $("#suppliers").html(data.supplier);
                        $("#vat_acs").html(data.vat_ac);
                        $('#edit_delete').html("<?php if ($this->rbac->hasPrivilege('medicine', 'can_edit')) { ?><a href='#'' onclick='getRecord(" + id + ")' data-toggle='tooltip'  data-original-title='<?php echo $this->lang->line('edit'); ?>'><i class='fa fa-pencil'></i></a><?php } if ($this->rbac->hasPrivilege('medicine', 'can_delete')) { ?><a onclick='delete_record(" + id + ")'  href='#'  data-toggle='tooltip'  data-original-title='<?php echo $this->lang->line('delete'); ?>'><i class='fa fa-trash'></i></a><?php } ?>");
                        holdModal('viewModal');
                    },
                });
            }
            function addBulk(id) {
                $.ajax({
                    url: '<?php echo base_url(); ?>admin/pharmacy/getPharmacy',
                    type: "POST",
                    data: {pharmacy_id: id},
                    dataType: 'json',
                    success: function (data) {
                        $("#pharm_id").val(id);
                        holdModal('addBulkModal');
                    },
                })
            }
            $(document).ready(function (e) {
                $("#formbatch").on('submit', (function (e) {
                    e.preventDefault();
                    $("#formbatchbtn").button("loading");
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/medicineBatch',
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
                            $("#formbatchbtn").button('reset');
                        },
                        error: function () {
                            
                        }
                    });
                }));
            });
            function delete_record(id) {
                if (confirm('Are you sure')) {
                    $.ajax({
                        url: '<?php echo base_url(); ?>admin/pharmacy/delete/' + id,
                        type: "POST",
                        data: {opdid: ''},
                        dataType: 'json',
                        success: function (data) {

                            window.location.reload(true);
                        }
                    })
                }
            }
            function holdModal(modalId) {
                $('#' + modalId).modal({
                    backdrop: 'static',
                    keyboard: false,
                    show: true
                });
            }

            function addbadstock(id) {
                $("#pharmacy_stock_id").val(id);
                getbatchnolist(id);
                holdModal('addBadStockModal');
            }


            function getbatchnolist(id, selectid = '') {
                var div_data = "";
                $("#batch_stock_no").html("<option value=''><?php echo $this->lang->line('select') ?></option>");
                $.ajax({
                    type: "POST",
                    url: base_url + "admin/pharmacy/getBatchNoList",
                    data: {'medicine': id},
                    dataType: 'json',
                    success: function (res) {
                        console.log(res);
                        $.each(res, function (i, obj)
                        {
                            var sel = "";
                            if (obj.batch_no == selectid) {
                                sel = "selected";
                            }
                            div_data += "<option " + sel + " value='" + obj.batch_no + "'>" + obj.batch_no + "</option>";
                        });
                        $('#batch_stock_no').append(div_data);
                    }
                });
            }

            function getExpire(batch_no) {

                $.ajax({
                    type: "POST",
                    url: base_url + "admin/pharmacy/getExpiryDate",
                    data: {'batch_no': batch_no},
                    dataType: 'json',
                    success: function (data) {
                        if (data != null) {
                            $('#batch_expire').val(data.expiry_date);
                            $('#batch_available_qty').val(data.available_quantity);
                            $('#medicine_batch_id').val(data.id);
                        }
                    }
                });
            }
</script>