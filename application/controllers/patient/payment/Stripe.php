<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Stripe extends Patient_Controller
{

    public $payment_method = array();
    public $pay_method     = array();
    public $patient_data;
    public $setting;

    public function __construct()
    {
        parent::__construct();
        $this->config->load("payroll");
        $this->load->library('Enc_lib');
        $this->load->library('Customlib');
        $this->load->library('stripe_payment');
        $this->patient_data   = $this->session->userdata('patient');
        $this->payment_method = $this->paymentsetting_model->get();
        $this->pay_method     = $this->paymentsetting_model->getActiveMethod();
        $this->marital_status = $this->config->item('marital_status');
        $this->payment_mode   = $this->config->item('payment_mode');
        $this->blood_group    = $this->config->item('bloodgroup');
        $this->setting        = $this->setting_model->get();
    }

    public function index()
    {
        $setting             = $this->setting[0];
        $data                = array();
        $id                  = $this->patient_data['patient_id'];
        $data["id"]          = $id;
        $data['productinfo'] = "bill payment momona health care";
        if ($this->session->has_userdata('payment_data')) {
            $payment_data = $this->session->userdata("payment_data");
            
            $api_publishable_key         = ($this->pay_method->api_publishable_key);
            $api_secret_key              = ($this->pay_method->api_secret_key);
            $data['api_publishable_key'] = $api_publishable_key;
            $data['api_secret_key']      = $api_secret_key;
            $data['case_reference_id']   = $payment_data['case_reference_id'];
            $data['amount']              = $payment_data['deposit_amount'];
            $data['currency']            = $setting['currency'];
            $data['hospital_name']       = $setting['name'];
            $data['image']               = $setting['image'];
            
            $this->load->view("layout/patient/header");
            $this->load->view("patient/payment/stripe/stripe", $data);
            $this->load->view("layout/patient/footer");
        }
    }

    public function complete()
    {
        $payment_data           = $this->session->userdata('payment_data');

        $stripeToken         = $this->input->post('stripeToken');
        $stripeTokenType     = $this->input->post('stripeTokenType');
        $stripeEmail         = $this->input->post('stripeEmail');
        $data                = $this->input->post();
        $data['stripeToken'] = $stripeToken;
        $data['total']  = $payment_data["deposit_amount"];
        $data['description'] = 'test product';
        $data['currency']    = 'USD';
        $response         = $this->stripe_payment->payment($data);
        if ($response->isSuccessful()) {
            $transactionid = $response->getTransactionReference();
            $response      = $response->getData();
            if ($response['status'] == 'succeeded') {
                $payment_data = $this->session->userdata('payment_data');
                
                $save_record = array(
                    'case_reference_id' => $payment_data["case_reference_id"],
                    'type' => "payment",
                    'amount'  => $payment_data['deposit_amount'],
                    'payment_mode' => 'Online',
                    'payment_date' => date('Y-m-d H:i:s'),
                    'note'         => "Online fees deposit through Stripe TXN ID: " . $transactionid,
                    'patient_id'                  => $this->patient_data['patient_id']
                );
                if($payment_data['payment_for'] == "opd"){
                    $save_record["opd_id"] = $payment_data['id'];
                }elseif($payment_data['payment_for'] == "ipd"){
                    $save_record["ipd_id"] = $payment_data['id'];
                }elseif($payment_data['payment_for'] == "pharmacy"){
                    $save_record["pharmacy_bill_basic_id"] = $payment_data['id']; 
                }elseif($payment_data['payment_for'] == "pathology"){
                    $save_record["pathology_billing_id"] = $payment_data['id'];
                }elseif($payment_data['payment_for'] == "radiology"){
                    $save_record["radiology_billing_id"] = $payment_data['id'];
                }elseif($payment_data['payment_for'] == "blood_bank"){
                    $save_record["blood_issue_id"] = $payment_data['id'];
                }elseif($payment_data['payment_for'] == "ambulance"){
                    $save_record["ambulance_call_id"] = $payment_data['id'];
                }
                $insert_id = $this->payment_model->insertOnlinePaymentInTransactions($save_record);
                redirect(base_url("patient/pay/successinvoice/"));
            }
        } elseif ($response->isRedirect()) {
            $response->redirect();
        } else {
            redirect(site_url('patient/dashboard'));
        }
    }
}
