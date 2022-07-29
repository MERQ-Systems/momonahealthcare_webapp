<?php


namespace FormTools\Modules\SystemCheck;

use PDO;
use FormTools\Core;
use FormTools\FieldTypes;
use FormTools\Themes;


/**
 * Contains all functions relating to the Orphan Record Check page. This test has specific,
 * hardcoded tests to run on each table. The tests may vary depending on the current Core version.
 */


class Orphans
{

    /**
     * Called for each of the Core tables. The table structure changes over time, and each table
     * needs to have different tests performed on it.
     *
     * @param string $table_name
     */
    public static function findTableOrphans($table_name, $remove_orphans)
    {
        $table_prefix = Core::getDbTablePrefix();

        $results = array(
            "table_name" => $table_name,
            "num_tests" => 0,
            "num_orphans" => 0,
            "test_descriptions" => "",
            "problems" => ""
        );

        $table_name_without_prefix = preg_replace("/^{$table_prefix}/", "", $table_name);

        $has_test = true;
        switch ($table_name_without_prefix) {
            case "accounts":
                $response = Orphans::testAccounts($remove_orphans);
                break;
            case "account_settings":
                $response = Orphans::testAccountSettings($remove_orphans);
                break;
            case "client_forms":
                $response = Orphans::testClientForms($remove_orphans);
                break;
            case "client_views":
                $response = Orphans::testClientViews($remove_orphans);
                break;
            case "email_templates":
                $response = Orphans::testEmailTemplates($remove_orphans);
                break;
            case "email_template_edit_submission_views":
                $response = Orphans::testEmailTemplateEditSubmissionViews($remove_orphans);
                break;
            case "email_template_recipients":
                $response = Orphans::testEmailTemplateRecipients($remove_orphans);
                break;
            case "email_template_when_sent_views":
                $response = Orphans::testEmailTemplateWhenSentViews($remove_orphans);
                break;
            case "field_options":
                $response = Orphans::testFieldOptions($remove_orphans);
                break;
            case "field_settings":
                $response = Orphans::testFieldSettings($remove_orphans);
                break;
            case "field_type_settings":
                $response = Orphans::testFieldTypeSettings($remove_orphans);
                break;
            case "field_type_setting_options":
                $response = Orphans::testFieldTypeSettingOptions($remove_orphans);
                break;
            case "field_type_validation_rules":
                $response = Orphans::testFieldTypeValidationRules($remove_orphans);
                break;
            case "field_validation":
                $response = Orphans::testFieldValidation($remove_orphans);
                break;
            case "form_email_fields":
                $response = Orphans::testFormEmailFields($remove_orphans);
                break;
            case "form_fields":
                $response = Orphans::testFormFields($remove_orphans);
                break;
            case "menu_items":
                $response = Orphans::testMenuItems($remove_orphans);
                break;
            case "multi_page_form_urls":
                $response = Orphans::testMultiPageFormUrls($remove_orphans);
                break;
            case "new_view_submission_defaults":
                $response = Orphans::testNewViewSubmissionDefaults($remove_orphans);
                break;
            case "public_form_omit_list":
                $response = Orphans::testPublicFormOmitList($remove_orphans);
                break;
            case "public_view_omit_list":
                $response = Orphans::testPublicViewOmitList($remove_orphans);
                break;
            case "views":
                $response = Orphans::testViews($remove_orphans);
                break;
            case "view_columns":
                $response = Orphans::testViewColumns($remove_orphans);
                break;
            case "view_fields":
                $response = Orphans::testViewFields($remove_orphans);
                break;
            case "view_filters":
                $response = Orphans::testViewFilters($remove_orphans);
                break;
            case "view_tabs":
                $response = Orphans::testViewTabs($remove_orphans);
                break;

            default:
                // no test: field_types, forms, hooks, hook_calls, list_groups, menus, modules, sessions, settings, themes

                $has_test = false;
                break;
        }

        $results["has_test"] = $has_test;
        if ($has_test) {
            $results["num_tests"] = $response["num_tests"];
            $results["num_orphans"] = $response["num_orphans"];
            $results["test_descriptions"] = $response["test_descriptions"];
            $results["problems"] = $response["problems"];
            $results["clean_up_problems"] = isset($response["clean_up_problems"]) ? $response["clean_up_problems"] : "";
        }

        return $results;
    }


    public static function cleanOrphans()
    {
        $root_dir = Core::getRootDir();

        require_once("$root_dir/global/misc/config_core.php");
        $tables = Tables::getComponentTables($STRUCTURE);

        $problems = array();
        foreach ($tables as $table_name) {
            $response = Orphans::findTableOrphans($table_name, true);
            if (!empty($response["clean_up_problems"])) {
                $problems[] = $response["clean_up_problems"];
            }
        }

        $message = "The orphaned records / references have been cleaned up.";
        if (!empty($problems)) {
            $problem_list = array();
            foreach ($problems as $p) {
                foreach ($p as $p2) {
                    $problem_list[] = "&bull; " . $p2;
                }
            }

            $message = "The orphaned results were cleaned up, however the following problems were encountered:<br />" . implode("<br />",
            $problem_list);
        }

        return array(true, $message);
    }


    // ----------------------------------------------------------------------------------------------
    // INDIVIDUAL TABLE TESTS


    /**
     * Tests: account_id
     */
    private static function testAccountSettings($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Looks for settings associated with non-existent user accounts.",
            "problems" => array()
        );

        $valid_account_ids = General::getAccountIds();

        $db->query("SELECT * FROM {PREFIX}account_settings");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        $num_orphans = 0;
        foreach ($rows as $row) {
            $curr_account_id = $row["account_id"];

            if (!in_array($curr_account_id, $valid_account_ids)) {
                $response["problems"][] = "Invalid account ID: $curr_account_id";
                $num_orphans++;

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}account_settings
                        WHERE  account_id = :account_id AND
                               setting_name = :setting_name
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "account_id" => $curr_account_id,
                        "setting_name" => $row["setting_name"]
                    ));
                    $db->execute();
                }
            }

            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = $num_orphans;

        return $response;
    }


    /**
     * Tests: theme, menu_id.
     */
    private static function testAccounts($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks theme associated with accounts is a valid, enabled theme, and checks the menu ID of accounts exists.",
            "problems" => array(),
            "clean_up_problems" => array()
        );

        $db->query("SELECT account_id, account_type, theme, menu_id FROM {PREFIX}accounts");
        $db->execute();
        $account_rows = $db->fetchAll();

        $valid_menu_ids = General::getMenuIds();

        $first_client_menu_id = "";
        if ($remove_orphans) {
            $db->query("SELECT menu_id FROM {PREFIX}menus WHERE menu_type = 'client' LIMIT 1");
            $db->execute();
            $menu_id = $db->fetch(PDO::FETCH_COLUMN);
            if (!empty($menu_id)) {
                $first_client_menu_id = $menu_id;
            }
        }

        // get a list of valid theme folders
        $themes = Themes::getList(true);
        $valid_theme_folders = array();
        foreach ($themes as $theme_info) {
            $valid_theme_folders[] = $theme_info["theme_folder"];
        }

        $num_tests = 0;
        foreach ($account_rows as $row) {
            if (!in_array($row["menu_id"], $valid_menu_ids)) {
                $response["problems"][] = "Invalid menu ID: {$row["menu_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $new_menu_id = 1;
                    if ($row["account_type"] == "client") {
                        $new_menu_id = $first_client_menu_id;
                    }

                    if (empty($new_menu_id)) {
                        $response["clean_up_problems"][] = "There's no client menu. Please create one, then re-run the test to fix all dud references.";
                    } else {
                        $db->query("
                            UPDATE {PREFIX}accounts
                            SET    menu_id = :menu_id,
                            WHERE  account_id = :account_id
                        ");
                        $db->bindAll(array(
                            "menu_id" => $new_menu_id,
                            "account_id" => $row["account_id"]
                        ));
                        $db->execute();
                    }
                }
            }
            $num_tests++;

            if (!in_array($row["theme"], $valid_theme_folders)) {
                $response["problems"][] = "Invalid theme: {$row["theme"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        UPDATE {PREFIX}accounts
                        SET    theme = 'default',
                               swatch = 'green'
                        WHERE  account_id = :account_id
                    ");
                    $db->bind("account_id", $row["account_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testClientForms($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid account IDs and invalid form IDs.",
            "problems" => array()
        );

        $db->query("SELECT * FROM {PREFIX}client_forms");
        $db->execute();
        $client_forms = $db->fetchAll();

        $valid_account_ids = General::getAccountIds();
        $valid_form_ids = General::getFormIds();

        $num_tests = 0;
        foreach ($client_forms as $row) {
            if (!in_array($row["account_id"], $valid_account_ids)) {
                $response["problems"][] = "Invalid account ID: {$row["account_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}client_forms
                        WHERE  account_id = :account_id AND
                               form_id = :form_id
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "account_id" => $row["account_id"],
                        "form_id" => $row["form_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid form ID: {$row["form_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}client_forms
                        WHERE  account_id = :account_id AND
                               form_id = :form_id
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "account_id" => $row["account_id"],
                        "form_id" => $row["form_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testClientViews($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid account IDs and invalid View IDs.",
            "problems" => array()
        );

        $db->query("SELECT * FROM {PREFIX}client_views");
        $db->execute();
        $client_views = $db->fetchAll();

        $valid_account_ids = General::getAccountIds();
        $valid_view_ids = General::getViewIds();

        $num_tests = 0;
        foreach ($client_views as $row) {
            if (!in_array($row["account_id"], $valid_account_ids)) {
                $response["problems"][] = "Invalid account ID: {$row["account_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}client_views
                        WHERE  account_id = :account_id AND
                               view_id = :view_id
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "account_id" => $row["account_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid View ID: {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                          DELETE FROM {PREFIX}client_views
                          WHERE  account_id = :account_id AND
                                 view_id = :view_id
                          LIMIT 1
                    ");
                    $db->bindAll(array(
                        "account_id" => $row["account_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    /**
     * Tests: form_id, view_mapping_view_id, limit_email_content_to_fields_in_view, email_from_account_id,
     *        email_from_form_email_id, email_reply_to_account_id, email_reply_to_form_email_id,
     */
    private static function testEmailTemplates($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Assorted tests for invalid form IDs, email configuration IDs, View IDs, Account IDs.",
            "problems" => array()
        );

        $valid_account_ids = General::getAccountIds();
        $valid_view_ids = General::getViewIds();
        $valid_form_email_config_ids = General::getFormEmailConfigIds();

        $db->query("SELECT * FROM {PREFIX}email_templates");
        $db->execute();
        $email_templates = $db->fetchAll();

        $num_tests = 0;
        $num_orphans = 0;
        foreach ($email_templates as $row) {
            if (isset($row["view_mapping_view_id"])) {
                if (!in_array($row["view_mapping_view_id"], $valid_view_ids)) {
                    $response["problems"][] = "Invalid view_mapping_view_id: {$row["view_mapping_view_id"]} for email_id = {$row["email_id"]}";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    view_mapping_view_id = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }

            if (isset($row["limit_email_content_to_fields_in_view"])) {
                if (!in_array($row["limit_email_content_to_fields_in_view"], $valid_view_ids)) {
                    $response["problems"][] = "Invalid limit_email_content_to_fields_in_view: {$row["limit_email_content_to_fields_in_view"]} for email_id = {$row["email_id"]}";
                    $num_orphans++;

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    limit_email_content_to_fields_in_view = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }

            if (isset($row["email_from_account_id"])) {
                if (!in_array($row["email_from_account_id"], $valid_account_ids)) {
                    $response["problems"][] = "Invalid email_from_account_id: {$row["email_from_account_id"]} for email_id = {$row["email_id"]}";
                    $num_orphans++;

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    email_from_account_id = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }

            if (isset($row["email_from_form_email_id"])) {
                if (!in_array($row["email_from_form_email_id"], $valid_form_email_config_ids)) {
                    $response["problems"][] = "Invalid email_from_form_email_id: {$row["email_from_form_email_id"]} for email_id = {$row["email_id"]}";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    email_from_form_email_id = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }

            if (isset($row["email_reply_to_account_id"])) {
                if (!in_array($row["email_reply_to_account_id"], $valid_account_ids)) {
                    $response["problems"][] = "Invalid email_reply_to_account_id: {$row["email_reply_to_account_id"]} for email_id = {$row["email_id"]}";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    email_reply_to_account_id = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }

            if (isset($row["email_reply_to_form_email_id"])) {
                if (!in_array($row["email_reply_to_form_email_id"], $valid_form_email_config_ids)) {
                    $response["problems"][] = "Invalid email_reply_to_form_email_id: {$row["email_reply_to_form_email_id"]} for email_id = {$row["email_id"]}";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}email_templates
                            SET    email_reply_to_form_email_id = NULL
                            WHERE  email_id = :email_id
                        ");
                        $db->bind("email_id", $row["email_id"]);
                        $db->execute();
                    }
                }
                $num_tests++;
            }
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = $num_orphans;

        return $response;
    }


    /**
     * This table is a pretty recent addition. If the current Core version doesn't have the table,
     * this test simply won't be called.
     */
    private static function testEmailTemplateEditSubmissionViews($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid email template IDs and invalid View IDs.",
            "problems" => array()
        );

        $valid_email_ids = General::getEmailIds();
        $valid_view_ids = General::getViewIds();

        $db->query("SELECT * FROM {PREFIX}email_template_edit_submission_views");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["email_id"], $valid_email_ids)) {
                $response["problems"][] = "Invalid email template ID: {$row["email_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}email_template_edit_submission_views
                        WHERE  email_id = :email_id AND
                               view_id = :view_id
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "email_id" => $row["email_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid View ID: {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}email_template_edit_submission_views
                        WHERE  email_id = :email_id AND
                               view_id = :view_id
                        LIMIT 1
                    ");
                    $db->bindAll(array(
                        "email_id" => $row["email_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    /**
     * This table is a pretty recent addition. If the current Core version doesn't have the table,
     * this test simply won't be called.
     */
    private static function testEmailTemplateRecipients($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records mapped to now-deleted email template IDs, deleted Account ID and email configuration ID references.",
            "problems" => array()
        );

        $valid_email_ids = General::getEmailIds();
        $valid_account_ids = General::getAccountIds();
        $valid_email_config_ids = General::getFormEmailConfigIds();

        $db->query("SELECT * FROM {PREFIX}email_template_recipients");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["email_template_id"], $valid_email_ids)) {
                $response["problems"][] = "invalid template ID {$row["email_template_id"]} being referenced by the table's Primary Key ID {$row["recipient_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}email_template_recipients
                        WHERE  recipient_id = :recipient_id
                        LIMIT 1
                    ");
                    $db->bind("recipient_id", $row["recipient_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!empty($row["account_id"]) && !in_array($row["account_id"], $valid_account_ids)) {
                $response["problems"][] = "invalid account ID {$row["account_id"]} being referenced by the table's Primary Key ID {$row["recipient_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        UPDATE {PREFIX}email_template_recipients
                        SET    account_id = NULL
                        WHERE  recipient_id = :recipient_id
                        LIMIT 1
                    ");
                    $db->bind("recipient_id", $row["recipient_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!empty($row["form_email_id"]) && !in_array($row["form_email_id"], $valid_email_config_ids)) {
                $response["problems"][] = "invalid form email field configuration {$row["form_email_id"]} being referenced by the table's Primary Key ID {$row["recipient_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        UPDATE {PREFIX}email_template_recipients
                        SET    form_email_id = NULL
                        WHERE  recipient_id = :recipient_id
                        LIMIT 1
                    ");
                    $db->bind("recipient_id", $row["recipient_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testEmailTemplateWhenSentViews($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records mapped to now-deleted email templates and Views.",
            "problems" => array()
        );

        $valid_email_ids = General::getEmailIds();
        $valid_view_ids = General::getViewIds();

        $db->query("SELECT * FROM {PREFIX}email_template_when_sent_views");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["email_id"], $valid_email_ids)) {
                $response["problems"][] = "invalid email template ID {$row["email_template_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}email_template_when_sent_views
                        WHERE  email_id = :email_id AND
                               view_id = {$row["view_id"]}
                    ");
                    $db->bindAll(array(
                        "email_id" => $row["email_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "invalid View ID {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}email_template_when_sent_views
                        WHERE  email_id = :email_id AND
                               view_id = :view_id
                    ");
                    $db->bindAll(array(
                        "email_id" => $row["email_id"],
                        "view_id" => $row["view_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFieldOptions($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks each field option is attached to a valid list_group_id.",
            "problems" => array()
        );

        $valid_list_group_ids = General::getListGroupIds();

        $db->query("SELECT * FROM {PREFIX}field_options");
        $db->execute();
        $field_options = $db->fetchAll();

        $num_tests = 0;
        foreach ($field_options as $row) {
            if (!in_array($row["list_group_id"], $valid_list_group_ids)) {
                $response["problems"][] = "invalid list_group_id {$row["list_group_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_options
                        WHERE  list_id = :list_id
                    ");
                    $db->bind("list_id", $row["list_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFieldSettings($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid references to deleted field IDs and settings IDs.",
            "problems" => array()
        );

        $valid_field_ids = General::getFieldIds();
        $valid_field_type_setting_ids = General::getFieldTypeSettingIds();

        $db->query("SELECT * FROM {PREFIX}field_settings");
        $db->execute();
        $field_settings = $db->fetchAll();

        $num_tests = 0;
        foreach ($field_settings as $row) {
            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "invalid field_id: {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_settings
                        WHERE  field_id = :field_id
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            if (!in_array($row["setting_id"], $valid_field_type_setting_ids)) {
                $response["problems"][] = "invalid setting_id: {$row["setting_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_settings
                        WHERE  setting_id = :setting_id
                    ");
                    $db->bind("setting_id", $row["setting_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFieldTypeSettings($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid references to deleted field types.",
            "problems" => array()
        );

        $valid_field_type_ids = General::getFieldTypeIds();

        $db->query("SELECT setting_id, field_type_id FROM {PREFIX}field_type_settings");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["field_type_id"], $valid_field_type_ids)) {
                $response["problems"][] = "setting_id: {$row["setting_id"]} references invalid field_type_id: {$row["field_type_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_type_settings
                        WHERE  field_type_id = :field_type_id
                    ");
                    $db->bind("field_type_id", $row["field_type_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFieldTypeSettingOptions($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for invalid references to deleted field type settings.",
            "problems" => array()
        );

        $valid_field_type_setting_ids = General::getFieldTypeSettingIds();

        $db->query("SELECT setting_id, option_order FROM {PREFIX}field_type_setting_options");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["setting_id"], $valid_field_type_setting_ids)) {
                $response["problems"][] = "Invalid reference to setting_id: {$row["setting_id"]} for option_order: {$row["option_order"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_type_setting_options
                        WHERE setting_id = :setting_id AND
                              option_order = :option_order
                    ");
                    $db->bindAll(array(
                        "setting_id"   => $row["setting_id"],
                        "option_order" => $row["option_order"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFieldTypeValidationRules($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent field types.",
            "problems" => array()
        );

        $valid_field_type_ids = General::getFieldTypeIds();

        $db->query("SELECT rule_id, field_type_id FROM {PREFIX}field_type_validation_rules");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["field_type_id"], $valid_field_type_ids)) {
                $response["problems"][] = "Invalid reference to field_type_id: {$row["field_type_id"]} for rule_id: {$row["rule_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_type_validation_rules
                        WHERE  rule_id = :rule_id
                    ");
                    $db->bind("rule_id", $row["rule_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    /**
     * N.B. The field_validation table has a composite primary key of rule_id and field_id. rule_id is just an integer
     * from 1-N, where N is the number of validation rules for the field type. So this test just looks for and clears out
     * invalid field IDs - rule IDs are neither here nor there.
     * @param $remove_orphans
     * @return array
     */
    private static function testFieldValidation($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for validation rules that are no longer mapped to valid fields or validation rules.",
            "problems" => array()
        );

        $valid_field_ids = General::getFieldIds();

        $db->query("SELECT rule_id, field_id FROM {PREFIX}field_validation");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "Invalid reference to field_id: {$row["field_id"]} for rule_id: {$row["rule_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}field_validation
                        WHERE  field_id = :field_id
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFormEmailFields($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records that map to invalid form_id and corresponding form fields",
            "problems" => array()
        );

        $valid_form_ids = General::getFormIds();
        $db->query("SELECT * FROM {PREFIX}form_email_fields");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid reference to form_id {$row["form_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}form_email_fields
                        WHERE  form_email_id = :form_email_id
                    ");
                    $db->bind("form_email_id", $row["form_email_id"]);
                    $db->execute();
                }
            } else {
                $form_field_ids = General::getFormFieldIds($row["form_id"]);
                if (!in_array($row["email_field_id"], $form_field_ids)) {
                    $response["problems"][] = "form_email_id: {$row["form_email_id"]} contains invalid reference to field_id {$row["email_field_id"]} for the email_field_id field";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            DELETE FROM {PREFIX}form_email_fields
                            WHERE  form_email_id = :form_email_id
                        ");
                        $db->bind("form_email_id", $row["form_email_id"]);
                        $db->execute();
                    }
                }
                if (!empty($row["first_name_field_id"]) && !in_array($row["first_name_field_id"], $form_field_ids)) {
                    $response["problems"][] = "form_email_id: {$row["form_email_id"]} contains invalid reference to field_id {$row["first_name_field_id"]} for the first_name_field_id field";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}form_email_fields
                            SET    first_name_field_id = NULL
                            WHERE  form_email_id = :form_email_id
                        ");
                        $db->bind("form_email_id", $row["form_email_id"]);
                        $db->execute();
                    }
                }
                if (!empty($row["last_name_field_id"]) && !in_array($row["last_name_field_id"], $form_field_ids)) {
                    $response["problems"][] = "form_email_id: {$row["form_email_id"]} contains invalid reference to field_id {$row["last_name_field_id"]} for the last_name_field_id field";

                    // clean-up code
                    if ($remove_orphans) {
                        $db->query("
                            UPDATE {PREFIX}form_email_fields
                            SET    last_name_field_id = NULL
                            WHERE  form_email_id = :form_email_id
                        ");
                        $db->bind("form_email_id", $row["form_email_id"]);
                        $db->execute();
                    }
                }
                $num_tests += 3;
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testFormFields($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records that map to invalid form_id and field_type_id records.",
            "problems" => array()
        );

        $valid_form_ids = General::getFormIds();
        $valid_field_type_ids = General::getFieldTypeIds();

        $db->query("SELECT field_id, form_id, field_type_id FROM {PREFIX}form_fields");
        $db->execute();
        $form_fields = $db->fetchAll();

        $num_tests = 0;
        foreach ($form_fields as $row) {
            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid reference to form_id {$row["form_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}form_fields
                        WHERE field_id = :field_id
                        LIMIT 1
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["field_type_id"], $valid_field_type_ids)) {
                $response["problems"][] = "Invalid reference to field_type_id {$row["field_type_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $textbox_field_type_id = FieldTypes::getFieldTypeIdByIdentifier("textbox");
                    $db->query("
                        UPDATE {PREFIX}form_fields
                        SET    field_type_id = :field_type_id
                        WHERE  field_id = :field_id
                    ");
                    $db->bindAll(array(
                        "field_type_id" => $textbox_field_type_id,
                        "field_id" => $row["field_id"]
                    ));
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testMenuItems($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for menu item records that are mapped to invalid menus",
            "problems" => array()
        );

        $valid_menu_ids = General::getMenuIds();

        $db->query("SELECT menu_id, menu_item_id FROM {PREFIX}menu_items");
        $db->execute();
        $menu_items = $db->fetchAll();

        $num_tests = 0;
        foreach ($menu_items as $row) {
            if (!in_array($row["menu_id"], $valid_menu_ids)) {
                $response["problems"][] = "Invalid reference to menu_id {$row["menu_id"]} for menu_item_id {$row["menu_item_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}menu_items
                        WHERE  menu_item_id = :menu_item_id
                    ");
                    $db->bind("menu_item_id", $row["menu_item_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testMultiPageFormUrls($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records that are mapped to invalid form_ids",
            "problems" => array()
        );

        $valid_form_ids = General::getFormIds();

        $db->query("SELECT form_id, page_num FROM {PREFIX}multi_page_form_urls");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid reference to form_id {$row["form_id"]} for page_num {$row["page_num"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}multi_page_form_urls
                        WHERE  form_id = :form_id
                    ");
                    $db->bind("form_id", $row["form_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testNewViewSubmissionDefaults($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for records that are mapped to invalid view_ids and field_ids",
            "problems" => array()
        );

        $valid_view_ids = General::getViewIds();
        $valid_field_ids = General::getFieldIds();

        $db->query("SELECT view_id, field_id FROM {PREFIX}new_view_submission_defaults");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}new_view_submission_defaults
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "Invalid reference to field_id {$row["field_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}new_view_submission_defaults
                        WHERE  field_id = {$row["field_id"]}
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testPublicFormOmitList($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent form IDs or account IDs",
            "problems" => array()
        );

        $valid_form_ids = General::getFormIds();
        $valid_account_ids = General::getAccountIds();

        $db->query("SELECT * FROM {PREFIX}public_form_omit_list");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid reference to form_id {$row["form_id"]} for account_id {$row["account_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}public_form_omit_list
                        WHERE  form_id = :form_id
                    ");
                    $db->bind("form_id", $row["form_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["account_id"], $valid_account_ids)) {
                $response["problems"][] = "Invalid reference to account_id {$row["account_id"]} for form_id {$row["form_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}public_form_omit_list
                        WHERE  account_id = :account_id
                    ");
                    $db->bind("account_id", $row["account_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testPublicViewOmitList($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent view IDs or account IDs",
            "problems" => array()
        );

        $valid_view_ids = General::getViewIds();
        $valid_account_ids = General::getAccountIds();

        $db->query("SELECT * FROM {PREFIX}public_view_omit_list");
        $db->execute();
        $rows = $db->fetchAll();

        $num_tests = 0;
        foreach ($rows as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for account_id {$row["account_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}public_view_omit_list
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["account_id"], $valid_account_ids)) {
                $response["problems"][] = "Invalid reference to account_id {$row["account_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}public_view_omit_list
                        WHERE  account_id = :account_id
                    ");
                    $db->bind("account_id", $row["account_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testViews($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent form IDs",
            "problems" => array()
        );

        $valid_form_ids = General::getFormIds();

        $db->query("SELECT * FROM {PREFIX}views");
        $db->execute();
        $views = $db->fetchAll();
        $num_tests = 0;

        foreach ($views as $row) {
            if (!in_array($row["form_id"], $valid_form_ids)) {
                $response["problems"][] = "Invalid reference to form_id {$row["form_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}views
                        WHERE  form_id = :form_id
                    ");
                    $db->bind("form_id", $row["form_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testViewColumns($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
        "test_descriptions" => "Checks for references to non-existent View IDs and field IDs",
        "problems" => array()
        );

        $valid_view_ids = General::getViewIds();
        $valid_field_ids = General::getFieldIds();

        $db->query("SELECT * FROM {PREFIX}view_columns");
        $db->execute();
        $view_columns = $db->fetchAll();

        $num_tests = 0;
        foreach ($view_columns as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_columns
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "Invalid reference to field_id {$row["field_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_columns
                        WHERE  field_id = :field_id
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testViewFields($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent View IDs and field IDs",
            "problems" => array()
        );

        $valid_view_ids = General::getViewIds();
        $valid_field_ids = General::getFieldIds();

        $db->query("SELECT * FROM {PREFIX}view_fields");
        $db->execute();
        $view_fields = $db->fetchAll();

        $num_tests = 0;
        foreach ($view_fields as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_fields
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "Invalid reference to field_id {$row["field_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_fields
                        WHERE  field_id = :field_id
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testViewFilters($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent View IDs and field IDs",
            "problems" => array()
        );

        $valid_view_ids = General::getViewIds();
        $valid_field_ids = General::getFieldIds();

        $db->query("SELECT * FROM {PREFIX}view_filters");
        $db->execute();
        $view_filters = $db->fetchAll();

        $num_tests = 0;
        foreach ($view_filters as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for field_id {$row["field_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_filters
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;

            if (!in_array($row["field_id"], $valid_field_ids)) {
                $response["problems"][] = "Invalid reference to field_id {$row["field_id"]} for view_id {$row["view_id"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_filters
                        WHERE  field_id = :field_id
                    ");
                    $db->bind("field_id", $row["field_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }


    private static function testViewTabs($remove_orphans)
    {
        $db = Core::$db;

        $response = array(
            "test_descriptions" => "Checks for references to non-existent View IDs",
            "problems" => array()
        );

        $valid_view_ids = General::getViewIds();

        $db->query("SELECT * FROM {PREFIX}view_tabs");
        $db->execute();
        $view_tabs = $db->fetchAll();

        $num_tests = 0;
        foreach ($view_tabs as $row) {
            if (!in_array($row["view_id"], $valid_view_ids)) {
                $response["problems"][] = "Invalid reference to view_id {$row["view_id"]} for tab_number {$row["tab_number"]}";

                // clean-up code
                if ($remove_orphans) {
                    $db->query("
                        DELETE FROM {PREFIX}view_tabs
                        WHERE  view_id = :view_id
                    ");
                    $db->bind("view_id", $row["view_id"]);
                    $db->execute();
                }
            }
            $num_tests++;
        }

        $response["num_tests"] = $num_tests;
        $response["num_orphans"] = count($response["problems"]);

        return $response;
    }
}
