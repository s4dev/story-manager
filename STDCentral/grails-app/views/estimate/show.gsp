
<%@ page import="std.board.Estimate" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estimate.label', default: 'Estimate')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-estimate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-estimate" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list estimate">
			
				<g:if test="${estimateInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="estimate.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${estimateInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimateInstance?.amountType}">
				<li class="fieldcontain">
					<span id="amountType-label" class="property-label"><g:message code="estimate.amountType.label" default="Amount Type" /></span>
					
						<span class="property-value" aria-labelledby="amountType-label"><g:fieldValue bean="${estimateInstance}" field="amountType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimateInstance?.story}">
				<li class="fieldcontain">
					<span id="story-label" class="property-label"><g:message code="estimate.story.label" default="Story" /></span>
					
						<span class="property-value" aria-labelledby="story-label"><g:link controller="story" action="show" id="${estimateInstance?.story?.id}">${estimateInstance?.story?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimateInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="estimate.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${estimateInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${estimateInstance?.id}" />
					<g:link class="edit" action="edit" id="${estimateInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
