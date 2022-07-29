<?php

$name = ($live->create_for_surname == "") ? $live->create_for_name : $live->create_for_name . " " . $live->create_for_surname;
if ($api_Response->status == "waiting") {
    $st_label = "label label-warning";
} elseif ($api_Response->status == "started") {
    $st_label = "label label-success";
}

?>
<div class="row">
  <div class="col-lg-12 col-md-12">
        <div class="modal-header zoommodal-title">
            <h4 class="modal-title"><?php echo $live->title; ?></h4>
        </div>
    </div>

    <div class="col-lg-4 col-md-4">
        <label>
            <span class="labalblock"> <?php echo $this->lang->line('host'); ?></span> <span class="text-dark robo-normal"><span class="text-dark"><?php echo $name; ?></span>
        </label>
    </div>

    <div class="col-lg-4 col-md-4">
        <label>
            <span class="labalblock"> <?php echo $this->lang->line('date'); ?></span> <span class="text-dark robo-normal"><span class="text-dark"><?php echo date($this->customlib->getHospitalDateFormat(true, true), strtotime($live->date)); ?></span>
        </label>
    </div>

    <div class="col-lg-4 col-md-4">
        <label>
            <span class="labalblock"> <?php echo $this->lang->line('duration'); ?></span> <span class="text-dark robo-normal"><span class="text-dark"><?php echo $live->duration; ?></span>
        </label>
    </div>
</div>

<div class="row">
  <div class="col-lg-12 col-md-12">
  <div class="zoommodal-border">
    <label class="pull-left minus7top">
        <span class="labalblock"> <?php echo $this->lang->line('status'); ?></span><span class="font-w-normal <?php echo $st_label; ?>"><i class="fa fa-video-camera"></i> <?php echo $this->lang->line($api_Response->status); ?></span>
    </label>

<?php
if ($api_Response->status == "started") {
    if ($conference_setting->use_zoom_app) {
        ?>

   <a href="<?php echo $live_url->join_url; ?>" class="btn btn-outline-success btn-sm pull-right join-btn" data-id="<?php echo $live->id; ?>" target="_blank">
      <i class="fa fa-video-camera"></i> <?php echo $this->lang->line('join') . ' ' . $this->lang->line('now'); ?>
      </a>

  <?php
} else {
        ?>
      <a href="<?php echo site_url('patient/dashboard/join/' . $live->id); ?>" class="btn btn-outline-success btn-sm pull-right">
            <i class="fa fa-video-camera"></i> <?php echo $this->lang->line('join') . ' ' . $this->lang->line('now'); ?>
      </a>

  <?php
}

}
?>
</div>
</div>
</div>