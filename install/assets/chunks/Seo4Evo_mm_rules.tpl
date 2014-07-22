/**
 * Seo4Evo_mm_rules
 *
 * Seo4Evo example rules for ManagerManager SEO Tab
 *
 * @category	chunk
 * @internal @modx_category Seo4Evo
 * @author      Author: Nicola71 http://www.tattoocms.it/
 */
// copy and paste in you ManageManeger rules chunk


//seo tab
mm_createTab('Seo','Seo', '', $news_tpl, '', '600');
mm_moveFieldsToTab('CustomTitle,MetaDescription,MetaKeywords,CanonicalUrl,Aliases,GoogleAuthor,RobotsIndex,RobotsFollow,sitemap_exclude,sitemap_changefreq,sitemap_priority', 'Seo', '', $news_tpl);
if ($modx->db->getValue($modx->db->select('count(id)', $modx->getFullTableName('site_tmplvars'), "name='MetaKeywords'"))) {
	mm_widget_tags('MetaKeywords',',');
}
mm_ddMaxLength('MetaDescription', '', '', 350);
mm_ddMaxLength('CustomTitle', '', '', 70);