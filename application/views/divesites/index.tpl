{include file='header.tpl' title='Dive Sites'}

{if $DISPATCHER.action eq 'edit'}
{include file='divesites/divesite.edit.tpl'}
{elseif $DISPATCHER.action eq 'show'}
{include file='divesites/divesite.show.tpl'}
{else}
{include file='divesites/divesite.list.tpl'}
{/if}