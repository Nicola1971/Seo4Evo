/**
 * mm_demo_rules_SEO
 *
 * example rules for SEO Tab
 *
 * @category	chunk
 * @internal @modx_category Seo4Evo
 */
// copy and paste in you ManageManeger rules chunk


//seo tab
mm_createTab('Seo','Seo', '', $news_tpl, '', '600');
mm_moveFieldsToTab('CustomTitle,MetaDescription,MetaKeywords,CanonicalUrl,Aliases,GoogleAuthor,RobotsIndex,RobotsFollow,sitemap_exclude,sitemap_changefreq,sitemap_priority', 'Seo', '', $news_tpl);
if ($modx->db->getValue($modx->db->select('count(id)', $modx->getFullTableName('site_tmplvars'), "name='MetaKeywords'"))) {
	mm_widget_tags('MetaKeywords',',');
}