<script type="text/javascript">//<![CDATA[
{literal}
function captchaSelect(obj) {
	obj.parent().children().removeClass('selected');
	if($('#input-captcha').val() != obj.attr('rel')) {
		$('#input-captcha').val(obj.attr('rel'));
		obj.addClass('selected');
	} else {
		$('#input-captcha').val(null);
	}
}
{/literal}
//]]></script>

<div class="control-group captcha-wrapper">
	<div class="control-label">
		<label for="">Click on <b>{$captcha.question}</b> to prove you're human:</label>
	</div>
	<div class="controls">
		{foreach from=$captcha.choices key=k item=row}
			<a href="#" onclick="captchaSelect($(this));return false;" rel="{$k+1}" class="captcha-image"><img src="/images/captcha/{$row[1]}" border="" alt="{$row[1]}" /></a>
		{/foreach}
		<input type="hidden" name="captcha" value="-1" id="input-captcha" />
		<span class="help-inline"></span>
	</div>
</div>
