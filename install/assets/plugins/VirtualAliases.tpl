//<?
/**
 * VirtualAliases
 *
 * Allows for an unlimited number of custom aliases per page.
 *
 * @category plugin
 * @version 1.0
 * @author Nicola Lambathakis
 * @author Brian Stanback 
 * @internal @properties &aliasesTV=Aliases TV name;string;Aliases
 * @internal @events OnPageNotFound
 * @internal @modx_category Seo4Evo
 * @internal @installset base, sample
 */


$e = &$modx->event;

if ($e->name == "OnPageNotFound") {
   // Retrieve requested path + alias
   $documentAlias = str_replace($modx->config['friendly_url_suffix'], '', $_REQUEST['q']);

   // Search TVs for potential alias matches
   $sql = "SELECT tvc.contentid as id, tvc.value as value FROM " . $modx->getFullTableName('site_tmplvars') . " tv ";
   $sql .= "INNER JOIN " . $modx->getFullTableName('site_tmplvar_templates') . " tvtpl ON tvtpl.tmplvarid = tv.id ";
   $sql .= "LEFT JOIN " . $modx->getFullTableName('site_tmplvar_contentvalues') . " tvc ON tvc.tmplvarid = tv.id ";
   $sql .= "LEFT JOIN " . $modx->getFullTableName('site_content') . " sc ON sc.id = tvc.contentid ";
   $sql .= "WHERE sc.published = 1 AND tvtpl.templateid = sc.template AND tv.name = '$aliasesTV' AND tvc.value LIKE '%" . $modx->db->escape($documentAlias) . "%'";
   $results = $modx->dbQuery($sql);

   // Attempt to find an exact match
   while ($row = $modx->db->getRow($results)) {
      $pageAliases = explode("\n", $row["value"]);
      foreach ($pageAliases as $alias) {
         if (trim($alias) == $documentAlias) {
            // Redirect to new document, if an alias was found
            $found = $row["id"];
            if ($found) {
               if ($found == $modx->config['site_start']) {
                  $pageUrl = $modx->config['site_url'];
               } else {
                  $pageUrl = $modx->makeUrl($found, '', '', "full");
               }

               // Send a permanent redirect
               $modx->sendRedirect($pageUrl, 0, "REDIRECT_HEADER", "HTTP/1.1 301 Moved Permanently");
               exit();
            }
         }
      }
   }

   // If no exact match found, return 404
   header("HTTP/1.0 404 Not Found");
   header("Status: 404 Not Found");
}