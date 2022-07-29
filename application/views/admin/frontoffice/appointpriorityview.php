<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-2">
                <div class="box border0">
                    <ul class="tablists">
                        <li><a href="<?php echo site_url('admin/visitorspurpose') ?>" ><?php echo $this->lang->line('purpose'); ?></a></li>
                        <li><a href="<?php echo site_url('admin/complainttype') ?>"><?php echo $this->lang->line('complain_type'); ?></a></li>
                        <li><a href="<?php echo site_url('admin/source') ?>"><?php echo $this->lang->line('source'); ?></a></li>
                        <li><a href="<?php echo site_url('admin/appointpriority') ?>" class="active"><?php echo $this->lang->line('appointment_priority'); ?></a></li>
                    </ul>
                </div>
            </div><!--./col-md-3-->

            <div class="col-md-10">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header ptbnull">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('appointment_priority_list'); ?> </h3>
                        <div class="box-tools pull-right">
                             <?php if ($this->rbac->hasPrivilege('setup_front_office', 'can_add')) {?>
                            <a data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm addappointment"><i class="fa fa-plus"></i>  <?php echo $this->lang->line('add_priority'); ?></a>
                            <?php }?>
                        </div>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                        <div class="download_label"><?php echo $this->lang->line('appointment_priority_list'); ?></div>
                        <div class="table-responsive mailbox-messages">
                            <table class="table table-hover table-striped table-bordered example">
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('priority'); ?></th>
                                        <th class="text-right noExport"><?php echo $this->lang->line('action'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
if (empty($appoint_priority_list)) {
    ?>
                                        <?php
} else {

    foreach ($appoint_priority_list as $key => $value) {
        ?>
                                            <tr>

                                                <td class="mailbox-name">
                                                    <a href="#" data-toggle="popover" class="detail_popover"><?php echo $value['appoint_priority'] ?></a>

                                                </td>


                                                <td class="mailbox-date pull-right">
                                                    <?php if ($this->rbac->hasPrivilege('setup_front_office', 'can_edit')) {?>
                                                        <a data-target="#editmyModal" onclick="get(<?php echo $value['id']; ?>)"  class="btn btn-default btn-xs" data-toggle="tooltip" title="" data-original-title="<?php echo $this->lang->line('edit'); ?>">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    <?php }?>
                                                     <?php if ($value['id'] > 1) { ?>
                                                        <?php if ($this->rbac->hasPrivilege('setup_front_office', 'can_delete')) {?>
                                                            <a class="btn btn-default btn-xs" data-toggle="tooltip" title="" onclick="delete_appointpriority('<?php echo $value['id']; ?>')" data-original-title="<?php echo $this->lang->line('delete'); ?>">
                                                                <i class="fa fa-trash"></i>
                                                            </a>
                                                        <?php } ?>
                                                    <?php } ?>
                                                </td>


                                            </tr>
                                            <?php
}
}
?>
                                </tbody>
                            </table><!-- /.table -->
                        </div><!-- /.mail-box-messages -->
                    </div><!-- /.box-body -->
                </div>
            </div><!--/.col (left) -->
            <!-- right column -->
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

<!-- new END -->

</div><!-- /.content-wrapper -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-mid" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('add_priority'); ?></h4>
            </div>

            <form id="formadd" action="<?php echo site_url('admin/appointpriority/add') ?>"  id="employeeform" name="employeeform" method="post" accept-charset="utf-8">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10">
                        <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('priority'); ?></label> <small class="req"> *</small>
                            <input class="form-control" id="appoint_priority" name="appoint_priority" value="<?php echo set_value('appoint_priority'); ?>"/>
                            <span class="text-danger"><?php echo form_error('appoint_priority'); ?></span>
                        </div>
                    </div>
                </div><!--./col-md-12-->
                <div class="modal-footer">
                    <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" id="formaddbtn" class="btn btn-info pull-right"><i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div><!--./row-->
    </div>
</div>


<div class="modal fade" id="editmyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-mid" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('edit_priority'); ?></h4>
            </div>
        <form id="editformadd" action="<?php echo site_url('admin/appointpriority/edit') ?>" name="employeeform" method="post" accept-charset="utf-8" enctype="multipart/form-data">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10">
                        <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('priority'); ?></label> <small class="req"> *</small>
                            <input class="form-control" id="appoint_priority_edit" name="appoint_priority" value="<?php echo set_value('appoint_priority'); ?>"/>
                            <span class="text-danger"><?php echo form_error('appoint_priority'); ?></span>
                             <input type="hidden" id="id" name="id">
                        </div>
                    </div>
                </div><!--./modal-body-->
                <div class="modal-footer">
                    <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" id="editformaddbtn" class="btn btn-info pull-right"><i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div><!--./row-->
    </div>
</div>
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


<script>


    $(document).ready(function (e) {
        $('#formadd').on('submit', (function (e) {
            e.preventDefault();
            $("#formaddbtn").button('loading');
            $.ajax({
                url: $(this).attr('action'),
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


    function get(id) {

        $('#editmyModal').modal('show');
        $.ajax({

            dataType: 'json',

            url: '<?php echo base_url(); ?>admin/appointpriority/get_data/' + id,

            success: function (result) {

                $('#id').val(result.id);
                $('#appoint_priority_edit').val(result.appoint_priority);
            }

        });
    }

    $(document).ready(function (e) {

        $('#editformadd').on('submit', (function (e) {
            e.preventDefault();
            $("#editformaddbtn").button('loading');
            $.ajax({
                url: $(this).attr('action'),
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
                    $("#editformaddbtn").button('reset');
                },
                error: function () {

                }
            });
        }));
    });


$(".addappointment").click(function(){
    $('#formadd').trigger("reset");
});

    $(document).ready(function (e) {
        $('#myModal,#editmyModal').modal({
        backdrop: 'static',
        keyboard: false,
        show:false
        });
    });

    function delete_appointpriority(id){
        delete_recordByIdReload('admin/appointpriority/delete/'+id, '<?php echo $this->lang->line('delete_confirm') ?>')
    }
</script>