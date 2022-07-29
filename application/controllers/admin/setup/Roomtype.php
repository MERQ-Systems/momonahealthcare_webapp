<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Roomtype extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('form_validation');
    }

    public function index()
    {
        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_sidebar_menu', 'admin/setup/roomtype');
        $this->session->set_userdata('sub_menu', 'bed');
        $data['roomtype_list'] = $this->Roomtype_Model->roomtypelist();
        $this->load->view('layout/header');
        $this->load->view('setup/Roomtype', $data);
        $this->load->view('layout/footer');
    }

    public function add()
    {
        $this->form_validation->set_rules('name', $this->lang->line('name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name' => form_error('name'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {

            $roomtype = array('name' => $this->input->post('name'));
            $this->Roomtype_Model->saveroomtype($roomtype);
            $msg   = $this->lang->line('room_type_added_successfully');
            $array = array('status' => 'success', 'error' => '', 'message' => $msg);
        }
        echo json_encode($array);
    }

    public function getdata($id)
    {
        $data['roomtype_data'] = $this->Roomtype_Model->roomtypelist($id);
        $this->load->view('setup/roomtype/editroomtype', $data);
    }

    public function edit($id)
    {
        $this->form_validation->set_rules('name', $this->lang->line('name'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {

            $msg = array(
                'name' => form_error('name'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {

            $roomtype = array(
                'name' => $this->input->post('name'),
                'id'   => $this->input->post('id'),
            );

            $this->Roomtype_Model->saveroomtype($roomtype);
            $msg   = $this->lang->line('room_type_updated_successfully');
            $array = array('status' => 'success', 'error' => '', 'message' => $msg);
        }
        echo json_encode($array);
    }
}
