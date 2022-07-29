<?php

defined('BASEPATH') OR exit('No direct script access allowed');

/*
  | -------------------------------------------------------------------
  | AUTO-LOADER
  | -------------------------------------------------------------------
  | This file specifies which systems should be loaded by default.
  |
  | In order to keep the framework as light-weight as possible only the
  | absolute minimal resources are loaded by default. For example,
  | the database is not connected to automatically since no assumption
  | is made regarding whether you intend to use it.  This file lets
  | you globally define which systems you would like loaded with every
  | request.
  |
  | -------------------------------------------------------------------
  | Instructions
  | -------------------------------------------------------------------
  |
  | These are the things you can load automatically:
  |
  | 1. Packages
  | 2. Libraries
  | 3. Drivers
  | 4. Helper files
  | 5. Custom config files
  | 6. Language files
  | 7. Models
  |
 */

/*
  | -------------------------------------------------------------------
  |  Auto-load Packages
  | -------------------------------------------------------------------
  | Prototype:
  |
  |  $autoload['packages'] = array(APPPATH.'third_party', '/usr/local/shared');
  |
 */
$autoload['packages'] = array();

/*
  | -------------------------------------------------------------------
  |  Auto-load Libraries
  | -------------------------------------------------------------------
  | These are the classes located in system/libraries/ or your
  | application/libraries/ directory, with the addition of the
  | 'database' library, which is somewhat of a special case.
  |
  | Prototype:
  |
  |	$autoload['libraries'] = array('database', 'email', 'session');
  |
  | You can also supply an alternative library name to be assigned
  | in the controller:
  |
  |	$autoload['libraries'] = array('user_agent' => 'ua');
 */
$autoload['libraries'] = array('database', 'email', 'session', 'form_validation', 'upload', 'pagination', 'Customlib', 'Role', 'Smsgateway', 'QDMailer', 'Adler32', 'Aes');

/*
  | -------------------------------------------------------------------
  |  Auto-load Drivers
  | -------------------------------------------------------------------
  | These classes are located in system/libraries/ or in your
  | application/libraries/ directory, but are also placed inside their
  | own subdirectory and they extend the CI_Driver_Library class. They
  | offer multiple interchangeable driver options.
  |
  | Prototype:
  |
  |	$autoload['drivers'] = array('cache');
 */
$autoload['drivers'] = array();

/*
  | -------------------------------------------------------------------
  |  Auto-load Helper Files
  | -------------------------------------------------------------------
  | Prototype:
  |
  |	$autoload['helper'] = array('url', 'file');
 */
$autoload['helper'] = array('url', 'file', 'menu', 'security');

/*
  | -------------------------------------------------------------------
  |  Auto-load Config files
  | -------------------------------------------------------------------
  | Prototype:
  |
  |	$autoload['config'] = array('config1', 'config2');
  |
  | NOTE: This item is intended for use ONLY if you have created custom
  | config files.  Otherwise, leave it blank.
  |
 */
$autoload['config'] = array();

/*
  | -------------------------------------------------------------------
  |  Auto-load Language files
  | -------------------------------------------------------------------
  | Prototype:
  |
  |	$autoload['language'] = array('lang1', 'lang2');
  |
  | NOTE: Do not include the "_lang" part of your file.  For example
  | "codeigniter_lang.php" would be referenced as array('codeigniter');
  |
 */
$autoload['language'] = array();

/*
  | -------------------------------------------------------------------
  |  Auto-load Models
  | -------------------------------------------------------------------
  | Prototype:
  |
  |	$autoload['model'] = array('first_model', 'second_model');
  |
  | You can also supply an alternative model name to be assigned
  | in the controller:
  |
  |	$autoload['model'] = array('first_model' => 'first');
 */
$autoload['model'] = array('admin_model','ambulance_model','appoint_priority_model','appointment_model','audit_model','bed_model','bedgroup_model','bedtype_model','birthordeath_model','blood_donorcycle_model','bloodbankstatus_model','blooddonor_model','bloodissue_model','calendar_model','captcha_model','casereference_model','certificate_model','charge_category_model','charge_model','chargetype_model','chatuser_model','cms_media_model','cms_menu_model','cms_menuitems_model','cms_page_content_model','cms_page_model','cms_program_model','complaint_model','complaintType_model','conference_model','conferencehistory_model','consultcharge_model','content_model','customfield_model','department_model','designation_model','dispatch_model','emailconfig_model','expense_model','expensehead_model','expmedicine_model','finding_model','floor_model','frontcms_setting_model','general_call_model','generatecertificate_model','generatepatientidcard_model','generatestaffidcard_model','income_model','incomehead_model','item_model','itemcategory_model','itemissue_model','itemstock_model','itemstore_model','itemsupplier_model','lab_model','language_model','leaverequest_model','leavetypes_model','medicine_category_model','medicine_dosage_model','messages_model','module_model','modulepermission_model','notification_model','notificationsetting_model','onlineappointment_model','operationtheatre_model','organisation_model','pathology_category_model','pathology_model','patient_id_card_model','patient_model','payment_model','paymentsetting_model','payroll_model','pharmacy_model','prefix_model','prescription_model','printing_model','radio_model','referral_category_model','referral_commission_model','referral_payment_model','referral_person_model','report_model','role_model','rolepermission_model','setting_model','smsconfig_model','source_model','specialist_model','staff_model','staffattendancemodel','staffidcard_model','staffroles_model','symptoms_model','systemnotification_model','taxcategory_model','timeline_model','tpa_model','transaction_model','unittype_model','user_model','userlog_model','userpermission_model','vehicle_model','visitors_model','visitors_purpose_model');