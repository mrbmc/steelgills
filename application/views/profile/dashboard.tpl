<div class="row">
    <div class="span12">
        <h2>Welcome, {$USER.name}</h2>
        <div class="content">
        	<header>
	            <h3><a href="/logbook/">Recent Dives</a></h3>
	        	<a href="/logbook/add" class="btn btn-primary">Record a dive</a>
        	</header>
            {include file="logbook/dive.list.mini.tpl" dives=$DATA.dives}
        </div>
    </div>
</div>
