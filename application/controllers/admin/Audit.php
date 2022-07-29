<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Audit extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('audit_model');
        $this->load->library('datatables');
    }

    public function unauthorized()
    {
        $data = array();
        $this->load->view('layout/header', $data);
        $this->load->view('unauthorized', $data);
        $this->load->view('layout/footer', $data);
    }

    public function index($offset = 0)
    {
        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'admin/audit/index');
        $data['title']      = $this->lang->line('audit_trail_report');
        $data['title_list'] = $this->lang->line('audit_trail_list');
        $this->load->view('layout/header');
        $this->load->view('admin/audit/index', $data);
        $this->load->view('layout/footer');
    }

    public function getDatatable()
    {
        $audit = $this->audit_model->getAllRecord();
        $audit = json_decode($audit);

        $dt_data = array();
        if (!empty($audit->data)) {
            foreach ($audit->data as $key => $value) {

                $date = $this->customlib->YYYYMMDDHisTodateFormat($value->time, $this->customlib->getHospitalTimeFormat());

                $row   = array();
                $row[] = $value->message;
                $row[] = $value->name;
                $row[] = $value->ip_address;
                $row[] = $value->action;
                $row[] = $value->platform;
                $row[] = $value->agent;
                $row[] = $date;
                $dt_data[] = $row;
            }
        }

        $json_data = array(
            "draw"            => intval($audit->draw),
            "recordsTotal"    => intval($audit->recordsTotal),
            "recordsFiltered" => intval($audit->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

    public function deleteall()
    {
        $this->audit_model->delete();
        $return = array('status' => 1, 'msg' => $this->lang->line('data_deleted_successfully'));
        echo json_encode($return);
    }

}
