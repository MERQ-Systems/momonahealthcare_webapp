<style type="text/css">
    .versionup{font-size: 16px;}
    .versionup span{display: block;}
    .upgradeup{}
    .update-list li h5{font-family:'Roboto-Medium';}
    .upgradeup h4, .upgradeup h5{font-family:'Roboto-Bold';}
    .update-list{padding: 0; margin: 0;}
    .update-list li{list-style: none;}
</style>
<div class="content-wrapper" style="min-height: 946px;">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <!--/.col (right) -->
            <!-- left column -->
            <?php $this->load->view('setting/sidebar'); ?>
            <div class="col-md-10">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header ptbnull">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('system_update')?></h3>
                        <div class="box-tools pull-right">

                        </div><!-- /.box-tools -->
                    </div><!-- /.box-header -->
                    <div class="box-body">                      
                        <div class="row text-center">
                            <div class="col-md-6 col-md-offset-3 progress" style="display: none;">
                              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                <span class="sr-only">100% <?php echo $this->lang->line('complete')?></span>
                              </div>
                            </div>
                            <div class="col-md-4 col-md-offset-4">
                                <div class="alert <?php echo (isset($version) && $version != "") ? 'alert-danger':'alert-success' ?>">
                                    <p class="versionup">                                  
                              <?php echo $this->lang->line('your_app_name_version'); ?> <span> <?php echo $current_version; ?></span></p>
                                </div><!--./alert alert-danger-->
                            </div><!--./col-md-4 -->
                            <?php
                            if (isset($version) && $version != "") {
                                ?>
                                <div class="col-md-4 col-md-offset-4">
                                    <div class="alert alert-success">
                                        <p class="versionup"><?php echo $this->lang->line('latest_app_name_version'); ?> <span> <?php echo $version; ?></span></p>
                                    </div><!--./alert alert-danger-->
                                </div><!--./col-md-4 -->
                                <?php
                            }
                           echo "<div class='clearfix'></div>"; 
                        if ($this->session->flashdata('message')) {
                            ?>
                            <div class="col-md-12">
                               
                              </div>  
                            <?php
                        }
                        if (!$this->session->flashdata('message') && $this->session->flashdata('error')) {
                            ?>
                            
                            <?php
                        }                       

                            if (isset($version) && $version != "") {
                                ?>
                                <div class="col-md-12 mb10 mt10 upgradeup">
                                    <!-- <h4><i class="fa fa-info-circle"></i> New version is available for update.</h4> -->
                                    <form method="POST" action="<?php echo site_url('admin/updater'); ?>" id="form-update">
                                        <button type="button" class="btn cfees btn-submit" name="update_btn" value="update"> <?php echo $this->lang->line('update_now')?></button>
                                    </form>
                                </div><!--./col-md-12-->
                                <?php
                            }
                            ?>
                        </div><!--./row-->
                    </div><!-- /.box-body -->
                </div>
            </div><!--/.col (left) -->
            <!-- right column -->
        </div>
    </section><!-- /.content -->
</div>

<div class="modal fade" id="confirm-update" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel"><?php  echo $this->lang->line('confirmation'); ?></h4>
            </div>
            <div class="modal-body">
                <p><?php echo $this->lang->line('updater_instruction')?></p>
                <p><?php echo $this->lang->line('do_you_want_to_proceed')?></p>                  
            </div>
            <div class="modal-footer"><button type="button" class="btn cfees pull-right confirm-yes"><?php echo $this->lang->line('yes'); ?> </button></div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('.btn-submit').on('click', function (e) {
        $('#confirm-update').modal('show');
    });

    $('.confirm-yes').on('click', function (e) {
        $('#confirm-update').modal('hide');
        $('.progress').css('display','block');
        $('form#form-update').submit();
    });
</script>