{include file='header.tpl' title=$DATA.title}

{if $DISPATCHER.action eq 'edit'}
{include file='logbook/dive.edit.tpl'}
{elseif $DISPATCHER.action eq 'add'}
{include file='logbook/dive.edit.tpl'}
{elseif $DISPATCHER.action eq 'show'}
{include file='logbook/dive.show.tpl'}
{else}
{include file='logbook/dive.list.tpl'}
{/if}

{include file='footer.tpl'}