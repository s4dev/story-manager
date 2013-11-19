<%@ page import="std.board.Confirmation" %>



<div class="fieldcontain ${hasErrors(bean: confirmationInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="confirmation.text.label" default="Text" />
		
	</label>
	<g:textArea name="text" cols="40" rows="5" maxlength="1000" value="${confirmationInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: confirmationInstance, field: 'story', 'error')} required">
	<label for="story">
		<g:message code="confirmation.story.label" default="Story" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="story" name="story.id" from="${std.board.Story.list()}" optionKey="id" required="" value="${confirmationInstance?.story?.id}" class="many-to-one"/>
</div>

