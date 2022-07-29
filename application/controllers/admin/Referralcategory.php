<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Referralcategory extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model("referral_category_model");
        $this->load->library("form_validation");
    }

    public function add()
    {
        if (!$this->rbac->hasPrivilege('referral_category', 'can_add')) {
            access_denied();
        }
        $data = array();
        $this->form_validation->set_rules("name", $this->lang->line('name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg  = array("name" => form_error('name'));
            $data = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $category = array(
                "name" => $this->input->post('name'),
            );

            $this->referral_category_model->add($category);
            $data = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($data);
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('referral_category', 'can_delete')) {
            access_denied();
        }
        if (!empty($id)) {
            $this->referral_category_model->delete($id);
            echo json_encode(array("status" => 1, "message" => $this->lang->line("delete_message")));
        } else {
            redirect("admin/referral/category");
        }
    }

    public function get($id)
    {
        $data = $this->referral_category_model->get($id);
        echo json_encode($data);
    }

    public function update()
    {
        if (!$this->rbac->hasPrivilege('referral_category', 'can_edit')) {
            access_denied();
        }
        $data = array();
        $this->form_validation->set_rules("name", $this->lang->line('name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg  = array("name" => form_error('name'));
            $data = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $category = array(
                "id"   => $this->input->post('categoryid'),
                "name" => $this->input->post('name'),
            );

            $this->referral_category_model->update($category);
            $data = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($data);

    }

}
