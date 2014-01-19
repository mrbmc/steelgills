<h2>{if $DATA.dive.title!=''}{$DATA.dive.title}{else}{$DATA.dive.location}{/if}</h2>
	<ul class="navigation segmented left" style="margin: 10px 0;">
		<li><a href="/logbook/edit" class="">Add a New Dive</a></li>
		{if $DATA.user.id eq $DATA.dive.fk_userid || $DATA.user.status eq 'admin'}
		<li><a href="/logbook/edit/{$DATA.dive.diveid}">Edit This dive</a></li>
		{/if}
	{*	<li><a href="/logbook/print/{$DATA.dive.diveid}">Print</a></li>
		<li><a href="/logbook/send/{$DATA.dive.diveid}">Email</a></li>
		<li><a href="/logbook/share/{$DATA.dive.diveid}">Share</a></li>*}
		<li><iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2F{$smarty.server.HTTP_HOST|urlencode}%2Flogbook%2F{$DATA.dive.diveid}&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;font=arial&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:visible; width:300px;height:50px;padding:0;margin:0;" allowTransparency="true"></iframe></li>
	</ul>
<div id="content">
<div class="block">
		<strong>location:</strong>
		<a href="/divesites/show/{$DATA.dive.fk_divesiteid}">{$DATA.dive.location}</a><br />
		
		<strong>date:</strong>
		{$DATA.dive.time_start|date_format:"%B %e, %Y"}<br />

	<div class="clear"></div>
	{if $DATA.dive.description!=""}{$DATA.dive.description|nl2br}{/if}
</div>

<div class="block">
	<h3>Dive Profile</h3>
	<table width="600" class="profile">
	<tr>
		<td width="15%"><b>{$DATA.dive.time_start|date_format:"%H:%M"}</b><br />Time In</td>
		<td width="25%"></td>
		<td width="20%"></td>
		<td width="25%"></td>
		<td width="15%" align="right"><b>{$DATA.dive.time_end|date_format:"%H:%M"}</b><br />Time Out</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td><b>{$DATA.dive.deco_time}</b><br />Decomp. Stop</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td><b>{$DATA.dive.max_depth}</b><br />Max Depth</b></td>
		<td><b>{$DATA.dive.bottom_time}</b><br />Bottom Time</b></td>
		<td></td>
		<td><b>{$DATA.dive.total_time}</b><br />Total Time</b></td>
	</tr>
	</table>
</div>



<div class="block">
	<h3>Weight</h3>
	<p>{$DATA.dive.weight} lbs</p>
	
	<h3>Exposure Protection</h3>
	<p>
	{assign var="exposureArray" value=","|explode:$DATA.dive.exposure}
	{foreach from=$exposureArray key=k item=row}
		{if $row!=""}<div class="left"><span class="sprite {$row}" style="float:none;">{$row}</span>{$row}</div>{/if}
	{/foreach}
		<div class="clear"></div>
	</p>

	<h3>Air Start /  Finish</h3>
	<p>{$DATA.dive.air_start} / {$DATA.dive.air_end} psi</p>

	<h3>Water Conditions</h3>
	<dl>
		<dt>Temperature</dt>
			<dd>{$DATA.dive.temperature}</dd>
		<dt>Visibility</dt>
			<dd>{$DATA.dive.visibility}</dd>
		<dt>Current</dt>
			<dd>{$DATA.dive.current}</dd>
	</dl>

	<h3>Surface Conditions</h3>
	<dl>
		<dt>Air Temperature</dt>
			<dd>{$DATA.dive.air_temperature}</dd>
		<dt>Water Conditions</dt>
			<dd>{$DATA.dive.wave_height}</dd>
		<dt>Wind Speed</dt>
			<dd>{$DATA.dive.wind_speed}</dd>
	</dl>
</div>


</div>

