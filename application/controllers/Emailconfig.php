<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Emailconfig extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('smsgateway');
        $this->load->library('mailsmsconf');
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('email_setting', 'can_view')) {
            access_denied();
        }
        $data = array();
        $this->session->set_userdata('top_menu', 'setup');
        $this->session->set_userdata('sub_menu', 'schsettings/index');
        $this->session->set_userdata('inner_menu', 'emailconfig/index');
        $data['title']       = 'Email Config List';
        $data['mailMethods'] = $this->customlib->getMailMethod();
        $emaillist           = $this->emailconfig_model->get();
        $smtp_auth           = $this->config->item('smtp_auth');
        $smtp_encryption     = $this->config->item('smtp_encryption');
        if (empty($emaillist)) {
            $emaillist                = new stdClass();
            $emaillist->email_type    = "";
            $emaillist->smtp_server   = "";
            $emaillist->smtp_port     = "";
            $emaillist->smtp_username = "";
            $emaillist->smtp_password = "";
            $emaillist->ssl_tls       = "";
            $emaillist->smtp_auth     = "false";
        }
        $data['smtp_encryption'] = $smtp_encryption;
        $data['smtp_auth']       = $smtp_auth;
        $data['emaillist']       = $emaillist;
        $this->form_validation->set_rules('email_type', $this->lang->line('email') . " " . $this->lang->line('type'), 'required');
        if ($this->input->post('email_type') == "smtp") {
            $this->form_validation->set_rules('smtp_username', $this->lang->line('smtp_username'), 'required');
            $this->form_validation->set_rules('smtp_password', $this->lang->line('smtp_password'), 'required');
        }

        if ($this->form_validation->run() === false) {
            $data['title'] = 'Email Config List';
            $this->load->view('layout/header', $data);
            $this->load->view('emailconfig/emailIndex', $data);
            $this->load->view('layout/footer', $data);
        } else {
            $data['title'] = 'Email Config List';
            $data_insert   = array(
                'email_type'    => $this->input->post('email_type'),
                'smtp_username' => $this->input->post('smtp_username'),
                'smtp_password' => $this->input->post('smtp_password'),
                'smtp_server'   => $this->input->post('smtp_server'),
                'smtp_port'     => $this->input->post('smtp_port'),
                'ssl_tls'       => $this->input->post('smtp_security'),
                'smtp_auth'     => $this->input->post('smtp_auth'),
                'is_active'     => 'yes',
            );
            $this->emailconfig_model->add($data_insert);
            $this->session->set_flashdata('msg', '<div class="alert alert-success">' . $this->lang->line('update_message') . '</div>');
            redirect('emailconfig');
        }
    }

}
