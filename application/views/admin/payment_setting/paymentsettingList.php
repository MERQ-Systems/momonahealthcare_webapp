<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <?php $this->load->view('setting/sidebar'); ?>
            <div class="col-md-8"> 

                <div class="nav-tabs-custom">
                    <div class="box-header with-border">
                       <h3 class="box-title titlefix"><?php echo $this->lang->line('payment_methods'); ?></h3>
                    </div>   
                   <ul class="nav nav-tabs navlistscroll">
                        <li class="active"><a href="#tab_1" data-toggle="tab"><?php echo $this->lang->line('paypal'); ?></a></li>
                        <li><a href="#tab_2" data-toggle="tab"><?php echo $this->lang->line('stripe'); ?></a></li>
                        <li><a href="#tab_3" data-toggle="tab"><?php echo $this->lang->line('payu'); ?></a></li>
                        <li><a href="#tab_14" data-toggle="tab"><?php echo $this->lang->line('ccavenue'); ?></a></li>
                        <li><a href="#tab_5" data-toggle="tab"><?php echo $this->lang->line('instamojo'); ?></a></li>
                        <li><a href="#tab_6" data-toggle="tab"><?php echo $this->lang->line('paystack'); ?></a></li>
                        <li><a href="#tab_7" data-toggle="tab"><?php echo $this->lang->line('razorpay'); ?></a></li>          
                        <li><a href="#tab_8" data-toggle="tab"><?php echo $this->lang->line('paytm'); ?></a></li>
                        <li><a href="#tab_9" data-toggle="tab"><?php echo $this->lang->line('midtrans'); ?></a></li>      
                        <li><a href="#tab_10" data-toggle="tab"><?php echo $this->lang->line('pesapal'); ?></a></li>
                        <li><a href="#tab_15" data-toggle="tab"><?php echo $this->lang->line('flutter_wave'); ?></a></li>    
                        <li><a href="#tab_11" data-toggle="tab"><?php echo $this->lang->line('ipay_africa'); ?></a></li>
                        <li><a href="#tab_13" data-toggle="tab"><?php echo $this->lang->line('jazzcash'); ?></a></li>
                        <li><a href="#tab_12" data-toggle="tab"><?php echo $this->lang->line('billplz'); ?></a></li>       
                        <li><a href="#tab_16" data-toggle="tab"><?php echo $this->lang->line('sslcommerz'); ?></a></li>
                        <li><a href="#tab_17" data-toggle="tab"><?php echo $this->lang->line('walkingm'); ?></a></li>
                    </ul>
                    <div class="tab-content pb0">
                        <div class="tab-pane active" id="tab_1">
                            <form role="form" id="paypal" action="<?php echo site_url('admin/paymentsettings/paypal') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $paypal_result = check_in_array('paypal', $paymentlist);
                                                ?>
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('paypal_username'); ?> <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input autofocus="" id="name" name="paypal_username" placeholder="" type="text" class="form-control col-md-7 col-xs-12" value="<?php echo isset($paypal_result->api_username) ? $paypal_result->api_username : ""; ?>" />
                                                        <span class=" text text-danger paypal_username_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('paypal_password'); ?> <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input id="name" name="paypal_password" placeholder="" type="password" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paypal_result->api_password) ? $paypal_result->api_password : ""; ?>" />
                                                        <span class=" text text-danger paypal_password_error"></span>
                                                    </div></div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('paypal_signature'); ?> <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input id="name" name="paypal_signature" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paypal_result->api_signature) ? $paypal_result->api_signature : ""; ?>" />
                                                        <span class=" text text-danger paypal_signature_error"></span>
                                                    </div>  
												</div>
                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.paypal.com/in/home" target="_blank"><img src="<?php echo base_url() ?>backend/images/paypal.png" width="200"><p>https://www.paypal.com</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                            <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                <div class="box-footer">
                                    <button type="submit" class="btn btn-primary col-md-offset-3 paypal_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                </div>
                            <?php } ?>
                            </form>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">
                            <form role="form" id="stripe" id="stripe" action="<?php echo site_url('admin/paymentsettings/stripe') ?>" class="form-horizontal" method="post">
                                <div class="box-body minheight149">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $stripe_result = check_in_array('stripe', $paymentlist);
                                                ?>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('stripe_api_secret_key'); ?> <small class="req"> *</small></label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="api_secret_key" value="<?php echo isset($stripe_result->api_secret_key) ? $stripe_result->api_secret_key : ""; ?>">
                                                        <span class=" text text-danger api_secret_key_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label">
                                                        <?php echo $this->lang->line('stripe_publishable_key'); ?> <small class="req"> *</small></label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="api_publishable_key" value="<?php echo isset($stripe_result->api_publishable_key) ? $stripe_result->api_publishable_key : ""; ?>">
                                                        <span class=" text text-danger api_publishable_key_error"></span>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://stripe.com/" target="_blank"><img src="<?php echo base_url() ?>backend/images/stripe.png"><p>https://stripe.com</p></a>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!-- /.box-body -->
                                 <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                <div class="box-footer">
                                    <button type="submit" class="btn btn-primary col-md-offset-3 stripe_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                </div>
                            <?php } ?>
                            </form>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_3">
                            <form role="form" id="payu" id="custom" action="<?php echo site_url('admin/paymentsettings/payu') ?>" class="form-horizontal" method="post">
                                <div class="box-body minheight149">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $payu_result = check_in_array('payu', $paymentlist);
                                                ?>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('payu_money_key'); ?> <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="key" value="<?php echo isset($payu_result->api_secret_key) ? $payu_result->api_secret_key : ""; ?>">
                                                        <span class="text text-danger key_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('payu_money_salt'); ?> <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="salt" value="<?php echo isset($payu_result->salt) ? $payu_result->salt : ""; ?>">
                                                        <span class="text text-danger salt_error"></span>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.payumoney.com" target="_blank"><img src="<?php echo base_url() ?>backend/images/paym.png"><p>https://www.payumoney.com</p></a>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!-- /.box-body -->
                                 <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                <div class="box-footer">
                                    <button type="submit" class="btn btn-primary col-md-offset-3 payu_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                </div>
                            <?php } ?>
                            </form>
                        </div>
                        <!-- /.tab-pane -->
<div class="tab-pane" id="tab_5">
                            <form role="form" id="instamojo"  action="<?php echo site_url('admin/paymentsettings/instamojo') ?>" class="form-horizontal" method="post">
                                <div class="box-body minheight149">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $instamojo_result = check_in_array('instamojo', $paymentlist);
                                                ?>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label">
                                                        <?php echo $this->lang->line('private_api_key'); ?>
                                                       <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="instamojo_apikey" value="<?php echo isset($instamojo_result->api_secret_key) ? $instamojo_result->api_secret_key : ""; ?>">
                                                        <span class="text text-danger instamojo_apikey_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label">
                                                        <?php echo $this->lang->line('private_auth_token'); ?>

                                                        <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="instamojo_authtoken" value="<?php echo isset($instamojo_result->api_publishable_key) ? $instamojo_result->api_publishable_key : ""; ?>">
                                                        <span class="text text-danger instamojo_authtoken_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label">
                                                        <?php echo $this->lang->line('private_salt'); ?>

                                                      <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="instamojo_salt" value="<?php echo isset($instamojo_result->salt) ? $instamojo_result->salt : ""; ?>">
                                                        <span class="text text-danger instamojo_salt_error"></span>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.instamojo.com/" target="_blank"><img src="<?php echo base_url() ?>backend/images/instamojo.png" width="200"><p>https://www.instamojo.com/</p></a>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 instamojo_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane " id="tab_6">
                            <form role="form" id="paystack" action="<?php echo site_url('admin/paymentsettings/paystack') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $paystack_result = check_in_array('paystack', $paymentlist);
                                               
                                                ?>
                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                         <?php echo $this->lang->line('paystack_secret_key'); ?>


                                                      <small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="paystack_secretkey" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paystack_result->api_secret_key) ? $paystack_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger paystack_secretkey_error"></span>
                                                    </div>  </div>


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://paystack.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/paystack.png" width="200"><p>https://paystack.com</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 paystack_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane " id="tab_7">
                            <form role="form" id="razorpay" action="<?php echo site_url('admin/paymentsettings/razorpay') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $razorpay_result = check_in_array('razorpay', $paymentlist);
                                            
                                                ?>                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('razorpay_key_id'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="razorpay_keyid" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($razorpay_result->api_publishable_key) ? $razorpay_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger razorpay_keyid_error"></span>
                                                    </div>  </div>
                                                    <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('razorpay_key_secret'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="razorpay_secretkey" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($razorpay_result->api_secret_key) ? $razorpay_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger razorpay_secretkey_error"></span>
                                                    </div>  </div>
                                                    


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://razorpay.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/razorpay.jpg" width="200"><p>https://razorpay.com/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 razorpay_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>

 
                         <div class="tab-pane " id="tab_8">
                            <form role="form" id="paytm" action="<?php echo site_url('admin/paymentsettings/paytm') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $paytm_result = check_in_array('paytm', $paymentlist);
                                               

                                                ?>
                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('merchant_id'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="paytm_merchantid" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paytm_result->api_publishable_key) ? $paytm_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger paytm_merchantid_error"></span>
                                                    </div>  </div>
                                                    <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('merchant_key'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="paytm_merchantkey" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paytm_result->api_secret_key) ? $paytm_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger paytm_merchantkey_error"></span>
                                                    </div>  </div>
                                                      <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('website'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="paytm_website" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paytm_result->paytm_website) ? $paytm_result->paytm_website : ""; ?>" />
                                                        <span class=" text text-danger paytm_website_error"></span>
                                                    </div>  </div>
                                                    <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('industry_type'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="paytm_industrytype" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($paytm_result->paytm_industrytype) ? $paytm_result->paytm_industrytype : ""; ?>" />
                                                        <span class=" text text-danger paytm_industrytype_error"></span>
                                                    </div>  </div>


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://paytm.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/paytm.jpg" width="200"><p>https://paytm.com/</p></a>
                                            </div>
                                        </div>

                                    </div>


                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 paytm_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane " id="tab_9">
                            <form role="form" id="midtrans" action="<?php echo site_url('admin/paymentsettings/midtrans') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $midtrans_result = check_in_array('midtrans', $paymentlist);
                                               

                                                ?>
                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('server_key');  ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="midtrans_serverkey" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($midtrans_result->api_secret_key) ? $midtrans_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger midtrans_serverkey_error"></span>
                                                    </div>  </div>
                                                   
                                                   


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://midtrans.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/midtrans.jpg" width="200"><p>https://midtrans.com/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 midtrans_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane " id="tab_10">
                            <form role="form" id="pesapal" action="<?php echo site_url('admin/paymentsettings/pesapal') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row"> 
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $pesapal_result = check_in_array('pesapal', $paymentlist);
                                               

                                                ?>
                                                
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('consumer_key'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="pesapal_consumer_key" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($pesapal_result->api_publishable_key) ? $pesapal_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger pesapal_consumer_key_error"></span>
                                                    </div>  </div>
                                                    <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('consumer_secret'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="pesapal_consumer_secret" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($pesapal_result->api_secret_key) ? $pesapal_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger pesapal_consumer_secret_error"></span>
                                                    </div>  </div>
                                                   
                                                   


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.pesapal.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/pesapal.jpg" width="200"><p>https://www.pesapal.com/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 midtrans_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>
                          <div class="tab-pane " id="tab_11">
                            <form role="form" id="ipayafrica" action="<?php echo site_url('admin/paymentsettings/ipayafrica') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $ipayafrica_result = check_in_array('ipayafrica', $paymentlist);                                         

                                                ?>
                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('vendor_id'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="ipayafrica_vendorid" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($ipayafrica_result->api_publishable_key) ? $ipayafrica_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger ipayafrica_vendorid_error"></span>
                                                    </div>  </div>
                                                    <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('hashkey'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="ipayafrica_hashkey" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($ipayafrica_result->api_secret_key) ? $ipayafrica_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger ipayafrica_hashkey_error"></span>
                                                    </div>  </div>
                                                   
                                                   


                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://ipayafrica.com/" target="_blank"><img src="<?php echo base_url();?>/backend/images/ipayafrica.png" width="200"><p>https://ipayafrica.com//</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 midtrans_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>
                         <div class="tab-pane " id="tab_12">
                            <form role="form" id="billplz" action="<?php echo site_url('admin/paymentsettings/billplz') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $billplz_result = check_in_array('billplz', $paymentlist);
                                                ?>

                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('api_key'); ?>
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="billplz_api_key" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($billplz_result->api_secret_key) ? $billplz_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger billplz_api_key_error"></span>
                                                    </div>  </div>
                                                     <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                         <?php echo $this->lang->line('customer_service_email'); ?>
                                                     
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="billplz_customer_service_email" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($billplz_result->api_email) ? $billplz_result->api_email : ""; ?>" />
                                                        <span class=" text text-danger billplz_customer_service_email_error"></span>
                                                    </div>  </div>
                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.billplz.com/" target="_blank">
                                                    <h5><?php echo $this->lang->line('payment_gateway_for_malaysia');?></h5>
                                                    <img src="<?php echo base_url(); ?>/backend/images/billplz.jpg" width="200"><p>https://www.billplz.com/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                        <button type="submit" class="btn btn-primary col-md-offset-3 jazzcash_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                    <?php } ?>
                                </div>
                            </form>
                        <!-- /.tab-pane -->


                    </div>
                    <div class="tab-pane " id="tab_13">
                            <form role="form" id="jazzcash" action="<?php echo site_url('admin/paymentsettings/jazzcash') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $jazzcash_result = check_in_array('jazzcash', $paymentlist);
                                                ?>

                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('pp_merchantid'); ?>
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="jazzcash_pp_MerchantID" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($jazzcash_result->api_secret_key) ? $jazzcash_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger jazzcash_pp_MerchantID_error"></span>
                                                    </div>  </div>
                                                     <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('pp_password'); ?>
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="jazzcash_pp_Password" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($jazzcash_result->api_password) ? $jazzcash_result->api_password : ""; ?>" />
                                                        <span class=" text text-danger jazzcash_pp_Password_error"></span>
                                                    </div>  
                                                </div>
                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.jazzcash.com.pk/" target="_blank">
                                                    <h5><?php echo $this->lang->line('payment_gateway_for_pakistan');?></h5>
                                                    <img src="<?php echo base_url(); ?>/backend/images/jazzcash.jpg" width="200"><p>https://www.jazzcash.com.pk/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                        <button type="submit" class="btn btn-primary col-md-offset-3 jazzcash_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                    <?php } ?>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane" id="tab_14">
                            <form role="form" id="ccavenue"  action="<?php echo site_url('admin/paymentsettings/ccavenue') ?>" class="form-horizontal" method="post">
                                <div class="box-body minheight149">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $ccavenue_result = check_in_array('ccavenue', $paymentlist);
                                                ?>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('merchant_id'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="ccavenue_secret" value="<?php echo isset($ccavenue_result->api_secret_key) ? $ccavenue_result->api_secret_key : ""; ?>">
                                                        <span class="text text-danger ccavenue_secret_error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('working_key'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="ccavenue_salt" value="<?php echo isset($ccavenue_result->salt) ? $ccavenue_result->salt : ""; ?>">
                                                        <span class="text text-danger ccavenue_salt_error"></span>
                                                    </div> 
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-5 control-label"><?php echo $this->lang->line('access_code'); ?><small class="req"> *</small>
                                                    </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="ccavenue_api_publishable_key" value="<?php echo isset($ccavenue_result->api_publishable_key) ? $ccavenue_result->api_publishable_key : ""; ?>">
                                                        <span class="text text-danger ccavenue_api_publishable_key_error"></span>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.ccavenue.com" target="_blank">
                                                    <h5><?php echo $this->lang->line('payment_gateway_for_india');?></h5>
                                                    <img src="<?php echo base_url() ?>backend/images/ccavenue.png" width="200"><p>https://www.ccavenue.com</p></a>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                        <button type="submit" class="btn btn-primary col-md-offset-3 ccavenue_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                    <?php } ?>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane " id="tab_15">
                            <form role="form" id="flutterwave" action="<?php echo site_url('admin/paymentsettings/flutterwave') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $flutterwave_result = check_in_array('flutterwave', $paymentlist);
                                               
  
                                                ?>
                                               
                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('public_key'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="public_key" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($flutterwave_result->api_publishable_key) ? $flutterwave_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger public_key_error"></span>
                                                    </div>  </div>
                                                   <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                       <?php echo $this->lang->line('secret_key'); ?>
                                                    <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="secret_key" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($flutterwave_result->api_secret_key) ? $flutterwave_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger secret_key_error"></span>
                                                    </div>  
                                                </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://flutterwave.com/us/" target="_blank">
                                                    <h5><?php echo $this->lang->line('multinational_payment_gateway');?></h5>
                                                    <img src="<?php echo base_url();?>/backend/images/flutterwave.png" width="200"><p>https://flutterwave.com/us</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                     <?php if($this->rbac->hasPrivilege('payment_methods', 'can_edit')){ ?>
                                    <button type="submit" class="btn btn-primary col-md-offset-3 midtrans_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                <?php } ?>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane " id="tab_16">
                            <form role="form" id="sslcommerz" action="<?php echo site_url('admin/paymentsettings/sslcommerz') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-7">
                                                <?php
                                                $sslcommerz_result = check_in_array('sslcommerz', $paymentlist);
                                               
  
                                                ?>
                                               
                                                 <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('store_id'); ?>
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="sslcommerz_api_key" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($sslcommerz_result->api_publishable_key) ? $sslcommerz_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger sslcommerz_api_key_error"></span>
                                                    </div>  </div>
                                                       <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                         <?php echo $this->lang->line('store_password'); ?>
                                                     
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="sslcommerz_store_password" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($sslcommerz_result->api_password) ? $sslcommerz_result->api_password : ""; ?>" />
                                                        <span class=" text text-danger sslcommerz_store_password_error"></span>
                                                    </div>  </div>

                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://www.sslcommerz.com/" target="_blank">
                                                    <h5><?php echo $this->lang->line('payment_gateway_for_bangladesh');?></h5>
                                                    <img src="<?php echo base_url(); ?>/backend/images/sslcommerz.png" width="200"><p>https://www.sslcommerz.com/</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                 <div class="box-footer">
                                    <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                        <button type="submit" class="btn btn-primary col-md-offset-3 sslcommerz_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                    <?php } ?>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane " id="tab_17">
                            <form role="form" id="walkingm" action="<?php echo site_url('admin/paymentsettings/walkingm') ?>" class="form-horizontal" method="post">
                                <div class="box-body">
                                    <div class="row">
                                            <div class="col-md-7">
                                                <?php
                                                $walkingm_result = check_in_array('walkingm', $paymentlist);
                                                ?>

                                                <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                        <?php echo $this->lang->line('client_id'); ?>
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="walkingm_client_id" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($walkingm_result->api_publishable_key) ? $walkingm_result->api_publishable_key : ""; ?>" />
                                                        <span class=" text text-danger walkingm_client_id_error"></span>
                                                    </div>  </div>
                                                     <div class="form-group">
                                                    <label class="control-label col-md-5 col-sm-12 col-xs-12" for="exampleInputEmail1">
                                                         <?php echo $this->lang->line('client_secret'); ?>
                                                     
                                                        <small class="req"> *</small></label>
                                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                                        <input  name="walkingm_client_secret" placeholder="" type="text" class="form-control col-md-7 col-xs-12"  value="<?php echo isset($walkingm_result->api_secret_key) ? $walkingm_result->api_secret_key : ""; ?>" />
                                                        <span class=" text text-danger walkingm_client_secret_error"></span>
                                                    </div>  </div>
                                            </div>
                                            <div class="col-md-5 text text-center disblock">
                                                <a href="https://walkingm.com/" target="_blank">
                                                    <h5><?php echo $this->lang->line('payment_gateway_for_liberia');?></h5><br>
                                                    <img src="<?php echo base_url(); ?>/backend/images/walkingm.png" width="200"><br><br><p>https://walkingm.com/</p></a>
                                            </div>
                                    </div>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                            <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                                                <button type="submit" class="btn btn-primary walkingm_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                                            <?php } ?>
                                        </div>
                                    </div>        
                                </div>
                            </form>
                        </div>

                    </div>
                    <!-- /.tab-content -->
                </div>
            </div>
            <div class="col-md-2">
                <div class="box box-primary">
                    <form role="form" action="<?php echo site_url('admin/paymentsettings/setting') ?>" id="payment_gateway" method="POST">
                        <div class="box-body">
                            <div class="form-group"> <!-- Radio group !-->
                                <?php
                                $radio_check = check_selected($paymentlist);
                                ?>

                                <label class="control-label"><?php echo $this->lang->line('select_payment_gateway'); ?> </label>

                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" name="payment_setting" value="paypal" <?php
                                        if ($radio_check == 'paypal') {
                                            echo "checked";
                                        }
                                        ?>>
                                        Paypal
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="stripe" <?php
                                        if ($radio_check == 'stripe') {
                                            echo "checked";
                                        }
                                        ?>>
                                        Stripe
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="payu" <?php
                                        if ($radio_check == 'payu') {
                                            echo "checked";
                                        }
                                        ?>>
                                        PayU
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="ccavenue" <?php
                                        if ($radio_check == 'ccavenue') {
                                            echo "checked";
                                        }
                                        ?>>
                                        CCAvenue
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="instamojo" <?php
                                        if ($radio_check == 'instamojo') {
                                            echo "checked";
                                        }
                                        ?>>
                                        Instamojo
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" name="payment_setting" value="paystack" <?php
                                        if ($radio_check == 'paystack') {
                                            echo "checked";
                                        }
                                        ?>>
                                        Paystack
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="razorpay" <?php
                                        if ($radio_check == 'razorpay') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Razorpay</label>
                                </div>                                
								<div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="paytm" <?php
                                        if ($radio_check == 'paytm') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Paytm</label>
                                </div>                              
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="midtrans" <?php
                                        if ($radio_check == 'midtrans') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Midtrans</label>
                                </div>                                
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="pesapal" <?php
                                        if ($radio_check == 'pesapal') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Pesapal</label>
                                </div> 
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="flutterwave" <?php
                                        if ($radio_check == 'flutterwave') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Flutter Wave</label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="ipayafrica" <?php
                                        if ($radio_check == 'ipayafrica') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    iPay Africa</label>
                                </div>                                    
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="jazzcash" <?php
                                        if ($radio_check == 'jazzcash') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    JazzCash</label>
                                </div>                            

                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="billplz" <?php
                                        if ($radio_check == 'billplz') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    Billplz</label>
                                </div>                           
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="sslcommerz" <?php
                                        if ($radio_check == 'sslcommerz') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    <?php echo ('SSLCommerz'); ?></label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="walkingm" <?php
                                        if ($radio_check == 'walkingm') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    <?php echo $this->lang->line('walkingm'); ?></label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio"  name="payment_setting" value="none" <?php
                                        if ($radio_check == 'none') {
                                            echo "checked";
                                        }
                                        ?>>
                                        
                                    <?php echo $this->lang->line('none'); ?></label>
                                </div>
                                 <span class="text text-danger payment_setting_error"></span>
                            </div>		
                        </div>
                        <!-- /.box-body -->
                    <?php if ($this->rbac->hasPrivilege('payment_methods', 'can_edit')) { ?>
                        <div class="box-footer">
                            <button type="submit" class="btn btn-primary pull-right payment_gateway_save" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $this->lang->line('save'); ?>"> <i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                        </div>
                    <?php } ?>
                    </form>
                </div>
            </div>
        </div>  
    </section>
</div>

<?php

function check_selected($array) {
    $selected = "none";
    if (!empty($array)) {

        foreach ($array as $a => $element) {
            if ($element->is_active == "yes") {
                $selected = $element->payment_type;
            }
        }
    }
    return $selected;
}

function check_in_array($find, $array) {
    if (!empty($array)) {

        foreach ($array as $element) {

            if ($find == $element->payment_type) {
                return $element;
            }
        }
    }
    $object = new stdClass();
    $object->id = "";
    $object->type = "";
    $object->api_id = "";
    $object->username = "";
    $object->url = "";
    $object->name = "";
    $object->contact = "";
    $object->password = "";
    $object->authkey = "";
    $object->senderid = "";
    $object->is_active = "";
    return $object;
}
?>


<script type="text/javascript">

    $("#payment_gateway").submit(function (e) {
        $("[class$='_error']").html("");

        var $this = $(".payment_gateway_save");
        $this.button('loading');
        var url = $(this).attr('action'); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#payment_gateway").serialize(), // serializes the form's elements.
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
                //if fails      
            }, complete: function () {
                $this.button('reset');
            }
        });

        e.preventDefault(); // avoid to execute the actual submit of the form.
    });



    $("#paypal").submit(function (e) {
        $("[class$='_error']").html("");

        var $this = $(".paypal_save");
        $this.button('loading');
        var url = $(this).attr('action'); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#paypal").serialize(), // serializes the form's elements.
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
                //if fails      
            }, complete: function () {
                $this.button('reset');
            }
        });

        e.preventDefault(); // avoid to execute the actual submit of the form.
    });

    $("#stripe").submit(function (e) {
        $("[class$='_error']").html("");

        var $this = $(".stripe_save");
        $this.button('loading');
        var url = $(this).attr('action'); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#stripe").serialize(), // serializes the form's elements.
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
                //if fails      
            }, complete: function () {
                $this.button('reset');
            }
        });

        e.preventDefault(); // avoid to execute the actual submit of the form.
    });

    $("#payu").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".payu_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#payu").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });


    $("#twocheckout").submit(function (e) {
        $("[class$='_twocheckout_error']").html("");
        var $this = $(".twocheckout_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#twocheckout").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_twocheckout_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });



    $("#ccavenue").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".ccavenue_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#ccavenue").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#flutterwave").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".flutterwave_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#flutterwave").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".flutterwave_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    }); 

    $("#paystack").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".paystack_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#paystack").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#instamojo").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".instamojo_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#instamojo").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#razorpay").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".razorpay_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#razorpay").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

  
    $("#paytm").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".paytm_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#paytm").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });


    $("#midtrans").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".midtrans_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#midtrans").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#pesapal").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".pesapal_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#pesapal").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#jazzcash").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".jazzcash_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#jazzcash").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#billplz").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".billplz_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#billplz").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#ipayafrica").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".ipayafrica_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#ipayafrica").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".ipayafrica_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#sslcommerz").submit(function (e) {
        $("[class$='_error']").html("");
        var $this = $(".sslcommerz_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#sslcommerz").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });

    $("#walkingm").submit(function (e) {
        e.preventDefault();
        $("[class$='_error']").html("");
        var $this = $(".walkingm_save");
        $this.button('loading');
        var url = $(this).attr('action');

        $.ajax({
            type: "POST",
            dataType: 'JSON',
            url: url,
            data: $("#walkingm").serialize(),
            success: function (data, textStatus, jqXHR)
            {
                if (data.st === 1) {
                    $.each(data.msg, function (key, value) {
                        $('.' + key + "_error").html(value);
                    });
                } else {
                    successMsg(data.msg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                $(".custom_loader").html("");
            }, complete: function () {
                $this.button('reset');
            }
        });
        e.preventDefault();
    });
</script>