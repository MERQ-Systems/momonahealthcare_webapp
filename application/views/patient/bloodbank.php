<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-3">
                <div class="box box-primary">
                    <div class="box-body box-profile">
                        <?php
                            $image = $result['image'];
                            if (!empty($image)) {

                                $file = $result['image'];
                            } else {

                                $file = "uploads/patient_images/no_image.png";
                            }
                            ?>
                        <img class="profile-user-img img-responsive img-circle" src="<?php echo base_url() . $file.img_time(); ?>" alt="User profile picture">
                        <h3 class="profile-username text-center"><?php echo $result['patient_name']; ?></h3>
                        <ul class="list-group list-group-unbordered">
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('patient_id'); ?></b> <a class="pull-right text-aqua"><?php echo $result['id']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('gender'); ?></b> <a class="pull-right text-aqua"><?php echo $result['gender']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('marital_status'); ?></b> <a class="pull-right text-aqua"><?php echo $result['marital_status']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('phone'); ?></b> <a class="pull-right text-aqua"><?php echo $result['mobileno']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('email'); ?></b> <a class="pull-right text-aqua"><?php echo $result['email']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('address'); ?></b> <a class="pull-right text-aqua"><?php echo $result['address']; ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('age') ?></b> <a class="pull-right text-aqua"><?php
                                  echo $this->customlib->getPatientAge($result['age'],$result['month'],$result['day'])
                                ?></a>
                            </li>
                            <li class="list-group-item listnoback">
                                <b><?php echo $this->lang->line('guardian_name'); ?></b> <a class="pull-right text-aqua"><?php echo $result['guardian_name']; ?></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active" ><a href="#bloodissue" data-toggle="tab" aria-expanded="true"><i class="fas fa-diagnoses"></i> <?php echo $this->lang->line('blood_issue'); ?></a></li>
                        <li ><a href="#activity" data-toggle="tab" aria-expanded="true"><i class="far fa-caret-square-down"></i> <?php echo $this->lang->line('component_issue'); ?></a></li>                        
                        
                    </ul>
                    <div class="impbtnview">
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="bloodissue">
                            <div class="box-tab-header">
                                <h3 class="box-tab-title"><?php echo $this->lang->line('blood_issue'); ?></h3>
                            </div>
                            <div class="download_label"><?php echo $result['patient_name'] . " " . $this->lang->line('blood_issue'); ?></div>
                            <div class="table-responsive">
                                 <table class="table table-striped table-bordered table-hover bloodissuelist">
                                    <thead>
                                        <tr> 
                                            <th><?php echo $this->lang->line('bill_no'); ?></th>
                                            <th><?php echo $this->lang->line('issue_date'); ?></th>
                                            <th><?php echo $this->lang->line('received_to'); ?></th>
                                            <th><?php echo $this->lang->line('blood_group'); ?></th> 
                                            <th><?php echo $this->lang->line('gender'); ?></th>
                                            <th><?php echo $this->lang->line('donor_name'); ?></th>
                                            <th><?php echo $this->lang->line('bags'); ?></th>
                                        
                                            <?php 
                                                if (!empty($blood_issuefields)) {
                                                    foreach ($blood_issuefields as $fields_key => $fields_value) {
                                                        ?>
                                                        <th class="white-space-nowrap"><?php echo $fields_value->name; ?></th>
                                                        <?php
                                                    } 
                                                }
                                            ?> 
                                            <th class="text-right"><?php echo $this->lang->line('amount') . " (" . $currency_symbol . ")"; ?></th>
                                            <th class="text-right"><?php echo $this->lang->line('paid_amount') . " (" . $currency_symbol . ")"; ?></th>
                                            <th class="text-right"><?php echo $this->lang->line('balance_amount') . " (" . $currency_symbol . ")"; ?></th>
                                            <th class="text-right"><?php echo $this->lang->line('action') ; ?></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="activity">
                            <div class="box-tab-header">
                                <h3 class="box-tab-title"><?php echo $this->lang->line('component_issue'); ?></h3>
                            </div>
                            <div class="download_label"><?php echo $result['patient_name'] . " " . $this->lang->line('component_issue'); ?></div> 
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover componentlist">
                                    <thead>
                                      <tr>
                                        <th><?php echo $this->lang->line('bill_no'); ?></th>
                                        <th><?php echo $this->lang->line('issue_date'); ?></th>
                                        <th><?php echo $this->lang->line('received_to'); ?></th>
                                        <th><?php echo $this->lang->line('blood_group'); ?></th> 
                                        <th><?php echo $this->lang->line('component'); ?></th> 
                                        <th><?php echo $this->lang->line('gender'); ?></th>
                                        <th><?php echo $this->lang->line('donor_name'); ?></th>
                                        <th><?php echo $this->lang->line('bags'); ?></th>
                                        <?php
                                            if (!empty($fields)) {
                                                foreach ($fields as $fields_key => $fields_value) {
                                                    ?>
                                                <th class="white-space-nowrap"><?php echo $fields_value->name; ?></th>
                                        <?php } } ?>
                                        <th class="text-right"><?php echo $this->lang->line('amount') . " (" . $currency_symbol . ")"; ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('paid_amount') . " (" . $currency_symbol . ")"; ?></th>
                                        <th class="text-right"><?php echo $this->lang->line('balance_amount') . " (" . $currency_symbol . ")"; ?></th>
                                          <th class="text-right"><?php echo $this->lang->line('action') ; ?></th>
                                        
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Diagnosis -->                        
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<div id="payMoney" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('make_payment') ?></h4>
            </div>
            <form id="payment_form" class="form-horizontal modal_payment" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="amount" class="col-sm-3 control-label"><?php echo $this->lang->line('payment_amount'); ?> (<?php echo $currency_symbol; ?>)</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="deposit_amount" id="amount_total_paid" >
                             <input type="hidden" class="form-control" name="net_amount" id="net_amount" >
                            <span id="deposit_amount_error" class="text text-danger"></span>
                            <input type="hidden" name="payment_for" value="blood_bank">
                            <input type="hidden" id="bill_id_modal" name="id" value="">
                            <input type="hidden" id="blood_donor_cycle_id" name="blood_donor_cycle_id" value="">
                        </div>
                    </div>
                </div>
            </form>    
                <div class="modal-footer">
                    <button id="pay_button" class="btn btn-info pull-right payment_radio"><?php echo $this->lang->line('add'); ?></button>
                </div>
        </div>
    </div>
</div>

<div class="modal fade" id="allpayments" tabindex="-1" role="dialog" aria-labelledby="follow_up">   
    <div class="modal-dialog modal-mid modal-lg" role="document">
        <div class="modal-content modal-media-content">
            <div class="modal-header modal-media-header">
                <button type="button" class="close"  data-dismiss="modal">&times;</button>
               <div class="modalicon"> 
                     <div id='allpayments_print'>
                    </div>
                </div>
                <h4 class="modal-title"><?php echo $this->lang->line('payments'); ?></h4>
            </div>
            <div class="pup-scroll-area pb0">
                 <div class="modal-body pt0 pb0" id="allpayments_result">

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
  function holdModal(modalId) {
        $('#' + modalId).modal({
            backdrop: 'static',
            keyboard: false,
            show: true
        });
    }
    function payModal(bill_id,balance_amount){
        $("#bill_id_modal").val(bill_id);
        $("#amount_total_paid").val(balance_amount.toFixed(2));
        $("#net_amount").val(balance_amount);
        $("#payMoney").modal({backdrop:'static'});
    }

    $('#pay_button').click(function(){
        var formdata = new FormData($('#payment_form')[0]);
        $.ajax({
            url: base_url+'patient/pay/checkvalidate',
            type: "POST",
            data: formdata, 
            dataType: 'json',
            cache : false,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.status == "fail") {
                    var message = "";
                    $.each(data.error, function (index, value) {
                        message += value;
                    });
                    errorMsg(message);
                } else {
                    window.location.replace(base_url+'patient/pay');
                }
            }
        })
    })

    $(document).ready(function () {
       $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $($.fn.dataTable.tables(true)).DataTable()
           .columns.adjust()
           .responsive.recalc();
        });   
    });
</script> 
<script type="text/javascript">
( function ( $ ) {
    var id = "<?php echo $result['id']; ?>";
    'use strict';
   
     $(document).ready(function () { 
        initDatatable('bloodissuelist','patient/dashboard/getbloodissueDatatable/'+ id,{},[],100,
                        [
                            {"aTargets": [ -1,-2,-3 ] ,'sClass': 'dt-body-right'},
                            {"aTargets": [ 1,2 ] ,'sClass': 'dt-body-left'},
                            {"aTargets": [ 6 ] ,'sClass': 'dt-body-left'},
                            {"aTargets": [ 3,7 ] ,'sClass': 'dt-body-left'},
                          
                        ]);
    });

    $(document).ready(function () {
        initDatatable('componentlist','patient/dashboard/getcomponentissueDatatable/'+ id,{},[],100,
                        [
                            {"aTargets": [ -1,-2,-3 ] ,'sClass': 'dt-body-right'},
                            {"aTargets": [ 1,2 ] ,'sClass': 'dt-body-left'},
                            {"aTargets": [ 6 ] ,'sClass': 'dt-body-left'},
                            {"aTargets": [ 3,7 ] ,'sClass': 'dt-body-left'},
                          
                        ]);
    });
} ( jQuery ) ) 

    $(document).on('click','.printIssueBill',function(){   

      var $this = $(this);
         var record_id=$this.data('recordId')
       $this.button('loading');
      $.ajax({
          url: base_url+'patient/dashboard/printBloodIssueBill',
          type: "POST",
          data:{'id':record_id},
          dataType: 'json',
           beforeSend: function() {
           $this.button('loading');
      
          },
          success: function(res) {
     popup(res.page);
       
          },
             error: function(xhr) { // if error occured
          alert("<?php echo $this->lang->line('error_occurred_please_try_again'); ?>");
        $this.button('reset');
              
         },
              complete: function() {
    $this.button('reset');
                 
             }
      });
  }); 

       $(document).on('click','.printcomponentIssueBill',function(){

      var $this = $(this);
         var record_id=$this.data('recordId')
       $this.button('loading');
      $.ajax({
          url: base_url+'patient/dashboard/printcomponentIssueBill',
          type: "POST",
          data:{'id':record_id},
          dataType: 'json',
           beforeSend: function() {
           $this.button('loading');

          },
          success: function(res) {
     popup(res.page);

          },
             error: function(xhr) { // if error occured
          alert("<?php echo $this->lang->line('error_occurred_please_try_again'); ?>");
        $this.button('reset');

         },
              complete: function() {
    $this.button('reset');

             }
      });
  });
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
        frameDoc.document.write('</head>');
        frameDoc.document.write('<body >');
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
</script>
<script>
    $(document).on('click','.view_payment',function(){  
        
             var record_id=$(this).data('recordId'); 
             var module_type =$(this).data('module_type');
            getPayments(record_id,module_type);
     });

    function getPayments(record_id,module_type){
        
         $.ajax({
             url: '<?php echo base_url(); ?>patient/dashboard/getpayment',
             type: "POST",
             data: {'id': record_id,module_type:module_type},
             dataType:"JSON",
             beforeSend: function(){

             },          
             success: function (data) {
          
                $('#allpayments_result').html(data.page);
                $('#allpayments').modal({
                backdrop: 'static',
                keyboard: false,
                show: true             
            
             });
         }
              
         });

     }

    $(document).on('click','.print_trans',function(){
      var $this = $(this);
      var record_id=$this.data('recordId');
       var module_type =$(this).data('moduleType');
      $this.button('loading');
      $.ajax({
          url: '<?php echo base_url(); ?>patient/dashboard/printbilltransaction',
          type: "POST",
          data:{'id':record_id,'module_type':module_type},
          dataType: 'json',
           beforeSend: function() {
                 $this.button('loading');
      
          },
          success: function(res) {
           popup(res.page);
          },
             error: function(xhr) { // if error occured
          alert("Error occured.please try again");
                  $this.button('reset');
              
         },
              complete: function() {
                   $this.button('reset');
                 
             }
      });
  });
</script>