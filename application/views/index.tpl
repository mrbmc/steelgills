{include file='header.tpl' title='Steel Gills'}


{if $USER.userid <= 0}
<div class="container home">
    <h1>Dive logs and divesites made fun &amp; easy.</h1>
    <div class="row">
        <div class="span6 offset3">
            <!-- <p>Sign up with one click!</p>
            <p>
                <a href="/login/twitter" class="twitter">Sign In with Twitter</a> &nbsp; <br />
                <a href="/login/facebook" class="facebook">Connect with Facebook</a> &nbsp;
            </p> -->
            <p>
                <!-- Or create a free account:<br /> -->
                <a href="{$DOCROOT}/signup" class="button hot big">Dive In</a>
            </p>
        </div>
    </div>
</div>
{else}
<div class="container">
    <div class="row">
        <div class="span12">
            <h2>Welcome, {$USER.username}</h2> 
            <div class="content">
                <h3>Recent Dives</h3>
                {include file="logbook/dive.list.mini.tpl" dives=$DATA.dives}
                <a href="/logbook/" class="button">View your logbook</a>
            </div>
        </div>
    </div>
</div>
{/if}

{*
{if $USER.userid>0}
<div id="profile_sidebar" class="sidebar">
    <h3>Welcome {$USER.first_name}</h3>
    <dl>
        <dt>Dives logged</dt>
        <dd>{$USER.diveslogged}</dd>
    </dl>
</div>
{/if}
*}

<script type="text/javascript">
function displayImages(data) {
    var idx = 0;//Math.round(Math.random() * data.photos.photo.length),
        item = data.photos.photo[idx],
        url = "http://farm"+ item['farm'] + ".staticflickr.com/"+item['server']+"/"+item['id']+"_"+item['secret']+".jpg";
    $('.wallpaper').css('background-image','url('+url+')');
    $('.caption','.wallpaper').text("\u00a9 "+item.ownername);
}
var FLICKR_KEY = "41392a7d72d8ac7bd82ae6b2006dc61a";
var FLICKR_SECRET = "57bd6c9b8bd55ad6";
var call = "http://api.flickr.com/services/rest/?";
    call += "&api_key="+FLICKR_KEY;
    call += "&method=flickr.photos.search";
    call += "&safe_search=1&format=json&nojsoncallback=1";
    call += "&content_type=1";
    call += "&per_page=1";
    call += "&page="+Math.round(Math.random()*500);
    call += "&sort=interestingness-desc";
    call += "&license=4,5,6,7,8";
    call += "&extras=owner_name";
    call += "&tags=scuba,reef";
    // call += "&auth_token=72157639992305893-5590d37efd959709&api_sig=92b7eba92ed1b05aefba1f6f559068f8";

var jqready = function () {
    if (typeof jQuery == 'undefined') {
        setTimeout(jqready, 50);
        return false;
    }
    $.getJSON(call, displayImages);
}
jqready();
</script>

{include file='footer.tpl'}