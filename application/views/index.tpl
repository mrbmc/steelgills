{include file='header.tpl' title='Steel Gills'}


{if $USER.userid > 0}
{include file='profile/dashboard.tpl' title='Dashboard'}
{else}
<div class="container home">
    <h1>Simple dive logs. Gorgeous dive sites.</h1>
    <div class="row">
        <div class="span6 offset3">
            <p>
                <a href="{$DOCROOT}/signup" class="button hot big">Dive In</a>
            </p>
        </div>
    </div>
</div>
{/if}


{include file='footer.tpl' module_js='app/profile'}