/**
 * Seo4Evo
 *
 * Returns HTML meta tags for SEO4EVO Package v.RC2.1
 *
 * @category	snippet
 * @internal	@modx_category Seo4Evo
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 */

//<?
/**
| --------------------------------------------------------------------------
| Snippet Title:     Seo4Evo By Nicola (Banzai) (based on MetaTagsExtra by Soda)
| Snippet Version:  RC2
|
| Description:
| Returns HTML meta tags from Seo4Evo Package
|
| Usage:
|   Insert [[Seo4Evo]] anywhere in the head section of your template.
| ---------------------------------------------------------------------------

*/

$MetaKeywords ="";
// Keywords displayed on all pages
// default is the $all_page_keywords parameter, else uncomment the line of your choice:
// With a chunk:
// $all_page_keywords="{{AllPageKeywords}}";
// Defined here
// $all_page_keywords="keywords1, keywors2,...";

$comma=(isset($all_page_keywords))?', ':'';
// *** KEYWORDS ***
$MetaKeywords= " <meta name=\"keywords\" content=\"{$all_page_keywords}{$comma}[*MetaKeywords*]\" />\n";
$MetaCharset ="";
$BaseUrl ="";
$MetaDesc = "";
$MetaRobots = "";
$MetaCopyright = "";

$id = $modx -> documentObject['id'];
$url = $modx->makeUrl($id, '', '', 'full');

// *** TITLE ***
$preTitle = isset($preTitle) ? $preTitle : '';
$postTitle = isset($postTitle) ? $postTitle : '';

$pagetitle = $modx->documentObject['pagetitle'];
$CTitle = $modx->getTemplateVarOutput('CustomTitle',$id);
$Custom = $CTitle['CustomTitle'];

if(!$Custom == ""){
$MetaTitle = " <title>$preTitle $Custom $postTitle</title>\n";
} else {
      $MetaTitle = " <title>$preTitle $pagetitle $postTitle</title>\n";
   }

// *** CHARSET***
$MetaCharset = " <meta charset=\"[(modx_charset)]\" />\n";
// *** BASEURL***
$BaseUrl = " <base href=\"[(site_url)]\" />\n";

// *** DESCRIPTION ***
$dyndesc = $modx->runSnippet(
        "DynamicDescription",
        array(
            "descriptionTV" => "MetaDescription",
			"maxWordCount=" => "25"

        )
);

$MetaDesc = " <meta name=\"description\" content=\"$dyndesc\" />\n";


// *** ROBOTS***
// Determine if this document has been set to non-searchable.
$MetaRobots = " <meta name=\"robots\" content=\"[*RobotsIndex*], [*RobotsFollow*]\" />\n";


//*** COPYRIGHT***
$MetaCopyright = " <meta name=\"copyright\" content=\"[(site_name)]\" />\n";

// ** FACEBOOK OPEN GRAPH PROTOCOL
// OG  parameters:
//$OpenGraph - enable OG metatags
//$OGfbappId your facebook app id;
//$OGimageTv - default: thumbnail
//$OGtype - default: website

$imageUrl = isset($OGimageTv) ? $OGimageTv : 'thumbnail';
$type = isset($OGtype) ? $OGtype : 'website';

$MetaProperty = " <meta property=\"og:site_name\" content=\"[(site_name)]\" />\n";
$MetaPropertyType = " <meta property=\"og:type\" content=\"$type\" />\n";
$MetaPropertyUrl = " <meta property=\"og:url\" content=\"$url\" />\n";
$MetaPropertyImage = " <meta property=\"og:image\" content=\"[(site_url)][*$imageUrl*]\" />\n";

$MetaPropertyFbApp = " <meta property=\"fb:app_id\" content=\"$OGfbappId\" />\n";

//Google Plus
//G+  parameters:
//$GooglePlus - enable G+ metatags
//$linkPub your google publisher page;
//$linkAuth your google author page;
$linkPub = isset($linkPub) ? $linkPub : '';
$LinkPublisher = " <link rel=\"publisher\" href=\"$linkPub\" />\n";

$GAuthor = $modx->getTemplateVarOutput('GoogleAuthor',$id);
$GoogleAthorship = $GAuthor['GoogleAuthor'];
if(!$GoogleAthorship == ""){
$LinkAuthor = " <link rel=\"author\" href=\"$GoogleAthorship\" />\n";
}

//*** Canonical**//
// check CanonicalUrl tv
// with tv empty > link to siteurl for homepage and to full alias url for other pages.

$CUrl = $modx->getTemplateVarOutput('CanonicalUrl',$id);
$CanonicalUrl = $CUrl['CanonicalUrl'];

if(!$CanonicalUrl == ""){
$Canonical = " <link rel=\"canonical\" href=\"$CanonicalUrl\" />\n";
} else {
      if(!$id == "1"){
$Canonical = " <link rel=\"canonical\" href=\"[(site_url)]\" />\n";
} else {
      $Canonical = " <link rel=\"canonical\" href=\"$url\" />\n";
   }
   }

// *** RETURN RESULTS ***
// you can change the order of displayed items:
$output = $MetaCharset.$BaseUrl.$MetaTitle.$MetaKeywords.$MetaDesc.$MetaRobots.$MetaCopyright.$Canonical;
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