
<%@ page import="std.board.Assumption" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'assumption.label', default: 'Assumption')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-assumption" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-assumption" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list assumption">
			
				<g:if test="${assumptionInstance?.statement}">
				<li class="fieldcontain">
					<span id="statement-label" class="property-label"><g:message code="assumption.statement.label" default="Statement" /></span>
					
						<span class="property-value" aria-labelledby="statement-label"><g:fieldValue bean="${assumptionInstance}" field="statement"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assumptionInstance?.provedFalse}">
				<li class="fieldcontain">
					<span id="provedFalse-label" class="property-label"><g:message code="assumption.provedFalse.label" default="Proved False" /></span>
					
						<span class="property-value" aria-labelledby="provedFalse-label"><g:formatBoolean boolean="${assumptionInstance?.provedFalse}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${assumptionInstance?.story}">
				<li class="fieldcontain">
					<span id="story-label" class="property-label"><g:message code="assumption.story.label" default="Story" /></span>
					
						<span class="property-value" aria-labelledby="story-label"><g:link controller="story" action="show" id="${assumptionInstance?.story?.id}">${assumptionInstance?.story?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${assumptionInstance?.id}" />
					<g:link class="edit" action="edit" id="${assumptionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
