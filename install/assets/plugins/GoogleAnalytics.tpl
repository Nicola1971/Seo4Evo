//<?php
/**
 * GoogleAnalytics
 *
 * Adds your Google Analytics to every page in your site
 *
 * @author     Mark Kaplan
 * @category   plugin
 * @version    2.0 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @disabled 1
 * @internal    @installset base
 * @internal    @modx_category Seo4Evo
 * @internal    @properties  &account=Account;string;UA-000000-0 &testMode=Test Mode;list;true,false;false &trackingNameTV=Alt tracking URL TV name;string; &trackingNamePH=Alt tracking URL placeholder name;string;&extraJs=Chunk containing extra JS;string; &codetype=Analytics code;list;UniversalAnalytics,GoogleAnalytics;UniversalAnalytics &codePosition=Place the analitycs code before closing tag;list;head,body;body
 */

//<?
/**
 * GoogleAnalytics
 *
 * Adds your Google Analytics to every page in your site
 *
 * @author     Mark Kaplan
 * @category   plugin
 * @version    2.0 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @disabled 1
 * @internal    @installset base
 * @internal    @modx_category Seo4Evo
 * @internal    @properties  &account=Account;string;UA-000000-0 &testMode=Test Mode;list;true,false;false &trackingNameTV=Alt tracking URL TV name;string; &trackingNamePH=Alt tracking URL placeholder name;string;&extraJs=Chunk containing extra JS;string; &codetype=Analytics code;list;UniversalAnalytics,GoogleAnalytics;UniversalAnalytics &codePosition=Place the analitycs code before closing tag;list;head,body;body
 */


// By Mark Kaplan
// Updated by Nicola Lambathakis, Nick Crossland, David Hyland, Ryan Thrash


/* CHANGELOG

2.0 - New Code position parameter

1.9 - New Option to change code type (UniversalAnalytics/GoogleAnalytics)

1.8 - New Google Universal Analitycs code

1.7 - 5 Jan 2011 - fix bug with trackingNameTV (http://modxcms.com/forums/index.php/topic,52422.msg335386.html#msg335386)

1.6 - 25 June 2010 - respect the site config "Enable stats tracking" setting **IF YOU UPGRADE AND FIND THE PLUGIN IS NOT WORKING - CHECK THIS SETTING, AS IT MAY NOT BE ENABLED ON YOUR SITE**

1.5 - 9 June 2010 - updated to use only the latest Async tracking code, plus various cleanups. Added "extraJs" parameter. Add documentation. Fixed check to surpress output in logged in manager (which was broken)

1.4 - 12-Mar-08 - added option to provide an alternative tracking name (by template variable or placeholder value). Made configuration interface slightly friendlier

1.3 - 14-Dec-07 - added option of new or legacy analytics code

1.2 - 1-Aug-06 - Added InManager check and test mode parameter

1.1 - 30-Jun-06 - Updated to work with current Google docs

*/


/* INSTALL

1. Create a new plugin, and paste the contents of this file into the Plugin Code area. Set the plugin name to "Google Analytics" and description to "<strong>1.7</strong>  Adds Google Analytics code to every page in your site"

2. Copy this line into the Plugin Configuration of the Configuration tab:

&account=Account;string;UA-000000-0 &testMode=Test Mode;list;true,false;false &trackingNameTV=Alt tracking URL TV name;string; &trackingNamePH=Alt tracking URL placeholder name;string;&extraJs=Chunk containing extra JS;string; &codetype=Analytics code;list;UniversalAnalytics,GoogleAnalytics;UniversalAnalytics &codePosition=Place the analitycs code before closing tag;list;head,body;body

3. Enter your Google Account details on the configuration tab

4. Check the OnWebPagePrerender box on the System Events tab

5. Press Save

6. Ensure "Stats Tracking" is enabled in the Site Configuration menu (Tools -> Configuration -> [ Site ] tab )  ** IMPORTANT IF UPGRADING - THIS SETTING WAS NOT RESPECTED BEFORE **

*/

/* USAGE

Once installed, you don't need to do anything else - all HTML pages which have the "Enable Stats Tracking" box ticked in Manager will automatically have the code inserted.

PARAMETERS (set in configuration tab)

account = Google Analytics tracking code, which looks like UA-000000-0
testMode = boolean - if true, do not send tracking data to Google. Code is outputted as comments, useful for debugging
trackingNameTV = see ALTERNATIVE TRACKING NAMES
trackingNamePH = see ALTERNATIVE TRACKING NAMES
extraJs = name of a chunk containing extra JS, which is inserted into the Google tracking code before the page view is recorded, if you wish to take advantage of GA's custom tracking features
codetype=Analytics js code type: new Universal Analytics or old GoogleAnalytics code
codePosition = choose js position : before closing head tag or before closing body tag (suggested)

ALTERNATIVE TRACKING NAMES
By default, Google will track the pages based on their [friendly] URL. Sometimes you may want to tell Analytics to report alternative tracking names.
For example to define stages of a goals, but where the URL may not change - e.g. submitting an eForm
The value for the URL that will be tracked can be set either by supplying a Template Variable name - this can then be entered on any page via the Manager
Alternatively the name of a placeholder can be supplied, which can be set by other plugins or snippets. A placeholder value will override a template value.

*/

// Is stats tracking turned on in the Site Config?
if ($modx->getConfig('track_visitors') != 1) {
	return;
}


// Parameters
$account = isset($account) && $account != 'UA-000000-0' ? $account : ''; // Ignore default value
$testMode = isset($testMode) && ($testMode == 'true') ? true: false;
$extraJs = isset($extraJs) ? $modx->evalSnippets($modx->mergePlaceholderContent($modx->getChunk($extraJs))) : '';
$codetype = isset($codetype)? $codetype: 'UniversalAnalytics';
$codePosition = isset($codePosition)? $codePosition: 'body';

// Tracking name - is it from a placeholder or a template variable?
$trackingName_value = '';
if (isset($trackingNameTV)) {
		$trackingNameTv_array = !empty($trackingNameTV)?$modx->getTemplateVarOutput($trackingNameTV):array();
		$trackingName_value = (isset($trackingNameTv_array[$trackingNameTV]) && !empty($trackingNameTv_array[$trackingNameTV]))?$trackingNameTv_array[$trackingNameTV]:$trackingName_value;
}

// If a placeholder name is defined, and the placeholder has a value, use that instead
if (isset($trackingNamePH) && !empty($trackingNamePH)) {
	$v = $modx->getPlaceholder($trackingNamePH) ;
	$trackingName_value = !empty($v) ? $v : $trackingName_value;
}


// make sure an account number has been supplied
if(!empty($account)){

	// Enclose value in quotes and a comma
	$trackingName_value = (!empty($trackingName_value)) ? ', "'.addslashes($trackingName_value).'"' : '';
		if ($codetype == "GoogleAnalytics") {
	$script = "

	<script type=\"text/javascript\">

	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', '$account']);
	  $extraJs
	  _gaq.push(['_trackPageview' $trackingName_value]);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

	</script>";
	$insert_before = ''.$codePosition.'';
		}
        else {
    	$script = "

<script>
  (function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,\'script\',\'//www.google-analytics.com/analytics.js\',\'ga\');

  ga(\'create\', \''.$account.'\', \'auto\');
  ga(\'send\', \'pageview\');

</script>";
	$insert_before = ''.$codePosition.'';
        }


} else {
  $script = '<!-- Google Analytics account not supplied -->';
}


switch ($modx->Event->name) {

	case "OnWebPagePrerender":

		if ($testMode) {
			$script = '<!-- Google Analytics plugin is in test mode - output would be: '. $script . ' -->';
		} else if (isset($_SESSION['mgrValidated'])) {
			$script = '<!-- Logged in to Manager - Google Analytics plugin output surpressed, but would be: '. $script . ' -->';
		}

		// Only track HTML documents, in the front end, which have the "Track" box checked in the Manager
		$googleize = ($modx->isFrontEnd() && $modx->documentObject['donthit']==0 && $modx->documentObject['contentType']=='text/html');

		if ($googleize) {
			$modx->documentOutput = preg_replace("/(<\/$insert_before>)/i", $script."\n\\1", $modx->documentOutput);
		}

		break;

}