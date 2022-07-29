<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Income extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->helper('form');
        $this->load->library("datatables");
        $this->load->model("transaction_model");
        $this->modules = $this->config->item('modules');
        $this->config->load("payroll");
        $this->config->load("image_valid");
        $this->search_type = $this->config->item('search_type');
        $this->load->helper('customfield_helper');
        $this->config->item('search_type');
    }

    public function index()
    {
        if (!$this->module_lib->hasActive('income')) {
            access_denied();
        }
        $this->session->set_userdata('top_menu', 'finance');
        $this->session->set_userdata('sub_menu', 'income/index');
        $data['title']       = $this->lang->line('add_income');
        $data['title_list']  = $this->lang->line('recent_income');
        $data['fields']      = $this->customfield_model->get_custom_fields('income', 1);
        $incomeHead          = $this->incomehead_model->get();
        $data['incheadlist'] = $incomeHead;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/income/incomeList', $data);
        $this->load->view('layout/footer', $data);
    }

    public function getDatatable()
    {
        $dt_response = $this->income_model->getAllRecord();
        $fields      = $this->customfield_model->get_custom_fields('income', 1);
        $dt_response = json_decode($dt_response);

        $dt_data = array();
        if (!empty($dt_response->data)) {
            foreach ($dt_response->data as $key => $value) {

                $row = array();
//====================================
                $column_first = '<a href="#" data-toggle="popover" class="detail_popover">' . $value->name . '</a>';
                $column_first .= '<div class="rowoptionview rowview-mt-19">';

                if ($value->documents) {

                    $column_first .= ' <a href="' . base_url() . 'admin/income/download/' . $value->documents . '" class="btn btn-default btn-xs"  data-toggle="tooltip" title="' . $this->lang->line('download') . '"><i class="fa fa-download"></i></a>';
                }

                if ($this->rbac->hasPrivilege('income', 'can_edit')) {

                    $column_first .= ' <a onclick="edit(' . $value->id . ')" class="btn btn-default btn-xs" data-toggle="tooltip" title="' . $this->lang->line('edit') . '"> <i class="fa fa-pencil"></i> </a>';
                }
                if ($this->rbac->hasPrivilege('income', 'can_delete')) {

                    $column_first .= ' <a class="btn btn-default btn-xs"  data-toggle="tooltip" title="' . $this->lang->line('delete') . '" onclick="delete_record(' . $value->id . ')"><i class="fa fa-trash"></i></a>';
                }

                $column_first .= '</div>';
                $column_first .= '<div class="fee_detail_popover" style="display: none">';

                if ($value->note == "") {

                    $column_first .= '<p class="text text-danger">' . $this->lang->line('no_description') . '</p>';

                } else {

                    $column_first .= '<p class="text text-info">' . $value->note . '</p>';
                }

                $column_first .= '</div>';
                //==============================

                $row[] = $column_first;
                $row[] = $value->invoice_no;
                $row[] = $this->customlib->YYYYMMDDTodateFormat($value->date);
                $row[] = $value->note;
                $row[] = $value->income_category;
                //====================
                if (!empty($fields)) {

                    foreach ($fields as $fields_key => $fields_value) {
                        $display_field = $value->{"$fields_value->name"};
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $value->{"$fields_value->name"} . " target='_blank'>" . $value->{"$fields_value->name"} . "</a>";
                        }
                        $row[] = $display_field;
                    }
                }
                //====================
                $row[] = $value->amount;

                $dt_data[] = $row;
            }
        }
        $json_data = array(
            "draw"            => intval($dt_response->draw),
            "recordsTotal"    => intval($dt_response->recordsTotal),
            "recordsFiltered" => intval($dt_response->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

    public function add()
    {
        $this->session->set_userdata('top_menu', 'Income');
        $this->session->set_userdata('sub_menu', 'income/index');
        $data['title']      = $this->lang->line('add_income');
        $data['title_list'] = $this->lang->line('recent_income');
        $custom_fields      = $this->customfield_model->getByBelong('income');

        foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
            if ($custom_fields_value['validation']) {
                $custom_fields_id   = $custom_fields_value['id'];
                $custom_fields_name = $custom_fields_value['name'];
                $this->form_validation->set_rules("custom_fields[income][" . $custom_fields_id . "]", $custom_fields_name, 'trim|required');
            }
        }
        $this->form_validation->set_rules('inc_head_id[]', $this->lang->line('income_head'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('amount', $this->lang->line('amount'), 'trim|required|xss_clean|valid_amount');
        $this->form_validation->set_rules('name', $this->lang->line('name'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('date', $this->lang->line('date'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('documents', $this->lang->line('documents'), 'callback_handle_upload');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'inc_head_id[]' => form_error('inc_head_id[]'),
                'name'          => form_error('name'),
                'date'          => form_error('date'),
                'amount'        => form_error('amount'),
                'documents'     => form_error('documents'),
            );

            if (!empty($custom_fields)) {
                foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
                    if ($custom_fields_value['validation']) {
                        $custom_fields_id                                               = $custom_fields_value['id'];
                        $custom_fields_name                                             = $custom_fields_value['name'];
                        $error_msg2["custom_fields[income][" . $custom_fields_id . "]"] = form_error("custom_fields[income][" . $custom_fields_id . "]");
                    }
                }
            }
            if (!empty($error_msg2)) {
                $error_msg = array_merge($msg, $error_msg2);
            } else {
                $error_msg = $msg;
            }

            $array = array('status' => 'fail', 'error' => $error_msg, 'message' => '');
        } else {
            $date = $this->input->post('date');
            $data = array(
                'inc_head_id'  => $this->input->post('inc_head_id'),
                'name'         => $this->input->post('name'),
                'date'         => $this->customlib->dateFormatToYYYYMMDD($date),
                'amount'       => $this->input->post('amount'),
                'invoice_no'   => $this->input->post('invoice_no'),
                'note'         => $this->input->post('description'),
                'documents'    => $this->input->post('documents'),
                'generated_by' => $this->customlib->getLoggedInUserID(),
            );
            $custom_field_post  = $this->input->post("custom_fields[income]");
            $custom_value_array = array();
            if (!empty($custom_field_post)) {
                foreach ($custom_field_post as $key => $value) {
                    $check_field_type = $this->input->post("custom_fields[income][" . $key . "]");
                    $field_value      = is_array($check_field_type) ? implode(",", $check_field_type) : $check_field_type;
                    $array_custom     = array(
                        'belong_table_id' => 0,
                        'custom_field_id' => $key,
                        'field_value'     => $field_value,
                    );
                    $custom_value_array[] = $array_custom;
                }
            }
            $insert_id = $this->income_model->add($data);

            if (!empty($custom_value_array)) {
                $this->customfield_model->insertRecord($custom_value_array, $insert_id);
            }

            if (isset($_FILES["documents"]) && !empty($_FILES['documents']['name'])) {
                $fileInfo = pathinfo($_FILES["documents"]["name"]);
                $img_name = $insert_id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["documents"]["tmp_name"], "./uploads/hospital_income/" . $img_name);
                $data_img = array('id' => $insert_id, 'documents' => 'uploads/hospital_income/' . $img_name);
                $this->income_model->add($data_img);
            }
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($array);
    }

    public function download($documents)
    {
        $this->load->helper('download');
        $filepath = "./uploads/hospital_income/" . $this->uri->segment(6);
        $data     = file_get_contents($filepath);
        $name     = $this->uri->segment(6);
        force_download($name, $data);
    }

    public function view($id)
    {
        if (!$this->rbac->hasPrivilege('income', 'can_view')) {
            access_denied();
        }
        $data['title']  = $this->lang->line('fees_master_list');
        $income         = $this->income_model->get($id);
        $data['income'] = $income;
        $this->load->view('layout/header', $data);
        $this->load->view('income/incomeShow', $data);
        $this->load->view('layout/footer', $data);
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('income', 'can_delete')) {
            access_denied();
        }
        $data['title'] = $this->lang->line('fees_master_list');
        $this->income_model->remove($id);
        redirect('admin/income/index');
    }

    public function create()
    {
        $data['title'] = $this->lang->line('add_fees_master');
        $this->form_validation->set_rules('income', $this->lang->line('fees_master'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $this->load->view('layout/header', $data);
            $this->load->view('income/incomeCreate', $data);
            $this->load->view('layout/footer', $data);
        } else {
            $data = array(
                'income' => $this->input->post('income'),
            );
            $this->income_model->add($data);
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-left">' . $this->lang->line('income_added_successfully') . '</div>');
            redirect('income/index');
        }
    }

    public function handle_upload()
    {
        $image_validate = $this->config->item('file_validate');
        if (isset($_FILES["documents"]) && !empty($_FILES['documents']['name'])) {
            $file_type         = $_FILES["documents"]['type'];
            $file_size         = $_FILES["documents"]["size"];
            $file_name         = $_FILES["documents"]["name"];
            $allowed_extension = $image_validate['allowed_extension'];
            $ext               = pathinfo($file_name, PATHINFO_EXTENSION);
            $allowed_mime_type = $image_validate['allowed_mime_type'];
            if ($files = @filesize($_FILES['documents']['tmp_name'])) {
                if (!in_array($file_type, $allowed_mime_type)) {
                    $this->form_validation->set_message('handle_upload', $this->lang->line('file_type_not_allowed'));
                    return false;
                }

                if (!in_array(strtolower($ext), $allowed_extension) || !in_array($file_type, $allowed_mime_type)) {
                    $this->form_validation->set_message('handle_upload', $this->lang->line('file_extension_not_allowed'));
                    return false;
                }
                if ($file_size > $image_validate['upload_size']) {
                    $this->form_validation->set_message('handle_upload', $this->lang->line('file_size_shoud_be_less_than') . number_format($image_validate['upload_size'] / 1048576, 2) . " MB");
                    return false;
                }
            } else {
                $this->form_validation->set_message('handle_upload', $this->lang->line('error_file_uploading'));
                return false;
            }
            return true;
        }
        return true;
    }

    public function getDataByid($id)
    {
        $data['title']       = $this->lang->line('edit_fees_master');
        $data['id']          = $id;
        $income              = $this->income_model->get($id);
        $data['income']      = $income;
        $incomeHead          = $this->incomehead_model->get();
        $data['incheadlist'] = $incomeHead;
        $this->load->view('admin/income/editModal', $data);
    }

    public function edit($id)
    {
        $data['title']       = $this->lang->line('edit_fees_master');
        $data['id']          = $id;
        $income              = $this->income_model->get($id);
        $data['income']      = $income;
        $data['title_list']  = 'Fees Master List';
        $income_result       = $this->income_model->get();
        $data['incomelist']  = $income_result;
        $expnseHead          = $this->incomehead_model->get();
        $data['incheadlist'] = $expnseHead;
        $custom_fields       = $this->customfield_model->getByBelong('income');
        if (!empty($custom_fields)) {
            foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
                if ($custom_fields_value['validation']) {
                    $custom_fields_id   = $custom_fields_value['id'];
                    $custom_fields_name = $custom_fields_value['name'];

                    $this->form_validation->set_rules("custom_fields[income][" . $custom_fields_id . "]", $custom_fields_name, 'trim|required');
                }
            }
        }
        $this->form_validation->set_rules('inc_head_id', $this->lang->line('income_head'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('inc_head_id[]', $this->lang->line('income_head'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('amount', $this->lang->line('amount'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('name', $this->lang->line('name'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('date', $this->lang->line('date'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('documents', $this->lang->line('documents'), 'callback_handle_upload');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'inc_head_id[]' => form_error('inc_head_id[]'),
                'amount'        => form_error('amount'),
                'name'          => form_error('name'),
                'date'          => form_error('date'),
                'documents'     => form_error('documents'),
            );

            if (!empty($custom_fields)) {
                foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
                    if ($custom_fields_value['validation']) {
                        $custom_fields_id                                               = $custom_fields_value['id'];
                        $custom_fields_name                                             = $custom_fields_value['name'];
                        $error_msg2["custom_fields[income][" . $custom_fields_id . "]"] = form_error("custom_fields[income][" . $custom_fields_id . "]");
                    }
                }
            }
            if (!empty($error_msg2)) {
                $error_msg = array_merge($msg, $error_msg2);
            } else {
                $error_msg = $msg;
            }
            $array = array('status' => 'fail', 'error' => $error_msg, 'message' => '');
        } else {
            $custom_field_post = $this->input->post("custom_fields[income]");
            $date              = $this->input->post('date');
            $data              = array(
                'id'           => $id,
                'inc_head_id'  => $this->input->post('inc_head_id'),
                'name'         => $this->input->post('name'),
                'date'         => $this->customlib->dateFormatToYYYYMMDD($date),
                'amount'       => $this->input->post('amount'),
                'invoice_no'   => $this->input->post('invoice_no'),
                'note'         => $this->input->post('description'),
                'generated_by' => $this->customlib->getLoggedInUserID(),
            );
            $insert_id = $this->income_model->add($data);
            if (!empty($custom_fields)) {
                foreach ($custom_field_post as $key => $value) {
                    $check_field_type = $this->input->post("custom_fields[income][" . $key . "]");
                    $field_value      = is_array($check_field_type) ? implode(",", $check_field_type) : $check_field_type;
                    $array_custom     = array(
                        'belong_table_id' => $id,
                        'custom_field_id' => $key,
                        'field_value'     => $field_value,
                    );
                    $custom_value_array[] = $array_custom;
                }
                $this->customfield_model->updateRecord($custom_value_array, $id, 'income');
            }
            if (isset($_FILES["documents"]) && !empty($_FILES['documents']['name'])) {
                $fileInfo = pathinfo($_FILES["documents"]["name"]);
                $img_name = $id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["documents"]["tmp_name"], "./uploads/hospital_income/" . $img_name);
                $data_img = array('id' => $id, 'documents' => 'uploads/hospital_income/' . $img_name);
                $this->income_model->add($data_img);
            }
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message'));
        }
        echo json_encode($array);
    }

    public function incomeSearch()
    {
        if (!$this->rbac->hasPrivilege('income_report', 'can_view')) {
            access_denied();
        }

        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'admin/income/incomesearch');
        $custom_fields      = $this->customfield_model->get_custom_fields('income', '', '', 1);
        $data["searchlist"] = $this->search_type;
        $data['fields']     = $custom_fields;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/income/incomeSearch', $data);
        $this->load->view('layout/footer', $data);
    }

    // public function transactionreport($value = '')
    // {
    //     if (!$this->rbac->hasPrivilege('transaction_report', 'can_view')) {
    //         access_denied();
    //     }
    //     $this->session->set_userdata('top_menu', 'Reports');
    //     $this->session->set_userdata('sub_menu', 'admin/income/transactionreport');
    //     $search_type                = $this->input->post("search_type");
    //     $collect_staff              = $this->input->post("collect_staff");
    //     $data['staffsearch_select'] = $collect_staff;
    //     $select_staffsearch         = 'staffby.generated_by,staff.id as staffid,staff.name as staffname,staff.surname as staffsurname,staff.employee_id';
    //     $groupby_staffsearch        = 'staffby';
    //     $join_staffsearch           = array('LEFT JOIN staff ON staffby.generated_by = staff.id');
    //     $tablename_staffsearch      = "(SELECT `generated_by` FROM `pharmacy_bill_basic` UNION ALL SELECT `approved_by` as generated_by FROM `pathology_report` UNION ALL SELECT `approved_by` as generated_by FROM `radiology_report` UNION ALL SELECT `generated_by` FROM `operation_theatre` UNION ALL SELECT `generated_by` FROM `blood_issue` UNION ALL SELECT `generated_by` FROM `ambulance_call`) AS staffby";
    //     $resultList_staffsearch     = $this->patient_model->getstaffsearch($select_staffsearch, $join_staffsearch, $tablename_staffsearch, $groupby_staffsearch);
    //     $data['staffsearch']        = $resultList_staffsearch;

    //     if (isset($search_type)) {
    //         $search_type = $this->input->post("search_type");
    //     } else {
    //         $search_type = "this_month";
    //     }

    //     $parameter = array('OPD' => array('label' => 'OPD', 'table'               => 'visit_details', 'search_table' => 'visit_details',
    //         'search_column'                           => 'appointment_date', 'select' => 'visit_details.*,visit_details.appointment_date as date,visit_details.id as reff, patients.id as pid,patients.patient_name,visit_details.generated_by as bill_generated_by',
    //         'join'                                    => array('LEFT JOIN staff ON visit_details.cons_doctor = staff.id',
    //             'LEFT JOIN opd_details ON opd_details.id = visit_details.opd_details_id',
    //             'LEFT JOIN patients ON opd_details.patient_id = patients.id',
    //         ),
    //         'condition'                               => 'visit_details.generated_by= ' . $this->db->escape($collect_staff),
    //     ),
    //         'IPD'                    => array('label' => 'IPD', 'table' => 'ipd_details', 'search_table' => 'transactions',
    //             'search_column'                           => 'payment_date',
    //             'select'                                  => 'ipd_details.id,transactions.payment_date as date,transactions.amount,patients.id as pid,patients.patient_name,ipd_details.id as reff,transactions.received_by as bill_generated_by',
    //             'join'                                    => array(
    //                 'JOIN staff ON ipd_details.cons_doctor = staff.id',
    //                 'JOIN patients ON ipd_details.patient_id = patients.id',
    //                 'JOIN transactions ON transactions.ipd_id = ipd_details.id',
    //             ),
    //             'condition'                               => 'transactions.received_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'Pharmacy'               => array('label' => 'Pharmacy', 'table' => 'pharmacy_bill_basic', 'search_table' => 'pharmacy_bill_basic',
    //             'search_column'                           => 'date',
    //             'select'                                  => 'pharmacy_bill_basic.*,patients.patient_name as patient_name,pharmacy_bill_basic.id as reff,pharmacy_bill_basic.net_amount as amount,pharmacy_bill_basic.generated_by as bill_generated_by',
    //             'join'                                    => array('JOIN patients ON patients.id = pharmacy_bill_basic.patient_id'),
    //             'condition'                               => 'pharmacy_bill_basic.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'Pathology'              => array('label' => 'Pathology', 'table' => 'pathology_report', 'search_table' => 'pathology_report',
    //             'search_column'                           => 'reporting_date',
    //             'select'                                  => 'pathology_report.*, pathology_report.apply_charge as amount,pathology_report.id as reff,pathology_report.reporting_date as date,pathology.id, pathology.short_name,patients.patient_name,pathology_report.approved_by as bill_generated_by',
    //             'join'                                    => array(
    //                 'JOIN pathology ON pathology_report.pathology_id = pathology.id',
    //                 'LEFT JOIN staff ON pathology_report.consultant_doctor = staff.id',
    //                 'JOIN patients ON pathology_report.patient_id=patients.id'),
    //             'condition'                               => 'pathology_report.approved_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'Radiology'              => array('label' => 'Radiology', 'table' => 'radiology_report', 'search_table' => 'radiology_report',
    //             'search_column'                           => 'reporting_date',
    //             'select'                                  => 'radiology_report.*,radiology_report.apply_charge as amount,radiology_report.reporting_date as date, radiology_report.id as reff,radio.id, radio.short_name,patients.patient_name,radiology_report.generated_by as bill_generated_by',
    //             'join'                                    => array(
    //                 'JOIN radio ON radiology_report.radiology_id = radio.id',
    //                 'JOIN staff ON radiology_report.consultant_doctor = staff.id',
    //                 'JOIN patients ON radiology_report.patient_id=patients.id',
    //             ),
    //             'condition'                               => 'radiology_report.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'Operation_Theatre'      => array('label' => 'Operation Theatre', 'table' => 'operation_theatre', 'search_table' => 'operation_theatre',
    //             'search_column'                           => 'date',
    //             'select'                                  => 'operation_theatre.*,patients.patient_name,operation_theatre.id as reff,operation_theatre.generated_by as bill_generated_by',
    //             'join'                                    => array(
    //                 'JOIN staff ON staff.id = operation_theatre.consultant_doctor',
    //                 'LEFT JOIN opd_details ON opd_details.id = operation_theatre.opd_details_id',
    //                 'LEFT JOIN ipd_details ON ipd_details.id = operation_theatre.ipd_details_id',
    //                 'LEFT JOIN patients ON patients.id = opd_details.patient_id',

    //             ),
    //             'condition'                               => 'operation_theatre.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'Blood_Bank'             => array('label' => 'Blood Bank', 'table'        => 'blood_issue',
    //             'search_column'                           => 'created_at', 'search_table' => 'blood_issue',
    //             'select'                                  => 'blood_issue.*,blood_issue.id as reff,blood_issue.created_at as date,patients.patient_name,blood_issue.generated_by as bill_generated_by',
    //             'join'                                    => array('JOIN patients ON blood_issue.patient_id=patients.id'),
    //             'condition'                               => 'blood_issue.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'ambulance'              => array('label' => 'Ambulance', 'table' => 'ambulance_call', 'search_table' => 'ambulance_call',
    //             'search_column'                           => 'date',
    //             'select'                                  => 'ambulance_call.*,ambulance_call.id as reff,patients.patient_name,ambulance_call.generated_by as bill_generated_by',
    //             'join'                                    => array('JOIN patients ON ambulance_call.patient_id=patients.id'),
    //             'condition'                               => 'ambulance_call.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'income'                 => array('label' => 'General Income', 'table' => 'income', 'search_table' => 'income',
    //             'search_column'                           => 'date',
    //             'select'                                  => 'income.*,income.name as patient_name,income.invoice_no as reff,income.generated_by as bill_generated_by',
    //             'join'                                    => array('JOIN income_head ON income.inc_head_id = income_head.id'),
    //             'condition'                               => 'income.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //         'expense'                => array('label' => 'Expenses', 'table' => 'expenses', 'search_table' => 'expenses',
    //             'search_column'                           => 'date',
    //             'select'                                  => 'expenses.*,expenses.name as patient_name,expenses.invoice_no as reff,expenses.is_deleted as bill_generated_by',
    //             'join'                                    => array('JOIN expense_head ON expenses.exp_head_id = expense_head.id'),
    //             'condition'                               => 'expenses.is_deleted=' . $this->db->escape($collect_staff),
    //         ),
    //         'payroll'                => array('label' => 'Payroll', 'table' => 'staff_payslip', 'search_table' => 'staff_payslip',
    //             'search_column'                           => 'payment_date',
    //             'select'                                  => 'staff_payslip.*,staff.name as patient_name,staff.surname,staff.employee_id as patient_unique_id,staff_payslip.payment_date as date,staff_payslip.net_salary as amount,staff_payslip.id as reff,staff_payslip.generated_by as bill_generated_by',
    //             'join'                                    => array('JOIN staff ON staff_payslip.staff_id = staff.id'),
    //             'condition'                               => 'staff_payslip.generated_by=' . $this->db->escape($collect_staff),
    //         ),
    //     );

    //     $i                 = 0;
    //     $data["parameter"] = $parameter;
    //     foreach ($parameter as $key => $value) {

    //         $select     = $parameter[$key]['select'];
    //         $join       = $parameter[$key]['join'];
    //         $table_name = $parameter[$key]['table'];

    //         if ($collect_staff != null) {
    //             $condition = array($parameter[$key]['condition']);
    //         } else {
    //             $condition = array();
    //         }

    //         if (empty($search_type)) {

    //             $search_type = "";
    //             $resultList  = $this->report_model->getReport($table_name,$select, $join,  $condition);
    //         } else {
    //             $search_table     = $parameter[$key]['search_table'];
    //             $search_column    = $parameter[$key]['search_column'];
    //             $additional       = array();
    //             $additional_where = array();
    //             $resultList       = $this->report_model->searchReport($table_name,$select, $join,  $search_type, $search_table, $search_column, $condition);
    //         }

    //         $rd[$parameter[$key]['label']]         = $resultList;
    //         $data['parameter'][$key]['resultList'] = $resultList;
    //         $i++;
    //     }

    //     if (isset($_POST['collect_staff']) && $_POST['collect_staff'] != "") {

    //     } else {
    //         $condition2 = array();
    //         $condition3 = array();
    //         $condition4 = array();
    //     }

    //     $resultList2 = $this->report_model->searchReport($table_name = 'ipd_details',$search_table = 'ipd_details',$select = 'patients.id as pid,patients.patient_name,ipd_details.id as reff,ipd_details.generated_by as bill_generated_by', $join = array('JOIN staff ON ipd_details.cons_doctor = staff.id',
    //         'LEFT JOIN patients ON ipd_details.patient_id = patients.id',
    //     ),  $search_type,  $search_column = 'date', $condition2);

    //     if (!empty($resultList2)) {
    //         foreach ($resultList2 as $key => $value) {
    //             array_push($rd["IPD"], $value);
    //             array_push($data['parameter']["IPD"]['resultList'], $value);
    //         }
    //     }

    //     $resultList3 = $this->report_model->searchReport($table_name = 'visit_details',$select = 'visit_details.id,patients.id as pid,patients.patient_name,visit_details.id as reff', $join = array('JOIN staff ON visit_details.cons_doctor = staff.id',
    //         'LEFT JOIN opd_details ON visit_details.id = visit_details.opd_details_id',
    //         'LEFT JOIN patients ON opd_details.patient_id = patients.id',

    //     ),  $search_type, $search_table = 'visit_details', $search_column = 'date', $condition3);

    //     if (!empty($resultList3)) {
    //         foreach ($resultList3 as $key => $value) {
    //             array_push($rd["OPD"], $value);
    //             array_push($data['parameter']["OPD"]['resultList'], $value);
    //         }
    //     }

    //     $resultList4 = $this->report_model->searchReport($table_name = 'visit_details',$select = 'visit_details.id,transactions.payment_date,transactions.amount,patients.id as pid,patients.patient_name,visit_details.id as reff,transactions.received_by as bill_generated_by', $join = array('JOIN staff ON visit_details.cons_doctor = staff.id',
    //         'LEFT JOIN opd_details ON opd_details.id = visit_details.opd_details_id',
    //         'LEFT JOIN patients ON opd_details.patient_id = patients.id',
    //         'LEFT JOIN transactions ON transactions.opd_id = opd_details.id',

    //     ),  $search_type, $search_table = 'transactions', $search_column = 'payment_date', $condition4);

    //     if (!empty($resultList4)) {
    //         foreach ($resultList4 as $key => $value) {
    //             array_push($rd["OPD"], $value);
    //             array_push($data['parameter']["OPD"]['resultList'], $value);
    //         }
    //     }

    //     $data["resultlist"]  = $rd;
    //     $data["searchlist"]  = $this->search_type;
    //     $data["search_type"] = $search_type;
    //     $this->load->view('layout/header', $data);
    //     $this->load->view('admin/income/transactionReport', $data);
    //     $this->load->view('layout/footer', $data);
    // }

    public function checkvalidation()
    {
        $search = $this->input->post('search');
        $this->form_validation->set_rules('search_type', $this->lang->line('search_type'), 'trim|required|xss_clean');

        $this->form_validation->set_rules('modules_select', $this->lang->line('modules'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'search_type'    => form_error('search_type'),
                'modules_select' => form_error('modules_select'),

            );
            $json_array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $param = array(
                'search_type'    => $this->input->post('search_type'),
                'collect_staff'  => $this->input->post('collect_staff'),
                'modules_select' => $this->input->post('modules_select'),
                'date_from'      => $this->input->post('date_from'),
                'date_to'        => $this->input->post('date_to'),
            );

            $json_array = array('status' => 'success', 'error' => '', 'param' => $param, 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($json_array);
    }

    public function checkvalidationincome()
    {
        $search = $this->input->post('search');
        $this->form_validation->set_rules('search_type', $this->lang->line('search_type'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'search_type' => form_error('search_type'),

            );
            $json_array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $param = array(
                'search_type' => $this->input->post('search_type'),

                'date_from'   => $this->input->post('date_from'),
                'date_to'     => $this->input->post('date_to'),
            );

            $json_array = array('status' => 'success', 'error' => '', 'param' => $param, 'message' => $this->lang->line('success_message'));
        }
        echo json_encode($json_array);
    }

    public function alltransactionreport($value = '')
    {
        if (!$this->rbac->hasPrivilege('transaction_report', 'can_view')) {
            access_denied();
        }
        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'admin/income/alltransactionreport');
        $data['title']          = 'title';
        $resultList_staffsearch = $this->patient_model->getstaffsearch();
        $data['staffsearch']    = $resultList_staffsearch;
        $data["modules"]        = $this->customlib->get_modules();
        $data["searchlist"]     = $this->search_type;
        $data['search_data']    = '';
        $this->load->view('layout/header', $data);
        $this->load->view('admin/income/alltransactionReport', $data);
        $this->load->view('layout/footer', $data);
    }

    public function transactionreports()
    {
        $search['search_type']    = $this->input->post('search_type');
        $search['collect_staff']  = $this->input->post('collect_staff');
        $search['modules_select'] = $this->input->post('modules_select');
        $search['date_from']      = $this->input->post('date_from');
        $search['date_to']        = $this->input->post('date_to');
        $start_date               = '';
        $end_date                 = '';

        if ($search['search_type'] == 'period') {

            $start_date = $this->customlib->dateFormatToYYYYMMDD($search['date_from']);
            $end_date   = $this->customlib->dateFormatToYYYYMMDD($search['date_to']);

        } else {

            if (isset($search['search_type']) && $search['search_type'] != '') {
                $dates               = $this->customlib->get_betweendate($search['search_type']);
                $data['search_type'] = $search['search_type'];
            } else {
                $dates               = $this->customlib->get_betweendate('this_year');
                $data['search_type'] = '';
            }

            $start_date = $dates['from_date'];
            $end_date   = $dates['to_date'];
        }

        $search['start_date'] = $start_date;
        $search['end_date']   = $end_date;

        if ($search['modules_select'] == 'all') {
            $transactiondata = $this->transaction_model->transactionRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'opd_patient') {
            $transactiondata = $this->transaction_model->opdpatientRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'ipd_patient') {
            $transactiondata = $this->transaction_model->ipdpatientRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'pharmacy_bill') {
            $transactiondata = $this->transaction_model->pharmacybillRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'pathology_test') {
            $transactiondata = $this->transaction_model->pathologybillRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'radiology_test') {
            $transactiondata = $this->transaction_model->radiologybillRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'blood_issue') {
            $transactiondata = $this->transaction_model->bloodissuebillRecord($search);
        } elseif ($search['modules_select'] == 'ambulance_call') {
            $transactiondata = $this->transaction_model->ambulancecallRecord($search);
        } elseif ($search['modules_select'] == 'income') {
            $transactiondata = $this->transaction_model->incomeRecord($start_date, $end_date, $search['collect_staff']);

        } elseif ($search['modules_select'] == 'expense') {
            $transactiondata = $this->transaction_model->expensesRecord($start_date, $end_date, $search['collect_staff']);
        } elseif ($search['modules_select'] == 'payroll_report') {
            $transactiondata = $this->transaction_model->payrollRecord($start_date, $end_date, $search['collect_staff']);
        }

        $transactiondata = json_decode($transactiondata);
        $dt_data         = array();
        $total_amount    = 0;

        if (!empty($transactiondata->data)) {
            foreach ($transactiondata->data as $key => $value) {
                $total_amount += $value->amount;

                if (!empty($value->ward)) {
                    $ward = $this->customlib->getSessionPrefixbyType($value->ward);
                } else {
                    $ward = '';
                }
                if (!empty($value->reference)) {
                    $reference = $value->reference;
                } else {
                    $reference = '';
                }
                if ($value->section != null) {
                    if($value->section == "Appointment"){
                        $section = "OPD / Appointment";
                    }else{
                        $section = $value->section;
                    }
                } else {
                    $section = '';
                }
                if ($value->type != null) {
                    $type = $this->lang->line($value->type);
                } else {
                    $type = '';
                }
                if ($value->payment_mode != null) {
                    $payment_mode = $this->lang->line(strtolower($value->payment_mode));
                } else {
                    $payment_mode = '';
                }
                if (!empty($value->amount)) {
                    $amount = $value->amount;
                } else {
                    $amount = '';
                }
                if (!empty($value->patient_id)) {
                    $patient_id = " (" . $value->patient_id . ")";
                } else {
                    $patient_id = '';
                }

                if (($search['modules_select'] == 'income') || ($search['modules_select'] == 'expense') || ($search['modules_select'] == 'payroll_report')) {
                    $date = $this->customlib->YYYYMMDDTodateFormat($value->payment_date);
                } else {
                    $date = $this->customlib->YYYYMMDDHisTodateFormat($value->payment_date, $this->customlib->getHospitalTimeFormat());
                }

                $row                = array();
                $transaction_prefix = $this->customlib->getSessionPrefixByType('transaction_id');
               
                $row[]     = $transaction_prefix . $value->id;
                $row[]     = $date;
                if(!empty($value->patient_id)){
                     $row[]     = composePatientName($value->patient_name,$value->patient_id);
                 }else{
                    $row[]="";
                 }
               
                $row[]     = $ward . $reference;
                $row[]     = $section;
                $row[]     = composeStaffNameByString($value->name, $value->surname, $value->employee_id);
                $row[]     = $type;
                $row[]     = $payment_mode;
                $row[]     = $amount;
                $dt_data[] = $row;
            }
            $footer_row   = array();
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "<b>" . $this->lang->line('total_amount') . "</b>" . ':';
            $footer_row[] = "<b>" . (number_format($total_amount, 2, '.', '')) . "<br/>";
            $dt_data[]    = $footer_row;
        }

        $json_data = array(
            "draw"            => intval($transactiondata->draw),
            "recordsTotal"    => intval($transactiondata->recordsTotal),
            "recordsFiltered" => intval($transactiondata->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

    public function incomereports()
    {
        $search['search_type'] = $this->input->post('search_type');
        $search['date_from']   = $this->input->post('date_from');
        $search['date_to']     = $this->input->post('date_to');
        $start_date            = '';
        $end_date              = '';
        $fields                = $this->customfield_model->get_custom_fields('income', '', '', 1);
        if ($search['search_type'] == 'period') {

            $start_date = $this->customlib->dateFormatToYYYYMMDD($search['date_from']);
            $end_date   = $this->customlib->dateFormatToYYYYMMDD($search['date_to']);

        } else {

            if (isset($search['search_type']) && $search['search_type'] != '') {
                $dates               = $this->customlib->get_betweendate($search['search_type']);
                $data['search_type'] = $search['search_type'];
            } else {
                $dates               = $this->customlib->get_betweendate('this_year');
                $data['search_type'] = '';
            }

            $start_date = $dates['from_date'];
            $end_date   = $dates['to_date'];
        }

        $reportdata   = $this->transaction_model->incomereportRecord($start_date, $end_date);
        $reportdata   = json_decode($reportdata);
        $dt_data      = array();
        $total_amount = 0;
        if (!empty($reportdata->data)) {
            foreach ($reportdata->data as $key => $value) {

                $total_amount += $value->amount;
                $row   = array();
                $row[] = $value->invoice_name;
                $row[] = $value->invoice_no;
                $row[] = $value->income_category;
                $row[] = $this->customlib->YYYYMMDDTodateFormat($value->payment_date);
                if (!empty($fields)) {
                    foreach ($fields as $fields_key => $fields_value) {
                        $display_field = $value->{"$fields_value->name"};
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $value->{"$fields_value->name"} . " target='_blank'>" . $value->{"$fields_value->name"} . "</a>";

                        }
                        $row[] = $display_field;
                    }
                }

                $row[]     = $value->amount;
                $dt_data[] = $row;
            }

            $footer_row   = array();
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "<b>" . $this->lang->line('total_amount') . "</b>" . ':';
            $footer_row[] = "<b>" . (number_format($total_amount, 2, '.', '')) . "<br/>";
            $dt_data[]    = $footer_row;
        }

        $json_data = array(
            "draw"            => intval($reportdata->draw),
            "recordsTotal"    => intval($reportdata->recordsTotal),
            "recordsFiltered" => intval($reportdata->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

    public function incomegroup()
    {
        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'reports/incomegroup');

        if (isset($_POST['search_type'])) {
            $search_type = $this->input->post("search_type");
        } else {
            $search_type = "";
        }
        $data['head_id'] = $head_id = "";
        if (isset($_POST['head']) && $_POST['head'] != '') {
            $data['head_id'] = $head_id = $_POST['head'];
        }
        $data['fields']      = $this->customfield_model->get_custom_fields('income', '', '', 1);
        $data["searchlist"]  = $this->search_type;
        $data["search_type"] = $search_type;
        $incomeList          = $this->income_model->searchincomegroup($search_type, $head_id);
        $data['headlist']    = $this->incomehead_model->get();
        $data['incomeList']  = $incomeList;
        $this->load->view('layout/header', $data);
        $this->load->view('admin/income/groupincomeReport', $data);
        $this->load->view('layout/footer', $data);
    }

    /* this function is used to get and return income group report parameter without applying any validation */
    public function getgroupreportparam()
    {

        $search_type = $this->input->post('search_type');
        $head        = $this->input->post('head');

        $date_from = "";
        $date_to   = "";
        if ($search_type == 'period') {

            $date_from = $this->input->post('date_from');
            $date_to   = $this->input->post('date_to');
        }

        $params = array('search_type' => $search_type, 'head' => $head, 'date_from' => $date_from, 'date_to' => $date_to);
        $array  = array('status' => 1, 'error' => '', 'params' => $params);
        echo json_encode($array);
    }
    /* this function is used to get income group report by using datatable */

    public function dtincomegroupreport()
    {
        $search_type = $this->input->post('search_type');
        $date_from   = $this->input->post('date_from');
        $date_to     = $this->input->post('date_to');
        $head        = $this->input->post('head');
        $fields      = $this->customfield_model->get_custom_fields('income', '', '', 1);
        if (isset($search_type) && $search_type != '') {

            $dates               = $this->customlib->get_betweendate($search_type);
            $data['search_type'] = $_POST['search_type'];

        } else {

            $dates               = $this->customlib->get_betweendate('this_year');
            $data['search_type'] = '';

        }
        $data['head_id'] = $head_id = "";
        if (isset($_POST['head']) && $_POST['head'] != '') {
            $data['head_id'] = $head_id = $_POST['head'];
        }

        $start_date = date('Y-m-d', strtotime($dates['from_date']));
        $end_date   = date('Y-m-d', strtotime($dates['to_date']));

        $data['label'] = date($this->customlib->getHospitalDateFormat(), strtotime($start_date)) . " " . $this->lang->line('to') . " " . date($this->customlib->getHospitalDateFormat(), strtotime($end_date));
        $incomeList    = $this->report_model->searchincomegroup($start_date, $end_date, $head_id);
        //echo $this->db->last_query();die;
        $m               = json_decode($incomeList);
        $currency_symbol = $this->customlib->getHospitalCurrencyFormat();
        $dt_data         = array();
        $grand_total     = 0;

        if (!empty($m->data)) {
            $grd_total  = 0;
            $inchead_id = 0;
            $count      = 0;
            foreach ($m->data as $key => $value) {
                $income_head[$value->head_id][] = $value;
            }
            foreach ($m->data as $key => $value) {
                $inc_head_id  = $value->head_id;
                $total_amount = "<b>" . $value->amount . "</b>";
                $grd_total += $value->amount;
                $row = array();
                if ($inchead_id == $inc_head_id) {
                    $row[] = "";
                    $count++;
                } else {
                    $row[] = $value->income_category;
                    $count = 0;
                }
                $row[] = $value->id;
                $row[] = $value->name;
                $row[] = $this->customlib->YYYYMMDDTodateFormat($value->date);
                $row[] = $value->invoice_no;

                if (!empty($fields)) {
                    foreach ($fields as $fields_key => $fields_value) {

                        $display_field = $value->{"$fields_value->name"};
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $value->{"$fields_value->name"} . " target='_blank'>" . $value->{"$fields_value->name"} . "</a>";

                        }
                        $row[] = $display_field;
                    }
                }
                
                $row[]      = $value->amount;
                $dt_data[]  = $row;
                $inchead_id = $value->head_id;
                $sub_total  = 0;
                if ($count == (count($income_head[$value->head_id]) - 1)) {
                    foreach ($income_head[$value->head_id] as $inc_headkey => $inc_headvalue) {
                        $sub_total += $inc_headvalue->amount;
                    }
                    $amount_row   = array();
                    $amount_row[] = "";
                    $amount_row[] = "";
                    $amount_row[] = "";
                    $amount_row[] = "";
                    $amount_row[] = "";
                    $amount_row[] = "<b>" . $this->lang->line('sub') . " " . $this->lang->line('total').': ' .amountFormat($sub_total) . "</b>";
                    $dt_data[]    = $amount_row;
                }
            }

            $grand_total  = "<b>" . $currency_symbol . amountFormat($grd_total) . "</b>";
            $footer_row   = array();
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "";
            $footer_row[] = "<b>" . $this->lang->line('total').': ' .$grand_total. "</b>";
            $dt_data[]    = $footer_row;
        }

        $json_data = array(
            "draw"            => intval($m->draw),
            "recordsTotal"    => intval($m->recordsTotal),
            "recordsFiltered" => intval($m->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

}
