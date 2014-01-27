{$smarty.session.sort_col}
<ul class="list">
	<li class="head">
		<span class="d-date {if $smarty.session.sort_col=="time_start"}{$smarty.session.sort_order}{/if}"><a href="?sort=date">Date</a></span>
		<span class="d-title {if $smarty.session.sort_col=="location"}{$smarty.session.sort_order}{/if}"><a href="?sort=location">Location</a></span>
		<span class="d-profile {if $smarty.session.sort_col=="max_depth"}{$smarty.session.sort_order}{/if}"><a href="?sort=depth">Depth / Time</a></span>
	</li>
	{foreach from=$dives key=k item=row}
	<li class="{cycle values="odd,even"}">
		<span class="d-date">{$row->time_start|date_format:"%b %e, %Y"}</span>
		<span class="d-title"><a href="/logbook/show/{$row->diveid}">{if $row->title!=''}<strong>{$row->title}</strong>: {/if}{$row->location}</a></span>
		<span class="d-profile">{$row->max_depth} ft / {$row->bottom_time} min</span>
	</li>
	{/foreach}
</ul>
