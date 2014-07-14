Seo4Evo
=======
### Seo4Evo RC 2.0

Collections of SEO Tools for MODx Evolution from various authors with a dedicated ManagerManager Tab

![seo tab](https://raw.githubusercontent.com/Nicola1971/Seo4Evo/master/seo4evo-RC2.jpg)

# This Package includes   

## Plugins:
* **Virtual Alias**: http://www.stanback.net/code/modx/virtual-aliases.html

## Snippets:
* **Seo4Evo**: Returns HTML meta tags for SEO4EVO Package 
* **Sitemap Snippet**: http://modx.com/extras/package/sitemap
* **DynamicDescription** http://modx.com/extras/package/dynamicdescription

## Chunks:
* **mm demo rules SEO** (sample code for ManagerManager plugin the Seo Tab)

## Tvs

* **Aliases** (301 redirect urls for Virtual Alias)
* **CanonicalUrl** 
* **GoogleAuthor**
* **MetaDescription** (metatag description)
* **MetaKeywords** (metatag keywords)
* **CustomTitle** (cmetatag title)
* **RobotsFollow** (setting for metatag robots)
* **RobotsIndex** (setting for metatag robots)
* **sitemap_changefreq** (setting for Sitemap Snippet)
* **sitemap_exclude** (setting for Sitemap Snippet)
* **sitemap_priority** (setting for Sitemap Snippet)

# Install

* With **Package Managerv

* set all **Seo4Evo template variables**  for access to you template
* copy the code from **mm demo rules SEO** in your default mm rules chunk

# Create a sitemap page
### Create a new resource :

* title: sitemap
* URL alias: sitemap.xml
* Show in menu : no 
* Published: yes
* Internet Media Type: text/xml
* Rich text: no
* Resource content: ``````[!SiteMap? &amp;format=`sp`  &excludeTemplates=`blank` &excludeTV=`sitemap_exclude` &priority=`sitemap_priority` &changefreq=`sitemap_changefreq` &excludeWeblinks=`true`!]``````
###### see: http://wiki.modxcms.com/index.php/SiteMap:_Google_sitemaps_in_MODx


# Snippet Call

* Add Seo4Evo snippet call after the opening <head> tag in your template

###Basic call - only site metatags
`[[Seo4Evo]]`

###With Facebook Open Graph metatags
```[[Seo4Evo? &OpenGraph=`1` &OGfbappId=`123456789123456789` &OGimageTv=`my-thumbnail` &OGtype=`article`]]```

###With Facebook Open Graph e Google plus metatags
```[[Seo4Evo? &OpenGraph=`1` &OGfbappId=`123456789123456789` &OGimageTv=`my-thumbnail` &OGtype=`article` &GooglePlus=`1` &linkPub=`https://plus.google.com/123456789123456789`]]```


## Snippet Call Parameters:

### Facebook Open Graph Protocol Parameters

* **OpenGraph** - 1= enable OG metatags
* **OGfbappId** - your facebook app id
* **OGimageTv** - image tv for your shared post on facebook default tv: thumbnail 
* **OGtype** - default: website (more infos: https://developers.facebook.com/docs/reference/opengraph)

### Google Plus Parameters

* **GooglePlus** -  1= enable G+ metatags
* **linkPub** - the "brand" google publisher page


# On page settings (tvs)

#### Seo4Evo Snippet tvs:
* **linkAuth** - your google author page
* **CustomTitle** - Seo Custom Title for metatag title - Default value is [*pagetitle*]
* **Meta Keywords** - Meta Keywords - comma separated keywords
* **CanonicalUrl** - Custom CanonicalUrl - If Empty full alias for pages or domain url for homepage - works like using if snippet :
<link rel="canonical" href="[[if? &is=`[*id*]:is:1` &then=`[(site_url)]` &else=`[(site_url)][~[*id*]~]`]]" />
* **301 Redirects** - Add old url - Url redirect using Virtual Alias Plugin.
http://www.stanback.net/code/modx/virtual-aliases.html 
New aliases should each be added on a **separate line**. Omit any leading or trailing slashes as well as the default suffix (usaully .html) 
* **Author** -  Google plus author page URL (if empty does not diesplay the tag)
* **Meta Description** - If Empty get the first 25 words from content (via $modx->runSnippet **DynamicDescription Snippet**)


#### SiteMap Snippet tvs:
* **Robots Index this Page** - Include or exclude the page in Search Engines
* **Robots - Following Links** - Follow or noFollow links on the page
* **Sitemap exclude** - Include or exclude the page in Google SiteMap
* **Sitemap update frequency** - How often the content will be changed
* **Sitemap Priority** - Importance of the page

 


