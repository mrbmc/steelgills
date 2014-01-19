{include file='header.tpl' title='Member Profile'}

{if $DISPATCHER.action eq 'edit'}
{include file='profile/profile.edit.tpl' member=$DATA.member}
{else}
{include file='profile/profile.show.tpl' member=$DATA.member}
{/if}

{include file='footer.tpl'}
