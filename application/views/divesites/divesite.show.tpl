{include file='header.tpl' title='Dive Sites'}
<p><br></p>
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

<script src="/js/SGMap{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js" type="text/javascript"></script>
<script type="text/javascript">//<![CDATA[
{literal}
function map_init () {
	if(typeof google == "undefined" || typeof google.maps == "undefined"){
		return SGMap.loadScript('map_init');
	}
	var marker = {
		id: {/literal}{$DATA.divesite.divesiteid}{literal},
		point:{
			latitude:{/literal}{$DATA.divesite.latitude}{literal}, 
			longitude:{/literal}{$DATA.divesite.longitude}{literal}
			},
		description:'{/literal}{$DATA.divesite.title}{literal}<br />{/literal}{if $DATA.divesite.city}{$DATA.divesite.city}, {/if}{literal}{/literal}{$DATA.divesite.country}{literal}<br /><small>{/literal}{$DATA.divesite.latitude}{literal} x {/literal}{$DATA.divesite.longitude}{literal}</small>'
		};
	SGMap.init(marker);
	SGMap.addMarker(marker);
	SGMap.map.setZoom(13);
}
function displayImages(data) {
	for(i=0,max=Math.min(12,data.photos.photo.length);i<max;i++) {
        var item = data.photos.photo[i],
        	url = "http://farm"+ item['farm'] + ".staticflickr.com/"+item['server']+"/"+item['id']+"_"+item['secret']+".jpg";
	    $('.divesite-images').append($('<div class="span2"></div>').append($('<img class="thumbnail" />').attr('src',url)));
	}
}
var FLICKR_KEY = "41392a7d72d8ac7bd82ae6b2006dc61a";
var FLICKR_SECRET = "57bd6c9b8bd55ad6";
var call = "http://api.flickr.com/services/rest/?";
    call += "&api_key="+FLICKR_KEY;
    call += "&method=flickr.photos.search";
    call += "&safe_search=1&format=json&nojsoncallback=1";
    call += "&content_type=1";
    // call += "&per_page=10";
    call += "&page=1";
    call += "&sort=interestingness-desc";
    //call += "&license=4,5,6,7,8";
    call += "&extras=owner_name";
    call += "&tags={/literal}{$DATA.divesite.title}{literal}";
    // call += "&auth_token=72157639992305893-5590d37efd959709&api_sig=92b7eba92ed1b05aefba1f6f559068f8";

var jqready = function () {
    if (typeof jQuery == 'undefined') {
        setTimeout(jqready, 50);
        return false;
    }
    map_init();
    $.getJSON(call, displayImages);
}
jqready();
{/literal}
//]]></script>
