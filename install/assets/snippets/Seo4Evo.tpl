/**
 * Seo4Evo
 *
 * Seo4Evo RC 3.0 - Manage and return Meta Tags using modx Tvs
 *
 * @category	snippet
 * @internal	@modx_category Seo4Evo
 * @version     RC 3.0
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/   
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 */

//<?
/**
| --------------------------------------------------------------------------
| Snippet Title:     Seo4Evo By Nicola (Banzai) (based on MetaTagsExtra by Soda)
| Snippet Version:  RC 3.0
|
| Description:
| Manage and return Meta Tags using modx Tvs from Seo4Evo Package
|
| Basic Snippet Parameters:
|
| KeywordsTv - custom keywords tv - Example: &KeywordsTv=`documentTags`
| all_page_keywords - chunk or comma separated list of Keywords displayed on all pages - Example: &all_page_keywords=`modx, snippets, plugins`
| preTitle -  custom pre title - Example: &preTitle &preTitle=`[(site_name)] |`
| postTitle -  custom post title - Example:  &postTitle=`| [(site_name)]`
|
| ******* Facebook Open Graph  Parameters: ******
| OpenGraph - enable OG metatags  - Example: &OpenGraph=`1`
| OGfbappId your facebook app id - Example: &OGfbappId=`123456789123456789`
| OGtype - default: website - Example &OGtype=`article`
| OGimageTv - default: thumbnail - Example: &OGimageTv=`my-thumbnail`
|
| ******* GooglePlus  Parameters: ******
| GooglePlus - enable G+ metatags  - Example: &GooglePlus=`1`
| linkPub your google publisher page  - Example: &linkPub=`https://plus.google.com/123456789123456789`
|
| Usage:
|  Insert [[Seo4Evo]] anywhere in the head section of your template.
|
|  with custom MetaTags Tv (for old sites)
|  [[Seo4Evo? &KeywordsTv=`documentTags`]]
|
|  With Facebook Open Graph metatags
| [[Seo4Evo? &OpenGraph=`1` &OGfbappId=`123456789123456789` &OGimageTv=`my-thumbnail` &OGtype=`article`]]
|
| With Facebook Open Graph e Google plus metatags
| [[Seo4Evo? &OpenGraph=`1` &OGfbappId=`123456789123456789` &OGimageTv=`my-thumbnail` &OGtype=`article` &GooglePlus=`1` &linkPub=`https://plus.google.com/123456789123456789`]]
| ---------------------------------------------------------------------------

*/
$Keywords = isset($KeywordsTv) ? $KeywordsTv : '[*MetaKeywords*]';
$MetaKeywords ="";
$comma=(isset($all_page_keywords))?', ':'';
// *** KEYWORDS ***
$MetaKeywords= " <meta name=\"keywords\" content=\"{$all_page_keywords}{$comma}{$Keywords}\" />\n";
$MetaCharset ="";
$BaseUrl ="";
$MetaDesc = "";
$MetaRobots = "";
$MetaCopyright = "";

$id = $modx -> documentObject['id'];
$url = $modx->makeUrl($id, '', '', 'full');

// *** Meta Title ***
$preTitle = isset($preTitle) ? $preTitle : '';
$postTitle = isset($postTitle) ? $postTitle : '';

$pagetitle = $modx->documentObject['pagetitle'];
$CTitle = $modx->getTemplateVarOutput('CustomTitle',$id);
$Custom = $CTitle['CustomTitle'];

if(!$Custom == ""){
$MetaTitle = " <title>$preTitle$Custom$postTitle</title>\n";
} else {
      $MetaTitle = " <title>$preTitle$pagetitle$postTitle</title>\n";
   }

// *** Meta Charset***
$MetaCharset = " <meta charset=\"[(modx_charset)]\" />\n";
// *** BASEURL***
$BaseUrl = " <base href=\"[(site_url)]\" />\n";

// *** Meta Description ***
$dyndesc = $modx->runSnippet(
        "DynamicDescription",
        array(
            "descriptionTV" => "MetaDescription",
			"maxWordCount=" => "25"
        )
);

$MetaDesc = " <meta name=\"description\" content=\"$dyndesc\" />\n";

// *** Meta Robots***
$MetaRobots = " <meta name=\"robots\" content=\"[*RobotsIndex*], [*RobotsFollow*]\" />\n";

//*** Meta Copiright***
$MetaCopyright = " <meta name=\"copyright\" content=\"[(site_name)]\" />\n";

// *** Last Modified ***
$editedon = date(r,$modx->documentObject['editedon']);
$MetaEditedOn = " <meta http-equiv=\"last-modified\" content=\"$editedon\" />\n";

// ** FACEBOOK OPEN GRAPH PROTOCOL

$imageUrl = isset($OGimageTv) ? $OGimageTv : 'thumbnail';
$type = isset($OGtype) ? $OGtype : 'website';

$MetaProperty = " <meta property=\"og:site_name\" content=\"[(site_name)]\" />\n";
$MetaPropertyType = " <meta property=\"og:type\" content=\"$type\" />\n";
$MetaPropertyUrl = " <meta property=\"og:url\" content=\"$url\" />\n";
$MetaPropertyImage = " <meta property=\"og:image\" content=\"[(site_url)][*$imageUrl*]\" />\n";

$MetaPropertyFbApp = " <meta property=\"fb:app_id\" content=\"$OGfbappId\" />\n";

//Google Plus

$linkPub = isset($linkPub) ? $linkPub : '';
$LinkPublisher = " <link rel=\"publisher\" href=\"$linkPub\" />\n";

$GAuthor = $modx->getTemplateVarOutput('GoogleAuthor',$id);
$GoogleAthorship = $GAuthor['GoogleAuthor'];
if(!$GoogleAthorship == ""){
$LinkAuthor = " <link rel=\"author\" href=\"$GoogleAthorship\" />\n";
}

//*** Canonical**//
// Custom CanonicalUrl tv
// with tv empty > link to siteurl for homepage and to full alias url for other pages.

$CUrl = $modx->getTemplateVarOutput('CanonicalUrl',$id);
$CanonicalUrl = $CUrl['CanonicalUrl'];

if(!$CanonicalUrl == ""){
$Canonical = " <link rel=\"canonical\" href=\"$CanonicalUrl\" />\n";
} else {
	$Canonical = $modx->documentIdentifier == $modx->config['site_start'] ? " <link rel=\"canonical\" href=\"[(site_url)]\" />" : " <link rel=\"canonical\" href=\"[(site_url)][~[*id*]~]\" />\n";
}

// *** RETURN RESULTS ***
// you can change the order of displayed items:
$output = $MetaCharset.$BaseUrl.$MetaTitle.$MetaKeywords.$MetaDesc.$MetaRobots.$MetaCopyright.$MetaEditedOn.$Canonical;
//return OpenGraph metatags if OpenGraph=1
if ($OpenGraph >= 1) {
    $output .= $MetaProperty.$MetaPropertyType.$MetaPropertyUrl.$MetaPropertyImage.$MetaPropertyFbApp;
}
//return Google plus metatags if GooglePlus=1
if ($GooglePlus >= 1) {
    $output .= $LinkAuthor.$LinkPublisher;
}

return $output;
//?>
?>