<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Ambulance_model extends MY_Model
{

    public function __construct()
    {
        parent::__construct();
    }

  

    public function totalPatientAmbulance($patient_id)
    {
        $query = $this->db->select('count(ambulance_call.patient_id) as total')
            ->where('patient_id', $patient_id)
            ->get('ambulance_call');
        return $query->row_array();
    }


    public function getpatientAmbulanceYearCounter($patient_id,$year)
    {
    $sql= "SELECT count(*) as `total_visits`,Year(date) as `year` FROM `ambulance_call` WHERE YEAR(date) >= ".$this->db->escape($year)." AND patient_id=".$this->db->escape($patient_id)." GROUP BY  YEAR(date)";

      $query = $this->db->query($sql);
        return $query->result_array();
    }





}
