Seo4Evo
=======

Collections of SEO Tools for MODx Evolution with a dedicated Manager Tab

![seo tab](https://raw.githubusercontent.com/Nicola1971/Seo4Evo/master/seo4evo.jpg)

This Package includes   

## Plugins:
* Virtual Alias

## Snippets:
* Sitemap Snippet

## Chunks:
* mm demo rules SEO (example for manager Manager)

## Tvs

* Aliases
* CustomTitle (custom title for metatag title)
* RobotsFollow (for metatag robots)
* RobotsIndex (for metatag robots)
* sitemap_changefreq (for Sitemap Snippet)
* sitemap_exclude (for Sitemap Snippet)
* sitemap_priority (for Sitemap Snippet)

## Install

With Package Manager

# Usage
## Sitemap
Create a modx document named sitemap with doc type xml 
and add
``````[!SiteMap? &amp;format=`sp`  &excludeTemplates=`blank` &excludeTV=`sitemap_exclude` &priority=`sitemap_priority` &changefreq=`sitemap_changefreq` &excludeWeblinks=`true`!]``````
###### see: http://wiki.modxcms.com/index.php/SiteMap:_Google_sitemaps_in_MODx
## MetaTags

### Title

`<title>[*CustomTitle*]</title> ` 
### Robots
` <meta name="robots" content="[*RobotsIndex*], [*RobotsFollow*]" />`


#SEO TAB

Copy the code from the sample mm rules chunk in your default Manager manager chunk
