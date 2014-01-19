<div id="content">

	<ul class="navigation segmented left" style="margin-right: 10px;">
		<li><a href="/divesites/edit">add a dive site</a></li>
		{if $USER.userid > 0}
		<li><a href="/divesites/all">everyone's sites</a></li>
		<li><a href="/divesites/me">my sites</a></li>
		{/if}
	</ul>
		
	<div class="clear"></div>
	
<table class="list">
<thead>
<tr>
	<th><a href="?sort=name">Name</a></th>
	<th><a href="?sort=date">Date</a></th>
	<th>&nbsp;</th>
</tr>
</thead>
<tbody>
{foreach from=$DATA.divers key=k item=row}
{strip}
<tr style="background:{cycle values="#eeeeee,#dddddd"};">
	<td><a href="/divers/show/{$row->userid|md5}">{$row->first_name} {$row->last_name|substr:0:1}</a></td>
	<td>{$row->time_start|date_format:"%b %e, %Y"}</td>
	{if $user.status=='admin'}<td><small><a href="/logbook/edit/{$row->diveid}">edit</a></small></td>{/if}
</tr>
{/strip}
{/foreach}
</tbody>
</table>


	{include file='pagenav.tpl' PAGENAV=$DATA.pagenav}
	
</div><!-- content -->
<div class="clear"></div>
