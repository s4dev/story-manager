<%@ page import="std.board.Requirement" %>



<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="requirement.content.label" default="Content" />
		
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="1000" value="${requirementInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'referenceId', 'error')} required">
	<label for="referenceId">
		<g:message code="requirement.referenceId.label" default="Reference Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="referenceId" required="" value="${requirementInstance?.referenceId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'story', 'error')} ">
	<label for="story">
		<g:message code="requirement.story.label" default="Story" />
		
	</label>
	<g:select id="story" name="story.id" from="${std.board.Story.list()}" optionKey="id" value="${requirementInstance?.story?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'filename', 'error')} ">
	<label for="filename">
		<g:message code="requirement.filename.label" default="Filename" />
		
	</label>
	<g:textField name="filename" value="${requirementInstance?.filename}"/>
</div>

