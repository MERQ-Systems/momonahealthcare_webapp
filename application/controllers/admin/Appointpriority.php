<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Appointpriority extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->model('appoint_priority_model');
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_view')) {
            access_denied();
        }

        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_menu', 'admin/visitorspurpose');
        $this->form_validation->set_rules('appoint_priority', $this->lang->line('appointment_priority'), 'required');

        if ($this->form_validation->run() == false) {
            $data['appoint_priority_list'] = $this->appoint_priority_model->appoint_priority_list();
            $this->load->view('layout/header');
            $this->load->view('admin/frontoffice/appointpriorityview', $data);
            $this->load->view('layout/footer');
        } else {
            $appoint_priority = array(
                'appoint_priority' => $this->input->post('appoint_priority'),
                'description'      => $this->input->post('description'),
            );
            $this->appoint_priority_model->add($appoint_priority);
            $this->session->set_flashdata('msg', '<div class="alert alert-success">' . $this->lang->line('appointment_priority_added_successfully') . '</div>');
            redirect('admin/appointpriority');
        }
    }

    public function add()
    {
        $this->form_validation->set_rules('appoint_priority', $this->lang->line('priority'), 'required');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('appoint_priority'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $appoint_priority = array(
                'appoint_priority' => $this->input->post('appoint_priority'),
            );
            $this->appoint_priority_model->add($appoint_priority);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }

        echo json_encode($array);
    }

    public function edit()
    {

        $this->form_validation->set_rules('appoint_priority', $this->lang->line('priority'), 'required');
        $id = $this->input->post('id');
        if ($this->form_validation->run() == false) {

            $msg = array(
                'name' => form_error('appoint_priority'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {

            $appoint_priority = array(
                'appoint_priority' => $this->input->post('appoint_priority'),
            );

            $this->appoint_priority_model->update($id, $appoint_priority);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }

        echo json_encode($array);
    }

    public function edit1($appoint_priority_id)
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_edit')) {
            access_denied();
        }
        $this->form_validation->set_rules('appoint_priority', $this->lang->line('appointment_priority'), 'required');

        if ($this->form_validation->run() == false) {
            $data['appoint_priority_list'] = $this->appoint_priority_model->appoint_priority_list();
            $data['appoint_priority_data'] = $this->appoint_priority_model->appoint_priority_list($appoint_priority_id);
            $this->load->view('layout/header');
            $this->load->view('admin/frontoffice/appointpriorityview', $data);
            $this->load->view('layout/footer');
        } else {
            $appoint_priority = array(
                'appoint_priority' => $this->input->post('appoint_priority'),
            );
            $this->appoint_priority_model->update($appoint_priority_id, $appoint_priority);
            $this->session->set_flashdata('msg', '<div class="alert alert-success"> ' . $this->lang->line('appointment_priority_updated_successfully') . '</div>');
            redirect('admin/visitorspurpose');
        }
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_delete')) {
            access_denied();
        }
        $this->appoint_priority_model->delete($id);
        echo json_encode(array('status' => 1, 'msg' => $this->lang->line('delete_message')));
    }

    public function get_data($id)
    {
        $result = $this->appoint_priority_model->appoint_priority_list($id);
        echo json_encode($result);
    }

}
