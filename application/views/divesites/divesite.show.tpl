{include file='header.tpl' title='Dive Sites'}
<h2>{$DATA.divesite.title}</h2>
{if ($DATA.user.userid>0 && $DATA.divesite.fk_userid==$DATA.user.userid) || $DATA.user.status=='admin'}
<ul class="navigation segmented">
	<li><a href="/divesites/edit/{$DATA.divesite.divesiteid}">edit</a></li>
</ul>
{/if}
<dl>
	<dt>Location</dt>
	<dd>{if $DATA.divesite.city!=''}{$DATA.divesite.city}, {/if}{$DATA.divesite.country}</dd>

	<dt>Position</dt>
	<dd>{$DATA.divesite.latitude}' {if $DATA.divesite.latitude >= 0}N{else /}S{/if}
		{$DATA.divesite.longitude}' {if $DATA.divesite.longitude >= 0}E{else /}W{/if}</dd>

	<dt>Max Depth</dt>
	<dd>{$DATA.divesite.max_depth} ft</dd>

	<dt>Description</dt>
	<dd>{$DATA.divesite.description}</dd>
</dl>

<div class="clear"></div>
<div id="map_canvas" class="map"></div>

{include file='footer.tpl'}

<script src="/js/SGMap{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js" type="text/javascript"></script>
<script type="text/javascript">//<![CDATA[
{literal}
function map_init () {
	if(typeof google == "undefined" || typeof google.maps == "undefined"){
		return SGMap.loadScript('map_init');
	}
	var marker = {
		id: {/literal}{$DATA.divesite.divesiteid}{literal},
		point:{
			latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
			longitude:{/literal}{$DATA.divesite.longitude}{literal}
			},
		description:'{/literal}{$DATA.divesite.title}{literal}<br />{/literal}{if $DATA.divesite.city}{$DATA.divesite.city}, {/if}{literal}{/literal}{$DATA.divesite.country}{literal}<br /><small>{/literal}{$DATA.divesite.latitude}{literal} x {/literal}{$DATA.divesite.longitude}{literal}</small>'
		};
	SGMap.init(marker);
	SGMap.addMarker(marker);
	SGMap.map.setZoom(13);
}
window.onload = map_init;

{/literal}
//]]></script>

