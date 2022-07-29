<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Stripe extends Patient_Controller
{

    public $pay_method = "";
    public $amount = 0;

    function __construct() {
        parent::__construct();
        $this->pay_method = $this->paymentsetting_model->getActiveMethod();
        $this->setting = $this->setting_model->get()[0];
        $this->load->library(array('stripe_payment'));
        $this->load->model(array('onlineappointment_model','charge_model'));
    }

    public function index() {

        

        $appointment_id = $this->session->userdata('appointment_id');
        $appointment_data = $this->onlineappointment_model->getAppointmentDetails($appointment_id);
        $data['setting'] = $this->setting;
        $charges_array = $this->charge_model->getChargeDetailsById($appointment_data->charge_id);
        if(isset($charges_array->standard_charge)){
            $charge = $charges_array->standard_charge + ($charges_array->standard_charge*$charges_array->percentage/100);
        }else{
            $charge=0;
        }
        $this->session->set_userdata('payment_amount',$charge);
        $this->session->set_userdata('charge_id',$appointment_data->charge_id);
        $total = $charge;
        $data['amount'] = $total;
        $data['name'] = $appointment_data->name;
        $data['currency_name'] = $this->setting['currency'];
        $data['api_publishable_key'] = $this->pay_method->api_publishable_key;
        $this->load->view('patient/onlineappointment/stripe/index', $data);
    }

    public function complete() {
        $amount = $this->session->userdata('payment_amount');
        $stripeToken         = $this->input->post('stripeToken');
        $stripeTokenType     = $this->input->post('stripeTokenType');
        $stripeEmail         = $this->input->post('stripeEmail');
        $data                = $this->input->post();
        $data['stripeToken'] = $stripeToken;
        $data['total']  = $amount;
        $data['description'] = 'test product';
        $data['currency']    = 'USD'; 
        $response            = $this->stripe_payment->payment($data);
        if ($response->isSuccessful()) {
            $transactionid = $response->getTransactionReference();
            $response      = $response->getData();
            if ($response['status'] == 'succeeded') {
                $payment_section = $this->config->item('payment_section');
                $appointment_id = $this->session->userdata('appointment_id');
                $charge_id = $this->session->userdata('charge_id');
                $appointment_data = $this->onlineappointment_model->getAppointmentDetails($appointment_id);
                $gateway_response['appointment_id'] = $appointment_id; 
                $gateway_response['paid_amount']    = $amount;
                $gateway_response['transaction_id'] = $transactionid;
                $gateway_response['charge_id']      = $charge_id;
                $gateway_response['payment_mode']   = 'Stripe';
                $gateway_response['payment_type']   = 'Online';
                $gateway_response['note']           = "Payment deposit through Stripe TXN ID: " . $transactionid;
                $gateway_response['date']           = date("Y-m-d H:i:s");
                $transaction_array = array(
                    'amount'                 => $amount,
                    'patient_id'             => $this->customlib->getPatientSessionUserID(),
                    'section'                => $payment_section['appointment'],
                    'type'                   => 'payment',
                    'appointment_id'         => $appointment_id,
                    'payment_mode'           => "Online",
                    'note'                   => "Online fees deposit through Billplz TXN ID: " . $transactionid ,
                    'payment_date'           => date('Y-m-d H:i:s'),
                    'received_by'            => 1,
                );
                $return_detail = $this->onlineappointment_model->paymentSuccess($gateway_response, $transaction_array);
                redirect(base_url("patient/onlineappointment/checkout/successinvoice/" . $appointment_id));
            }
        } elseif ($response->isRedirect()) {
            $response->redirect();
        } else {
            redirect(site_url('patient/onlineappointment/checkout/paymentfailed'));
        }
    }

}

?>