

<div class="row">
	<div class="span6">
		<div class="breadcrumb">
			{if $DATA.member.userid}<h1>{$DATA.member.username}'s Logbook </h1>{/if}
		</div>
		
	</div>
	<div class="span6">
		<div class="pull-right">
			<a href="/logbook/add" class="btn btn-primary">&plus; Add a dive</a>
		</div>
		
	</div>
</div>


<div class="content">
	<ul class="navigation tabs">
		<li class="tab{if $smarty.cookies.tab_log!="log-charts"} active{/if}"><a href="#log-list" id="tab1" rel="tab_log" title="log-list">Dives</a></li> 
		<li class="tab{if $smarty.cookies.tab_log=="log-charts"} active{/if}"><a href="#log-charts" id="tab2" rel="tab_log" title="log-charts">Charts</a></li>
	</ul>
	<div class="tab-content">
		<a name="dives"></a>
		<div class="tab-pane {if $smarty.cookies.tab_log!="log-charts"}active{/if}" id="log-list">
			{include file='logbook/dive.list.mini.tpl' dives=$DATA.dives}
		</div>
		<a name="charts"></a>
		<div class="tab-pane{if $smarty.cookies.tab_log=="log-charts"} active{/if}" id="log-charts">
			<h3>Air consumption vs. depth</h3>
			<img src="http://chart.apis.google.com/chart?chs=842x320&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|1000|3800|3000&cht=lc&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->air_used/30},{/foreach}0&chdl=PSI&chco=ff00ff&chls=1,1,0" />
			<h3>Bottom time vs. Depth</h3>
			<img src="http://chart.apis.google.com/chart?chs=842x320&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|50|100|150&cht=lc&chdl=depth|bottom+time&chco=ff00ff,00ffff&chls=1,1,0&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->max_depth/1.5},{/foreach}{$row->max_depth/1.5}|{foreach from=$DATA.dives key=k item=row}{$row->bottom_time/0.6},{/foreach}{$row->bottom_time/0.6}" />
			<h3>Current vs. Visibility</h3>
			<img src="http://chart.apis.google.com/chart?chs=842x320&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|50|100|150&cht=lc&chdl=current|visibility&chco=ff00ff,00ffff&chls=1,1,0&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->current/0.1},{/foreach}{$row->current/0.1}|{foreach from=$DATA.dives key=k item=row}{$row->visibility/3},{/foreach}{$row->visibility/3}" />
		</div>
	</div>
</div>


{include file='pagenav.tpl' PAGENAV=$DATA.pagenav}

{include file='footer.tpl' module_js="app/logbook"}
