<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Pushnotification
{

    public $CI;

    //package name: com.merqconsultancy.momona
    public $API_ACCESS_KEY = "AAAAnTtG9l4:APA91bHPCWuWl_BKZunoJbnuVbdC-OsqQqsTbrv8Fekb3y0RIB4eBf_VrffPm3SFTL9BJr7wuGwbJ_unBZTE2L9UU3DTMudtMBNxG4o1Rc4Isd1K83-v2Aat9xixn_fF0N92cWf3EjKr";
     
    public $fcmUrl  = "https://fcm.googleapis.com/fcm/send";

    public function __construct()
    {
        $this->CI = &get_instance();
    }

    public function send($tokens, $msg, $action = "")
    {       
        $notificationData = [
            'title'  => $msg['title'],
            'body'   => $msg['body'],
            'action' => $action,
            'sound'  => 'mySound',
        ];
        
        $fcmNotification = [

            'to'          => $tokens, //single token
            'collapseKey' => "{$tokens}",
            'data'        => $notificationData,

        ];

        $headers = [
            'Authorization: key=' . $this->API_ACCESS_KEY,
            'Content-Type: application/json',
        ];
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->fcmUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
        $result = curl_exec($ch);
        curl_close($ch);

        return true;

    }

}
