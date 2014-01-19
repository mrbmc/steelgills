{include file='admin/header.tpl'}

{if $USER.status eq 'admin'}
	{assign var=tpl value='admin/'}
	{assign var=tpl value=$tpl|cat:$DISPATCHER.action}
	{assign var=tpl value=$tpl|cat:'.tpl'}

	{if $DISPATCHER.action=='index'}
		Welcome back!
	{else}
		{include file=$tpl}
	{/if}
{else}
	You don't have permissions to access this area.
	{if $USER.userid <= 0}
		{include file='login_form.tpl'}
	{/if}
{/if}


{include file='admin/footer.tpl'}
