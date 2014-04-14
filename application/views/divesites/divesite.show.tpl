{include file='header.tpl' title='Dive Sites'}
<div class="row">
	<div class="span6">
		<ul class="breadcrumb">
			<li><h1>{$DATA.divesite.title}</h1></li>
		</ul>
		
	</div>
	<div class="span6">
		<ul class="navigation pull-right">
		{if ($DATA.user.userid>0 && $DATA.divesite.fk_userid==$DATA.user.userid) || $DATA.user.status=='admin'}
			<li><a href="/divesites/edit/{$DATA.divesite.divesiteid}">edit</a></li>
		{/if}
			<li><a href="/logbook/new/divesite/{$DATA.divesite.divesiteid}" class="btn btn-primary">Log A Dive Here</a>
		</ul>
	</div>
</div>

<div class="row">
	<div class="span6">

		<h3>{if $DATA.divesite.city!=''}{$DATA.divesite.city}, {/if}{$DATA.divesite.country}</h3>
		<p class="description">{$DATA.divesite.description}</p>
		
		<table class="table">
			<thead>
				<tr>
					<th>Max Depth</th>
					<th>Difficulty</th>
					<th>Rating</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>{$DATA.divesite.max_depth}</td>
					<td>{$DATA.divesite.difficulty}</td>
					<td>{$DATA.divesite.rating}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="span6">
		<div id="map_canvas" class="map"></div>
		{$DATA.divesite.latitude}&deg;{if $DATA.divesite.latitude >= 0}N{else}S{/if}
		{$DATA.divesite.longitude}&deg;{if $DATA.divesite.longitude >= 0}E{else}W{/if}
	</div>
</div>

<p><br></p>
<div class="row divesite-images"></div>



<script type="text/javascript">//<![CDATA[
{literal}
if(typeof SG == 'undefined') var SG = {};

SG.map_key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
SG.map_markers = [{
	divesiteid: {/literal}{$DATA.divesite.divesiteid}{literal},
	title: "{/literal}{$DATA.divesite.title}{literal}",
	latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
	longitude:{/literal}{$DATA.divesite.longitude}{literal},
	description:'{/literal}{$DATA.divesite.title}{literal}<br />{/literal}{if $DATA.divesite.city}{$DATA.divesite.city}, {/if}{literal}{/literal}{$DATA.divesite.country}{literal}<br /><small>{/literal}{$DATA.divesite.latitude}{literal} x {/literal}{$DATA.divesite.longitude}{literal}</small>'
	// marker: {
	// 	id: {/literal}{$DATA.divesite.divesiteid}{literal},
	// 	point:{
	// 		},
	// 	zoom: 8,
	// }
}];

{/literal}
//]]></script>


{include file='footer.tpl' module_js="app/divesite.show"}
