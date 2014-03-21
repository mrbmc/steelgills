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
	</div>
</div>
{/if}
<div class="row">
	<div class="span6">
		<ul class="navigation tabs pull-left"> 
			<li class="{if $smarty.cookies.tab_map!="tab-list"}active{/if}">
				<a href="#tab-map" id="tab-link-map" rel="tab_map" title="View As Map">Map</a>
			</li> 
			<li class="{if $smarty.cookies.tab_map=="tab-list"}active{/if}">
				<a href="#tab-list" id="tab-link-list" rel="tab_map" title="View As List">List</a>
			</li> 
		</ul> 
		{if $USER.userid > 0}
		<ul class="navigation tabs-dummy pull-left">
			<li class="{if $DISPATCHER.action=='all' || ($DISPATCHER.action=='index' && $USER.userid<=0)}active{/if}">
				<a href="/divesites/all">everyone's sites</a>
			</li>
			<li class="{if $DISPATCHER.action=='me' || ($DISPATCHER.action=='index' && $USER.userid>0)}active{/if}">
				<a href="/divesites/me">my sites</a>
			</li>
			<!--li><a href="/divesites/search">search dive sites</a></li>-->
		</ul>
		{/if}
	</div>
	<div class="span6">
		<a href="/divesites/edit" class="btn btn-primary pull-right">&plus; add a dive site</a>
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

{if $MEDIA!="mobile"}<script type="text/javascript">//<![CDATA[
{literal}
if(typeof SG == 'undefined') var SG = {};
SG.map_markers = {/literal}{$DATA.json}{literal};
SG.map_scope = "{/literal}{$DISPATCHER.action}{literal}";
SG.map_key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
{/literal}
//]]></script>
{/if}

{include file='footer.tpl' module_js="app/divesites"}
