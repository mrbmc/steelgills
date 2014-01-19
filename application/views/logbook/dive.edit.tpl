<div class="content">
	<h2>{if $DATA.dive.id <= 0}Add{else}Edit{/if} A Dive&nbsp;</h2>

{if $DATA.last_dive.diveid<=0}
<div class="module">
	<h3>Looks like you haven't logged any dives yet.</h3>
	<p>Let's record your first dive!</p>
	<p class="small"></p>
</div>
{/if}

	
	
	<form method="POST" action="/logbook/update/" name="myForm" id="myForm" style="width: 640px;">
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
				<legend>Dive Info</legend>
				<div>
					<label for="Location">Location</label>
					<span><input type="text" id="location" class="text" class="text" name="location" value="{$DATA.dive.location}" style="width:200px;" /></span>
					<span class="status"></span>
					<input type="hidden" name="fk_divesiteid" value="{$DATA.dive.fk_divesiteid}" id="fk_divesiteid" />
				</div>
	
				<div>
					<label>Date</label>
					<input type="text" name="date_start" id="datepicker" class="date-pick" value="{if $DATA.dive.time_start!=""}{$DATA.dive.time_start|date_format:"%D"}{else}{$smarty.now|date_format:"%D"}{/if}" />
					<span class="status"></span>
				</div>
			</fieldset>
	
			<fieldset>
				<legend>Gear</legend>
				<div class="left">
					<label for="exposure">Exposure Protection</label>
					<div id="exposureWrapper">
						
						{foreach from=$DATA.last_dive.exposures key=k item=row}
							{if $DATA.dive.diveid > 0}
							<a href="#" onclick="exposureSelect($(this));return false;" rel="{$row}" class="{if $DATA.dive.exposure|strpos:$row!==false}selected{/if}"><span class="sprite {$row}">{$row}</span></a>
							{else}
							<a href="#" onclick="exposureSelect($(this));return false;" rel="{$row}" class="{if $DATA.last_dive.exposure|strpos:$row!==false}selected{/if}"><span class="sprite {$row}">{$row}</span></a>
							{/if}
						{/foreach}
						<input type="hidden" name="exposure" value="{$DATA.dive.exposure}" id="exposure" />
					</div>
					<span></span>
					<span class="status"></span>
				</div>
				<div class="left">
					<label for="weight">Weight</label>
					<span><input type="text" class="text" name="weight" id="weight" value="{if $DATA.dive.diveid > 0}{$DATA.dive.weight}{else}{$DATA.last_dive.weight}{/if}" style="width:25px;" maxlength="2" />lbs</span>
					<span class="status"></span>
				</div>
			</fieldset>
		</div>
	
		<div><a name="DiveProfile"></a>
			<fieldset>
			<legend>Dive Profile</legend>
	
	
			<table width="600" class="profile">
			<tr>
				<td width="15%">
					{if $DATA.dive.diveid > 0}
					<span><input type="text" class="text" name="time_start" id="time_start" value="{$DATA.dive.time_start|date_format:"%H:%M"}" /></span>
					{else}
					<span><input type="text" class="text" name="time_start" id="time_start" value="{$DATA.last_dive.time_end|date_format:"%H:%M"}" /></span>
					{/if}
					<span class="status"></span>
					<br />Time In</td>
				<td width="25%"></td>
				<td width="20%"></td>
				<td width="25%"></td>
				<td width="15%" align="right">
					{if $DATA.dive.diveid > 0}
					<span><input type="text" class="text" name="time_end" id="time_end" value="{$DATA.dive.time_end|date_format:"%H:%M"}" /></span>
					{else}
					<span><input type="text" class="text" name="time_end" id="time_end" value="{$DATA.last_dive.time_end|date_format:"%H:%M"}" /></span>
					{/if}
					<span class="status"></span>
					<br />Time Out</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<span><input type="text" class="text" name="deco_time" id="deco_time" value="{$DATA.dive.deco_time}" /></span>
					<span class="status"></span>
					<br />Decomp. Stop</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span><input type="text" class="text" name="max_depth" id="max_depth" value="{$DATA.dive.max_depth}" /></span>
					<span class="status"></span>
					<br />Max Depth
				</td>
				<td>
					<span><input type="text" class="text" name="bottom_time" id="bottom_time" value="{$DATA.dive.bottom_time}" /></span>
					<span class="status"></span>
					<br />Bottom Time</td>
				<td></td>
				<td><b id="totaltime"><br />Total Time</b></td>
			</tr>
			</table>
			</fieldset>
	
	
			<fieldset>
			<legend>Air Consumption</legend>
			<div class="left">
				<span class="sprite tank_full"></span>
				<label for="air_start">Air Start (psi)</label>
				<span><input type="text" class="text" name="air_start" id="air_start" value="{if $DATA.dive.air_start}{$DATA.dive.air_start}{else}3000{/if}" /></span>
				<span class="status"></span>
			</div>
			<div class="left">
				<span class="sprite tank_empty"></span>
				<label for="air_end">Air End (psi)</label>
				<span><input type="text" class="text" name="air_end" id="air_end" value="{$DATA.dive.air_end}" /></span>
				<span class="status"></span>
			</div>
			</fieldset>
		</div>
	
	
		<div><a name="Conditions"></a>
			<fieldset>
			<legend>Conditions</legend>
			<div class="left">
				<label for="visibility">Visibility: <input type="text" class="text naked" name="visibility" id="visibility" value="{if $DATA.dive.visibility}{$DATA.dive.visibility}{else}100{/if}" /> ft</label>
				<div id="vis_slider" style="width:200px;"></div>
				
	
				<label for="current">Current: <input type="text" class="text naked" name="current" id="current" value="{if $DATA.dive.current}{$DATA.dive.current}{else}0{/if}" /> kts</label>
				<div id="cur_slider" style="width:200px;"></div>
				<span class="status"></span>
			</div>
			<div class="left" style="width:30em;">
				<div style="background:#FFF;margin:0;padding: 0 0.25em;">
					<div class="left">
					<label for="air_temperature">Air temperature</label>
					<span><input type="text" class="text" name="air_temperature" id="air_temperature" value="{$DATA.dive.air_temperature}" /></span>
					<span class="status"></span>
					</div>
	
					<div class="left">
					<label for="wind_speed">Wind Speed</label>
					<span><input type="text" class="text" name="wind_speed" id="wind_speed" value="{$DATA.dive.wind_speed}" /></span>
					<span class="status"></span>
					</div>
					<div class="clear"></div>
				</div>
				<div style="background:url(/images/sprites.gif) no-repeat 0px -120px;height: 20px;"></div>
				<div>
					<div class="left">
						<label for="temperature">Water Temperature</label>
						<span><input type="text" class="text" name="temperature" id="temperature" value="{$DATA.dive.temperature}" /></span>
						<span class="status"></span>
					</div>
					<div class="left">
						<label for="wave_height">Wave Height</label>
						<span><input type="text" class="text" name="wave_height" id="wave_height" value="{$DATA.dive.wave_height}" /></span>
						<span class="status"></span>
					</div>
				</div>
			</div>
			<div class="left">
	
			</div>
			</fieldset>
		</div>
	
	
		<div><a name="Observations"></a>
			<fieldset>
			<legend>Observations</legend>
			<div>
				<label for="description">Notes</label>
				<span><textarea name="description" id="description" cols="40" rows="6">{$DATA.dive.description}</textarea></span>
				<span class="status"></span>
			</div>
			</fieldset>
		</div>
	
		<div align="center">
			<input type="submit" value="save" class="button" />
			<input type="button" value="revert" onclick="document.location.href='';" class="button"/>
		</div>
	
	</div><!-- /tab-area -->

</div><!--/content-->

</form>
{literal}
<link type="text/css" href="/css/redmond/jquery-ui-1.7.3.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.autocomplete.js"></script>
<style type="text/css">
#demo-frame > div.demo { padding: 10px !important; }
input.text {
width: 80px;
}
</style>
<script type="text/javascript">/*<![CDATA[*/
divesites=[{/literal}{foreach from=$DATA.divesites key=k item=row}"{$row->title}|{$row->divesiteid}",{/foreach}{literal}"dummy"];
$(function(){
	$("#location").autocompleteArray(divesites,{
		maxItems:10,
		onItemSelect:function(li){
			$('#location').val($(li).text());
			$('#fk_divesiteid').val(li.extra[0]);
			console.log("selected:" + li.extra[0]);
		}
	});
	$("#datepicker").datepicker({
		showOn: 'button',
		buttonImage: '/images/calendar.gif',
		buttonImageOnly: true,
	});
	$('#vis_slider').slider({
			value:{/literal}{if $DATA.dive.visibility}{$DATA.dive.visibility}{else}100{/if}{literal},
			range: "max",
			min: 0,
			max: 500,
			step: 5,
			slide: function(event, ui) {
				$('#visibility').val(ui.value);
			}
	});
	$('#cur_slider').slider({
			value:{/literal}{if $DATA.dive.current}{$DATA.dive.current}{else}0{/if}{literal},
			range: "max",
			min: 0,
			max: 10,
			step: 0.25,
			slide: function(event, ui) {
				$('#current').val(ui.value);
			}
	});

	updateTime();
	$('#time_start').change(updateTime);
	$('#time_end').change(updateTime);
});

function updateTime () {
		begin = $('#time_start').val().split(":");
		end = $('#time_end').val().split(":");
		hrs = end[0]-begin[0];
		min = (end[1]-begin[1])+"";
		if(min.length==1)
			min = "0"+min;
		duration = hrs+":"+min;
		$('#totaltime').html(duration);
}
var exposure = new Array('{/literal}{$DATA.dive.exposure|replace:',':"','"}{literal}');
function exposureSelect(obj) {
	var val = obj.attr('rel');
	var idx = exposure.contains(val);
	if(idx===false) {
		exposure.push(val);
		obj.addClass('selected');
	} else {
		exposure.splice(idx,1);
		obj.removeClass('selected');
	}
	$('#exposure').val(exposure);
}

/*]]>*/</script>
{/literal}
