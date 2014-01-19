{if $PAGENAV.totalItems > $PAGENAV.perpage}
{math equation="ceil(count / columns)+1" 
   count=$PAGENAV.totalItems 
   columns=$PAGENAV.perpage 
   assign="max"}

<ul class="navigation segmented">
{section name=foo start=1 loop=$max step=1}
	{if $smarty.section.foo.index==$PAGENAV.page}
		<li class="active selected"><a href="#" class="selected active">{$smarty.section.foo.index}</a></li>
	{else}
		<li><a href="{$PAGENAV.urlTemplate|replace:'|#|':$smarty.section.foo.index}">{$smarty.section.foo.index}</a></li>
	{/if}
{/section}
</ul>
{/if}