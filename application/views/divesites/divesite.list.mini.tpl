<ul class="list">
		<li class="head">
		<span class="ds-title">Name</span>
		<span class="ds-location">Location</span>
		<span class="ds-geocode">Geocode</span>
		</li>
	{foreach from=$divesites key=k item=row}
		<li class="{cycle values="odd,even"}">
		<span class="ds-title"><a href="/divesites/show/{$row->divesiteid}">{$row->title}</a></span>
		<span class="ds-location">{if $row->city!=''}{$row->city}, {/if}{$row->country}</span>
		<span class="ds-geocode">{$row->latitude}' N x {$row->longitude}' W</span>
		</li>
	{/foreach}
</ul>
