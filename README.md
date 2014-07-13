Seo4Evo
=======
### Seo4Evo RC 1.1

Collections of SEO Tools for MODx Evolution from various authors with a dedicated ManagerManager Tab

![seo tab](https://raw.githubusercontent.com/Nicola1971/Seo4Evo/master/seo4evo-RC1.1.jpg)

# This Package includes   

## Plugins:
* Virtual Alias: http://www.stanback.net/code/modx/virtual-aliases.html

## Snippets:
* Seo4Evo: Returns HTML meta tags for SEO4EVO Package (based on MetaTagsExtra by Soda http://modx.com/extras/package/metatagsextra) 
* Sitemap Snippet: http://modx.com/extras/package/sitemap
* DynamicDescription 1.0.0 http://modx.com/extras/package/dynamicdescription

## Chunks:
* mm demo rules SEO (sample code for ManagerManager plugin the Seo Tab)

## Tvs

* Aliases (301 redirect urls for Virtual Alias)
* CanonicalUrl 
* GoogleAuthor
* MetaDescription (metatag description)
* MetaKeywords (metatag keywords)
* CustomTitle (cmetatag title)
* RobotsFollow (setting for metatag robots)
* RobotsIndex (setting for metatag robots)
* sitemap_changefreq (setting for Sitemap Snippet)
* sitemap_exclude (setting for Sitemap Snippet)
* sitemap_priority (setting for Sitemap Snippet)

# Install

* With Package Manager

* set all Seo4Evo template variables  for access to you template
* copy the code from mm demo rules SEO in your default mm rules chunk

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
Add [[Seo4Evo]] after the opening <head> tag in your template

