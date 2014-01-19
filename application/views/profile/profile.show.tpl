{include file='header.tpl' title='Member Profile'}
<h2>{if $DATA.member.username}{$DATA.member.username}{else}Member Profile{/if}</h2>

{if $DATA.member.userid==$USER.userid || $USER.status=='admin'}
	<ul class="navigation segmented left" style="margin: 10px 0;">
{if $DATA.member.userid==$USER.userid}
<li><a href="/profile/edit" class="button">edit your profile</a></li>
{else}
<li><a href="/profile/edit/{$DATA.member.userid}" class="button">edit this profile</a></li>
{/if}
	</ul>
{/if}
<div class="clear"></div>

<fieldset>
	<dl>
		<dt>Dives logged</dt>
		<dd>{$DATA.member.diveslogged}</dd>

		{if $DATA.member.certification}<dt>Certification</dt>
		<dd>{$DATA.member.certification}</dd>{/if}

		<dt>Location</dt>
		<dd>{if $DATA.member.city}{$DATA.member.city}{/if} {if $DATA.member.country}{$DATA.member.country}{/if}</dd>

		<dt>Member Since</dt>
		<dd>{$DATA.member.created_at|date_format:"%B %e, %Y"}</dd>
	</dl>
</fieldset>


<h3>Recent Dives</h3>
{include file="logbook/dive.list.mini.tpl" dives=$DATA.member.dives}

<h3>Favorite Divesites</h3>
{include file="divesites/divesite.list.mini.tpl" divesites=$DATA.member.divesites}

{include file='footer.tpl'}
