<div class="content-wrapper">  
    <section class="content">
        <div class="row">  
            <?php $this->load->view('admin/pharmacy/pharmacyMasters') ?>
            <div class="col-md-10">              
                <div class="box box-primary" id="tachelist">
                    <div class="box-header ptbnull">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('dosage_interval_list'); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('dosage_interval', 'can_add')) { ?>
                                <a onclick="add()" class="btn btn-primary btn-sm medicine"><i class="fa fa-plus"></i>  <?php echo $this->lang->line('add_dosage_interval'); ?></a> 
                            <?php } ?>    
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="mailbox-controls">
                        </div>
                        <div class="table-responsive mailbox-messages">
                            <div class="download_label"><?php echo $this->lang->line('dosage_interval_list'); ?></div>
                            <table class="table table-striped table-bordered table-hover ajaxlist" >
                                <thead>
                                    <tr>
                                        <th><?php echo $this->lang->line('name'); ?></th>
                                        
                                        <th class="text-right noExport"><?php echo $this->lang->line('action'); ?></th>
                                    </tr> 
                                </thead>
                                <tbody>
                                   
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="">
                        <div class="mailbox-controls">
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </section>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-mid" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('add_dosage_interval') ?></h4> 
            </div>
            <form id="formadd" action="<?php echo site_url('admin/medicinedosage/add_interval') ?>"  id="employeeform" name="employeeform" method="post" accept-charset="utf-8">
                <div class="modal-body pt0 pb0">
                    <div class="ptt10">
                            <div class="form-group">
                                <label for="exampleInputEmail1"><?php echo $this->lang->line('interval'); ?></label>
                                <small class="req"> *</small>
                                 <input autofocus="" name="id" id="id" placeholder="" type="hidden" class="form-control"   />
                                <input autofocus="" name="name" id="name" placeholder="" type="text" class="form-control"   />
                            </div>  
                    </div>
                </div><!--./modal-->         
                <div class="modal-footer">
                    <button type="submit" id="formaddbtn" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info pull-right"><?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div><!--./row--> 
    </div>
</div>


<script type="text/javascript">
( function ( $ ) { 
    'use strict';
    $(document).ready(function () {
        initDatatable('ajaxlist','admin/medicinedosage/get_doseIntervallist');
    });
} ( jQuery ) )
</script>
<script> 


 $('#myModal').on('hidden.bs.modal', function (e) {
$('#formadd').trigger("reset");
 $('#myModal .modal-title').html('<?php echo $this->lang->line('add_dosage_interval') ?>');
})

 
 function add(){
     $('#myModal').modal('show');
     
 }
    
 $(document).ready(function (e) {
  $('#myModal').modal({
           backdrop: 'static',
            keyboard: false,
            show:false
        });
        $(".select2").select2();
    });

    $(document).ready(function (e) {
        $('#formadd').on('submit', (function (e) {
            $("#formaddbtn").button('loading');
            e.preventDefault();
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
        
        $.ajax({
            dataType: 'JSON',
            url: base_url+'admin/medicinedosage/get_doseintervalbyid/' + id,

            beforeSend: function() {
               
            },
            success: function(result) {
                 $('#id').val(result.id);
                 $('#name').val(result.name);
                        
              $('#myModal .modal-title').html('<?php echo $this->lang->line('edit_dosage_interval') ?>');
              $('#myModal').modal('show');
            },
            error: function(xhr) { // if error occured
                alert("Error occured.please try again");
               
            },
            complete: function() {
             
            }
        });

    }

function delete_intervalById(id){
  
    if (confirm('<?php echo $this->lang->line("delete_confirm"); ?>')) {
                    $.ajax({
                        url: "<?php echo base_url();?>admin/medicinedosage/delete_doseInterval/"+id,
                        success: function (res) {
                            successMsg('<?php echo $this->lang->line('delete_confirm')?>');
                            window.location.reload(true);
                        }
                    });
                }
}

$(".medicine").click(function(){
	$('#formadd').trigger("reset");
});
</script>