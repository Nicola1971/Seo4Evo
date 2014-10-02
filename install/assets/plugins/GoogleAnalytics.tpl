//<?php
/**
 * GoogleAnalytics
 *
 * Adds your Google Analytics to every page in your site
 *
 * @author    Nicola Lambathakis - Original developer Mark Kaplan
 * @category    plugin
 * @version    2.0 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @disabled 1
 * @internal    @installset base
 * @internal    @modx_category Seo4Evo
 * @internal    @properties  &account=Account;string;UA-000000-0 &codetype=Analytics code;list;UniversalAnalytics,OldAnalyticsCode;UniversalAnalytics
 */

/*
// <?php
/*
* GoogleAnalytics Plugin
* version 2.0
* author: Nicola Lambathakis 01 October 2014 * Original developer Mark Kaplan (30-Jul-2006 )
*
*
* Adds your Google Analytics to every page in your site
*
* Parameter: &account=Account;string;UA-000000-0 &codetype=Analytics code;list;UniversalAnalytics,OldAnalyticsCode;UniversalAnalytics
*
* Event: OnWebPagePrerender
*/
$e = $modx->Event;
$codetype = isset($codetype)? $codetype: 'UniversalAnalytics';
$account = isset($account)? $account: '';
 if ($codetype == "OldAnalyticsCode") {
$script = $account? '
<!-- Google Analytics -->
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "'.$account.'";
urchinTracker();
</script>
': '

<!-- Google Analytics Account Not Supplied -->

';
 }
else {
$script = $account? '
<!-- Google Universal Analytics -->
<script>
  (function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,\'script\',\'//www.google-analytics.com/analytics.js\',\'ga\');

  ga(\'create\', \''.$account.'\', \'auto\');
  ga(\'send\', \'pageview\');

</script>
': '

<!-- Google Analytics Account Not Supplied -->

';
 }

switch ($e->name) {
	case "OnWebPagePrerender":
		$googleize = ($modx->documentObject['donthit']==0 && $modx->documentObject['contentType']=='text/html');
              if ($googleize) {
			$modx->documentOutput = preg_replace("/(<\/body>)/i", $script."\n\\1", $modx->documentOutput);
		}
		break;

	default :
		return; // stop here - this is very important.
		break;
}
// ?>