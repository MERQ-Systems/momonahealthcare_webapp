<?php

namespace FormTools\Modules\SwiftMailer;

use FormTools\Core;
use FormTools\Hooks;
use FormTools\Module as FormToolsModule;
use FormTools\Modules;
use FormTools\Sessions;
use PDO, PDOException;
use Swift_Mailer, Swift_Message, Swift_SmtpTransport, Swift_TransportException, Swift_Attachment, Swift_Plugins_AntiFloodPlugin;


class Module extends FormToolsModule
{
    protected $moduleName = "Swift Mailer";
    protected $moduleDesc = "This module lets your configure your server's SMTP settings for Swift Mailer, letting you override the default mail() functionality used to sent emails.";
    protected $author = "Ben Keen";
    protected $authorEmail = "ben.keen@gmail.com";
    protected $authorLink = "https://formtools.org";
    protected $version = "2.0.7";
    protected $date = "2019-05-05";
    protected $originLanguage = "en_us";

    protected $nav = array(
        "module_name" => array("index.php", false),
        "word_help"   => array("help.php", true)
    );

    private static $ciphers = array(
        "AES-128-CBC",
        "AES-128-CBC-HMAC-SHA1",
        "AES-128-CBC-HMAC-SHA256",
        "AES-128-CFB",
        "AES-128-CFB1",
        "AES-128-CFB8",
        "AES-128-CTR",
        "AES-128-ECB",
        "AES-128-OFB",
        "AES-128-XTS",
        "AES-192-CBC",
        "AES-192-CFB",
        "AES-192-CFB1",
        "AES-192-CFB8",
        "AES-192-CTR",
        "AES-192-ECB",
        "AES-192-OFB",
        "AES-256-CBC",
        "AES-256-CBC-HMAC-SHA1",
        "AES-256-CBC-HMAC-SHA256",
        "AES-256-CFB",
        "AES-256-CFB1",
        "AES-256-CFB8"
    );

    public function install ($module_id)
    {
        $db = Core::$db;

        $settings = array(
            array('swiftmailer_enabled', 'no'),
            array('smtp_server', ''),
            array('port', ''),
            array('requires_authentication', 'no'),
            array('username', ''),
            array('password', ''),
            array('authentication_procedure', ''),
            array('use_encryption', ''),
            array('encryption_type', ''),
            array('charset', 'UTF-8'),
            array('server_connection_timeout', 15),
            array('use_anti_flooding', ''),
            array('anti_flooding_email_batch_size', ''),
            array('anti_flooding_email_batch_wait_time', '')
        );

        $settings_query = "
            INSERT INTO {PREFIX}settings (setting_name, setting_value, module)
            VALUES (:setting_name, :setting_value, 'swift_mailer')
        ";

        try {
            foreach ($settings as $row) {
                $db->query($settings_query);
                $db->bind("setting_name", $row[0]);
                $db->bind("setting_value", $row[1]);
                $db->execute();
            }

            $db->query("
                CREATE TABLE {PREFIX}module_swift_mailer_email_template_fields (
                    email_template_id MEDIUMINT NOT NULL,
                    return_path VARCHAR(255) NOT NULL,
                    PRIMARY KEY (email_template_id)
            )");
            $db->execute();

            $this->resetHooks();

            // now map all the email template IDs for the extra return path field
            $db->query("SELECT email_id FROM {PREFIX}email_templates");
            $db->execute();
            $email_template_ids = $db->fetchAll(PDO::FETCH_COLUMN);

            foreach ($email_template_ids as $email_template_id) {
                $db->query("
                    INSERT INTO {PREFIX}module_swift_mailer_email_template_fields (email_template_id, return_path)
                    VALUE (:email_template_id, '')
                ");
                $db->bind("email_template_id", $email_template_id);
                $db->execute();
            }
        } catch (PDOException $e) {
            return array(false, $e->getMessage());
        }

        return array(true, "");
    }


    /**
     * The Swift Mailer uninstall script. This is called by Form Tools when the user explicitly chooses to
     * uninstall the module. The hooks are automatically removed by the core script; settings needs to be explicitly
     * removed, since it's possible some modules would want to leave settings there in case they re-install it
     * later.
     */
    public function uninstall($module_id)
    {
        $db = Core::$db;

        $db->query("DROP TABLE {PREFIX}module_swift_mailer_email_template_fields");
        $db->execute();

        $db->query("DELETE FROM {PREFIX}settings WHERE module = 'swift_mailer'");
        $db->execute();

        return array(true, "");
    }


    public function upgrade($module_id, $old_module_version)
    {
        $this->resetHooks();
    }


    public function resetHooks()
    {
        $this->clearHooks();

        Hooks::registerHook("template", "swift_mailer", "edit_template_tab2", "", "swift_display_extra_fields_tab2");
        Hooks::registerHook("code", "swift_mailer", "end", "ft_create_blank_email_template", "swift_map_email_template_field");
        Hooks::registerHook("code", "swift_mailer", "end", "ft_delete_email_template", "swift_delete_email_template_field");
        Hooks::registerHook("code", "swift_mailer", "end", "ft_update_email_template", "swift_update_email_template_append_extra_fields");
        Hooks::registerHook("code", "swift_mailer", "end", "ft_get_email_template", "swift_get_email_template_append_extra_fields");
    }


    /**
     * Updates the Swift Mailer settings.
     *
     * @param array $info
     * @return array [0] T/F<br />
     *               [1] Success / error message
     */
    public function updateSettings($info)
    {
        $L = $this->getLangStrings();

        $settings = array(
            "swiftmailer_enabled"     => isset($info["swiftmailer_enabled"]) ? "yes" : "no",
            "requires_authentication" => isset($info["requires_authentication"]) ? "yes" : "no",
            "use_encryption"          => isset($info["use_encryption"]) ? "yes" : "no"
        );

        // Enable module
        if (isset($info["swiftmailer_enabled"])) {
            $settings["smtp_server"] = $info["smtp_server"];
            if (isset($info["port"])) {
                $settings["port"] = $info["port"];
            }
        }

        // Use authentication
        if (isset($info["requires_authentication"])) {
            if (isset($info["username"])) {
                $settings["username"] = $info["username"];
            }
            if (isset($info["password"])) {
                $settings["password"] = self::encode($info["password"]);
            }
            if (isset($info["authentication_procedure"])) {
                $settings["authentication_procedure"] = $info["authentication_procedure"];
            }
        }

        // Use encryption
        if (isset($info["use_encryption"])) {
            if (isset($info["encryption_type"])) {
                $settings["encryption_type"] = $info["encryption_type"];
            }
        }

        // Advanced
        $remember = Sessions::get("swift_mailer.remember_advanced_settings");
        if (Sessions::exists("swift_mailer.remember_advanced_settings") && !empty($remember)) {
            if (isset($info["server_connection_timeout"])) {
                $settings["server_connection_timeout"] = $info["server_connection_timeout"];
            }
            if (isset($info["charset"])) {
                $settings["charset"] = $info["charset"];
            }

            // Anti-flooding
            $settings["use_anti_flooding"] =  isset($info["use_anti_flooding"]) ? "yes" : "no";

            if (isset($info["anti_flooding_email_batch_size"])) {
                $settings["anti_flooding_email_batch_size"] = $info["anti_flooding_email_batch_size"];
            }
            if (isset($info["anti_flooding_email_batch_wait_time"])) {
                $settings["anti_flooding_email_batch_wait_time"] = $info["anti_flooding_email_batch_wait_time"];
            }
        }

        Modules::setModuleSettings($settings);

        return array(true, $L["notify_settings_updated"]);
    }


    /**
     * Called on the test tab. It sends one of the three test emails: plain text, HTML and multi-part
     * using the SMTP settings configured on the settings tab. This is NOT for the test email done on the
     * email templates "Test" tab; it uses the main swift_send_email function for that.
     *
     * @param array $info
     * @return array [0] T/F<br />
     *               [1] Success / error message
     */
    public function sendTestEmail($info)
    {
        $L = $this->getLangStrings();

        // create a message
        $message = new Swift_Message();
        $message->setFrom($info["from_email"]);
        $message->setTo($info["recipient_email"]);

        // now send the appropriate email
        switch ($info["test_email_format"]) {
            case "text":
                $message->setSubject($L["phrase_plain_text_email"]);
                $message->setBody($L["notify_plain_text_email_sent"]);
                break;
            case "html":
                $message->setSubject($L["phrase_html_email"]);
                $message->setBody($L["notify_html_email_sent"], "text/html");
                break;
            case "multipart":
                $message->setSubject(htmlspecialchars_decode($L["phrase_multipart_email"]));
                $message->setBody($L["notify_plain_text_email_sent"]);
                $message->addPart($L["notify_plain_text_email_sent"], "text/html");
                break;
        }

        try {
            $mailer = $this->getMailer();
            if (!$mailer->send($message, $errors)) {
                return array(false, $L["notify_problem_sending_test_email"] . " " . implode(", ", $errors));
            }
        } catch (Swift_TransportException $e) {
            return array(false, $L["notify_problem_sending_test_email"] . " " . $e->getMessage());
        }

        return array(true, $L["notify_email_sent"]);
    }


    /**
     * Sends an email with the Swift Mailer module.
     *
     * @param array $email_components
     * @return array
     */
    public function sendEmail($email_components)
    {
        $db = Core::$db;
        $L = $this->getLangStrings();

        $settings = $this->getSettings();

        if (!isset($email_components["cc"])) {
            $email_components["cc"] = array();
        }
        if (!isset($email_components["bcc"])) {
            $email_components["bcc"] = array();
        }

        $mailer = $this->getMailer();

        // apply the optional anti-flood settings
        $use_anti_flooding = (isset($settings["use_anti_flooding"]) && $settings["use_anti_flooding"] == "yes");
        if ($use_anti_flooding) {
            $batch_size      = $settings["anti_flooding_email_batch_size"];
            $batch_wait_time = $settings["anti_flooding_email_batch_wait_time"];

            if (is_numeric($batch_size) && is_numeric($batch_wait_time)) {
                $mailer->registerPlugin(new Swift_Plugins_AntiFloodPlugin($batch_size, $batch_wait_time));
            }
        }

        $message = new Swift_Message();
        $message->setSubject($email_components["subject"]);

        if (!empty($email_components["text_content"]) && !empty($email_components["html_content"])) {
            $message->setBody($email_components["text_content"]);
            $message->addPart($email_components["html_content"], "text/html");
        } else if (!empty($email_components["text_content"])) {
            $message->setBody($email_components["text_content"]);
        } else if (!empty($email_components["html_content"])) {
            $message->setBody($email_components["html_content"], "text/html");
        }

        // add the return path if it's defined

        if (isset($email_components["email_id"])) {
            $db->query("
                SELECT return_path
                FROM {PREFIX}module_swift_mailer_email_template_fields
                WHERE email_template_id = :email_template_id
            ");
            $db->bind("email_template_id", $email_components["email_id"]);
            $db->execute();

            $return_path = $db->fetch(PDO::FETCH_COLUMN);
            if (isset($return_path) && !empty($return_path)) {
                $message->setReturnPath($return_path);
            }
        }

        if (isset($settings["charset"]) && !empty($settings["charset"])) {
            $message->setCharset($settings["charset"]);
        }

        $message->setTo(self::getEmailList($email_components["to"]));

        $cc = self::getEmailList($email_components["cc"]);
        if (!empty($cc)) {
            $message->setCc($cc);
        }

        $bcc = self::getEmailList($email_components["bcc"]);
        if (!empty($bcc)) {
            $message->setBcc($bcc);
        }

        $reply_to = isset($email_components["reply_to"]) ? $email_components["reply_to"] : array();
        if (!empty($reply_to["name"]) && !empty($reply_to["email"])) {
            $message->setReplyTo($reply_to["email"], $reply_to["name"]);
        } else if (!empty($reply_to["email"])) {
            $message->setReplyTo($reply_to["email"]);
        }

        $from = $email_components["from"];
        if (!empty($from["name"]) && !empty($from["email"])) {
            $message->setFrom($from["email"], $from["name"]);
        } else if (!empty($email_components["from"]["email"])) {
            $message->setFrom($from["email"]);
        }

        // finally, if there are any attachments, attach 'em
        if (isset($email_components["attachments"])) {
            foreach ($email_components["attachments"] as $attachment_info) {
                $message->attach(Swift_Attachment::fromPath($attachment_info["file_and_path"]));
            }
        }

        try {
            if (!$mailer->send($message, $errors)) {
                return array(false, $L["notify_email_error"] . " " . implode(", ", $errors));
            }
        } catch (Swift_TransportException $e) {
            return array(false, $L["notify_email_error"] . " " . $e->getMessage());
        }

        return array(true, $L["notify_email_sent"]);
    }


    public function getMailer()
    {
        $settings = $this->getSettings();

        if (empty($settings["port"])) {
            $transport = new Swift_SmtpTransport($settings["smtp_server"]);
        } else {
            $transport = new Swift_SmtpTransport($settings["smtp_server"], $settings["port"]);
        }

        if ($settings["requires_authentication"] == "yes") {
            $transport->setUsername($settings["username"]);
            $transport->setPassword(self::decode($settings["password"]));
            $transport->setAuthMode($settings["authentication_procedure"]);
        }

        if ($settings["use_encryption"] == "yes") {
            $transport->setEncryption($settings["encryption_type"]);
        }

        // if required, set the server timeout (Swift Mailer default == 15 seconds)
        if (isset($settings["server_connection_timeout"]) && !empty($settings["server_connection_timeout"])) {
            $transport->setTimeout($settings["server_connection_timeout"]);
        }

        return new Swift_Mailer($transport);
    }

    /**
     * Displays the extra fields on the Edit Email template: tab 2
     */
    public function displayExtraFieldsTab2($location, $info)
    {
        $L = $this->getLangStrings();

        $return_path = htmlspecialchars($info["template_info"]["swift_mailer_settings"]["return_path"]);

        echo <<< END
<tr>
  <td valign="top" class="red"> </td>
  <td valign="top">{$L["phrase_undeliverable_email_recipient"]}</td>
  <td valign="top">
    <input type="text" name="swift_mailer_return_path" style="width: 300px" value="$return_path" />
  </td>
</tr>
END;
    }


    /**
     * This is called by the ft_create_blank_email_template function.
     *
     * @param array $info
     */
    public function mapEmailTemplateField($info)
    {
        $db = Core::$db;

        $db->query("
            INSERT INTO {PREFIX}module_swift_mailer_email_template_fields (email_template_id, return_path)
            VALUES (:email_template_id, '')
        ");
        $db->bind("email_template_id", $info["email_id"]);
        $db->execute();
    }


    /**
     * Hook for: Emails::createBlankEmailTemplate()
     *
     * @param array $info
     */
    public function deleteEmailTemplateField($info)
    {
        $db = Core::$db;
        $db->query("
            DELETE FROM {PREFIX}module_swift_mailer_email_template_fields
            WHERE email_template_id = :email_template_id
        ");
        $db->bind("email_template_id", $info["email_id"]);
        $db->execute();
    }


    /**
     * This extends the ft_get_email_template function, adding the additional Swift Mailer return_path variable within a "swift_mailer_settings"
     * key.
     */
    public function getEmailTemplateAppendExtraFields($info)
    {
        $db = Core::$db;

        $db->query("
            SELECT return_path
            FROM {PREFIX}module_swift_mailer_email_template_fields
            WHERE email_template_id = :email_id
        ");
        $db->bind("email_id", $info["email_template"]["email_id"]);
        $db->execute();

        $info["email_template"]["swift_mailer_settings"]["return_path"] = $db->fetch(PDO::FETCH_COLUMN);

        return $info;
    }


    public function updateEmailTemplateAppendExtraFields($info)
    {
        $db = Core::$db;

        $db->query("
            UPDATE {PREFIX}module_swift_mailer_email_template_fields
            SET    return_path = :return_path
            WHERE  email_template_id = :email_template_id
        ");
        $db->bindAll(array(
            "return_path" => $info["info"]["swift_mailer_return_path"],
            "email_template_id" => $info["email_id"]
        ));
        $db->execute();
    }

    private static function encode ($str)
    {
        return @openssl_encrypt($str, self::getCipher(), "km");
    }

    private static function decode ($str)
    {
        return @openssl_decrypt($str, self::getCipher(), "km");
    }

    private static function getCipher ()
    {
        $ciphers = openssl_get_cipher_methods();
        $selected_cipher = "";
        foreach (self::$ciphers as $curr_cipher) {
            if (in_array($curr_cipher, $ciphers)) {
                $selected_cipher = $curr_cipher;
                break;
            }
        }
        // assumption is that at least ONE cipher exists on the users system
        if (empty($selected_cipher)) {
            $selected_cipher = $ciphers[0];
        }

        return $selected_cipher;
    }


    private static function getEmailList ($list)
    {
        $emails = array();

        foreach ($list as $item) {
            if (empty($item["email"])) {
                continue;
            }
            $email = $item["email"];

            if (empty($item["name"])) {
                $emails[] = $email;
            } else {
                $emails[$email] = $item["name"];
            }
        }

        return $emails;
    }
}
