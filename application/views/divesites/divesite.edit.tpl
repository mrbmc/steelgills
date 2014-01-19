{include file='header.tpl' title='Dive Sites'}
<script src="/js/maps{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js" type="text/javascript"></script>
<script type="text/javascript">/*<![CDATA[*/
{literal}
var marker;
var geocodeCallback = function () {
	SGMap.map.setCenter(marker.position);
	SGMap.updateLatLon(marker.position);
	SGMap.map.setZoom(11);
	SGMap.refreshBounds('all');
};
function addMarker() {
	SGMap.clearMap();
	address = $("#city").val();// + ", " + $("#country").val();
	marker = SGMap.addMarker({point:address,description:address,draggable:true});
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
	SGMap.init(center);
	SGMap.map.setZoom({/literal}{if $DATA.divesite.divesiteid}11{else}2{/if}{literal});
	//marker = SGMap.addMarker({point:{latitude:0,longitude:0},draggable:true});
	{/literal}{if $DATA.divesite.divesiteid>0}{literal}
	var point = {latitude:{/literal}{$DATA.divesite.latitude}{literal}, longitude:{/literal}{$DATA.divesite.longitude}{literal}};
	marker = SGMap.addMarker({point:point,description:'{/literal}{$DATA.divesite.title}{literal}',draggable:true});
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
		SGMap.addMarker({point:{latitude:$("#latitude").val(),longitude:$("#longitude").val()},description:address,draggable:true});
		geocodeCallback();
	});
	$("#longitude").change(function(){
		address = $("#city").val();// + ", " + $("#country").val();
		SGMap.addMarker({point:{latitude:$("#latitude").val(),longitude:$("#longitude").val()},description:address,draggable:true});
		geocodeCallback();
	});
}
window.onload = SGMap.loadScript;
{/literal}
/*]]>*/</script>

<h2>{if $DATA.divesite.divesiteid>0}Edit{else}Add{/if} a divesite</h2>

<form method="POST" action="/divesites/update/" name="myForm" id="myForm">
<input type="hidden" id="divesiteid" name="divesiteid" value="{$DATA.divesite.divesiteid}" />

<fieldset>
<legend>Divesite Info</legend>
<div>
	<label for="title">Name</label>
	<span><input type="text" class="text" id="title" name="title" value="{$DATA.divesite.title}" /></span>
	<span class="status"></span>
</div>
<div>
	<label for="max_depth">Max Depth</label>
	<span><input type="text" class="text" id="max_depth" name="max_depth" value="{$DATA.divesite.max_depth}" /></span>
	<span class="status"></span>
</div>
<div>
	<label for="description">Notes</label>
	<span><textarea name="description" id="description" cols="40" rows="6">{$DATA.divesite.description}</textarea></span>
	<span class="status"></span>
</div>
</fieldset>



<fieldset>
<legend>Divesite Location</legend>
<div>
	<label for="city"></label>
	<span>Type the name of the closest city and country and we'll try to find it on the map.<br />
	You can also drag &amp; drop the pin on the map to mark the precise spot.</span>
</div>

<div class="left">
	<label for="city">Nearest City</label>
	<span><input type="text" class="text long" id="city" name="city" value="{$DATA.divesite.city}" /></span>
	<span class="status"></span>
</div>

{*<div>
	<label for="country">Country</label>
	<span><!--input type="text" class="text" id="country" name="country" value="{$DATA.divesite.country}" /-->
	{include file='country_selector.tpl'}
	</span>
	<span class="status"></span>
</div>*}

<div class="left">
	<label for="latitude">Latitude</label>
	<span><input type="text" class="text" id="latitude" name="latitude" value="{$DATA.divesite.latitude}" /></span>
	<span class="status"></span>
</div>
<div class="left">
	<label for="longitude">Longitude</label>
	<span><input type="text" class="text" id="longitude" name="longitude" value="{$DATA.divesite.longitude}" /></span>
	<span class="status"></span>
</div>
<div class="map" id="map_canvas"></div>

</fieldset>

{*<fieldset>
<legend>Divesite Features</legend>
<div style="width:50%" class="left">
<div><label for="feature_drift">drift</label><span><input type="checkbox" name="feature_drift" /></span></div>
<div><label for="feature_wall">wall</label><span><input type="checkbox" name="feature_wall" /></span></div>
<div><label for="feature_swimthrough">swim through</label><span><input type="checkbox" name="feature_swimthrough" /></span></div>
<div><label for="feature_mooring">boat mooring</label><span><input type="checkbox" name="feature_mooring" /></span></div>
<div><label for="feature_shore">shore dive</label><span><input type="checkbox" name="feature_shore" /></span></div>
</div>
<div style="width:50%" class="right">
</div>
</fieldset>*}



<fieldset>
	<legend>Action</legend>
<div align="center">
	<input type="submit" value="save" class="button" />
	<input type="button" value="revert" class="button cool" onclick="document.location.href='';" />
</div>
</fieldset>



</form>



{include file='footer.tpl'}