<div class="row">
    <div class="span12">
        <h2>Welcome, {$USER.name}</h2>
        <div class="content">
            
            <h3 class=""><a href="/logbook/">Recent Dives</a></h3>
            {include file="logbook/dive.list.mini.tpl" dives=$DATA.dives}
        </div>
    </div>
</div>
