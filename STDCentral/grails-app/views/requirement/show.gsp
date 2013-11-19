
<%@ page import="std.board.Requirement" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-requirement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-requirement" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list requirement">
			
				<g:if test="${requirementInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="requirement.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${requirementInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.referenceId}">
				<li class="fieldcontain">
					<span id="referenceId-label" class="property-label"><g:message code="requirement.referenceId.label" default="Reference Id" /></span>
					
						<span class="property-value" aria-labelledby="referenceId-label"><g:fieldValue bean="${requirementInstance}" field="referenceId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.story}">
				<li class="fieldcontain">
					<span id="story-label" class="property-label"><g:message code="requirement.story.label" default="Story" /></span>
					
						<span class="property-value" aria-labelledby="story-label"><g:link controller="story" action="show" id="${requirementInstance?.story?.id}">${requirementInstance?.story?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.filename}">
				<li class="fieldcontain">
					<span id="filename-label" class="property-label"><g:message code="requirement.filename.label" default="Filename" /></span>
					
						<span class="property-value" aria-labelledby="filename-label"><g:fieldValue bean="${requirementInstance}" field="filename"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${requirementInstance?.id}" />
					<g:link class="edit" action="edit" id="${requirementInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
