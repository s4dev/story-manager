<%@ page import="std.board.Assumption" %>



<div class="fieldcontain ${hasErrors(bean: assumptionInstance, field: 'statement', 'error')} ">
	<label for="statement">
		<g:message code="assumption.statement.label" default="Statement" />
		
	</label>
	<g:textArea name="statement" cols="50" rows="5" value="${assumptionInstance?.statement}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assumptionInstance, field: 'provedFalse', 'error')} ">
	<label for="provedFalse">
		<g:message code="assumption.provedFalse.label" default="Proved False" />
		
	</label>
	<g:checkBox name="provedFalse" value="${assumptionInstance?.provedFalse}" />
</div>

<div class="fieldcontain ${hasErrors(bean: assumptionInstance, field: 'story', 'error')} required">
	<label for="story">
		<g:message code="assumption.story.label" default="Story" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="story" name="story.id" from="${std.board.Story.list()}" optionKey="id" required="" value="${assumptionInstance?.story?.id}" class="many-to-one"/>
</div>

