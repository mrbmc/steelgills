{include file='header.tpl' title='Steel Gills'}


{if $USER.userid > 0}
{include file='profile/dashboard.tpl' title='Dashboard'}
{else}
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
{/if}


{include file='footer.tpl' module_js='app/profile'}