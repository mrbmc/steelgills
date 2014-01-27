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


{include file='footer.tpl'}

<script type="text/javascript">//<![CDATA[
{literal}
SG.init_page = function(){
	if(typeof google == "undefined" || typeof google.maps == "undefined"){
		return setTimeout(SG.init_page,50);
	}
    SG.init_map();
    SG.init_images();
}
SG.init_map = function() {
	var marker = {
		id: {/literal}{$DATA.divesite.divesiteid}{literal},
		point:{
			latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
			longitude:{/literal}{$DATA.divesite.longitude}{literal}
			},
		description:'{/literal}{$DATA.divesite.title}{literal}<br />{/literal}{if $DATA.divesite.city}{$DATA.divesite.city}, {/if}{literal}{/literal}{$DATA.divesite.country}{literal}<br /><small>{/literal}{$DATA.divesite.latitude}{literal} x {/literal}{$DATA.divesite.longitude}{literal}</small>'
	};
	SG.map.key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
	SG.map.center = marker.point;
	SG.map.init();
	SG.map.addMarker(SG.map.marker);
	SG.map.map.setZoom(13);
}
SG.init_images = function() {
	var FLICKR_KEY = "{/literal}{$CONFIG.FLICKR_KEY}{literal}",
		FLICKR_SECRET = "{/literal}{$CONFIG.FLICKR_SECRET}{literal}",
		flickrCall = "http://api.flickr.com/services/rest/?";
	    flickrCall += "&api_key="+FLICKR_KEY;
	    flickrCall += "&method=flickr.photos.search";
	    flickrCall += "&safe_search=1&format=json&nojsoncallback=1";
	    flickrCall += "&content_type=1";
	    // flickrCall += "&per_page=10";
	    flickrCall += "&page=1";
	    flickrCall += "&sort=interestingness-desc";
	    //flickrCall += "&license=4,5,6,7,8";
	    flickrCall += "&extras=owner_name";
	    flickrCall += "&tags={/literal}{$DATA.divesite.title}{literal}";
	    // flickrCall += "&auth_token=72157639992305893-5590d37efd959709&api_sig=92b7eba92ed1b05aefba1f6f559068f8";
    $.getJSON(flickrCall, function(data){
		for(i=0,max=Math.min(12,data.photos.photo.length);i<max;i++) {
	        var item = data.photos.photo[i],
	        	url = "http://farm"+ item['farm'] + ".staticflickr.com/"+item['server']+"/"+item['id']+"_"+item['secret']+".jpg";
		    $('.divesite-images').append($('<div class="span2"></div>').append($('<img class="thumbnail" />').attr('src',url)));
		}
    });
}
{/literal}
//]]></script>
<script type="text/javascript" src="/js/SGMap{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&key={$CONFIG.GOOGLE_API_KEY}"></script>
