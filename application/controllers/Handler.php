<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Handler extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
    }

    public function show_404()
    {
        $this->load->view('errors/error_message');
    }

}
