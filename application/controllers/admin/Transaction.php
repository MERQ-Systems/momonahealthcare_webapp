<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Transaction extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model(array('transaction_model'));
    }

    public function printTransaction()
    {
        $print_details         = $this->printing_model->get('', 'paymentreceipt');
        $id                    = $this->input->post('id');
        $transaction           = $this->transaction_model->getTransaction($id);
        $data['transaction']   = $transaction;
        $data['print_details'] = $print_details;
        $page                  = $this->load->view('admin/transaction/_printTransaction', $data, true);
        echo json_encode(array('status' => 1, 'page' => $page));
    }

    public function deleteByID()
    {
        $id          = $this->input->post('id');
        $transaction = $this->transaction_model->delete($id);
        $array       = array('status' => 'success', 'message' => $this->lang->line('delete_message'));
        echo json_encode($array);
    }

    public function download($trans_id)
    {
        $transaction = $this->transaction_model->getTransaction($trans_id);
        $this->load->helper('download');
        $filepath    = "./uploads/payment_document/" . $transaction->attachment;
        $report_name = $transaction->attachment_name;
        $data        = file_get_contents($filepath);
        force_download($report_name, $data);
    }

    public function transactionreport()
    {
        if (!$this->rbac->hasPrivilege('daily_transaction_report', 'can_view')) {
            access_denied();
        }
        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'admin/transaction/dailytransactionreport');
        $data['title'] = 'title';
        $this->form_validation->set_rules('date_from', $this->lang->line('date_from'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('date_to', $this->lang->line('date_to'), 'trim|required|xss_clean');
        if ($this->form_validation->run() == false) {
            $msg = array(
                'date_from' => form_error('date_from'),
                'date_to'   => form_error('date_to'),
            );
            $json_array = array('status' => 'fail', 'error' => $msg, 'message' => '');
        } else {
            $date_from = $this->customlib->dateFormatToYYYYMMDD($this->input->post('date_from'));
            $date_to   = $this->customlib->dateFormatToYYYYMMDD($this->input->post('date_to'));

            $reportdata = $this->transaction_model->getTransactionBetweenDate($date_from, $date_to, 'payment');
            $start_date = strtotime($date_from);
            $end_date   = strtotime($date_to);
            $date_array = array();
            for ($i = $start_date; $i <= $end_date; $i += 86400) {
                $date_array[date('Y-m-d', $i)] = array('amount' => 0, 'online_transaction' => 0, 'offline_transaction' => 0, 'total_transaction' => 0);
            }

            if (!empty($reportdata)) {
                foreach ($reportdata as $key => $value) {

                    $date_array[date('Y-m-d', strtotime($value->payment_date))]['amount']            = $date_array[date('Y-m-d', strtotime($value->payment_date))]['amount'] + $value->amount;
                    $date_array[date('Y-m-d', strtotime($value->payment_date))]['total_transaction'] = $date_array[date('Y-m-d', strtotime($value->payment_date))]['total_transaction'] + 1;

                    if ($value->payment_mode == "Online") {
                        $date_array[date('Y-m-d', strtotime($value->payment_date))]['online_transaction'] = $date_array[date('Y-m-d', strtotime($value->payment_date))]['online_transaction'] + $value->amount;
                    } else {
                        $date_array[date('Y-m-d', strtotime($value->payment_date))]['offline_transaction'] = $date_array[date('Y-m-d', strtotime($value->payment_date))]['offline_transaction'] + $value->amount;
                    }
                }
            }

            $dt_data = array();
            foreach ($date_array as $dt_key => $dt_value) {
                $row                        = array();
                $row['date']                = $dt_key;
                $row['total_transaction']   = $dt_value['total_transaction'];
                $row['online_transaction']  = $dt_value['online_transaction'];
                $row['offline_transaction'] = $dt_value['offline_transaction'];
                $row['amount']              = $dt_value['amount'];
                $dt_data[]                  = $row;
            }

            $data['result'] = $dt_data;
        }

        $this->load->view('layout/header', $data);
        $this->load->view('admin/transaction/transactionreport', $data);
        $this->load->view('layout/footer', $data);
    }

    public function gettransactionbydate()
    {
        if (!$this->rbac->hasPrivilege('transaction_report', 'can_view')) {
            access_denied();
        }
        $date          = $this->input->post('date');
        $data['title'] = 'title';
        $result         = $this->transaction_model->getTransactionBetweenDate($date, $date, 'payment');
        $data['result'] = $result;
        $page           = $this->load->view('admin/transaction/_gettransactionbydate', $data, true);
        echo json_encode(array('status' => 1, 'page' => $page));
    }
}
