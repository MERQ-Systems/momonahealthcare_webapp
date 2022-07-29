 <div class="col-md-2"> 
                <div class="box border0">
                    <ul class="tablists">
                        <?php if ($this->rbac->hasPrivilege('medicine_category', 'can_view')) { ?>
                        <li><a href="<?php echo base_url(); ?>admin/medicinecategory/medicine" class="<?php echo set_sidebar_Submenu('admin/medicinecategory/medicine'); ?>"> <th><?php echo $this->lang->line('medicine_category'); ?></th></a></li>
						<?php } ?>
                         <?php  if ($this->rbac->hasPrivilege('medicine_supplier', 'can_view')) { ?>
						 <li><a class="<?php echo set_sidebar_Submenu('admin/medicinecategory/supplier'); ?>" href="<?php echo base_url(); ?>admin/medicinecategory/supplier" > <th><?php echo $this->lang->line('supplier'); ?></th></a></li>
 <?php }  if ($this->rbac->hasPrivilege('medicine_dosage', 'can_view')) { ?>
                         <li><a class="<?php echo set_sidebar_Submenu('admin/medicinedosage'); ?>" href="<?php echo base_url(); ?>admin/medicinedosage" > <th><?php echo $this->lang->line('medicine_dosage'); ?></th></a></li>
                    <?php }  if ($this->rbac->hasPrivilege('dosage_interval', 'can_view')) { ?>
                     <li><a class="<?php echo set_sidebar_Submenu('admin/medicinedosage/interval'); ?>" href="<?php echo base_url(); ?>admin/medicinedosage/interval" > <th><?php echo $this->lang->line('dose_interval'); ?></th></a></li>
                     <?php }  if ($this->rbac->hasPrivilege('dosage_duration', 'can_view')) { ?>
                     <li><a class="<?php echo set_sidebar_Submenu('admin/medicinedosage/duration'); ?>" href="<?php echo base_url(); ?>admin/medicinedosage/duration" > <th><?php echo $this->lang->line('dose_duration'); ?></th></a></li>
                 <?php } ?>
                    </ul>
                </div>
            </div>