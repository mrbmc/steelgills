<div class="row">
    <div class="span12">
        {*<h2>Welcome, {$USER.username}</h2> *}
        <div class="content">
            <a href="/logbook/" class="button pull-right">View your logbook</a>
            <h3 class="">Recent Dives</h3>
            {include file="logbook/dive.list.mini.tpl" dives=$DATA.dives}
        </div>
    </div>
</div>
