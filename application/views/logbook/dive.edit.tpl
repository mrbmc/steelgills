<div class="content">
	<h2>{if $DATA.dive.id <= 0}Add{else}Edit{/if} A Dive&nbsp;</h2>

{if $DATA.last_dive.diveid<=0}
<div class="module">
	<h3>Looks like you haven't logged any dives yet.</h3>
	<p>Let's record your first dive!</p>
	<p class="small"></p>
</div>
{/if}

	
	
	<form method="POST" action="/logbook/update/" name="myForm" id="myForm">
	<input type="hidden" name="diveid" value="{$DATA.dive.diveid}" />
	<input type="hidden" name="fk_userid" value="{if $DATA.dive.fk_userid}{$DATA.dive.fk_userid}{else}{$USER.userid}{/if}" />
	
	
	<ul class="navigation tabs"> 
		<li><a href="#GeneralInfo" id="tab1" title="GeneralInfo" class="tab selected">Basics</a></li> 
		<li><a href="#DiveProfile" id="tab2" title="DiveProfile" class="tab">Profile</a></li> 
		<li><a href="#Conditions" id="tab3" title="Conditions" class="tab">Conditions</a></li>	
		<li><a href="#Observations" id="tab4" title="Observations" class="tab">Observations</a></li>	
	</ul> 
	
	<div class="tab_area">
		<div><a name="GeneralInfo"></a>
			<fieldset>
				<h3>Dive Info</h3>
				<div class="control-group">
					<label for="Location">Location</label>
					<input type="text" id="location" class="text" class="text" name="location" value="{$DATA.dive.location}" style="width:200px;" tabindex="1" />
					<span class="status"></span>
					<input type="text" name="fk_divesiteid" value="{$DATA.dive.fk_divesiteid}" id="fk_divesiteid" />
				</div>
	
				<div class="control-group">
					<label>Date</label>
					<input type="text" name="date_start" id="datepicker" class="date-pick" value="{if $DATA.dive.time_start!=""}{$DATA.dive.time_start|date_format:"%D"}{else}{$smarty.now|date_format:"%D"}{/if}" tabindex="2" />
					<span class="status"></span>
				</div>
			</fieldset>
	
			<fieldset>
				<h3>Gear</h3>
				<div class="control-group">
					<div class="control-label"><label for="exposure">Exposure Protection</label></div>
					<div class="controls" id="exposureWrapper">
						
						{foreach from=$DATA.last_dive.exposures key=k item=row}
							{$dive = ($DATA.dive.diveid > 0) ? $DATA.dive : $DATA.last_dive}
							<a href="#" data-exposure="{$row}" class="exposure-item {if $dive.exposure|strpos:$row!==false}selected{/if}"><span class="sprite {$row}">{$row}</span></a>
						{/foreach}
						<input type="hidden" name="exposure" value="{$DATA.dive.exposure}" id="exposure" tabindex="3" />
					</div>
					<span class="status"></span>
				</div>
				<div class="control-group">
					<label for="weight">Weight</label>
					<span><input type="text" class="text" name="weight" id="weight" value="{if $DATA.dive.diveid > 0}{$DATA.dive.weight}{else}{$DATA.last_dive.weight}{/if}" style="width:25px;" maxlength="2" tabindex="4" />lbs</span>
					<span class="status"></span>
				</div>
			</fieldset>
		</div>
	
		<a name="DiveProfile"></a>
		<fieldset>
			<h3>Dive Profile</h3>
	
	
			{$dive = ($DATA.dive.diveid > 0) ? $DATA.dive : $DATA.last_dive}
			<div id="dive-profile">
				<div class="control-group" id="time-in-group">
					<div class="control-label">
						<label for="time_start">Time In</label>
					</div>
					<div class="controls">
						<input type="text" class="text" name="time_start" id="time_start" value="{$dive.time_start|date_format:"%H:%M"}" tabindex="10" />
						
					</div>
				</div>
				<div class="control-group" id="time-out-group">
					<div class="control-label">
						<label for="time_end">Time Out</label>
					</div>
					<div class="controls">
						<input type="text" class="text" name="time_end" id="time_end" value="{$dive.time_end|date_format:"%H:%M"}" tabindex="14" />
					</div>
				</div>
				<div class="control-group" id="bottom-time-group">
					<div class="control-label">
						<label for="bottom_time">Bottom Time</label>
					</div>
					<div class="controls">
						<input type="text" class="text" name="bottom_time" id="bottom_time" value="{$dive.bottom_time}" tabindex="12" />
					</div>
				</div>
				<div class="control-group" id="deco-time-group">
					<div class="control-label">
						<label for="deco_time">Deco Time</label>
					</div>
					<div class="controls">
						<input type="text" class="text" name="deco_time" id="deco_time" value="{$dive.deco_time}" tabindex="13" />
					</div>
				</div>
				<div class="control-group" id="max-depth-group">
					<div class="control-label">
						<label for="max-depth">Max Depth</label>
					</div>
					<div class="controls">
						<input type="text" class="text" name="max_depth" id="max_depth" value="{$dive.max_depth}" tabindex="11" />
					</div>
				</div>
				<div class="control-group" id="total-time-group">
					<label for="">Total Time: <span id="totaltime"></span></label>
				</div>
			</div>


			<div class="row-fluid">
				<div class="span6">
					<div class="control-group">
						<span class="sprite tank_full"></span>
						<div class="control-label">
							<label for="air_start">Air Start (psi)</label>
						</div>
						<div class="controls">
							<input type="text" class="text" name="air_start" id="air_start" value="{if $DATA.dive.air_start}{$DATA.dive.air_start}{else}3000{/if}" tabindex="20" />
							<span class="status"></span>
						</div>
					</div>
				</div>
				<div class="span6">
					<div class="control-group">
						<span class="sprite tank_empty"></span>
						<div class="control-label">
							<label for="air_end">Air End (psi)</label>
							
						</div>
						<div class="controls">
							<input type="text" class="text" name="air_end" id="air_end" value="{$DATA.dive.air_end}" tabindex="20" />
							<span class="status"></span>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
		
	
	
		<a name="Conditions"></a>
		<fieldset>
			<h3>Conditions</h3>
			<div class="row-fluid">
				<div class="span4">
					<div class="control-group">
						<div class="control-label">
							<label for="visibility">Visibility</label>
						</div>
						<div class="controls">
							<input type="text" class="text naked" name="visibility" id="visibility" value="{if $DATA.dive.visibility}{$DATA.dive.visibility}{else}100{/if}" tabindex="30" /> ft
							<div id="vis_slider"></div>
						</div>
					</div>
					<div class="control-group">
						<div class="control-label"><label for="current">Current</label></div>
						<div class="controls">
							<input type="text" class="text naked" name="current" id="current" value="{if $DATA.dive.current}{$DATA.dive.current}{else}0{/if}" tabindex="31" /> kts
							<div id="cur_slider"></div>
						</div>
						<span class="status"></span>
					</div>
				</div>
				<div class="span4">
					<div class="control-group">
						<label for="air_temperature">Air temperature</label>
						<span><input type="text" class="text" name="air_temperature" id="air_temperature" value="{$DATA.dive.air_temperature}" tabindex="32" /></span>
						<span class="status"></span>
					</div>
	
					<div class="control-group">
						<label for="wind_speed">Wind Speed</label>
						<span><input type="text" class="text" name="wind_speed" id="wind_speed" value="{$DATA.dive.wind_speed}" tabindex="33" /></span>
						<span class="status"></span>
					</div>
				</div>
				<div class="span4">
					<div class="control-group">
						<label for="temperature">Water Temperature</label>
						<span><input type="text" class="text" name="temperature" id="temperature" value="{$DATA.dive.temperature}" tabindex="34" /></span>
						<span class="status"></span>
					</div>
					<div class="control-group">
						<label for="wave_height">Wave Height</label>
						<span><input type="text" class="text" name="wave_height" id="wave_height" value="{$DATA.dive.wave_height}" tabindex="35" /></span>
						<span class="status"></span>
					</div>
				</div>
			</div>
		</fieldset>
	
	
		<div><a name="Observations"></a>
			<fieldset>
			<h3>Observations</h3>
			<div class="control-group">
				<!-- <div class="control-label"><label for="description">Notes</label></div> -->
				<div class="controls">
					<textarea name="description" class="input-block-level" id="description" cols="40" rows="6" tabindex="40">{$DATA.dive.description}</textarea>
					<span class="status"></span>
				</div>
			</div>
			</fieldset>
		</div>
	
		<div align="center">
			<input type="submit" value="save" class="btn btn-primary" />
			<a href="#" value="revert" onclick="document.location.href='';">revert</a>
		</div>
	
	</div><!-- /tab-area -->

</div><!--/content-->

</form>
{literal}
<style type="text/css">
#demo-frame > div.demo { padding: 10px !important; }
input.text {
width: 80px;
}
</style>
<script type="text/javascript">/*<![CDATA[*/
if(typeof SG == 'undefined') var SG = {};
var divesites = [{/literal}{foreach from=$DATA.divesites key=k item=row}"{$row->title}|{$row->divesiteid}",{/foreach}{literal}"dummy"];
var divesites = {/literal}{$DATA.divesites|@json_encode}{literal};

var exposure = new Array('{/literal}{$DATA.dive.exposure|replace:',':"','"}{literal}');
var Dive = {
	visibility: {/literal}{if $DATA.dive.visibility}{$DATA.dive.visibility}{else}100{/if}{literal},
	current: {/literal}{if $DATA.dive.current}{$DATA.dive.current}{else}0{/if}{literal}
}

/*]]>*/</script>
{/literal}
{include file='footer.tpl' module_js="app/logbook.edit"}
