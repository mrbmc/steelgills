<h2>{if $DATA.dive.title!=''}{$DATA.dive.title}{else}{$DATA.dive.location}{/if}</h2>
<ul class="navigation segmented left" style="margin: 10px 0;">
	{if $DATA.user.id eq $DATA.dive.fk_userid || $DATA.user.status eq 'admin'}
	<li><a href="/logbook/edit/{$DATA.dive.diveid}">Edit This dive</a></li>
	{/if}
	{*<li><a href="/logbook/print/{$DATA.dive.diveid}">Print</a></li>
	<li><a href="/logbook/send/{$DATA.dive.diveid}">Email</a></li>
	<li><a href="/logbook/share/{$DATA.dive.diveid}">Share</a></li>*}
	<li><iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2F{$smarty.server.HTTP_HOST|urlencode}%2Flogbook%2F{$DATA.dive.diveid}&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;font=arial&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:visible; width:300px;height:50px;padding:0;margin:0;" allowTransparency="true"></iframe></li>
</ul>
<div class="dive-detail">
	<dl class="table">
		<dt>Date</dt>
		<dd><a href="/divesites/show/{$DATA.dive.fk_divesiteid}">{$DATA.dive.location}</a></dd>
		<dt>Location</dt>
		<dd>{$DATA.dive.time_start|date_format:"%B %e, %Y"}</dd>
		<dt>Description</dt>
		<dd>{if $DATA.dive.description!=""}{$DATA.dive.description|nl2br}{/if}</dd>
	</dl>




	<div class="dive-profile">
		<div class="control-group" id="time-in-group">
			<div class="control-label">
				<label for="time_start">Time In</label>
			</div>
			<div class="controls">
				{$DATA.dive.time_start|date_format:"%H:%M"}
			</div>
		</div>
		<div class="control-group" id="time-out-group">
			<div class="control-label">
				<label for="time_end">Time Out</label>
			</div>
			<div class="controls">
				{$DATA.dive.time_end|date_format:"%H:%M"}
			</div>
		</div>
		<div class="control-group" id="bottom-time-group">
			<div class="control-label">
				<label for="bottom_time">Bottom Time</label>
			</div>
			<div class="controls">
				{$DATA.dive.bottom_time}
			</div>
		</div>
		<div class="control-group" id="deco-time-group">
			<div class="control-label">
				<label for="deco_time">Deco Time</label>
			</div>
			<div class="controls">
				{$DATA.dive.deco_time}
			</div>
		</div>
		<div class="control-group" id="max-depth-group">
			<div class="control-label">
				<label for="max-depth">Max Depth</label>
			</div>
			<div class="controls">
				{$DATA.dive.max_depth}
			</div>
		</div>
		<div class="control-group" id="total-time-group">
			<label for="">Total Time: <span id="totaltime"></span></label>
		</div>
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

{include file='footer.tpl' module_js="app/dive"}
