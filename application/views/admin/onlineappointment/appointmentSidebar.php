<div class="box border0">
    <?php if ($this->rbac->hasPrivilege('online_appointment_slot', 'can_view')) { ?>
    <ul class="tablists">
        <li><a href="<?php echo site_url('admin/onlineappointment'); ?>" class="<?php echo set_sidebar_Submenu('admin/onlineappointment'); ?>"><?php echo $this->lang->line("slots"); ?></a></li>
    </ul>
    <?php } ?>
    <?php if ($this->rbac->hasPrivilege('online_appointment_doctor_shift', 'can_view')) { ?>
    <ul class="tablists">
            <li><a href="<?php echo site_url('admin/onlineappointment/doctorglobalshift'); ?>" class="<?php echo set_sidebar_Submenu('admin/onlineappointment/doctorglobalshift'); ?>"><?php echo $this->lang->line("doctor_shift"); ?></a></li>
    </ul>
    <?php } ?>
    <?php if ($this->rbac->hasPrivilege('online_appointment_shift', 'can_view')) { ?>
    <ul class="tablists">
            <li><a href="<?php echo site_url('admin/onlineappointment/globalshift'); ?>" class="<?php echo set_sidebar_Submenu('admin/onlineappointment/globalshift'); ?>"><?php echo $this->lang->line("shift"); ?></a></li>
    </ul>
    <?php } ?>
</div>
