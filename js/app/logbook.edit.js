define(['../steelgills'], function() {
	function updateTime () {
			begin = $('#time_start').val().split(":");
			end = $('#time_end').val().split(":");
			hrs = end[0]-begin[0];
			min = (end[1]-begin[1])+"";
			if(min.length==1)
				min = "0"+min;
			duration = hrs+":"+min;
			$('#totaltime').html(duration);
	}

	function findDivesite (query) {
		// console.log('typeahead',query);
		return function findMatches(q, callback){
			// console.log(q);
			var matches = [],
				substrRegex = new RegExp(q, 'i');

		    $.each(divesites, function(i, site) {
		      if (substrRegex.test(site.title)) {
		        // the typeahead jQuery plugin expects suggestions to a
		        // JavaScript object, refer to typeahead docs for more info
		        matches.push({ value: site.title });
		      }
		    });

			callback(matches);
		}
	}


	function exposureSelect(e) {
		e.preventDefault();
		var obj = $(e.currentTarget),
			val = obj.data('exposure'),
			idx = exposure.contains(val);

		obj.toggleClass('selected');
		if(idx===false) {
			exposure.push(val);
		} else {
			exposure.splice(idx,1);
			// obj.removeClass('selected');
		}
		$('#exposure').val(exposure);
		return false;
	}

    require(['jquery'],function($){
    require(['jquery','typeahead'],function($){
		console.log('wireup()');

		$('.exposure-item').on('click',exposureSelect);

		$("#location").typeahead({
			hint: true,
			highlight: true,
			minLength: 1,
			selected: function () {
				alert('hello');
			}
		},
		{
			name: 'divesites',
			displayKey: 'value',
			source: findDivesite(divesites)
		});
		$("#location").on('change',function(){
			// $('#fk_divesiteid').val($(this).val);
		});
/*
		$("#location").autocomplete("#",{
			maxItems:10,
			onItemSelect:function(li){
				$('#location').val($(li).text());
				$('#fk_divesiteid').val(li.extra[0]);
				console.log("selected:" + li.extra[0]);
			}
		});
		$("#datepicker").datepicker({
			showOn: 'button',
			buttonImage: '/images/calendar.gif',
			buttonImageOnly: true,
		});
		$('#vis_slider').slider({
				value:Dive.visibility,
				range: "max",
				min: 0,
				max: 500,
				step: 5,
				slide: function(event, ui) {
					$('#visibility').val(ui.value);
				}
		});
		$('#cur_slider').slider({
				value:Dive.current,
				range: "max",
				min: 0,
				max: 10,
				step: 0.25,
				slide: function(event, ui) {
					$('#current').val(ui.value);
				}
		});

		updateTime();
		$('#time_start').change(updateTime);
		$('#time_end').change(updateTime);
*/
    });
    });

});