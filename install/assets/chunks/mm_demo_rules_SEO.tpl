/**
 * mm_demo_rules_SEO
 *
 * example rules for SEO Tab
 *
 * @category	chunk
 * @internal @modx_category SEO
 */
// copy and paste in you ManageManeger rules chunk


//seo tab
mm_createTab('Seo','Seo', '', $news_tpl, '', '600');
mm_moveFieldsToTab('CustomTitle,Aliases,RobotsIndex,RobotsFollow,sitemap_exclude,sitemap_changefreq,sitemap_priority', 'Seo', '', $news_tpl);

