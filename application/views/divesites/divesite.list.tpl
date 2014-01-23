
<div class="row-fluid">
	<div class="span6">
		<ul class="breadcrumb">
			<li><h1>Divesites</h1></li>
		</ul>
	</div>
	<div class="span6">
		{if $USER.userid > 0}
		<ul class="navigation segmented">
			<li><a href="/divesites/edit"><b>+</b> add a dive site</a></li>
		</ul>
		<ul class="navigation segmented">
			<li>{if $DISPATCHER.action=='all' || ($DISPATCHER.action=='index' && $USER.userid<=0)}<a class="selected">everyone's sites</a>{else}<a href="/divesites/all">everyone's sites</a>{/if}</li>
			<li>{if $DISPATCHER.action=='me' || ($DISPATCHER.action=='index' && $USER.userid>0)}<a class="selected">my sites</a>{else}<a href="/divesites/me">my sites</a>{/if}</li>
			<!--li><a href="/divesites/search">search dive sites</a></li>-->
		</ul>
		{/if}
		
		<ul class="navigation tabs pull-right"> 
			<li class="{if $smarty.cookies.tab_map=="tabContentMap" || !$smarty.cookies.tab_map || $smarty.cookies.tab_map==""} selected{/if}">
				<a href="#tab-map" id="tab-link-map" title="View As Map">Map</a>
			</li> 
			<li class="{if $smarty.cookies.tab_map=="tabContentList"} selected{/if}">
				<a href="#tab-list" id="tab-link-list" title="View As List">List</a>
			</li> 
		</ul> 
		
	</div>
</div>

<div class="content">
	
	<div class="tab-content">
		<div class="tab-pane" id="tab-map"{if $smarty.cookies.tab_map!="tabContentMap" && $smarty.cookies.tab_map!=""} style="display:none;"{/if}>
			<div id="map_canvas" class="map"></div>
			<div id="consolediv"></div>
		</div>
		<div class="tab-pane" id="tab-list"{if $smarty.cookies.tab_map!="tabContentList"} style="display:none;"{/if}>
				{include file="divesites/divesite.list.mini.tpl" divesites=$DATA.divesites}
		</div>
		<div class="clear"></div>
	</div>

	{include file='pagenav.tpl' PAGENAV=$DATA.pagenav}
</div><!--/content -->


<script src="/js/SGMap{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js" type="text/javascript"></script>

{if $MEDIA!="mobile"}<script type="text/javascript">//<![CDATA[
{literal}
function map_init () {
	if(typeof google == "undefined" || typeof google.maps == "undefined"){
		return SGMap.loadScript();
	}
	SGMap.markers = {/literal}{$DATA.json}{literal}
	SGMap.init({point:{latitude:30,longitude:-90},scope:'{/literal}{$DISPATCHER.action}{literal}'});
	google.maps.event.addListener(SGMap.map, "dragend", function(){SGMap.refreshBounds();});
	google.maps.event.addListener(SGMap.map, "zoom_changed", function(){SGMap.refreshBounds();});
}
{/literal}{*function refreshList () {
	var tableHTML = "";
	var i=0;
	for(id in SGMap.markerLibrary) 
	{
		continue;
		i++;
		var m = SGMap.markers[id];
		if(m.title=="")
			m.title = m.city+', '+m.country;
		tableHTML += '<li class="'+((i%2==1)?"odd":"even")+'">';
		tableHTML += '<span class="ds-title"><a href="/divesites/show/'+m.divesiteid+'">'+m.title+'</a></span>';
		tableHTML += '<span class="ds-location">';
			if(m.city!='' && m.city!=null) tableHTML += m.city+', ';
			tableHTML += m.country;
		tableHTML += '</span>';
		tableHTML += '<span class="ds-geocode" style="word-wrap:none;">'+m.latitude+' N x '+m.longitude+' W</span>';
		tableHTML += '</li>';
	}
	var bak = $('#listTableBody').html();
	$('#listTableBody').html(bak+tableHTML);
	console.log(tableHTML);
}*}{literal}

window.onload = function() {
	if(getCookie('tab_map')!="tabContentList")
		map_init();
}

{/literal}
//]]></script>
{/if}