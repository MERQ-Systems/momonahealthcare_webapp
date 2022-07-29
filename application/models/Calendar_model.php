<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Calendar_model extends MY_Model
{

    public function saveEvent($data)
    {
        $this->db->trans_start(); # Starting Transaction
        $this->db->trans_strict(false); # See Note 01. If you wish can remove as well
        //=======================Code Start===========================
        if (isset($data["id"])) {
            
            $this->db->where("id", $data["id"])->update("events", $data);
            $insert_id = $this->db->insert_id();
        } else {
            
            $this->db->insert("events", $data);
            $insert_id = $this->db->insert_id();
            
        }
        //======================Code End==============================

        $this->db->trans_complete(); # Completing transaction
        /* Optional */

        if ($this->db->trans_status() === false) {
        # Something went wrong.
            $this->db->trans_rollback();
            return false;
        } else {
            return $insert_id;
        }
    }

    public function getEvents($id = null)
    {
        if (!empty($id)) {
            $query = $this->db->where("id", $id)->get("events");
            return $query->row_array();
        } else {
            $query = $this->db->get("events");
            return $query->result_array();
        }
    }

    public function getPatientEvents($id = null)
    {
        $cond  = "event_type = 'public' or event_type = 'task' ";
        $query = $this->db->where($cond)->get("events");
        return $query->result_array();
    }

    public function deleteEvent($id)
    {
        $this->db->trans_start(); # Starting Transaction
        $this->db->trans_strict(false); # See Note 01. If you wish can remove as well
        //=======================Code Start===========================
        $this->db->where("id", $id)->delete("events");        
        $record_id = $id;
        //======================Code End==============================

        $this->db->trans_complete(); # Completing transaction
        /* Optional */

        if ($this->db->trans_status() === false) {
            # Something went wrong.
            $this->db->trans_rollback();
            return false;
        } else {
            return $record_id;
        }
    }

    public function getTask($id, $role_id,$limit = null, $offset = null)
    {
        $query = $this->db->where(array('event_type' => 'task', 'event_for' => $id, 'role_id' => $role_id))->order_by("is_active,start_date", "asc")->limit($limit, $offset)->get("events");
        return $query->result_array();
    }

    public function countrows($id, $role_id)
    {
        $query = $this->db->where(array("event_type" => "task", 'event_for' => $id, 'role_id' => $role_id))->get("events");
        return $query->num_rows();
    }

    public function countincompleteTask($id)
    {
        $query = $this->db->where("event_type", "task")->where("is_active", "no")->where("event_for", $id)->where("start_date", date("Y-m-d"))->get("events");
        return $query->num_rows();
    }

    public function getincompleteTask($id)
    {
        $query = $this->db->where("event_type", "task")->where("is_active", "no")->where("event_for", $id)->where("start_date", date("Y-m-d"))->order_by("start_date", "asc")->get("events");
        return $query->result_array();
    }
}
