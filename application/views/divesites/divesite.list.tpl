{*<div class="row">
	<div class="span6">
		<ul class="breadcrumb">
			<li><h1>Divesites</h1></li>
		</ul>
	</div>
	<div class="span6">
	</div>
</div> *}
{if $USER.userid > 0}
<div class="row">
	<div class="span12">
		<a href="/divesites/edit" class="btn btn-primary pull-right">&plus; add a dive site</a>
	</div>
</div>
{/if}
<div class="row">
	<div class="span6">
		<ul class="navigation tabs"> 
			<li class="{if $smarty.cookies.tab_map!="tab-list"}active{/if}">
				<a href="#tab-map" id="tab-link-map" rel="tab_map" title="View As Map">Map</a>
			</li> 
			<li class="{if $smarty.cookies.tab_map=="tab-list"}active{/if}">
				<a href="#tab-list" id="tab-link-list" rel="tab_map" title="View As List">List</a>
			</li> 
		</ul> 
	</div>
	<div class="span6">
		{if $USER.userid > 0}
		<ul class="navigation tabs-dummy pull-right">
			<li class="{if $DISPATCHER.action=='all' || ($DISPATCHER.action=='index' && $USER.userid<=0)}active{/if}">
				<a href="/divesites/all">everyone's sites</a>
			</li>
			<li class="{if $DISPATCHER.action=='me' || ($DISPATCHER.action=='index' && $USER.userid>0)}active{/if}">
				<a href="/divesites/me">my sites</a>
			</li>
			<!--li><a href="/divesites/search">search dive sites</a></li>-->
		</ul>
		{else}
		<br />
		{/if}
	</div>
</div>
<div class="row">
	<div class="span12">
		
		<div class="tab-content">
			<div class="tab-pane{if $smarty.cookies.tab_map!="tab-list"} active{/if}" id="tab-map">
				<div id="map_canvas" class="map"></div>
				<div id="consolediv"></div>
			</div>
			<div class="tab-pane{if $smarty.cookies.tab_map=="tab-list"} active{/if}" id="tab-list">
				{include file="divesites/divesite.list.mini.tpl" divesites=$DATA.divesites}
				{include file='pagenav.tpl' PAGENAV=$DATA.pagenav}
			</div>
			<div class="clear"></div>
		</div>

	</div>
</div>

{include file='footer.tpl'}


{if $MEDIA!="mobile"}<script type="text/javascript">//<![CDATA[
{literal}
SG.init_page = function() {
    if (typeof jQuery == 'undefined' || typeof SG.Map == 'undefined' || typeof google.maps == 'undefined') {
        setTimeout(SG.init_page, 50);
        return false;
    }
	SG.Map.markers = {/literal}{$DATA.json}{literal};
	SG.Map.scope = {/literal}"{$DISPATCHER.action}"{literal};
	SG.Map.key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
	if(getCookie('tab-map')!="tab-list") {
		SG.Map.init();
	}
}
{/literal}
//]]></script>
{/if}
<script type="text/javascript" src="/js/SGMap{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&key={$CONFIG.GOOGLE_API_KEY}"></script>
