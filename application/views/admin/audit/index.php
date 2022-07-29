<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-info" id="attendencelist">
                    <div class="box-header with-border" >
                                <h3 class="box-title"> <?php echo $this->lang->line('audit_trail_report_list'); ?></h3>
<div class="box-tools pull-right">
                 <button class="btn btn-primary btn-sm checkbox-toggle delete_all"><i class="fa fa-trash"></i> <?php echo $this->lang->line('delete_all'); ?></button>
                                                                                   
                                                    </div>
                    </div>
                    <div class="box-body table-responsive">
                        <div class="mailbox-controls">
                            <div class="pull-right">
                            </div>
                        </div>
                        <div class="download_label"><?php $this->lang->line('audit_trail_report_list'); ?></div>
                        <table class="table table-striped table-bordered table-hover all-list" data-export-title="<?php echo $this->lang->line('audit_trail_report_list'); ?>">
                            <thead>
                                <tr>
                                    <th><?php echo $this->lang->line('message'); ?></th>
                                    <th><?php echo $this->lang->line('users'); ?></th>
                                    <th><?php echo $this->lang->line('ip_address'); ?></th>
                                    <th><?php echo $this->lang->line('action'); ?></th>
                                    <th><?php echo $this->lang->line('platform'); ?></th>
                                    <th><?php echo $this->lang->line('agent'); ?></th>
                                    <th><?php echo $this->lang->line('date_time'); ?></th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                </section>
            </div>
        </div>
</div>
<script type="text/javascript">
      $(document).on('click','.delete_all',function(){
       delete_recordById('admin/audit/deleteall');
    });

    (function ($) {
        'use strict';
        $(document).ready(function () {
            initDatatable('all-list', 'admin/audit/getDatatable');
        });
    }(jQuery))
</script>