<aside class="main-sidebar" id="alert2">
    <?php if ($this->rbac->hasPrivilege('patient', 'can_view')) {?>
        <form class="navbar-form navbar-left search-form2" role="search"  action="<?php echo site_url('admin/admin/search'); ?>" method="POST">
            <?php echo $this->customlib->getCSRF(); ?>
            <div class="input-group ">
                <input type="text"  name="search_text" class="form-control search-form" placeholder="<?php echo $this->lang->line('search_by_name'); ?>">
                <span class="input-group-btn">
                    <button type="submit" name="search" id="search-btn" style="padding: 3px 12px !important;border-radius: 0px 30px 30px 0px; background: #fff;" class="btn btn-flat"><i class="fa fa-search"></i></button>
                </span>
            </div>
        </form>
    <?php }?> 
    <section class="sidebar" id="sibe-box">
        <?php $this->load->view('layout/top_sidemenu');?>
        <ul class="sidebar-menu verttop">
            <li class="treeview <?php echo set_Topmenu('dashboard'); ?>">
                <a href="<?php echo base_url(); ?>admin/admin/dashboard">
                   <i class="fas fa-television"></i> <span> <?php echo $this->lang->line('dashboard'); ?></span>
               </a>
           </li>
            
            <?php
                if($this->module_lib->hasActive('bill')){
                    if(($this->rbac->hasPrivilege('opd_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('opd_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('ipd_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('ipd_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('pharmacy_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('pharmacy_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('pathology_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('pathology_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('radiology_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('radiology_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('blood_bank_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('blood_bank_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('ambulance_billing','can_view')) ||
                        ($this->rbac->hasPrivilege('ambulance_billing_payment','can_view')) ||
                        ($this->rbac->hasPrivilege('generate_bill','can_view')) ||
                        ($this->rbac->hasPrivilege('generate_discharge_card','can_view'))){ ?>
                        <li class="treeview <?php echo set_Topmenu('bill'); ?>">
                                <a href="<?php echo site_url('admin/bill/dashboard'); ?>">
                                   <i class="fas fa-file-invoice"></i> <span> <?php echo $this->lang->line('billing'); ?></span>
                                </a>
                            </li>
            <?php
                    } 
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('appointment')) {
                    if ($this->rbac->hasPrivilege('online_appointment_slot','can_view')||
$this->rbac->hasPrivilege('online_appointment_doctor_shift','can_view')||
$this->rbac->hasPrivilege('online_appointment_shift','can_view')||
$this->rbac->hasPrivilege('doctor_wise_appointment','can_view')||
$this->rbac->hasPrivilege('patient_queue','can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('appointment'); ?>">
                            <a  href="<?php echo base_url(); ?>admin/appointment/index">
                                <i class="fa fa-calendar-check-o"></i> <span><?php echo $this->lang->line('appointment'); ?></span>
                            </a>
                        </li>
            <?php
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('opd')) {
                    if ($this->rbac->hasPrivilege('opd_patient', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('OPD_Out_Patient'); ?>">
                            <a href="<?php echo base_url(); ?>admin/patient/search">
                                <i class="fas fa-stethoscope"></i> <span> <?php echo $this->lang->line('opd_out_patient'); ?></span>
                            </a>
                        </li>
            <?php 
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('ipd')) {
                    if ($this->rbac->hasPrivilege('ipd_patient', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('IPD_in_patient'); ?>">
                            <a href="<?php echo base_url() ?>admin/patient/ipdsearch">
                                <i class="fas fa-procedures" aria-hidden="true"></i> <span> <?php echo $this->lang->line('ipd_in_patient'); ?></span>
                            </a>
                        </li>
            <?php 
                    }
                } 
            ?>
            <?php
                if ($this->module_lib->hasActive('pharmacy')) {
                    if ($this->rbac->hasPrivilege('pharmacy_bill', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('pharmacy'); ?>">
                            <a href="<?php echo base_url(); ?>admin/pharmacy/bill">
                                <i class="fas fa-mortar-pestle"></i> <span> <?php echo $this->lang->line('pharmacy'); ?></span>
                            </a>
                        </li>
            <?php 
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('pathology')) {
                    if ($this->rbac->hasPrivilege('pathology_test', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('pathology'); ?>">
                            <a href="<?php echo base_url(); ?>admin/pathology/gettestreportbatch">
                                <i class="fas fa-flask"></i> <span><?php echo $this->lang->line('pathology'); ?></span>
                            </a>
                        </li>
            <?php 
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('radiology')) {
                    if ($this->rbac->hasPrivilege('radiology_test', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('radiology'); ?>">
                               
                            <a href="<?php echo base_url() ?>admin/radio/gettestreportbatch">
                                <i class="fas fa-microscope"></i> <span><?php echo $this->lang->line('radiology'); ?></span>
                            </a>
                        </li>
            <?php 
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('blood_bank')) {
                    if (($this->rbac->hasPrivilege('blood_issue', 'can_view')) || 
                        ($this->rbac->hasPrivilege('blood_donor', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_stock', 'can_view')) || 
                        ($this->rbac->hasPrivilege('bloodbank_print_header_footer', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_bank_product', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_bank_components', 'can_view')) ||
                        ($this->rbac->hasPrivilege('issue_component', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_bank_product', 'can_view'))
                        ) { ?>
                            <li class="treeview <?php echo set_Topmenu('blood_bank'); ?>">
                                <a href="<?php echo base_url() ?>admin/bloodbankstatus/">
                                    <i class="fas fa-tint"></i> <span><?php echo $this->lang->line('blood_bank'); ?></span>
                                </a>
                            </li>
            <?php 
                    }
                }
            ?>
            <?php 
                if ($this->module_lib->hasActive('ambulance')) {
                    if ($this->rbac->hasPrivilege('ambulance_call', 'can_view')) {
                    ?>
                        <li class="treeview <?php echo set_Topmenu('Transport'); ?>">
                            <a href="<?php echo base_url(); ?>admin/vehicle/getcallambulance">
                                <i class="fas fa-ambulance" aria-hidden="true"></i>
                                <span> <?php echo $this->lang->line('ambulance'); ?></span>
                            </a>
                        </li>
            <?php
                    }
                } 
            ?>
            <?php
                if ($this->module_lib->hasActive('front_office')) {
                    if(($this->rbac->hasPrivilege('visitor_book','can_view')) ||
                        ($this->rbac->hasPrivilege('phone_call_log','can_view')) ||
                        ($this->rbac->hasPrivilege('postal_dispatch','can_view')) ||
                        ($this->rbac->hasPrivilege('postal_receive','can_view')) ||
                        ($this->rbac->hasPrivilege('complain','can_view')) ||
                        ($this->rbac->hasPrivilege('setup_front_office','can_view')))
                        { ?>
                            <li class="treeview <?php echo set_Topmenu('front_office'); ?>">
                                <a  href="<?php echo base_url(); ?>admin/visitors">
                                    <i class="fas fa-dungeon"></i> <span><?php echo $this->lang->line('front_office'); ?></span>
                                </a>
                            </li>
            <?php
                    }
                }
            ?>
            <?php
                if (($this->module_lib->hasActive('birth_death_report')) || ($this->module_lib->hasActive('birth_death_report'))) {
                    if (($this->rbac->hasPrivilege('birth_record', 'can_view')) || ($this->rbac->hasPrivilege('death_record', 'can_view'))) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('birthordeath'); ?>">
                            <a href="<?php echo base_url(); ?>admin/birthordeath"><i class="fa fa-birthday-cake" aria-hidden="true"></i><span> <?php echo $this->lang->line('birth_death_record'); ?></span><i class="fa fa-angle-left pull-right"></i></a>
                            <ul class="treeview-menu">
                            <?php
                                if ($this->module_lib->hasActive('birth_death_report')) {
                                    if ($this->rbac->hasPrivilege('birth_record', 'can_view')) {
                                ?>
                                    <li class="<?php echo set_Submenu('birthordeath/index'); ?>"><a href="<?php echo base_url(); ?>admin/birthordeath"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('birth_record'); ?> </a></li>
                            <?php
                                    }
                                }

                                if ($this->rbac->hasPrivilege('death_record', 'can_view')) {
                            ?>
                                <li class="<?php echo set_Submenu('birthordeath/death'); ?>"><a href="<?php echo base_url(); ?>admin/birthordeath/death"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('death_record'); ?></a></li>
                                    <?php }?>
                                        </ul>
                                    </li>
            <?php
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('human_resource')) {
                    if (($this->rbac->hasPrivilege('staff', 'can_view') ||
                        $this->rbac->hasPrivilege('staff_attendance', 'can_view') ||
                        $this->rbac->hasPrivilege('staff_attendance_report', 'can_view') ||
                        $this->rbac->hasPrivilege('staff_payroll', 'can_view') ||
                        $this->rbac->hasPrivilege('payroll_report', 'can_view'))) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('HR'); ?>">
                            <a href="<?php echo base_url(); ?>admin/staff">
                                <i class="fas fa-sitemap"></i> <span><?php echo $this->lang->line('human_resource'); ?></span>
                            </a>
                        </li>
            <?php
                    }
                }
            ?>
            <?php
                if($this->module_lib->hasActive('referral')){
                    if ($this->rbac->hasPrivilege('referral_payment', 'can_view')) {  ?>
                        <li class="treeview <?php echo set_Topmenu('referral_payment'); ?>">
                            <a href="<?php echo base_url(); ?>admin/referral/payment">
                                <i class="fas fa-users"></i> <span><?php echo $this->lang->line('referral'); ?></span>
                            </a>
                        </li>
            <?php
                    }
                }
            ?>
            <?php
                if ($this->module_lib->hasActive('tpa_management')) {
                    if ($this->rbac->hasPrivilege('organisation', 'can_view')) {
                        ?>
                        <li class="treeview <?php echo set_Topmenu('tpa_management'); ?>">
                            <a href="<?php echo base_url() ?>admin/tpamanagement">
                                <i class="fas fa-umbrella"></i> <span><?php echo $this->lang->line('tpa_management'); ?></span>
                            </a>
                        </li>
            <?php
                    }
                }
            ?>
            <?php
                if (($this->module_lib->hasActive('income')) || ($this->module_lib->hasActive('expense'))) {
                    if (($this->rbac->hasPrivilege('income', 'can_view')) || ($this->rbac->hasPrivilege('expense', 'can_view'))) {
                        ?>
                            <li class="treeview <?php echo set_Topmenu('finance'); ?>">
                                <a href="<?php echo base_url(); ?>admin/patient/search">
                                <i class="fas fa-money-bill-wave"></i> <span><?php echo $this->lang->line('finance'); ?></span> <i class="fa fa-angle-left pull-right"></i>
                                </a>
                                <ul class="treeview-menu">
                                    <?php
                                        if ($this->module_lib->hasActive('income')) {
                                            if ($this->rbac->hasPrivilege('income', 'can_view')) {
                                    ?>
                                                <li class="<?php echo set_Submenu('income/index'); ?>"><a href="<?php echo base_url(); ?>admin/income"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('income'); ?> </a></li>
                                    <?php
                                            }
                                        }
                                        if ($this->module_lib->hasActive('expense')) {
                                            if ($this->rbac->hasPrivilege('expense', 'can_view')) {
                                    ?>
                                                <li class="<?php echo set_Submenu('expense/index'); ?>"><a href="<?php echo base_url(); ?>admin/expense"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('expenses'); ?></a></li>
                                    <?php 
                                            }
                                        }
                                    ?>
                                </ul>
                            </li>
                <?php
                        }
                    }
                ?>
                <?php
                    if ($this->module_lib->hasActive('communicate')) {
                        if (($this->rbac->hasPrivilege('notice_board', 'can_view') ||
                            $this->rbac->hasPrivilege('email_sms', 'can_view') ||
                            $this->rbac->hasPrivilege('email_sms_log', 'can_view'))) {
                            ?>
                                <li class="treeview <?php echo set_Topmenu('Messaging'); ?>">
                                    <a href= "<?php echo base_url(); ?>admin/notification">
                                        <i class = "fas fa-bullhorn"></i> <span><?php echo $this->lang->line('messaging'); ?></span>
                                    </a>
                                </li>
                <?php
                        }
                    } 
                ?>
                <?php
                    if ($this->module_lib->hasActive('inventory')) {
                        if (($this->rbac->hasPrivilege('issue_item', 'can_view') ||
                            $this->rbac->hasPrivilege('item_stock', 'can_view') ||
                            $this->rbac->hasPrivilege('item', 'can_view') ||
                            $this->rbac->hasPrivilege('item_category', 'can_view') ||
                            $this->rbac->hasPrivilege('item_category', 'can_view') ||
                            $this->rbac->hasPrivilege('store', 'can_view') ||
                            $this->rbac->hasPrivilege('supplier', 'can_view'))) {
                            ?>
                            <li class="treeview <?php echo set_Topmenu('Inventory'); ?>">
                                <a href="<?php echo base_url(); ?>admin/itemstock">
                                    <i class="fas fa-luggage-cart"></i> <span><?php echo $this->lang->line('inventory'); ?></span>
                                </a>
                            </li>
                <?php
                        }
                    }
                ?>
                <?php
                    if ($this->module_lib->hasActive('download_center')) {
                        if (($this->rbac->hasPrivilege('upload_content', 'can_view'))) {
                            ?>
                            <li class="treeview <?php echo set_Topmenu('Download Center'); ?>">
                                <a href="<?php echo base_url(); ?>admin/content">
                                    <i class="fas fa-download"></i> <span><?php echo $this->lang->line('download_center'); ?></span>
                                </a>
                            </li>
                <?php
                        }
                    }
                ?>
                <?php 
                    if ($this->module_lib->hasActive('certificate')) {
                        if (($this->rbac->hasPrivilege('patient_id_card',"can_view"))||
                            ($this->rbac->hasPrivilege('generate_patient_id_card', "can_view"))||
                            ($this->rbac->hasPrivilege('staff_id_card',"can_view"))||
                            ($this->rbac->hasPrivilege('generate_staff_id_card',"can_view"))||
                            ($this->rbac->hasPrivilege('certificate',"can_view"))||
                            ($this->rbac->hasPrivilege('generate_certificate',"can_view"))) {
                            ?>
                            <li class="treeview <?php echo set_Topmenu('Certificate'); ?>">
                                <a href="#">
                                <i class="fa fa-newspaper-o ftlayer"></i> <span><?php echo $this->lang->line('certificate'); ?></span> <i class="fa fa-angle-left pull-right"></i>
                                </a>
                                <ul class="treeview-menu">
                                   <?php if ($this->rbac->hasPrivilege('certificate', 'can_view')) { ?>
                                    <li class="<?php echo set_Submenu('admin/generatecertificate'); ?>"><a href="<?php echo base_url(); ?>admin/generatecertificate"><i class="fas fa-angle-right"></i><?php echo $this->lang->line('certificate'); ?> </a></li>
                                <?php } if ($this->rbac->hasPrivilege('generate_patient_id_card', 'can_view')) { ?>
                                     <li class="<?php echo set_Submenu('admin/generatepatientidcard'); ?>"><a href="<?php echo base_url('admin/generatepatientidcard/'); ?>"><i class="fas fa-angle-right"></i><?php echo $this->lang->line('patient_id_card'); ?></a></li>
                                     <?php }  if ($this->rbac->hasPrivilege('generate_staff_id_card', 'can_view')) { ?>
                                    <li class="<?php echo set_Submenu('admin/generatestaffidcard'); ?>"><a href="<?php echo base_url('admin/generatestaffidcard/'); ?>"><i class="fas fa-angle-right"></i><?php echo $this->lang->line('staff_id_card');?></a></li>
                                <?php } ?>
                                </ul>
                            </li>
                       
                <?php 
                        }
                    }
                ?>
                <?php
                    if ($this->module_lib->hasActive('front_cms')) {
                        if (($this->rbac->hasPrivilege('event', 'can_view') ||
                            $this->rbac->hasPrivilege('gallery', 'can_view') ||
                            $this->rbac->hasPrivilege('notice', 'can_view') ||
                            $this->rbac->hasPrivilege('media_manager', 'can_view') ||
                            $this->rbac->hasPrivilege('pages', 'can_view') ||
                            $this->rbac->hasPrivilege('menus', 'can_view') ||
                            $this->rbac->hasPrivilege('banner_images', 'can_view'))) {
                            ?>
                            <li class="treeview <?php echo set_Topmenu('Front CMS'); ?>">
                                <a href="<?php echo base_url(); ?>admin/front/page">
                                    <i class="fas fa-solar-panel"></i> <span><?php echo $this->lang->line('front_cms'); ?></span>
                                </a>
                            </li>
                <?php
                        }
                    } 
                ?>
                <?php 
                    if ($this->module_lib->hasActive('live_consultation')) {
                        if (($this->rbac->hasPrivilege('live_consultation', 'can_view')) || ($this->rbac->hasPrivilege('live_meeting', 'can_view'))) {?>
                            <li class="treeview <?php echo set_Topmenu('conference'); ?>">
                               <a href="#">
                                    <i class="fa fa-video-camera ftlayer"></i> <span><?php echo $this->lang->line('live_consultation'); ?></span> <i class="fa fa-angle-left pull-right"></i>
                                </a>
                                 <ul class="treeview-menu">
                                    <?php if ($this->rbac->hasPrivilege('live_consultation', 'can_view')) {?>
                                        <li class="<?php echo set_Submenu('conference/live_consult'); ?>"><a href="<?php echo base_url('admin/zoom_conference/consult'); ?>"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('live_consultation'); ?></a></li>
                                    <?php }if ($this->rbac->hasPrivilege('live_meeting', 'can_view')) {?>
                                        <li class="<?php echo set_Submenu('conference/live_meeting'); ?>"><a href="<?php echo base_url('admin/zoom_conference/meeting'); ?>"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('live_meeting'); ?> </a></li>
                                    <?php }?>
                                </ul>
                            </li>
                <?php
                        }
                    }
                ?>
                <?php
                if ($this->module_lib->hasActive('reports')) {
                    if (($this->rbac->hasPrivilege('opd_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('staff_attendance_report' , 'can_view')) ||
                        ($this->rbac->hasPrivilege('payroll_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('ipd_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('pharmacy_bill_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('pathology_patient_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('radiology_patient_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('ot_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_donor_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('payroll_month_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('payroll_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('staff_attendance_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('user_log', 'can_view')) ||
                        ($this->rbac->hasPrivilege('patient_login_credential', 'can_view')) ||
                        ($this->rbac->hasPrivilege('email_sms_log', 'can_view')) ||
                        ($this->rbac->hasPrivilege('tpa_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('ambulance_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('discharge_patient_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('appointment_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('transaction_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('blood_issue_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('income_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('expense_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('income_group_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('expense_group_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('inventory_stock_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('add_item_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('issue_inventory_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('expiry_medicine_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('birth_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('death_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('opd_balance_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('ipd_balance_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('live_consultation_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('live_meeting_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('all_transaction_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('patient_visit_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('patient_bill_report', 'can_view')) || 
                        ($this->rbac->hasPrivilege('component_issue_report', 'can_view')) ||
                        ($this->rbac->hasPrivilege('referral_report', 'can_view'))) {
                        ?> 
                        <li class="treeview <?php echo set_Topmenu('Reports'); ?>">
                            <a href="#">
                                <i class="fas fa-line-chart"></i> <span><?php echo $this->lang->line('reports'); ?></span> <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <?php if ($this->rbac->hasPrivilege('daily_transaction_report', 'can_view')) {?>
                                          <li class="<?php echo set_Submenu('admin/transaction/dailytransactionreport'); ?>"><a href="<?php echo base_url(); ?>admin/transaction/transactionreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line("daily_transaction_report"); ?></a>
                                    </li>

                                <?php } if ($this->rbac->hasPrivilege('all_transaction_report', 'can_view')) {?>
                                  
                                <li class="<?php echo set_Submenu('admin/income/alltransactionreport'); ?>"><a href="<?php echo base_url(); ?>admin/income/alltransactionreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line("all_transaction_report"); ?></a>
                                    </li>
                                <?php } ?>
                                <?php
                                    if ($this->module_lib->hasActive('appointment')) {
                                    if ($this->rbac->hasPrivilege('appointment_report', 'can_view')) {
                                        ?>
                                        <li class="<?php echo set_Submenu('admin/appointment/appointmentreport'); ?>"><a href="<?php echo base_url(); ?>admin/appointment/appointmentreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('appointment_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('opd')) {
                                    if ($this->rbac->hasPrivilege('opd_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/opd_report'); ?>"><a href="<?php echo base_url(); ?>admin/patient/opd_report"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('opd_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('ipd')) {
                                    if ($this->rbac->hasPrivilege('ipd_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/ipdreport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/ipdreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('ipd_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('opd')) {
                                    if ($this->rbac->hasPrivilege('opd_balance_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/opdreportbalance'); ?>"><a href="<?php echo base_url(); ?>admin/patient/opdreportbalance"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('opd_balance_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('ipd')) {
                                    if ($this->rbac->hasPrivilege('ipd_balance_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/ipdreportbalance'); ?>"><a href="<?php echo base_url(); ?>admin/patient/ipdreportbalance"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('ipd_balance_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('opd')) {
                                    if ($this->rbac->hasPrivilege('discharge_patient_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/opddischargepatientReport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/opddischargepatientreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('opd_discharged_patient'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('ipd')) {
                                    if ($this->rbac->hasPrivilege('discharge_patient_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/patient/dischargepatientreport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/dischargepatientreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('ipd_discharged_patient'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('pharmacy')) {
                                    if ($this->rbac->hasPrivilege('pharmacy_bill_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/pharmacy/billreport'); ?>"><a href="<?php echo base_url(); ?>admin/pharmacy/billreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('pharmacy_balance_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('pharmacy')) {
                                    if ($this->rbac->hasPrivilege('expiry_medicine_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/expmedicine/expmedicinereport'); ?>"><a href="<?php echo base_url(); ?>admin/expmedicine/expmedicinereport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('expiry_medicine_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('pathology')) {
                                    if ($this->rbac->hasPrivilege('pathology_patient_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/pathology/pathologyreport'); ?>"><a href="<?php echo base_url(); ?>admin/pathology/pathologyreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('pathology_patient_report'); ?></a></li>
                                <?php
                                    }
                                    }
                                    if ($this->module_lib->hasActive('radiology')) {
                                    if ($this->rbac->hasPrivilege('radiology_patient_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/radio/radiologyreport'); ?>"><a href="<?php echo base_url(); ?>admin/radio/radiologyreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('radiology_patient_report'); ?></a></li>
                                <?php
                                    }
                                    } 

                                    if ($this->rbac->hasPrivilege('ot_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/operationtheatre/otreport'); ?>"><a href="<?php echo base_url(); ?>admin/operationtheatre/otreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('ot_report'); ?></a></li>
                                <?php
                                    }

                                    if ($this->module_lib->hasActive('blood_bank')) {
                                    if ($this->rbac->hasPrivilege('blood_issue_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/bloodbank/bloodissuereport'); ?>"><a href="<?php echo base_url(); ?>admin/bloodbank/bloodissuereport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('blood_issue_report'); ?></a></li>
                                <?php
                                    } 
                                    } 
                                    if ($this->module_lib->hasActive('blood_bank')) {
                                    if ($this->rbac->hasPrivilege('component_issue_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/bloodbank/componentissuereport'); ?>"><a href="<?php echo base_url(); ?>admin/bloodbank/componentissuereport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('component_issue_report'); ?></a></li>
                                <?php 
                                    }
                                    }
                                    if ($this->module_lib->hasActive('blood_bank')) {
                                    if ($this->rbac->hasPrivilege('blood_donor_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/bloodbank/blooddonorreport'); ?>"><a href="<?php echo base_url(); ?>admin/bloodbank/blooddonorreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('blood_donor_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('live_consultation')) {
                                    if ($this->rbac->hasPrivilege('live_consultation_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('zoom_conference/consult_report'); ?>"><a href="<?php echo base_url('admin/zoom_conference/consult_report'); ?>"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('live_consultation_report'); ?></a></li>
                                <?php
                                        }
                                    }

                                    if ($this->module_lib->hasActive('live_consultation')) {
                                    if ($this->rbac->hasPrivilege('live_meeting_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('zoom_conference/meeting_report'); ?>"><a href="<?php echo base_url('admin/zoom_conference/meeting_report'); ?>"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('live_meeting_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('tpa_management')) {
                                    if ($this->rbac->hasPrivilege('tpa_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/tpamanagement/tpareport'); ?>"><a href="<?php echo base_url(); ?>admin/tpamanagement/tpareport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('tpa_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('income')) {
                                    if ($this->rbac->hasPrivilege('income_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('admin/income/incomesearch'); ?>"><a href="<?php echo base_url(); ?>admin/income/incomesearch"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('income_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('income')) {
                                    if ($this->rbac->hasPrivilege('income_group_report', 'can_view')) {
                                        ?>
                                        <li class="<?php echo set_Submenu('reports/incomegroup'); ?>"><a href="<?php echo base_url(); ?>admin/income/incomegroup"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('income_group_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('expense')) {
                                    if ($this->rbac->hasPrivilege('expense_report', 'can_view')) {
                                        ?>
                                        <li class="<?php echo set_Submenu('admin/expense/expensesearch'); ?>"><a href="<?php echo base_url(); ?>admin/expense/expensesearch"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('expense_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('expense')) {
                                    if ($this->rbac->hasPrivilege('expense_group_report', 'can_view')) {
                                        ?>
                                        <li class="<?php echo set_Submenu('reports/expensegroup'); ?>"><a href="<?php echo base_url(); ?>admin/expense/expensegroup"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('expense_group_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('ambulance')) {
                                    if ($this->rbac->hasPrivilege('ambulance_report', 'can_view')) {
                                        ?><li class="<?php echo set_Submenu('admin/vehicle/ambulancereport'); ?>"><a href="<?php echo base_url(); ?>admin/vehicle/ambulancereport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('ambulance_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('birth_death_report')) {
                                    if ($this->rbac->hasPrivilege('birth_report', 'can_view')) {
                                    ?><li class="<?php echo set_Submenu('admin/birthordeath/birthreport'); ?>"><a href="<?php echo base_url(); ?>admin/birthordeath/birthreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('birth_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('birth_death_report')) {
                                    if ($this->rbac->hasPrivilege('death_report', 'can_view')) {
                                    ?><li class="<?php echo set_Submenu('admin/birthordeath/deathreport'); ?>"><a href="<?php echo base_url(); ?>admin/birthordeath/deathreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('death_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->rbac->hasPrivilege('payroll_month_report', 'can_view')) {
                                    ?>
                                        <li class="<?php echo set_Submenu('admin/payroll/payrollreport'); ?>"><a href="<?php echo base_url(); ?>admin/payroll/payrollreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('payroll_month_report'); ?></a></li>
                                                        <?php
                                    }
                                    if ($this->rbac->hasPrivilege('payroll_report', 'can_view')) {
                                    ?>
                                        <li class="<?php echo set_Submenu('admin/payroll/payrollsearch'); ?>"><a href="<?php echo base_url(); ?>admin/payroll/payrollsearch"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('payroll_report'); ?></a></li>
                                <?php
                                    }
                                    if ($this->rbac->hasPrivilege('staff_attendance_report', 'can_view')) {
                                    ?>
                                        <li class="<?php echo set_Submenu('admin/staffattendance/attendancereport'); ?>"><a href="<?php echo base_url(); ?>admin/staffattendance/attendancereport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('staff_attendance_report'); ?></a></li>
                                <?php
                                    }

                                    if ($this->rbac->hasPrivilege('user_log', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('userlog/index'); ?>"><a href="<?php echo base_url(); ?>admin/userlog"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('user_log'); ?></a></li>
                                <?php
                                    }
                                    if($this->module_lib->hasActive('patient')){
                                        if ($this->rbac->hasPrivilege('patient_login_credential', 'can_view')) {
                                ?>
                                            <li class="<?php echo set_Submenu('admin/patient/patientcredentialreport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/patientcredentialreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('patient_login_credential'); ?></a></li>
                                <?php
                                        }
                                    }

                                    if ($this->module_lib->hasActive('communicate')) {
                                    if ($this->rbac->hasPrivilege('email_sms_log', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('mailsms/index'); ?>"><a href="<?php echo base_url(); ?>admin/mailsms/index"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('email_sms_log'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('inventory')) {
                                    if ($this->rbac->hasPrivilege('inventory_stock_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('Reports/itemreport'); ?>"><a href="<?php echo base_url(); ?>admin/item/itemreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('inventory_stock_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('inventory')) {
                                    if ($this->rbac->hasPrivilege('add_item_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('Reports/additemreport'); ?>"><a href="<?php echo base_url(); ?>admin/item/additemreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('inventory_item_report'); ?></a></li>
                                <?php
                                    }
                                    }

                                    if ($this->module_lib->hasActive('inventory')) {
                                    if ($this->rbac->hasPrivilege('issue_inventory_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('Reports/issueinventoryreport'); ?>"><a href="<?php echo base_url(); ?>admin/issueitem/issueinventoryreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('inventory_issue_report'); ?></a></li>
                                <?php 
                                    }
                                    }

                                    if ($this->rbac->hasPrivilege('audit_trail_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('admin/audit/index'); ?>"><a href="<?php echo base_url(); ?>admin/audit/index"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('audit_trail_report') ; ?></a></li>
                                <?php 
                                    }
                                    if($this->module_lib->hasActive('patient')){
                                    if ($this->rbac->hasPrivilege('patient_visit_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('admin/patient/patientvisitreport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/patientvisitreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line("patient_visit_report"); ?></a></li>
                                        <?php } }
                                         if($this->module_lib->hasActive('bill')){
                                            if ($this->rbac->hasPrivilege('patient_bill_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('admin/patient/patientbillreport'); ?>"><a href="<?php echo base_url(); ?>admin/patient/patientbillreport"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line("patient_bill_report"); ?></a></li>
                                        <?php } } 
                                        if($this->module_lib->hasActive('referral')){
                                            if ($this->rbac->hasPrivilege('referral_report', 'can_view')) {
                                ?>
                                        <li class="<?php echo set_Submenu('admin/referral/report'); ?>"><a href="<?php echo base_url(); ?>admin/referral/report"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line("referral_report"); ?></a></li>
                                <?php } } ?>

                            </ul>
                        </li>
                <?php
                        }
                    }
                ?>
                <?php
                if (($this->rbac->hasPrivilege('general_setting', 'can_view')) || ($this->rbac->hasPrivilege('charges', 'can_view')) || ($this->rbac->hasPrivilege('bed_status', 'can_view')) || ($this->rbac->hasPrivilege('opd_prescription_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('ipd_prescription_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('pharmacy_bill_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('setup_front_office', 'can_view')) || ($this->rbac->hasPrivilege('medicine_category', 'can_view')) || ($this->rbac->hasPrivilege('pathology_category', 'can_view')) || ($this->rbac->hasPrivilege('radiology_category', 'can_view')) || ($this->rbac->hasPrivilege('income_head', 'can_view')) || $this->rbac->hasPrivilege('leave_types', 'can_view') || ($this->rbac->hasPrivilege('item_category', 'can_view')) || ($this->rbac->hasPrivilege('hospital_charges', 'can_view')) || ($this->rbac->hasPrivilege('medicine_supplier', 'can_view')) || ($this->rbac->hasPrivilege('medicine_dosage', 'can_view') || ($this->rbac->hasPrivilege('users', 'can_view')))) {
                    ?> 
                                <li class="treeview <?php echo set_Topmenu('setup'); ?>">
                                    <a href="<?php echo base_url(); ?>">
                                        <i class="fas fa-cogs"></i> <span><?php echo $this->lang->line('setup'); ?></span> <i class="fa fa-angle-left pull-right"></i>
                                    </a>
                                    <ul class="treeview-menu">
                                 
                                        <?php
                if ($this->rbac->hasPrivilege('general_setting', 'can_view')) {
                        ?>
                                            <li class="<?php echo set_Submenu('schsettings/index'); ?>"><a href="<?php echo base_url(); ?>schsettings"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('settings'); ?></a></li>
                                            <?php
                }
                if($this->module_lib->hasActive('patient')){
                    if ($this->rbac->hasPrivilege('patient', 'can_view')) {
                        ?>

                                            <li class="<?php echo set_Submenu('setup/patient'); ?>"> <a href="<?php echo base_url(); ?>admin/admin/search"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('patient'); ?></a></li>
                                            <?php
                }
                }

                    if ($this->rbac->hasPrivilege('hospital_charges', 'can_view')) {
                        ?>
                                            <li class="<?php echo set_Submenu('charges/index'); ?>"><a href="<?php echo base_url(); ?>admin/charges"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('hospital_charges'); ?></a></li>
                                            <?php
                }
                    if ($this->module_lib->hasActive('ipd')) {
                        if ($this->rbac->hasPrivilege('bed', 'can_view')) {
                            ?>
                                                <li class="<?php echo set_Submenu('bed'); ?>"><a href="<?php echo base_url(); ?>admin/setup/bed/status"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('bed'); ?></a></li>
                                                <?php
                }
                    }

                    if (($this->rbac->hasPrivilege('opd_prescription_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('ipd_bill_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('ipd_prescription_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('pharmacy_bill_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('print_payslip_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('birth_print_header_footer', 'can_view')) || ($this->rbac->hasPrivilege('death_print_header_footer', 'can_view'))) {
                        ?>
                                            <li class="<?php echo set_Submenu('admin/printing'); ?>"><a href="<?php echo base_url(); ?>admin/printing"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('print_header_footer'); ?></a></li>
                                            <?php
                }
                    if ($this->module_lib->hasActive('front_office')) {
                        if ($this->rbac->hasPrivilege('setup_front_office', 'can_view')) {
                            ?>
                                                <li class="<?php echo set_Submenu('admin/visitorspurpose'); ?>"><a href="<?php echo base_url(); ?>admin/visitorspurpose"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('front_office'); ?></a></li>
                                                <?php
                }
                    }
                     if (($this->rbac->hasPrivilege('operation', 'can_view')) || ($this->rbac->hasPrivilege('operation_category', 'can_view'))) {
                            ?>
                                                <li class="<?php echo set_Submenu('operation_theatre/index'); ?>"><a href="<?php echo base_url(); ?>admin/operationtheatre/index"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('operations'); ?></a></li>
                                                <?php

                        }
                    if ($this->module_lib->hasActive('pharmacy')) {
                        if (($this->rbac->hasPrivilege('medicine_category', 'can_view') || ($this->rbac->hasPrivilege('medicine_supplier', 'can_view')) || ($this->rbac->hasPrivilege('medicine_dosage', 'can_view')))) {
                            ?>
                                                <li class="<?php echo set_Submenu('medicine/index'); ?>"><a href="<?php echo base_url(); ?>admin/medicinecategory/index"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('pharmacy'); ?></a></li>
                                                <?php
                }
                    }

                    if ($this->module_lib->hasActive('pathology')) {
                        if ($this->rbac->hasPrivilege('pathology_category', 'can_view') || $this->rbac->hasPrivilege('pathology_unit', 'can_view') || $this->rbac->hasPrivilege('pathology_parameter', 'can_view')) {
                            ?>
                                                <li class="<?php echo set_Submenu('addCategory/index'); ?>"><a href="<?php echo base_url(); ?>admin/pathologycategory/addcategory"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('pathology'); ?></a></li>
                                                <?php
                }
                    }
                    if ($this->module_lib->hasActive('radiology')) {
                        if ($this->rbac->hasPrivilege('radiology_category', 'can_view') || $this->rbac->hasPrivilege('radiology_unit', 'can_view') || $this->rbac->hasPrivilege('radiology_parameter', 'can_view')) {
                            ?>
                                                <li class="<?php echo set_Submenu('addlab/index'); ?>"><a href="<?php echo base_url(); ?>admin/lab/addlab"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('radiology'); ?></a></li>
                                                <?php
                }
                    } 

                     if ($this->module_lib->hasActive('blood_bank')) {
                        if ($this->rbac->hasPrivilege('blood_bank_product', 'can_view')) {
                            ?>
                                                <li class="<?php echo set_Submenu('admin/bloodbank'); ?>"><a href="<?php echo base_url(); ?>admin/bloodbank/products"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('blood_bank'); ?></a></li>
                                                <?php
                        }}
                    if (($this->rbac->hasPrivilege('symptoms_type', 'can_view')) || ($this->rbac->hasPrivilege('symptoms_head', 'can_view'))) {
                        ?>
                                                <li class="<?php echo set_Submenu('symptoms/index'); ?>"><a href="<?php echo base_url(); ?>admin/symptoms"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('symptoms'); ?></a></li>
                                                <?php
                }

                if (($this->rbac->hasPrivilege('finding', 'can_view')) || ($this->rbac->hasPrivilege('finding', 'can_view'))) {
                        ?>
                                                <li class="<?php echo set_Submenu('finding/index'); ?>"><a href="<?php echo base_url(); ?>admin/finding"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('findings'); ?></a></li>
                                                <?php
                }

                    if ($this->rbac->hasPrivilege('setting', 'can_view')) {?>
                                                <li class="<?php echo set_Submenu('conference/zoom_api_setting'); ?>"><a href="<?php echo base_url('admin/zoom_conference'); ?>"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('zoom_setting') ?></a></li>
                                        <?php }

                    if (($this->module_lib->hasActive('income')) || ($this->module_lib->hasActive('expense'))) {

                        if (($this->rbac->hasPrivilege('income_head', 'can_view')) || ($this->rbac->hasPrivilege('income_head', 'can_view'))) {
                            ?>
                            <?php if($this->module_lib->hasActive('income')){ ?>
                                <li class="<?php echo set_Submenu('finance/index'); ?>"><a href="<?php echo base_url(); ?>admin/incomehead"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('finance'); ?></a></li>
                            <?php }else{ ?>
                                <li class="<?php echo set_Submenu('finance/index'); ?>"><a href="<?php echo base_url(); ?>admin/expensehead"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('finance'); ?></a></li>

                            <?php } ?>
                    <?php
                }
                    }
                  
                    if (($this->rbac->hasPrivilege('leave_types', 'can_view')) || ($this->rbac->hasPrivilege('leave_types', 'can_view'))) {
                        ?>
                                            <li class="<?php echo set_Submenu('hr/index'); ?>"><a href="<?php echo base_url(); ?>admin/leavetypes"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('human_resource'); ?></a></li>
                                            <?php
                } ?>
                        <?php if($this->module_lib->hasActive('referral')){
                            if ($this->rbac->hasPrivilege('referral_commission', 'can_view')) {  ?>
                            <li class="<?php echo set_Submenu('admin/referral/commission'); ?>"><a href="<?php echo base_url(); ?>admin/referral/commission"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('referral'); ?></a></li>
                        <?php } } if ($this->module_lib->hasActive('appointment')) {if(($this->rbac->hasPrivilege('online_appointment_slot','can_view')) || ($this->rbac->hasPrivilege('online_appointment_doctor_shift','can_view')) || ($this->rbac->hasPrivilege('online_appointment_shift','can_view')) || ($this->rbac->hasPrivilege('doctor_wise_appointment','can_view'))){  ?>

                            <li class="<?php echo set_Submenu('admin/onlineappointment'); ?>"><a href="<?php echo base_url(); ?>admin/onlineappointment/"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('appointment'); ?></a></li>
                <?php  } }
                    if ($this->module_lib->hasActive('inventory')) {
                        if ($this->rbac->hasPrivilege('item_category', 'can_view')) {
                            ?>
                                                        <li class="<?php echo set_Submenu('inventory/index'); ?>"><a href="<?php echo base_url(); ?>admin/itemcategory"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('inventory'); ?></a></li>
                                            <?php }
                        } 
                            if ($this->rbac->hasPrivilege('custom_fields', 'can_view')){
                        ?>                              

                                            <li class="<?php echo set_Submenu('customfield/index'); ?>"><a href="<?php echo base_url(); ?>admin/customfield"><i class="fas fa-angle-right"></i> <?php echo $this->lang->line('custom_fields'); ?></a>
                                            </li>
                                        <?php } ?>
                                    </ul>

                            </li>
                    <?php
                   
                }
                ?>
                <?php
                    if ($this->module_lib->hasActive('system_settings')) {
                        if (($this->rbac->hasPrivilege('general_setting', 'can_view') ||
                            $this->rbac->hasPrivilege('session_setting', 'can_view') ||
                            $this->rbac->hasPrivilege('notification_setting', 'can_view') ||
                            $this->rbac->hasPrivilege('sms_setting', 'can_view') ||
                            $this->rbac->hasPrivilege('email_setting', 'can_view') ||
                            $this->rbac->hasPrivilege('payment_methods', 'can_view') ||
                            $this->rbac->hasPrivilege('languages', 'can_view') ||
                            $this->rbac->hasPrivilege('languages', 'can_add') ||
                            $this->rbac->hasPrivilege('backup_restore', 'can_view') ||
                            $this->rbac->hasPrivilege('front_cms_setting', 'can_view'))) {
                ?>
                <?php
                        }
                    }
                ?>

        </ul>
    </section>
</aside>