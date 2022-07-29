<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-2">
                <div class="box border0">
                    <ul class="tablists">
                        <li><a href="<?php echo site_url('admin/operationtheatre/category') ?>" ><?php echo $this->lang->line('operation_category'); ?></a></li>
                        <li><a href="<?php echo site_url('admin/operationtheatre') ?>" class="active"><?php echo $this->lang->line('operation'); ?></a></li>
                        
                </div>
            </div><!--./col-md-3-->
            <div class="col-md-10">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header ptbnull">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('operation_list'); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('setup_front_office', 'can_add')) {?>
                            <a data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm addoperation"><i class="fa fa-plus"></i>  <?php echo $this->lang->line('add_operation'); ?></a>
                            <?php }?>
                        </div>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                        <div class="download_label"><?php echo $this->lang->line('operation_category_list'); ?></div>
                        <div class="table-responsive mailbox-messages">
                            <table class="table table-hover table-striped table-bordered example">
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <th><?php echo $this->lang->line('category'); ?></th>
                                        <th class="text-right noExport"><?php echo $this->lang->line('action'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
if (!empty($operation_list)) {                                        
    foreach ($operation_list as $key => $value) {
        ?>
                                            <tr>
                                                <td class="mailbox-name"> <?php echo $value['operation']; ?>  </td>
                                                <td class="mailbox-name"> <?php echo $value['category']; ?>  </td>
                                                <td class="mailbox-date pull-right">
                                                    <?php if ($this->rbac->hasPrivilege('operation_theatre', 'can_edit')) {?>
                                                        <a data-target="#editmyModal" onclick="get(<?php echo $value['id']; ?>)"  class="btn btn-default btn-xs" data-toggle="tooltip" title="" data-original-title="<?php echo $this->lang->line('edit'); ?>">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    <?php }?>
                                                    <?php if ($this->rbac->hasPrivilege('operation_theatre', 'can_delete')) {?>
                                                        <a  class="btn btn-default btn-xs" data-toggle="tooltip" title="" onclick="delete_recordById('<?php echo $value['id']; ?>')" data-original-title="<?php echo $this->lang->line('delete'); ?>">
                                                            <i class="fa fa-trash"></i>
                                                        </a>
                                                        </a>
                                                    <?php }?>
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
<div class="modal fade" id="myModal"  role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-mid" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('add_operation'); ?></h4>
            </div>
            <form id="formadd" action="<?php echo site_url('admin/operationtheatre/addoperation') ?>"  id="employeeform" name="employeeform" method="post" accept-charset="utf-8">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10">
                        <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('operation_name'); ?></label> <small class="req"> *</small>
                            <input class="form-control" id="operation_name" name="operation_name" value="<?php echo set_value('operation_name'); ?>"/>
                            <span class="text-danger"><?php echo form_error('operation_name'); ?></span>
                        </div>
                        <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('category'); ?></label> <small class="req"> *</small>
                            <select class="form-control select2 " id="category" name="category" style="width:100%">
                                <option value=""><?php echo $this->lang->line('select'); ?></option>
                                <?php foreach($category_list as $category){ ?>
                                         <option value="<?php echo $category['id']; ?>"><?php echo $category['category']; ?></option>
                                  <?php  } ?>
                            </select>
                            <span class="text-danger"><?php echo form_error('category'); ?></span>
                        </div>
                    </div>
                </div><!--./col-md-12-->
                <div class="modal-footer">
                    <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" id="formaddbtn" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div><!--./row-->
    </div>
</div>

<div class="modal fade" id="editmyModal"  role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-mid" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('edit_operation'); ?></h4>
            </div>
            <form id="editformadd" action="<?php echo site_url('admin/operationtheatre/edit') ?>" name="employeeform" method="post" accept-charset="utf-8"  enctype="multipart/form-data" class="ptt10">
                <div class="modal-body pt0 pb0">
                    <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('operation_name'); ?></label> <small class="req"> *</small>
                            <input class="form-control" id="edit_operation_name" name="edit_operation_name" value="<?php echo set_value('edit_operation_name'); ?>"/>
                             <span class="text-danger"><?php echo form_error('edit_operation_name'); ?></span>
                            <input class="form-control" id="id" name="id" value="" type="hidden" />                           
                        </div>
                        <div class="form-group">
                            <label for="pwd"><?php echo $this->lang->line('category'); ?></label> <small class="req"> *</small>
                            <select class="form-control select2 " id="edit_category" name="edit_category" style="width:100%">
                                <option value=""><?php echo $this->lang->line('select'); ?></option>
                                <?php foreach($category_list as $category){ ?>
                                         <option value="<?php echo $category['id']; ?>"><?php echo $category['category']; ?></option>
                                  <?php  } ?>
                            </select>
                            <span class="text-danger"><?php echo form_error('category'); ?></span>
                        </div>                        
                </div><!--./modal-body-->
                <div class="modal-footer">
                    <button type="submit" data-loading-text="<?php echo $this->lang->line('processing'); ?>" id="editformaddbtn" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div><!--./row-->
    </div>
</div>

<script type="text/javascript">    
    $(document).ready(function (e) {
        $('.select2').select2();
    });
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

        $('#myModal,#editmyModal').modal({
            backdrop: 'static',
            keyboard: false,
            show:false
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
            url: '<?php echo base_url(); ?>admin/operationtheatre/getoperation/' + id,
            success: function (result) {
                $('#id').val(result.id);
                $('#edit_operation_name').val(result.operation);
                 $("#edit_category").select2("val", result.category_id);
               
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

$('#myModal').on('hidden.bs.modal', function(e) { 
    
    $("#category",$(this)).select2("val", "");
    $("#formadd",$(this)).find('input:text').val('');
   
});
</script>
<script>
     function delete_recordById(id) {
              
              if (confirm(<?php echo "'" . $this->lang->line('delete_confirm') . "'"; ?>)) {
                    $.ajax({
                        url: '<?php echo base_url()."admin/operationtheatre/deleteoperation"; ?>',
                        data:{id:id},
                        type:"post",
                        success: function (res) {
                           toastr.success(
                            "<?php echo $this->lang->line('record_deleted') ?>",
                            '',
                            {
                              timeOut: 1000,
                              fadeOut: 1000,
                              onHidden: function () {
                                 window.location.reload(true);
                                }
                            }
                          );  
                        }
                    });
                }
            }
</script>