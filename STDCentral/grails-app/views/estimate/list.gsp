
<%@ page import="std.board.Estimate" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estimate.label', default: 'Estimate')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-estimate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-estimate" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="amount" title="${message(code: 'estimate.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="amountType" title="${message(code: 'estimate.amountType.label', default: 'Amount Type')}" />
					
						<th><g:message code="estimate.story.label" default="Story" /></th>
					
						<g:sortableColumn property="type" title="${message(code: 'estimate.type.label', default: 'Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${estimateInstanceList}" status="i" var="estimateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${estimateInstance.id}">${fieldValue(bean: estimateInstance, field: "amount")}</g:link></td>
					
						<td>${fieldValue(bean: estimateInstance, field: "amountType")}</td>
					
						<td>${fieldValue(bean: estimateInstance, field: "story")}</td>
					
						<td>${fieldValue(bean: estimateInstance, field: "type")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${estimateInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
