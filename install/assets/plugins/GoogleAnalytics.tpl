//<?php
/**
 * GoogleAnalytics
 *
 * Adds Google Analytics 4 (gtag.js) to every page in your site
 *
 * @author     Mark Kaplan
 * @category   plugin
 * @version    3.0 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @disabled 1
 * @internal    @installset base
 * @internal    @modx_category Seo4Evo
 * @internal    @properties  &account=Measurement ID (G-XXXXXXXXXX);string;G-XXXXXXXXXX &testMode=Test Mode;list;true,false;false &consentMode=Consent Mode v2 default;list;none,denied;none &trackingNameTV=Alt page path TV name;string; &trackingNamePH=Alt page path placeholder name;string; &extraJs=Chunk containing extra JS;string; &codePosition=Place the analytics code before closing tag;list;head,body;head
 */

/*
GoogleAnalytics 3.0 - Google Analytics 4
By Mark Kaplan
Updated by Nicola Lambathakis, Nick Crossland, David Hyland, Ryan Thrash

CHANGELOG

3.0   - Google Analytics 4 (gtag.js). Universal Analytics and ga.js are no longer processed by Google
        (since July 2023): a UA-xxxx account is ignored and a warning comment is added to the page source.
      - New parameter consentMode (Consent Mode v2): "denied" sets all consent types to denied
        before the config call; your cookie banner must then call gtag('consent','update',{...}).
      - Alternative tracking name (TV or placeholder) is sent as page_location.
      - Default position: before </head> (as recommended by Google).
      - PHP 8.x compatible. The "codetype" parameter of 2.x is no longer used and can be removed.
2.0.2 - PHP 8.x compatibility
2.0   - New Code position parameter
1.9   - New Option to change code type (UniversalAnalytics/GoogleAnalytics)
1.8   - New Google Universal Analitycs code
1.6   - Respect the site config "Enable stats tracking" setting
1.5   - Added "extraJs" parameter
1.4   - Alternative tracking name (TV or placeholder)
1.2   - Added InManager check and test mode parameter

UPGRADE FROM 2.x
Keep the existing plugin and replace the code. In the Configuration tab, replace the UA-… value
of "account" with your GA4 Measurement ID (G-…). You can paste the new properties line from the
docblock above to get the new labels and the consentMode option.

PARAMETERS (set in configuration tab)

account        = GA4 Measurement ID, like G-ABC123DEF4 (Admin > Data streams > Web)
testMode       = true: the code is output as an HTML comment, nothing is sent to Google
consentMode    = none: no consent default is set (use it if your consent tool already does it)
                 denied: analytics_storage, ad_storage, ad_user_data, ad_personalization = denied
                 until your cookie banner updates the consent
trackingNameTV = name of a TV with an alternative page path or URL for this page
trackingNamePH = name of a placeholder with an alternative page path or URL (overrides the TV)
extraJs        = name of a chunk with extra JS, inserted after gtag() is defined and before the config call
                 (e.g. gtag('set', 'user_properties', {...});)
codePosition   = head (default, recommended) or body

NOTES
- The plugin respects the site setting "Track visitors" (track_visitors) and the "Track" box of each
  document (donthit). Logged-in manager users get the code as an HTML comment.
- Only text/html documents in the front end are tracked.
*/

// Is stats tracking turned on in the Site Config?
if ($modx->getConfig('track_visitors') != 1) {
	return;
}
if ($modx->Event->name !== 'OnWebPagePrerender') {
	return;
}

// Only track HTML documents, in the front end, which have the "Track" box checked in the Manager
if (!$modx->isFrontEnd()
	|| !empty($modx->documentObject['donthit'])
	|| ($modx->documentObject['contentType'] ?? 'text/html') !== 'text/html') {
	return;
}

// Parameters
$account      = trim((string)($account ?? ''));
$testMode     = (($testMode ?? 'false') === 'true');
$consentMode  = (($consentMode ?? 'none') === 'denied') ? 'denied' : 'none';
$codePosition = (($codePosition ?? 'head') === 'body') ? 'body' : 'head';

if ($account === '' || strtoupper($account) === 'G-XXXXXXXXXX' || strtoupper($account) === 'UA-000000-0') {
	return; // not configured yet
}

if (!preg_match('/^G-[A-Z0-9]+$/i', $account)) {
	if (stripos($account, 'UA-') === 0) {
		$script = '<!-- GoogleAnalytics: "' . htmlspecialchars($account, ENT_QUOTES) . '" is a Universal Analytics ID. Google stopped processing UA data in July 2023: set a GA4 Measurement ID (G-...) in the plugin configuration. -->';
	} else {
		$script = '<!-- GoogleAnalytics: invalid Measurement ID "' . htmlspecialchars($account, ENT_QUOTES) . '" (expected G-...). -->';
	}
} else {
	$account = strtoupper($account);

	// Alternative page path: placeholder overrides TV
	$trackingName = '';
	if (!empty($trackingNameTV)) {
		$tv = $modx->getTemplateVarOutput($trackingNameTV);
		if (is_array($tv) && !empty($tv[$trackingNameTV])) {
			$trackingName = (string)$tv[$trackingNameTV];
		}
	}
	if (!empty($trackingNamePH)) {
		$ph = $modx->getPlaceholder($trackingNamePH);
		if (!empty($ph)) {
			$trackingName = (string)$ph;
		}
	}

	// Extra JS from chunk
	$extra = '';
	if (!empty($extraJs)) {
		$chunk = $modx->getChunk($extraJs);
		if (is_string($chunk) && $chunk !== '') {
			$extra = $modx->evalSnippets($modx->mergePlaceholderContent($chunk));
		}
	}

	$jsonFlags = JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT;
	$lines = array();
	$lines[] = '<!-- Google tag (gtag.js) -->';
	$lines[] = '<script async src="https://www.googletagmanager.com/gtag/js?id=' . $account . '"></script>';
	$lines[] = '<script>';
	$lines[] = '  window.dataLayer = window.dataLayer || [];';
	$lines[] = '  function gtag(){dataLayer.push(arguments);}';
	if ($consentMode === 'denied') {
		$lines[] = "  gtag('consent', 'default', {'ad_storage': 'denied', 'ad_user_data': 'denied', 'ad_personalization': 'denied', 'analytics_storage': 'denied', 'wait_for_update': 500});";
	}
	$lines[] = "  gtag('js', new Date());";
	if ($extra !== '') {
		$lines[] = $extra;
	}
	if ($trackingName !== '') {
		$lines[] = "  gtag('config', " . json_encode($account, $jsonFlags) . ", {'page_location': new URL(" . json_encode($trackingName, $jsonFlags) . ", window.location.origin).href});";
	} else {
		$lines[] = "  gtag('config', " . json_encode($account, $jsonFlags) . ");";
	}
	$lines[] = '</script>';
	$script = implode("\n", $lines);

	if ($testMode) {
		$script = "<!-- Google Analytics plugin is in test mode - output would be:\n" . str_replace('--', '- -', $script) . "\n-->";
	} elseif (isset($_SESSION['mgrValidated'])) {
		$script = "<!-- Logged in to Manager - Google Analytics plugin output suppressed, but would be:\n" . str_replace('--', '- -', $script) . "\n-->";
	}
}

// Insert before the last </head> or </body> (no regex: the script may contain $ or \)
$output = (string)$modx->documentOutput;
$pos = strripos($output, '</' . $codePosition . '>');
if ($pos !== false) {
	$modx->documentOutput = substr_replace($output, $script . "\n", $pos, 0);
}
