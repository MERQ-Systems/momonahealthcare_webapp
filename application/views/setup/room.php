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
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('room') . " " . $this->lang->line('list'); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('bed', 'can_add')) { ?>
                                <a data-toggle="modal" data-target="#myModal" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i><?php echo $this->lang->line('add') ?></a> 
                            <?php } ?>
                        </div><!-- /.box-tools -->
                    </div>
                    <div class="box-body">
                        <div class="download_label"><?php echo $this->lang->line('room') . " " . $this->lang->line('list'); ?></div>
                        <div class="table-responsive mailbox-messages">
                            <table class="table table-hover table-striped table-bordered example">
                                <thead>
                                    <tr>                                    
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        <th><?php echo $this->lang->line('room') . " " . $this->lang->line('type'); ?></th>
                                        <th><?php echo $this->lang->line('floor'); ?></th>
                                        <th><?php echo $this->lang->line('department'); ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('action'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    if (empty($room_list)) {
                                        ?>
                                        <?php
                                    } else {
                                        foreach ($room_list as $key => $value) {
                                            ?>
                                            <tr>
                                                <td class="mailbox-name">
                                                    <a href="#" data-toggle="popover" class="detail_popover"><?php echo $value['room_name'] ?></a>
                                                    <div class="fee_detail_popover" style="display: none">
                                                        <?php
                                                        if ($value['description'] == "") {
                                                            ?>
                                                            <p class="text text-danger"><?php echo $this->lang->line('no_description'); ?></p>
                                                            <?php
                                                        } else {
                                                            ?>
                                                            <p class="text text-info"><?php echo $value['description']; ?></p>
                                                            <?php
                                                        }
                                                        ?>
                                                    </div>
                                                </td>
                                                <td class="mailbox-name">
                                                    <?php echo $value['room_type_name'] ?>
                                                </td>
                                                <td class="mailbox-name">
                                                    <?php echo $value['floor_name'] ?>
                                                </td>
                                                <td class="mailbox-name">
                                                    <?php echo $value['department_name'] ?>
                                                </td>

                                                <td class="mailbox-date pull-right">
                                                    <?php if ($this->rbac->hasPrivilege('bed', 'can_edit')) { ?>
                                                        <a data-toggle="modal" data-target="#editmyModal" onclick="edit(<?php echo $value['id']; ?>)"   class="btn btn-default btn-xs" data-toggle="tooltip" title="" data-original-title="Edit">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    <?php } ?>
                                                    <?php if ($this->rbac->hasPrivilege('bed', 'can_delete')) { ?>
                                                        <a href="<?php echo base_url(); ?>admin/visitorspurpose/delete/<?php echo $value['id']; ?>" class="btn btn-default btn-xs" data-toggle="tooltip" title="" onclick="return confirm('<?php echo $this->lang->line('delete_confirm') ?>');" data-original-title="Delete">
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
<!-- new END -->

</div><!-- /.content-wrapper -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm400" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('add') . " " . $this->lang->line('room'); ?></h4> 
            </div>

            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12" id="edit_expensedata">
                        <form id="addroom"  class="ptt10" method="post" accept-charset="utf-8" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('name'); ?></label>
                                        <input id="invoice_no" name="name" placeholder="" type="text" class="form-control"  value="<?php echo set_value('name'); ?>" />
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('room') . " " . $this->lang->line('type'); ?></label> 
                                        <select name="roomtype_id" class="form-control" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($roomtype_list as $value) {
                                                ?>
                                                <option value="<?php echo $value['id'] ?>"<?php
                                                if (set_value('roomtype_id') == $value['id']) {
                                                    echo "selected =selected";
                                                }
                                                ?>><?php echo $value['name'] ?></option>

                                                <?php
                                            }
                                            ?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('fee_groups_id'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('floor'); ?></label> 

                                        <select autofocus="" id="fee_groups_id" name="floor_id" class="form-control" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($floor_list as $value) {
                                                ?>
                                                <option value="<?php echo $value['id'] ?>"<?php
                                                if (set_value('floor_id') == $value['id']) {
                                                    echo "selected =selected";
                                                }
                                                ?>><?php echo $value['name'] ?></option>

                                                <?php
                                            }
                                            ?>
                                        </select>
                                        <span class="text-danger"><?php echo form_error('fee_groups_id'); ?></span>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('department'); ?></label>

                                        <select  name="dep_id" class="form-control" >
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php
                                            foreach ($dept_list as $value) {
                                                ?>
                                                <option value="<?php echo $value['id'] ?>"<?php
                                                if (set_value('dep_id') == $value['id']) {
                                                    echo "selected =selected";
                                                }
                                                ?>><?php echo $value['department_name'] ?></option>

                                                <?php
                                            }
                                            ?>
                                        </select>

                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1"><?php echo $this->lang->line('description'); ?></label>
                                        <textarea class="form-control" id="description" name="description" placeholder="" rows="2" placeholder="Enter ..."><?php echo set_value('description'); ?><?php echo set_value('description') ?></textarea>
                                    </div>
                                </div>
                            </div><!-- /.box-body -->
                            <div class="modal-footer">
                                <div class="pull-right">
                                    <button type="submit" class="btn btn-info"><?php echo $this->lang->line('save'); ?></button>
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
                <h4 class="modal-title"><?php echo $this->lang->line('edit') . " " . $this->lang->line('room'); ?></h4> 
            </div>
            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12" id="edit_roomdata">

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
    function edit(id) {       
        $.ajax({
            url: '<?php echo base_url(); ?>admin/setup/room/getdata/' + id,
            success: function (data) {

                $('#edit_roomdata').html(data);
            }
        });
    }
    $(document).ready(function (e) {
        $("#addroom").on('submit', (function (e) {
            e.preventDefault();
            $.ajax({
                url: '<?php echo base_url(); ?>admin/setup/room/add',
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
</script>