/**
 * Seo4Evo
 *
 * Seo4Evo RC 3.2 - Manage and return Meta Tags using modx Tvs
 *
 * @category	snippet
 * @internal	@modx_category Seo4Evo
 * @version     RC 3.2
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal @installset base, sample
 */

/**
| --------------------------------------------------------------------------
| Snippet Title:     Seo4Evo By Nicola (Banzai) (based on MetaTagsExtra by Soda)
| Snippet Version:  RC 3.2
|
| Description:
| Manage and return Meta Tags using modx Tvs from Seo4Evo Package
|
| Basic Snippet Parameters:
|
| KeywordsTv - custom keywords tv - Example: &KeywordsTv=`documentTags`
| MetaDescriptionTv -  custom description tv - Example: &MetaDescriptionTv=`introtext`
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
|
| With Facebook Open Graph, Google plus metatags, GeoLocation, DublinCore, Favicons
| [[Seo4Evo? &OpenGraph=`1` &OGfbappId=`123456789123456789` &OGimageTv=`my-thumbnail` &OGtype=`article` &GooglePlus=`1` &linkPub=`https://plus.google.com/123456789123456789` &GeoLocation=`1` &Country=`IT-RM` &City=`Rome` &LatLon=`41.859061, 12.540894` &DublinCore=`1` &dcLang=`en` &Favicons=`1` &iconDir=`/`]]
| ---------------------------------------------------------------------------

*/
$Keywords = isset($KeywordsTv) ? $KeywordsTv : '[*MetaKeywords*]';
$MetaDescriptionTv = isset($MetaDescriptionTv) ? $MetaDescriptionTv : 'MetaDescription';
$MetaKeywords ="";
$comma=(isset($all_page_keywords))?', ':'';

// *** KEYWORDS ***//
$MetaKeywords= "	<meta name=\"keywords\" content=\"{$all_page_keywords}{$comma}{$Keywords}\">\n";
$MetaCharset ="";
$BaseUrl ="";
$MetaDesc = "";
$MetaRobots = "";
$MetaCopyright = "";

$id = $modx -> documentObject['id'];
$url = $modx->makeUrl($id, '', '', 'full');

// *** Meta Title ***//
$preTitle = isset($preTitle) ? $preTitle : '';
$postTitle = isset($postTitle) ? $postTitle : '';

$pagetitle = $modx->documentObject['pagetitle'];
$CTitle = $modx->getTemplateVarOutput('CustomTitle',$id);
$Custom = $CTitle['CustomTitle'];

if(!$Custom == ""){
$MetaTitle = "	<title>".$preTitle.$Custom.$postTitle." | [(site_name)]</title>\n";
$SocialTitle = $preTitle.$Custom.$postTitle;
} else {
      $MetaTitle = "	<title>".$preTitle.$pagetitle.$postTitle." | [(site_name)]</title>\n";
      $SocialTitle = $preTitle.$pagetitle.$postTitle;
   }

// *** Header Desc ***//
$HeaderDesc = "<!-- Basic Header Needs
	================================================== -->\n";
	
// *** Meta Charset ***//
$MetaCharset = "	<meta charset=\"[(modx_charset)]\">\n";

// *** BASEURL ***//
$BaseUrl = "	<base href=\"[(site_url)]\">\n";

// *** Header Extra ***//
$HeaderExtra = "	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
	<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n\n";
	
// *** Meta Description ***//
$dyndesc = $modx->runSnippet(
        "DynamicDescription",
        array(
            "descriptionTV" => $MetaDescriptionTv,
			"maxWordCount=" => "25"
        )
);

$MetaDesc = "	<meta name=\"description\" content=\"".$dyndesc."\">\n";

// *** Meta Robots ***//
$MetaRobots = "	<meta name=\"robots\" content=\"[*RobotsIndex*], [*RobotsFollow*]\">\n";

//*** Meta Copiright ***//
$MetaCopyright = "	<meta name=\"copyright\" content=\"[(site_name)]\">\n";

// *** Last Modified ***//
$editedon = date(r,$modx->documentObject['editedon']);
$MetaEditedOn = "	<meta http-equiv=\"last-modified\" content=\"".$editedon."\">\n";

// ** FACEBOOK OPEN GRAPH PROTOCOL **//
$imageUrl = isset($OGimageTv) ? $OGimageTv : 'thumbnail';
$type = isset($OGtype) ? $OGtype : 'website';
$title = isset($OGtitle) ? $OGtitle : $preTitle.$Custom.$postTitle;
$description = isset($OGdescription) ? $OGdescription : $dyndesc;


$FbDesc = "	<!-- Facebook, more here http://ogp.me/ 
	=================================================== -->\n";
$MetaProperty = "	<meta property=\"og:site_name\" content=\"[(site_name)]\">\n";
$MetaPropertyType = "	<meta property=\"og:type\" content=\"".$type."\">\n";
$MetaPropertyTitle = "	<meta property=\"og:title\" content=\"".$SocialTitle."\">\n";
$MetaPropertyDescription = "	<meta property=\"og:description\" content=\"".$description."\">\n";
$MetaPropertyUrl = "	<meta property=\"og:url\" content=\"".$url."\">\n";
$MetaPropertyImage = "	<meta property=\"og:image\" content=\"[(site_url)][*$imageUrl*]\">\n";
$MetaPropertyFbApp = "	<meta property=\"fb:app_id\" content=\"".$OGfbappId."\">\n\n";

//*** Google Plus ***//
$GoogleDesc = "	<!-- Google Publisher. Profile url example: https://plus.google.com/1130658794498306186 
	=================================================== -->\n";
$linkPub = isset($linkPub) ? $linkPub : '';
$LinkPublisher = "	<link rel=\"publisher\" href=\"".$linkPub."\">\n\n";
$GAuthor = $modx->getTemplateVarOutput('GoogleAuthor',$id);
$GoogleAthorship = $GAuthor['GoogleAuthor'];
if(!$GoogleAthorship == ""){
$LinkAuthor = "	<link rel=\"author\" href=\"".$GoogleAthorship."\">\n\n";
}

//*** Canonical ***//
// Custom CanonicalUrl tv
// with tv empty > link to siteurl for homepage and to full alias url for other pages.

$CUrl = $modx->getTemplateVarOutput('CanonicalUrl',$id);
$CanonicalUrl = $CUrl['CanonicalUrl'];

if(!$CanonicalUrl == ""){
$Canonical = "	<link rel=\"canonical\" href=\"".$CanonicalUrl."\">\n\n";
} else {
	$Canonical = $modx->documentIdentifier == $modx->config['site_start'] ? "	<link rel=\"canonical\" href=\"[(site_url)]\" />" : "	<link rel=\"canonical\" href=\"[(site_url)][~[*id*]~]\">\n\n";
}

//*** GeoLocation ***//
$GeoMeta = "	<!-- GeoLocation Meta Tags / Geotagging. Used for custom results in Google. Generator here http://www.geo-tag.de/generator/en.html/ 
	=================================================== -->
	<meta name=\"geo.region\" content=\"".$Country."\" /> <!-- CountryCode-RegionalCode ex.: ES-TF -->
	<meta name=\"geo.placename\" content=\"".$City."\" /> <!-- City -->
	<meta name=\"geo.position\" content=\"".$LatLon."\" /> <!-- Lat/Lon -->
	<meta name=\"ICBM\" content=\"".$LatLon."\" /> <!-- Lat/Lon -->\n\n";

//*** Dublin Core ***//
$DCmeta = "	<!-- Dublin Core Metadata Element Set
	=================================================== -->
	<link rel=\"schema.DC\" href=\"http://purl.org/DC/elements/1.0/\" />
	<meta name=\"DC.Title\" content=\"".$SocialTitle."\" />
	<meta name=\"DC.Creator\" content=\"[(site_name)]\" />
	<meta name=\"DC.Type\" content=\"".$OGtype."\" />
	<meta name=\"DC.Date\" content=\"".$editedon."\" />
	<meta name=\"DC.Format\" content=\"text/html\" />
	<meta name=\"DC.Language\" content=\"".$dcLang."\" />\n\n";

//*** Favicons ***//
$Icons = "	<!-- Favicons. Generator here: http://www.favicon-generator.org/ 
	=================================================== -->
	<link rel=\"icon\" type=\"image/png\" sizes=\"36x36\" href=\"".$iconDir."android-icon-36x36.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"48x48\" href=\"".$iconDir."android-icon-48x48.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"72x72\" href=\"".$iconDir."android-icon-72x72.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"96x96\" href=\"".$iconDir."android-icon-96x96.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"144x144\" href=\"".$iconDir."android-icon-144x144.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"192x192\" href=\"".$iconDir."android-icon-192x192.png\">
	
	<link rel=\"apple-touch-icon\" sizes=\"192x192\" href=\"".$iconDir."apple-icon.png\">
	<link rel=\"apple-touch-icon\" sizes=\"57x57\" href=\"".$iconDir."apple-icon-57x57.png\">
	<link rel=\"apple-touch-icon\" sizes=\"60x60\" href=\"".$iconDir."apple-icon-60x60.png\">
	<link rel=\"apple-touch-icon\" sizes=\"72x72\" href=\"".$iconDir."apple-icon-72x72.png\">
	<link rel=\"apple-touch-icon\" sizes=\"76x76\" href=\"".$iconDir."apple-icon-76x76.png\">
	<link rel=\"apple-touch-icon\" sizes=\"114x114\" href=\"".$iconDir."apple-icon-114x114.png\">
	<link rel=\"apple-touch-icon\" sizes=\"120x120\" href=\"".$iconDir."apple-icon-120x120.png\">
	<link rel=\"apple-touch-icon\" sizes=\"144x144\" href=\"".$iconDir."apple-icon-144x144.png\">
	<link rel=\"apple-touch-icon\" sizes=\"152x152\" href=\"".$iconDir."apple-icon-152x152.png\">
	<link rel=\"apple-touch-icon\" sizes=\"180x180\" href=\"".$iconDir."apple-icon-180x180.png\">
	<link rel=\"apple-touch-icon\" sizes=\"192x192\" href=\"".$iconDir."apple-icon-precomposed.png\">
	
	<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"".$iconDir."favicon.ico\" />
	<link rel=\"icon\" type=\"image/png\" sizes=\"16x16\" href=\"".$iconDir."favicon-16x16.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"32x32\" href=\"".$iconDir."favicon-32x32.png\">
	<link rel=\"icon\" type=\"image/png\" sizes=\"96x96\" href=\"".$iconDir."favicon-96x96.png\">
	
	<meta name=\"msapplication-TileImage\" content=\"".$iconDir."ms-icon-70x70.png\">
	<meta name=\"msapplication-TileImage\" content=\"".$iconDir."ms-icon-144x144.png\">
	<meta name=\"msapplication-TileImage\" content=\"".$iconDir."ms-icon-150x150.png\">
	<meta name=\"msapplication-TileImage\" content=\"".$iconDir."ms-icon-310x310.png\">
	
	<meta name=\"msapplication-config\" content=\"".$iconDir."browserconfig.xml\" />
	<meta name=\"msapplication-TileColor\" content=\"#ffffff\">
	<link rel=\"manifest\" href=\"".$iconDir."manifest.json\">
	<meta name=\"theme-color\" content=\"#ffffff\">";

// *** RETURN RESULTS ***
// you can change the order of displayed items:
$output = $HeaderDesc.$MetaCharset.$BaseUrl.$HeaderExtra.$MetaTitle.$MetaKeywords.$MetaDesc.$MetaRobots.$MetaCopyright.$MetaEditedOn.$Canonical;
//return OpenGraph metatags if OpenGraph=1
if ($OpenGraph >= 1) {
    $output .= $FbDesc.$MetaProperty.$MetaPropertyType.$MetaPropertyTitle.$MetaPropertyDescription.$MetaPropertyUrl.$MetaPropertyImage.$MetaPropertyFbApp;
}
//return Google plus metatags if GooglePlus=1
if ($GooglePlus >= 1) {
    $output .= $GoogleDesc.$LinkAuthor.$LinkPublisher;
}
//return GeoLocation if GeoLocation=1
if ($GeoLocation >= 1) {
    $output .= $GeoMeta;
}
//return Dublin Core if DublinCore=1
if ($DublinCore >= 1) {
    $output .= $DCmeta;
}
//return Favicons if Favicons=1
if ($Favicons >= 1) {
    $output .= $Icons;
}

return $output;
