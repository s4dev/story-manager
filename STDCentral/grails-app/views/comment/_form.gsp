<%@ page import="std.board.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="comment.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="content" cols="50" rows="5" required="" value="${commentInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'story', 'error')} required">
	<label for="story">
		<g:message code="comment.story.label" default="Story" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="story" name="story.id" from="${std.board.Story.list()}" optionKey="id" required="" value="${commentInstance?.story?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'username', 'error')} ">
	<label for="username">
		<g:message code="comment.username.label" default="Username" />
		
	</label>
	<g:textField name="username" value="${commentInstance?.username}"/>
</div>

