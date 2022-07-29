<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-2">
                <?php
                $this->load->view('setup/bedsidebar');
                ?>
            </div>
            <div class="col-md-10">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('ward')." ".$this->lang->line('type')." ".." " . $this->lang->line('list'); ?></h3>
                        <div class="box-tools pull-right">
                            <a data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i> <?php echo $this->lang->line('add'); ?></a>      
                        </div><!-- /.box-tools -->
                    </div>
                    <div class="box-body">
                        <div class="download_label"><?php echo $this->lang->line('ward')." ".$this->lang->line('type')." ".." " . $this->lang->line('list'); ?></div>
                        <div class="table-responsive mailbox-messages">
                            <table class="table table-hover table-striped table-bordered example">
                                <thead>
                                    <tr>                                    
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('action'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    if (empty($wardtype_list)) {
                                        ?>
                                        <?php
                                    } else {
                                        foreach ($wardtype_list as $key => $value) {
                                            ?>
                                            <tr>

                                                <td class="mailbox-name">
                                                    <a href="#" data-toggle="popover" class="detail_popover"><?php echo $value['name'] ?></a>
                                                </td>
                                                <td class="mailbox-date pull-right">
                                                    <?php if ($this->rbac->hasPrivilege('setup_font_office', 'can_edit')) { ?>
                                                        <a data-toggle="modal" data-target="#editmyModal" onclick="edit(<?php echo $value['id']; ?>)"  class="btn btn-default btn-xs" data-toggle="tooltip" title="" data-original-title="Edit">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    <?php } ?>
                                                    <?php if ($this->rbac->hasPrivilege('setup_font_office', 'can_delete')) { ?>
                                                        <a href="<?php echo base_url(); ?>admin/visitorspurpose/delete/<?php echo $value['id']; ?>" class="btn btn-default btn-xs" data-toggle="tooltip" title="" onclick="return confirm('<?php echo $this->lang->line('delete_confirm') ?>');" data-original-title="Delete">
                                                            <i class="fa fa-remove"></i>
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
<!-- new END -->
</div><!-- /.content-wrapper -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm400" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('add') . " " . $this->lang->line('ward') . " " . $this->lang->line('type'); ?></h4> 
            </div>

            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 paddlr" id="edit_expensedata">
                        <form id="addwardtype"  class="ptt10" method="post" accept-charset="utf-8" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('name'); ?></label>
                                        <input id="invoice_no" name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('invoice_no'); ?>" />
                                    </div>
                                </div>  
                            </div><!-- /.box-body -->
                            <div class="box-footer">
                                <div class="pull-right ">
                                    <button type="submit" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>       
        </div>
    </div>    
</div>

<div class="modal fade" id="editmyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm400" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('edit') . " " . $this->lang->line('ward') . " " . $this->lang->line('type'); ?></h4> 
            </div>

            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 paddlr" id="edit_wardtypedata">
                    </div>
                </div>
            </div>
        </div>
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
        $("#addwardtype").on('submit', (function (e) {
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/setup/Wardtype/add',
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
                },
                error: function () {
                    alert("Fail")
                }
            });
        }));
    });

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

    function edit(id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/setup/wardtype/getdata/' + id,
            success: function (data) {
                $('#edit_wardtypedata').html(data);
            },

        });
    }
</script>