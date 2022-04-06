define(["jquery"], function($) {
	Modal = {
		url: "",
		selector: function () {
			return $('#'+SG.Modal.targetDiv);
		},
		openModal: function (url,_class) {
			// console.log('open modal:',url);
			var _modal = $('#sg-modal');
			if(_modal.length<=0) {
				_modal = $('<div id="sg-modal" class="modal ' + ((typeof _class != 'undefined')?_class:"") + ' fade"></div>');
				_modal.append('<a href="#" class="close">&times;</a>');
				_modal.append('<div class="modal-body"></div>');
				$('body').append(_modal);
			}
			$('.modal-body',_modal).load(url,function () {
				$(this).closest(".modal").toggleClass('in');
			    $(window).keydown(function(event){
			    	if(event.keyCode==27) { SG.Modal.closeModal(); }
			    });
			});
			$('.close','.modal').bind('click',function(e){
				$(this).closest('.modal').toggleClass("in",false);
			})
		},
		closeModal: function () {
			$('.modal').toggleClass("in",false);
		},
		init: function() {
			$('[data-modal-src]').click(function(e){
				e.preventDefault();
				var u = $(this).data('modal-src');
				Modal.openModal(u);
			})
		}
	}
	return Modal.init();
});