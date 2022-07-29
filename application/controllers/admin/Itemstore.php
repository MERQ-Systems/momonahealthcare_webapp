<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Itemstore extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->helper('file');
        $this->load->helper('url');
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('store', 'can_view')) {
            access_denied();
        }
        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_menu', 'inventory/index');
        $data['title']         = $this->lang->line('item_store_list');
        $itemstore_result      = $this->itemstore_model->get();
        $data['itemstorelist'] = $itemstore_result;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/itemstore/itemstoreList', $data);
        $this->load->view('layout/footer', $data);
    }

    public function add()
    {
        if (!$this->rbac->hasPrivilege('store', 'can_add')) {
            access_denied();
        }
        $this->form_validation->set_rules('name', $this->lang->line('item_store_name'), 'trim|required|xss_clean');

        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('name'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $data = array(
                'item_store'  => $this->input->post('name'),
                'code'        => $this->input->post('code'),
                'description' => $this->input->post('description'),
            );
            $this->itemstore_model->add($data);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }

        echo json_encode($array);
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('store', 'can_delete')) {
            access_denied();
        }
        $data['title'] = $this->lang->line('item_store_list');
        $this->itemstore_model->remove($id);
        echo json_encode(array("status" => 1, "msg" => $this->lang->line("delete_message"))); 
    }

    public function create()
    {
        if (!$this->rbac->hasPrivilege('store', 'can_add')) {
            access_denied();
        }
        $data['title']         = $this->lang->line('add_item_store');
        $itemstore_result      = $this->itemstore_model->get();
        $data['itemstorelist'] = $itemstore_result;
        $this->form_validation->set_rules('name', $this->lang->lang->line('name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $this->load->view('layout/header', $data);
            $this->load->view('admin/itemstore/itemstoreList', $data);
            $this->load->view('layout/footer', $data);
        } else {
            $data = array(
                'item_store'  => $this->input->post('name'),
                'code'        => $this->input->post('code'),
                'description' => $this->input->post('description'),
            );
            $this->itemstore_model->add($data);
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-left"></div>');
            redirect('admin/itemstore/index');
        }
    }

    public function edit()
    {
        if (!$this->rbac->hasPrivilege('store', 'can_edit')) {
            access_denied();
        }
        $id = $this->input->post('id');
        $this->form_validation->set_rules('name', $this->lang->line('item_store_name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('name'),
            );
            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $data = array(
                'id'          => $id,
                'item_store'  => $this->input->post('name'),
                'code'        => $this->input->post('code'),
                'description' => $this->input->post('description'),
            );

            $this->itemstore_model->add($data);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }

        echo json_encode($array);
    }

    public function get_data($id)
    {
        $itemstore_result = $this->itemstore_model->get($id);
        echo json_encode($itemstore_result);
    }

}
