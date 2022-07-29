<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Content extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('datatables');
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('upload_content', 'can_view')) {
            access_denied();
        }

        $this->session->set_userdata('top_menu', 'Download Center');
        $this->session->set_userdata('sub_menu', 'admin/content');
        $this->form_validation->set_rules('content_title', $this->lang->line('content_title'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('content_type', $this->lang->line('content_type'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('content_available[]', $this->lang->line('available_for'), 'trim|required|xss_clean');
        $post_data = $this->input->post();
        $this->form_validation->set_rules('file', $this->lang->line('image'), 'callback_handle_upload');
        if ($this->form_validation->run() == false) {
            $this->load->view('layout/header');
            $this->load->view('admin/content/createcontent');
            $this->load->view('layout/footer');
        } else {

            $data = array(
                'title' => $this->input->post('content_title'),
                'type'  => $this->input->post('content_type'),
                'note'  => $this->input->post('note'),
                'file'  => $this->input->post('file'),
            );

            $upload_date = $this->input->post('upload_date');
            if (!empty($upload_date)) {

                $data['date'] = $this->customlib->dateFormatToYYYYMMDD($this->input->post('upload_date'));
            } else {
                $data['date'] = null;
            }

            $insert_id = $this->content_model->add($data);
            if (isset($_FILES["file"]) && !empty($_FILES['file']['name'])) {
                $fileInfo = pathinfo($_FILES["file"]["name"]);
                $img_name = $insert_id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["file"]["tmp_name"], "./uploads/hospital_content/material/" . $img_name);
                $data_img = array('id' => $insert_id, 'file' => 'uploads/hospital_content/material/' . $img_name);
                $this->content_model->add($data_img);
            }
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-left">' . $this->lang->line('content_added_successfully') . ' </div>');
            redirect('admin/content');
        }
    }

    public function getcontentdatatable()
    {
        $dt_response = $this->content_model->getAllcontentRecord();
        $dt_response = json_decode($dt_response);
        $dt_data     = array();
        if (!empty($dt_response->data)) {
            foreach ($dt_response->data as $key => $value) {

                $row = array();
                //====================================

                $action = "<a href=" . base_url() . 'admin/content/download/' . $value->file . " onclick='' class='btn btn-default btn-xs'  data-toggle='tooltip' title='" . $this->lang->line('download') . "'><i class='fa fa-download'></i></a>";

                if ($this->rbac->hasPrivilege('upload_content', 'can_delete')) {
                    $action .= "<a href='#' onclick=delete_recordById('admin/content/delete/" . $value->id . "')  class='btn btn-default btn-xs pull-right'  data-toggle='tooltip' title='" . $this->lang->line('delete') . "'><i class='fa fa-trash'></i></a>";
                }

                //==============================
                $row[] = $value->title;
                $row[] = $value->type;
                if (!empty($value->date) && ($value->date == '1970-01-01')) {
                    $row[] = " ";
                } else {
                    $row[] = $this->customlib->YYYYMMDDTodateFormat($value->date);
                }
                $row[]     = $value->note;
                $row[]     = $action;
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
        $this->form_validation->set_rules('content_title', $this->lang->line('content_title'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('content_type', $this->lang->line('content_type'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('file', $this->lang->line('image'), 'callback_handle_upload');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'content_title' => form_error('content_title'),
                'content_type'  => form_error('content_type'),
                'file'          => form_error('file'),
            );

            $array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $data = array(
                'title' => $this->input->post('content_title'),
                'type'  => $this->input->post('content_type'),
                'note'  => $this->input->post('note'),

            );
            if (!empty($upload_date)) {
                $data['date'] = $this->customlib->dateFormatToYYYYMMDD($this->input->post('upload_date'));
            } else {
                $data['date'] = null;
            }
            $insert_id = $this->content_model->add($data);
            if (isset($_FILES["file"]) && !empty($_FILES['file']['name'])) {
                $fileInfo = pathinfo($_FILES["file"]["name"]);
                $img_name = $insert_id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["file"]["tmp_name"], "./uploads/hospital_content/material/" . $img_name);
                $data_img = array('id' => $insert_id, 'file' => 'uploads/hospital_content/material/' . $img_name);
                $this->content_model->add($data_img);
            }
            $array = array('status' => 'success', 'error' => '', 'message' => $this->lang->line('success_message'));
        }

        echo json_encode($array);
    }

    public function index1()
    {

        $this->customlib->getStaffRole();
        $data['title']             = 'Upload Content';
        $data['title_list']        = 'Upload Content List';
        $data['content_available'] = $this->customlib->contentAvailabelFor();
        $ght                       = $this->customlib->getcontenttype();
        $list                      = $this->content_model->get();
        $class                     = $this->class_model->get();
        $data['list']              = $list;
        $data['classlist']         = $class;
        $data['ght']               = $ght;
        $this->form_validation->set_rules('content_title', $this->lang->line('content_title'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('content_type', $this->lang->line('content_type'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('content_available[]', $this->lang->line('available_for'), 'trim|required|xss_clean');
        $post_data = $this->input->post();

        $this->form_validation->set_rules('file', $this->lang->line('image'), 'callback_handle_upload');
        if ($this->form_validation->run() == false) {
            $this->load->view('layout/header');
            $this->load->view('admin/content/createcontent', $data);
            $this->load->view('layout/footer');
        } else {

            $data = array(
                'title'      => $this->input->post('content_title'),
                'type'       => $this->input->post('content_type'),
                'note'       => $this->input->post('note'),
                'class_id'   => $classes,
                'cls_sec_id' => $section_id,
                'date'       => $this->customlib->dateFormatToYYYYMMDD($this->input->post('upload_date')),
                'file'       => $this->input->post('file'),
                'is_public'  => $visibility,
            );

            $insert_id = $this->content_model->add($data, $content_for);
            if (isset($_FILES["file"]) && !empty($_FILES['file']['name'])) {
                $fileInfo = pathinfo($_FILES["file"]["name"]);
                $img_name = $insert_id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["file"]["tmp_name"], "./uploads/hospital_content/material/" . $img_name);
                $data_img = array('id' => $insert_id, 'file' => 'uploads/hospital_content/material/' . $img_name);
                $this->content_model->add($data_img);
            }
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-left">' . $this->lang->line('success_message') . '</div>');
            redirect('admin/content');
        }
    }

    public function handle_upload()
    {
        if (isset($_FILES["file"]) && !empty($_FILES['file']['name'])) {
            $allowedExts = array('jpg', 'jpeg', 'png', "pdf", "doc", "docx", "rar", "zip");
            $temp        = explode(".", $_FILES["file"]["name"]);
            $extension   = end($temp);
            if ($_FILES["file"]["error"] > 0) {
                $error .= $this->lang->line('error_opening_the_file') . "<br />";
            }
            if (($_FILES["file"]["type"] != "application/pdf") && ($_FILES["file"]["type"] != "image/gif") && ($_FILES["file"]["type"] != "image/jpeg") && ($_FILES["file"]["type"] != "image/jpg") && ($_FILES["file"]["type"] != "application/vnd.openxmlformats-officedocument.wordprocessingml.document") && ($_FILES["file"]["type"] != "application/vnd.openxmlformats-officedocument.wordprocessingml.document") && ($_FILES["file"]["type"] != "image/pjpeg") && ($_FILES["file"]["type"] != "image/x-png") && ($_FILES["file"]["type"] != "application/x-rar-compressed") && ($_FILES["file"]["type"] != "application/octet-stream") && ($_FILES["file"]["type"] != "application/zip") && ($_FILES["file"]["type"] != "application/octet-stream") && ($_FILES["file"]["type"] != "image/png")) {
                $this->form_validation->set_message('handle_upload', $this->lang->line('file_type_not_allowed'));
                return false;
            }
            if (!in_array(strtolower($extension), $allowedExts)) {
                $this->form_validation->set_message('handle_upload', $this->lang->line('file_extension_not_allowed'));
                return false;
            }
            return true;
        } else {
            $this->form_validation->set_message('handle_upload', $this->lang->line('the_file_field_is_required'));
            return false;
        }
    }

    public function download($file)
    {
        $this->load->helper('download');
        $filepath = "./uploads/hospital_content/material/" . $this->uri->segment(7);
        $data     = file_get_contents($filepath);
        $name     = $this->uri->segment(7);
        force_download($name, $data);
    }

    public function edit($id)
    {
        if (!$this->rbac->hasPrivilege('upload_content', 'can_edit')) {
            access_denied();
        }
        $data['title']     = 'Add Content';
        $data['id']        = $id;
        $editpost          = $this->content_model->get($id);
        $data['editpost']  = $editpost;
        $ght               = $this->customlib->getcontenttype();
        $data['ght']       = $ght;
        $class             = $this->class_model->get();
        $data['classlist'] = $class;
        $this->form_validation->set_rules('content_title', $this->lang->line('content_title'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $listpost         = $this->content_model->get();
            $data['listpost'] = $listpost;
            $this->load->view('layout/header');
            $this->load->view('admin/content/editpost', $data);
            $this->load->view('layout/footer');
        } else {
            $data = array(
                'id'            => $this->input->post('id'),
                'content_title' => $this->input->post('content_title'),
                'content_type'  => $this->input->post('content_type'),
                'class_id'      => $this->input->post('class_id'),
                'date'          => $this->customlib->dateFormatToYYYYMMDD($this->input->post('upload_date')),
                'file_uploaded' => $this->input->file['file']['name'],
            );
            $this->content_model->addcontentpost($data);
            if (isset($_FILES["file"]) && !empty($_FILES['file']['name'])) {
                $fileInfo = pathinfo($_FILES["file"]["name"]);
                $img_name = $id . '.' . $fileInfo['extension'];
                move_uploaded_file($_FILES["file"]["tmp_name"], "./uploads/patient_images/" . $img_name);
                $data_img = array('id' => $id, 'file_uploaded' => 'uploads/patient_images/' . $img_name);
                $this->content_model->addcontentpost($data_img);
            }
            $this->session->set_flashdata('msg', '<div class="alert alert-success text-center">' . $this->lang->line('success_message') . '</div>');
            redirect('admin/content/createcontent/index');
        }
    }

    public function search()
    {
        $text                = $_GET['content'];
        $data['title']       = 'Fees Master List';
        $contentlist         = $this->content_model->search_by_content_type($text);
        $data['contentlist'] = $contentlist;
        $this->load->view('layout/header');
        $this->load->view('admin/content/search', $data);
        $this->load->view('layout/footer');
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('upload_content', 'can_delete')) {
            access_denied();
        }
        $data = $this->content_model->get($id);
        $file = $data['file'];

        if (file_exists($file)) {
            unlink($file);
        }

        $this->content_model->remove($id);
        echo json_encode(array('status' => 1, 'msg' => $this->lang->line('delete_message')));
    }
}
