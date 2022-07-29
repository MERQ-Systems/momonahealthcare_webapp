<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-2">
                <?php
$this->load->view('admin/referral/referralSidebar');
?>
            </div>
            <div class="col-md-10"> 
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line("referral_category_list"); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('referral_category', 'can_add')) { ?>
                                <a data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm addcategory"><i class="fa fa-plus"></i> <?php echo $this->lang->line('add_referral_category'); ?></a>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="table-responsive mailbox-messages">
                            <table class="table table-hover table-striped table-bordered example">
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <?php if ($this->rbac->hasPrivilege('referral_category', 'can_edit') || $this->rbac->hasPrivilege('referral_category', 'can_delete')) { ?>
                                            <th class="text-right noExport"><?php echo $this->lang->line('action'); ?></th>
                                        <?php } ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                        if (empty($category)) {
                                    ?>
                                    <?php
                                        } else {
                                        foreach ($category as $key => $value) {
                                    ?>
                                            <tr>
                                                <td class="mailbox-name">
                                                    <a href="#" data-toggle="popover" class="detail_popover"><?php echo $value['name'] ?></a>

                                                </td>
                                                <td class="mailbox-date pull-right">
                                                    <?php if ($this->rbac->hasPrivilege('referral_category', 'can_edit')) { ?>
                                                        <a href="#" onclick="getRecord('<?php echo $value['id'] ?>')" class="btn btn-default btn-xs" data-target="#myModalEdit" data-toggle="tooltip" title="" data-original-title="<?php echo $this->lang->line('edit'); ?>">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    <?php } if ($this->rbac->hasPrivilege('referral_category', 'can_delete')) { ?>
                                                        <a  class="btn btn-default btn-xs" data-toggle="tooltip" title="" onclick="delete_recordByIdReload('admin/referralcategory/delete/<?php echo $value['id']; ?>', '<?php echo $this->lang->line('delete_confirm') ?>')" data-original-title="<?php echo $this->lang->line('delete') ?>">
                                                            <i class="fa fa-trash"></i>
                                                        </a>
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm400" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line("add_category"); ?></h4>
            </div>
            <form id="addcategory" class="ptt10" method="post" accept-charset="utf-8" enctype="multipart/form-data">   
                <div class="modal-body pt0 pb0">
                    <div class="form-group">
                        <label for="exampleInputEmail1"><?php echo $this->lang->line('name'); ?></label>
                        <span class="req"> *</span>
                        <input  name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('name'); ?>" />
                    </div>
                </div>    
                <div class="modal-footer">
                    <div class="pull-right">
                        <button type="submit" id="addcategorybtn" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info"><?php echo $this->lang->line('save'); ?></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm400" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line("edit_category"); ?></h4>
            </div>

            <form id="editcategory" class="" method="post" accept-charset="utf-8" enctype="multipart/form-data">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10 row" id="">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for="exampleInputEmail1"><?php echo $this->lang->line('name'); ?></label>
                                <span class="req"> *</span>
                                <input id="edit_name" name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('name'); ?>" />
                                <input id="categoryid" name="categoryid" placeholder="" type="hidden" class="form-control"  />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" id="editcategorybtn" class="btn btn-info"><?php echo $this->lang->line('save'); ?></button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function (e) {
        $('#addcategory').on('submit', (function (e) {
            $("#addcategorybtn").button('loading');
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/referralcategory/add',
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
                            $('.' + index).html(value);
                            message += value;
                        });

                        errorMsg(message);
                    } else {
                        successMsg(data.message);
                        window.location.reload(true);
                    }
                    $("#addcategorybtn").button('reset');
                },
                error: function () {
                    alert("<?php echo $this->lang->line('fail'); ?>")
                }
            });
        }));
    });

    function getRecord(id) {
        $('#myModalEdit').modal('show');
        $.ajax({
            url: '<?php echo base_url(); ?>admin/referralcategory/get/' + id,
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#edit_name").val(data.name);
                $("#categoryid").val(id);
            },
            error: function () {
                alert("Fail")
            }

        });
    }

    $(document).ready(function (e) {
        $('#editcategory').on('submit', (function (e) {
            $("#editcategorybtn").button('loading');

            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/referralcategory/update',
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
                    $("#editcategorybtn").button('reset');
                },
                error: function () {
                    alert("Fail")
                }
            });
        }));
    });
    
    $(document).ready(function (e) {
        $('#myModal,#myModalEdit').modal({
        backdrop: 'static',
        keyboard: false,
        show:false
        });
    });
</script>