<ul class="list">
	<li class="head">
		<span class="d-date"><a href="?sort=date">Date</a></span>
		<span class="d-title"><a href="?sort=location">Location</a></span>
		<span class="d-profile"><a href="?sort=depth">Depth / Time</a></span>
	</li>
	{foreach from=$dives key=k item=row}
	<li class="{cycle values="odd,even"}">
		<span class="d-date">{$row->time_start|date_format:"%b %e, %Y"}</span>
		<span class="d-title"><a href="/logbook/show/{$row->diveid}">{if $row->title!=''}<strong>{$row->title}</strong>: {/if}{$row->location}</a></span>
		<span class="d-profile">{$row->max_depth} ft / {$row->bottom_time} min</span>
	</li>
	{/foreach}
</ul>
