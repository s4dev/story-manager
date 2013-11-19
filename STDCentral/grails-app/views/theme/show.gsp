
<%@ page import="std.board.Theme" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'theme.label', default: 'Theme')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-theme" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-theme" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list theme">
			
				<g:if test="${themeInstance?.deliverable}">
				<li class="fieldcontain">
					<span id="deliverable-label" class="property-label"><g:message code="theme.deliverable.label" default="Deliverable" /></span>
					
						<span class="property-value" aria-labelledby="deliverable-label"><g:fieldValue bean="${themeInstance}" field="deliverable"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${themeInstance?.build}">
				<li class="fieldcontain">
					<span id="build-label" class="property-label"><g:message code="theme.build.label" default="Build" /></span>
					
						<span class="property-value" aria-labelledby="build-label"><g:fieldValue bean="${themeInstance}" field="build"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${themeInstance?.functionalArea}">
				<li class="fieldcontain">
					<span id="functionalArea-label" class="property-label"><g:message code="theme.functionalArea.label" default="Functional Area" /></span>
					
						<span class="property-value" aria-labelledby="functionalArea-label"><g:link controller="functionalArea" action="show" id="${themeInstance?.functionalArea?.id}">${themeInstance?.functionalArea?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${themeInstance?.id}" />
					<g:link class="edit" action="edit" id="${themeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
