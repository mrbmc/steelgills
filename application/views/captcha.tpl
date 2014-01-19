<script type="text/javascript">//<![CDATA[
{literal}
function captchaSelect(obj) {
	obj.parent().children().removeClass('selected');
	if($('#captcha').val() != obj.attr('rel')) {
		$('#captcha').val(obj.attr('rel'));
		obj.addClass('selected');
	} else {
		$('#captcha').val(null);
	}
}
{/literal}
//]]></script>

<input type="hidden" name="captcha" value="-1" id="captcha" />
Click on <b>{$captcha.question}</b> to prove you're human:<br />
{foreach from=$captcha.choices key=k item=row}
	<a href="#" onclick="captchaSelect($(this));return false;" rel="{$k+1}"><img src="/images/captcha/{$row[1]}" border="" alt="{$row[1]}" /></a>
{/foreach}
<div class="clear"></div>