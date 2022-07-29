<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Bedgroup extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('form_validation');
    }

    public function add_bed_group()
    {

        $this->form_validation->set_rules(
            'name', $this->lang->line('name'), array('required',
                array('check_exists', array($this->bedgroup_model, 'valid_bed_group')),
            )
        );
        $this->form_validation->set_rules('floor', $this->lang->line('floor'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'name'  => form_error('name'),
                'floor' => form_error('floor'),
            );
            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $bed = array(
                'name'        => $this->input->post('name'),
                'color'       => $this->input->post('color'),
                'description' => $this->input->post('description'),
                'floor'       => $this->input->post('floor'),
            );

            $this->bedgroup_model->add_bed_group($bed);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($array);
    }

    public function index()
    {
        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_sidebar_menu', 'admin/setup/bedgroup');
        $this->session->set_userdata('sub_menu', 'bed');
        $data['bedgroup_list'] = $this->bedgroup_model->get_bedgroup();
        $data['floor']         = $this->floor_model->floor_list();
        $this->load->view('layout/header');
        $this->load->view('setup/bed/bedgroup', $data);
        $this->load->view('layout/footer');
    }

    public function delete_bedgroup($id)
    {
        $this->bedgroup_model->delete_bedgroup($id);
        echo json_encode(array('status' => 1, 'msg' => $this->lang->line('delete_message')));
    }

    public function update_bedgroup()
    {
        $this->form_validation->set_rules('name', $this->lang->line('name'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('floor', $this->lang->line('floor'), 'trim|required|xss_clean');

        if ($this->form_validation->run() == false) {

            $msg = array(
                'name'  => form_error('name'),
                'floor' => form_error('floor'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {

            $bed = array(
                'id'          => $this->input->post('id'),
                'name'        => $this->input->post('name'),
                'color'       => $this->input->post('color'),
                'floor'       => $this->input->post('floor'),
                'description' => $this->input->post('description'),
            );

            $this->bedgroup_model->add_bed_group($bed);
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }

        echo json_encode($array);
    }

    public function getbedgroupdata($id)
    {
        $data = $this->bedgroup_model->bedgroup_list($id);
        echo json_encode($data);
    }

}
