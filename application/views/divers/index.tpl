{include file='header.tpl' title='Divers'}

{if $DISPATCHER.action eq 'edit'}
{include file='divers/diver.edit.tpl'}
{elseif $DISPATCHER.action eq 'show'}
{include file='divers/diver.show.tpl'}
{else}
{include file='divers/diver.list.tpl'}
{/if}
<div class="clear"></div>

{include file='footer.tpl'}
