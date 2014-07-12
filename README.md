Seo4Evo
=======
### Seo4Evo RC 1.1

Collections of SEO Tools for MODx Evolution with a dedicated Manager Tab

![seo tab](https://raw.githubusercontent.com/Nicola1971/Seo4Evo/master/seo4evo-RC1.1.jpg)

This Package includes   

## Plugins:
* Virtual Alias: http://www.stanback.net/code/modx/virtual-aliases.html

## Snippets:
* Sitemap Snippet: http://modx.com/extras/package/sitemap
* DynamicDescription 1.0.0 http://modx.com/extras/package/dynamicdescription

## Chunks:
* mm demo rules SEO (sample code for ManagerManager plugin the Seo Tab)

## Tvs

* Aliases (301 redirect urls for Virtual Alias)
* MetaDescription (metatag description)
* MetaKeywords (metatag keywords)
* CustomTitle (cmetatag title)
* RobotsFollow (setting for metatag robots)
* RobotsIndex (setting for metatag robots)
* sitemap_changefreq (setting for Sitemap Snippet)
* sitemap_exclude (setting for Sitemap Snippet)
* sitemap_priority (setting for Sitemap Snippet)

## Install

With Package Manager

# Usage
## Sitemap
Create a modx document named sitemap with doc type xml 
and add
``````[!SiteMap? &amp;format=`sp`  &excludeTemplates=`blank` &excludeTV=`sitemap_exclude` &priority=`sitemap_priority` &changefreq=`sitemap_changefreq` &excludeWeblinks=`true`!]``````
###### see: http://wiki.modxcms.com/index.php/SiteMap:_Google_sitemaps_in_MODx
## MetaTags

### Meta Title
`<title>[*CustomTitle*]</title> ` 

### Meta Description

<meta name="description" content="[[DynamicDescription? &descriptionTV=`MetaDescription` &maxWordCount=`70`]]">

### Meta Keywords
<meta name="keywords" content="[*MetaKeywords*]">

### Robots
` <meta name="robots" content="[*RobotsIndex*], [*RobotsFollow*]" />`


#SEO TAB

Copy the code from the sample mm rules chunk in your default Manager manager chunk
