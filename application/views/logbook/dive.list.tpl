<div class="breadcrumb">
	{if $DATA.member.userid}<h1>{$DATA.member.username}'s Logbook </h1>{/if}
</div>

<div class="pull-right">
	<ul class="navigation segmented pull-left">
		<li><a href="#" id="tab1" rel="tab_log" title="tabContentList" class="tab{if $smarty.cookies.tab_log=="tabContentList" || !$smarty.cookies.tab_log || $smarty.cookies.tab_log==""} selected{/if}">Dives</a></li> 
		<li><a href="#" id="tab2" rel="tab_log" title="tabContentCharts" class="tab{if $smarty.cookies.tab_log=="tabContentCharts"} selected{/if}">Charts</a></li>
	</ul>
	<a href="/logbook/add" class="btn btn-primary">&plus; Add a dive</a>
	
</div>

<div class="content">
	<div class="tab_area">
		<a name="dives"></a>
		<div class="tabContent" id="tabContentList"{if $smarty.cookies.tab_log!="tabContentList" && $smarty.cookies.tab_log!=""} style="display:none;"{/if}>
			{include file='logbook/dive.list.mini.tpl' dives=$DATA.dives}
		</div>
		<a name="charts"></a>
		<div class="tabContent" id="tabContentCharts"{if $smarty.cookies.tab_log!="tabContentCharts"} style="display:none;"{/if}>
			<h3>Air consumption vs. depth</h3>
			<img src="http://chart.apis.google.com/chart?chs=550x200&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|1000|2000|3000&cht=lc&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->air_used/30},{/foreach}0&chdl=PSI&chco=ff00ff&chls=1,1,0" />
			<h3>Bottom time vs. Depth</h3>
			<img src="http://chart.apis.google.com/chart?chs=550x200&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|50|100|150&cht=lc&chdl=depth|bottom+time&chco=ff00ff,00ffff&chls=1,1,0&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->max_depth/1.5},{/foreach}{$row->max_depth/1.5}|{foreach from=$DATA.dives key=k item=row}{$row->bottom_time/0.6},{/foreach}{$row->bottom_time/0.6}" />
			<h3>Current vs. Visibility</h3>
			<img src="http://chart.apis.google.com/chart?chs=550x200&chf=bg,s,ffffff|c,s,ffffff&chxt=x,y&chxl=0:||1:|0|50|100|150&cht=lc&chdl=current|visibility&chco=ff00ff,00ffff&chls=1,1,0&chd=t:{foreach from=$DATA.dives key=k item=row}{$row->current/0.1},{/foreach}{$row->current/0.1}|{foreach from=$DATA.dives key=k item=row}{$row->visibility/3},{/foreach}{$row->visibility/3}" />
		</div>
	</div>
</div>


{include file='pagenav.tpl' PAGENAV=$DATA.pagenav}
