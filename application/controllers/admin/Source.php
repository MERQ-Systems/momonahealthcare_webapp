<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Source extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('form_validation');
    }

    public function index()
    {
        $this->form_validation->set_rules('source', $this->lang->line('source'), 'required');
        if ($this->form_validation->run() == false) {
            $data['source_list'] = $this->source_model->source_list();
            $this->load->view('layout/header');
            $this->load->view('admin/frontoffice/sourceview', $data);
            $this->load->view('layout/footer');
        } else {
            $source = array(
                'source'      => $this->input->post('source'),
                'description' => $this->input->post('description'),
            );
            $this->source_model->add($source);
            $this->session->set_flashdata('msg', '<div class="alert alert-success">' . $this->lang->line('success_message') . '</div>');
            redirect('admin/source');
        }
    }

    public function add()
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_add')) {
            access_denied();
        }

        $this->form_validation->set_rules('source', $this->lang->line('source'), 'required');
        if ($this->form_validation->run() == false) {

            $msg = array(
                'name' => form_error('source'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {

            $source = array(
                'source'      => $this->input->post('source'),
                'description' => $this->input->post('description'),
            );

            $this->source_model->add($source);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }

        echo json_encode($array);
    }

    public function edit1($source_id)
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_edit')) {
            access_denied();
        }
        $this->form_validation->set_rules('source', $this->lang->line('source'), 'required');
        if ($this->form_validation->run() == false) {
            $data['source_list'] = $this->source_model->source_list();
            $data['source_data'] = $this->source_model->source_list($source_id);
            $this->load->view('layout/header');
            $this->load->view('admin/frontoffice/sourceeditview', $data);
            $this->load->view('layout/footer');
        } else {

            $source = array(
                'source'      => $this->input->post('source'),
                'description' => $this->input->post('description'),
            );
            $this->source_model->update($source_id, $source);
            $this->session->set_flashdata('msg', '<div class="alert alert-success"> ' . $this->lang->line('source_updated_successfully') . '</div>');
            redirect('admin/source');
        }
    }

    public function edit()
    {
        $id = $this->input->post('id');
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_edit')) {
            access_denied();
        }
        $this->form_validation->set_rules('source', $this->lang->line('source'), 'required');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('source'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $source = array(
                'source'      => $this->input->post('source'),
                'description' => $this->input->post('description'),
            );
            $this->source_model->update($id, $source);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }

        echo json_encode($array);
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('setup_front_office', 'can_delete')) {
            access_denied();
        }
        $this->source_model->delete($id);
        echo json_encode(array('status' => 1, 'msg' => $this->lang->line('delete_message')));
    }

    public function get_data($id)
    {
        $result = $this->source_model->source_list($id);
        echo json_encode($result);
    }

}
