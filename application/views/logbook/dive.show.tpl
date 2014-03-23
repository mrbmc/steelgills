<div class="dive-detail">
	<div class="card">
		<div class="row">
			<div class="span4">
				<dl>
					<dt>Date</dt>
					<dd>{$DATA.dive.time_start|date_format:"%B %e, %Y"}</dd>
				</dl>
			</div>
			<div class="span4">
				<dl>
					<dt>Location</dt>
					<dd>
						{if $DATA.dive.fk_divesiteid>0}<a href="/divesites/show/{$DATA.dive.fk_divesiteid}">{/if}
						{$DATA.dive.location}
						{if $DATA.dive.fk_divesiteid>0}</a>{/if}
					</dd>
				</dl>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				{if $DATA.dive.description!=""}{$DATA.dive.description|nl2br}{/if}
			</div>
<!-- 			<div class="span4">
				{if $DATA.user.id eq $DATA.dive.fk_userid || $DATA.user.status eq 'admin'}
					<a href="/logbook/edit/{$DATA.dive.diveid}">Edit This dive</a>
					{/if}
			</div> -->
		</div>
		
	</div>


	<div class="row">
		<div class="span6">
			
			<h3>Kit</h3>
			<dl>
				<dt>Weight</dt>
				<dd>{$DATA.dive.weight} lbs</dd>
				
				<dt>Exposure Protection</dt>
				<dd>
				{assign var="exposureArray" value=","|explode:$DATA.dive.exposure}
				{foreach from=$exposureArray key=k item=row}
					{if $row!=""}
					<div class=""><span class="sprite {$row}" style="float:none;">{$row}</span>{$row}</div>
					{/if}
				{/foreach}
				</dd>

				<dt>Air Start /  Finish</dt>
				<dd>{$DATA.dive.air_start} / {$DATA.dive.air_end} psi</dd>

			</dl>
		</div>
		<div class="span6">
			
			<h3>Water Conditions</h3>
			<dl class="table">
				<dt>Temperature</dt>
					<dd>{$DATA.dive.temperature}</dd>
				<dt>Visibility</dt>
					<dd>{$DATA.dive.visibility}</dd>
				<dt>Current</dt>
					<dd>{$DATA.dive.current}</dd>
			</dl>

			<h3>Surface Conditions</h3>
			<dl class="table">
				<dt>Air Temperature</dt>
					<dd>{$DATA.dive.air_temperature}</dd>
				<dt>Water Conditions</dt>
					<dd>{$DATA.dive.wave_height}</dd>
				<dt>Wind Speed</dt>
					<dd>{$DATA.dive.wind_speed}</dd>
			</dl>
		</div>

	</div>



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

</div>

{include file='footer.tpl' module_js="app/dive"}
