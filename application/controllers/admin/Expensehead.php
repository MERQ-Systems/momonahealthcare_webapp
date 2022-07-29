<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Expensehead extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('expense_head', 'can_view')) {
            access_denied();
        }
        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_menu', 'finance/index');
        $data['title']        = 'Expense Head List';
        $category_result      = $this->expensehead_model->get();
        $data['categorylist'] = $category_result;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/expensehead/expenseheadList', $data);
        $this->load->view('layout/footer', $data);
    }

    public function add()
    {
        $this->form_validation->set_rules('expensehead', $this->lang->line('expense_head'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('expensehead'),
            );
            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $data = array(
                'exp_category' => $this->input->post('expensehead'),
                'description'  => $this->input->post('description'),
            );
            $this->expensehead_model->add($data);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($array);
    }

    public function view($id)
    {
        if (!$this->rbac->hasPrivilege('expense_head', 'can_view')) {
            access_denied();
        }
        $data['title']    = $this->lang->line('expense_head_list');
        $category         = $this->expensehead_model->get($id);
        $data['category'] = $category;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/expensehead/expenseheadShow', $data);
        $this->load->view('layout/footer', $data);
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('expense_head', 'can_delete')) {
            access_denied();
        }
        $data['title'] = $this->lang->line('expense_head_list');
        $this->expensehead_model->remove($id);
        echo json_encode(array("status" => 1, "msg" => $this->lang->line("delete_message")));
    }

    public function create()
    {
        if (!$this->rbac->hasPrivilege('expense_head', 'can_add')) {
            access_denied();
        }
        $data['title']        = $this->lang->line('add_expense_head');
        $category_result      = $this->expensehead_model->get();
        $data['categorylist'] = $category_result;
        $this->form_validation->set_rules('expensehead', $this->lang->line('expense_head'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $this->load->view('layout/header', $data);
            $this->load->view('admin/expensehead/expenseheadList', $data);
            $this->load->view('layout/footer', $data);
        } else {
            $data = array(
                'exp_category' => $this->input->post('expensehead'),
                'description'  => $this->input->post('description'),
            );
            $this->expensehead_model->add($data);
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-left">' . $this->lang->line('expense_head_added_successfully') . '</div>');
            redirect('admin/expensehead/index');
        }
    }    

    public function edit()
    {
        if (!$this->rbac->hasPrivilege('expense', 'can_edit')) {
            access_denied();
        }

        $id = $this->input->post('exphead_id');
        $this->form_validation->set_rules('expensehead', $this->lang->line('expense_head'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('expensehead'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $data = array(
                'id'           => $id,
                'exp_category' => $this->input->post('expensehead'),
                'description'  => $this->input->post('description'),
            );
            $this->expensehead_model->add($data);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }

        echo json_encode($array);
    }

    public function get_data($id)
    {
        $category = $this->expensehead_model->get($id);
        echo json_encode($category);
    }

}
