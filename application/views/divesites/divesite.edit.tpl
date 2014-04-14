{include file='header.tpl' title='Dive Sites'}

<h2>{if $DATA.divesite.divesiteid>0}Edit{else}Add{/if} a divesite</h2>
<form method="POST" action="/divesites/update/" name="myForm" id="myForm">
<input type="hidden" id="divesiteid" name="divesiteid" value="{$DATA.divesite.divesiteid}" />

<fieldset>
	<h3>Divesite Info</h3>
	<div class="control-group">
		<label for="title">Name</label>
		<span><input type="text" class="text input-block-level" id="title" name="title" value="{$DATA.divesite.title}" /></span>
		<span class="status"></span>
	</div>
	<div class="control-group">
		<label for="description">Notes</label>
		<span><textarea name="description" id="description" class="input-block-level" cols="40" rows="6">{$DATA.divesite.description}</textarea></span>
		<span class="status"></span>
	</div>
	<div class="control-group">
		<label for="max_depth">Max Depth</label>
		<span><input type="text" class="text" id="max_depth" name="max_depth" value="{$DATA.divesite.max_depth}" /></span>
		<span class="status"></span>
	</div>
</fieldset>

<fieldset>
	<h3>Divesite Location</h3>
	<div>
		<label for="city"></label>
		<p>Type the name of the closest city and country and we'll try to find it on the map.</p>
	</div>

	<div class="row-fluid">
		
		<div class="span6">
			<div class="control-group">
				<label for="city">Nearest City</label>
				<span><input type="text" class="text long" id="city" name="city" value="{$DATA.divesite.city}" /></span>
				<span class="status"></span>
			</div>
		</div>

		{*<div>
			<div class="control-group">
				
				<label for="country">Country</label>
				<span><!--input type="text" class="text" id="country" name="country" value="{$DATA.divesite.country}" /-->
				{include file='country_selector.tpl'}
				</span>
				<span class="status"></span>
			</div>
		</div>*}

		<div class="span3">
			<div class="control-group">
				
				<label for="latitude">Latitude</label>
				<span><input type="text" class="text" id="latitude" name="latitude" value="{$DATA.divesite.latitude}" /></span>
				<span class="status"></span>
			</div>
		</div>
		<div class="span3">
			<div class="control-group">
				
				<label for="longitude">Longitude</label>
				<span><input type="text" class="text" id="longitude" name="longitude" value="{$DATA.divesite.longitude}" /></span>
				<span class="status"></span>
			</div>
		</div>
	</div>

	<p><strong>Tip:</strong> You can drag &amp; drop the pin on the map to mark the precise spot.</p>

	<div class="map" id="map_canvas"></div>

</fieldset>


<fieldset>
	<h3>Special Features</h3>
	<div style="width:50%" class="left">
	<div><label for="feature_drift">drift</label><span><input type="checkbox" name="feature_drift" /></span></div>
	<div><label for="feature_wall">wall</label><span><input type="checkbox" name="feature_wall" /></span></div>
	<div><label for="feature_swimthrough">swim through</label><span><input type="checkbox" name="feature_swimthrough" /></span></div>
	<div><label for="feature_mooring">boat mooring</label><span><input type="checkbox" name="feature_mooring" /></span></div>
	<div><label for="feature_shore">shore dive</label><span><input type="checkbox" name="feature_shore" /></span></div>
	</div>
	<div style="width:50%" class="right">
	</div>
</fieldset>


<fieldset>
<div>
	<input type="submit" value="Save" class="button btn-primary" />
	{if $DATA.divesite.divesiteid>0}<input type="button" value="revert" class="button cool" onclick="document.location.href='';" />{/if}
</div>
</fieldset>



</form>

{include file='footer.tpl' module_js="app/divesite.edit"}

<script type="text/javascript">/*<![CDATA[*/
{literal}
if(typeof SG == 'undefined') var SG = {};
SG.map_key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
/*
var DivesiteData = {
	marker: {
		id: {/literal}{$DATA.divesite.divesiteid}{literal},
		point:{
			latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
			longitude:{/literal}{$DATA.divesite.longitude}{literal}
			},
		zoom: 2,
		description:'{/literal}{$DATA.divesite.title}{literal}<br />{/literal}{if $DATA.divesite.city}{$DATA.divesite.city}, {/if}{literal}{/literal}{$DATA.divesite.country}{literal}<br /><small>{/literal}{$DATA.divesite.latitude}{literal} x {/literal}{$DATA.divesite.longitude}{literal}</small>'
	}
}
SG.init_page = function() {
	try {
		$('#map_canvas');
	} catch (err) {
		console.log('jquery not ready');
        return setTimeout(SG.init_page, 50);
	}
    if (typeof jQuery == 'undefined' || typeof SG.map == 'undefined' || typeof google.maps == 'undefined') {
	    console.log('init_page dependencies not ready');
    }
    if(SG.map.map!==false) {
    	return;
    }

	if(getCookie('tab-map')!="tab-list") {
		map_init();
	}
}
var marker;
var geocodeCallback = function () {
	SG.map.map.setCenter(marker.position);
	SG.map.updateLatLon(marker.position);
	SG.map.map.setZoom(11);
	SG.map.refreshBounds('all');
};
function addMarker() {
	SG.map.clearMap();
	address = $("#city").val();// + ", " + $("#country").val();
	marker = SG.map.addMarker({point:address,description:address,draggable:true});
	if(marker!='geocoding') {
		geocodeCallback();
	}
}
function map_init() {
	var center = {
		point:{
			latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
			longitude:{/literal}{$DATA.divesite.longitude}{literal}
			}
		};
	SG.map.init(center);
	SG.map.map.setZoom({/literal}{if $DATA.divesite.divesiteid}11{else}2{/if}{literal});
	//marker = SG.map.addMarker({point:{latitude:0,longitude:0},draggable:true});
	{/literal}{if $DATA.divesite.divesiteid>0}{literal}
	var point = {latitude:{/literal}{$DATA.divesite.latitude}{literal}, longitude:{/literal}{$DATA.divesite.longitude}{literal}};
	marker = SG.map.addMarker({point:point,description:'{/literal}{$DATA.divesite.title}{literal}',draggable:true});
{/literal}{*	$("#country option").each(function(i){
		if($(this).val()=='{/literal}{$DATA.divesite.country}{literal}') {
			$(this).attr('selected', 'selected');
			return;
		} else {
			$(this).attr('selected', '');
		}
    });*}{literal}
	{/literal}{/if}{literal}


	$("#city").change(function(){
		addMarker();
	});
	$("#latitude").change(function(){
		address = $("#city").val();// + ", " + $("#country").val();
		SG.map.addMarker({point:{latitude:$("#latitude").val(),longitude:$("#longitude").val()},description:address,draggable:true});
		geocodeCallback();
	});
	$("#longitude").change(function(){
		address = $("#city").val();// + ", " + $("#country").val();
		SG.map.addMarker({point:{latitude:$("#latitude").val(),longitude:$("#longitude").val()},description:address,draggable:true});
		geocodeCallback();
	});
}
*/
{/literal}
/*]]>*/</script>