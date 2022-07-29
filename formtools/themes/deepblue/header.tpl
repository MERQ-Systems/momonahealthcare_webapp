<!DOCTYPE html>
<html dir="{$LANG.special_text_direction}">
<head>
  <title>{$head_title}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link rel="shortcut icon" href="{$theme_url}/images/favicon.ico">
  {template_hook location="head_top"}
  <script>
  //<![CDATA[
  var g = {literal}{{/literal}
    root_url:       "{$g_root_url}",
    error_colours:  ["ffbfbf", "ffeded"],
    notify_colours: ["c6e2ff", "f2f8ff"],
    js_debug:       {$g_js_debug}
  {literal}}{/literal};
  //]]>
  </script>
  <link type="text/css" rel="stylesheet" href="{$g_root_url}/global/css/main.css?v=3_0_0">
  <link type="text/css" rel="stylesheet" href="{$theme_url}/css/styles.css?v=3_0_0">
  <link href="{$theme_url}/css/smoothness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css"/>
  <script src="{$g_root_url}/global/scripts/jquery.js"></script>
  <script src="{$theme_url}/scripts/jquery-ui-1.8.14.custom.min.js"></script>
  <script src="{$g_root_url}/global/scripts/general.js?v=3_0_0"></script>
  <script src="{$g_root_url}/global/scripts/rsv.js?v=3_0_0"></script>
  {$head_string}
  {$head_js}
  {$head_css}

  {template_hook location="head_bottom"}
</head>
<body>

<div id="container" class="admin_container">

	<div id="header"><span
	  style="float:right"><img src="{$theme_url}/images/header_right_shadow.jpg" width="7" height="71" /></span><span
	  style="float:right"><img src="{$theme_url}/images/header_right.jpg" width="10" height="71" /></span>
    {if isset($settings.logo_link) && !empty($settings.logo_link)}<a href="{$settings.logo_link}">{/if}
      <img src="{$theme_url}/images/header_logo.jpg" width="200" height="71" border="0" />
    {if isset($settings.logo_link) && !empty($settings.logo_link)}</a>{/if}
    </div>

	  <div class="outer">
	  <div class="inner">
	    <div class="float-wrap">
	      <table cellspacing="0" cellpadding="0" width="990">
	      <tr>
	        <td width="200" valign="top">

		        <div id="left">
		          <div id="left_nav_top">
		            {if $is_logged_in && isset($settings.program_version)}
					  {if $settings.release_type == "alpha"}
					    <b>{$settings.program_version}-alpha-{$settings.release_date}</b>
                      {elseif $settings.release_type == "beta"}
					    <b>{$settings.program_version}-beta-{$settings.release_date}</b>
		              {else}
		                <b>{$settings.program_version}</b>
		              {/if}
		              {if $account.account_type == "admin"}
                         &nbsp;<a href="#" onclick="return ft.check_updates()" class="update_link">{$LANG.word_update}</a>
		              {/if}
		      	  	{else}
		      	  	  <div style="height: 20px"> </div>
		      	    {/if}
		          </div>

                  {ft_include file="menu.tpl"}

		        </div>
	        </td>
	        <td valign="top">

              <div id="main_top"></div>
              <span style="position: absolute; right: 0px;"><img src="{$theme_url}/images/main_right_shadow.jpg" width="7" height="292" /></span>

                  <div class="content_wrap">

                    <div id="page_content">

