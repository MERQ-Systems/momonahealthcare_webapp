<div class="table-responsive">    
    <table class="table table-striped bordergray mb0">
        <tr>
            <th><?php echo $this->lang->line('complain'); ?> #</th>
            <td><?php print_r($complaint_data['id']);?></td>
            <th><?php echo $this->lang->line('complain_type'); ?></th>
            <td><?php print_r($complaint_data['complaint_type']);?></td>
        </tr>
        <tr>
            <th><?php echo $this->lang->line('source'); ?></th>
            <td><?php print_r($complaint_data['source']);?></td>
            <th><?php echo $this->lang->line('name'); ?></th>
            <td><?php print_r($complaint_data['name']);?></td>
        </tr>

        <tr>
            <th><?php echo $this->lang->line('phone'); ?></th>
            <td><?php print_r($complaint_data['contact']);?></td>
            <th><?php echo $this->lang->line('date'); ?></th>
            <td><?php print_r($this->customlib->YYYYMMDDTodateFormat($complaint_data['date']));?></td>
        </tr>
        <tr>
            <th><?php echo $this->lang->line('description'); ?></th>
            <td><?php print_r($complaint_data['description']);?></td>
            <th><?php echo $this->lang->line('action_taken'); ?></th>
            <td><?php print_r($complaint_data['action_taken']);?></td>
        </tr>
        <tr>
            <th><?php echo $this->lang->line('assigned'); ?></th>
            <td><?php print_r($complaint_data['assigned']);?></td>
            <th><?php echo $this->lang->line('note'); ?></th>
            <td><?php print_r($complaint_data['note']);?></td>
        </tr>
    </table>
</div>    