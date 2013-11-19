
<%@ page import="std.board.Requirement" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-requirement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-requirement" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'requirement.content.label', default: 'Content')}" />
					
						<g:sortableColumn property="referenceId" title="${message(code: 'requirement.referenceId.label', default: 'Reference Id')}" />
					
						<th><g:message code="requirement.story.label" default="Story" /></th>
					
						<g:sortableColumn property="filename" title="${message(code: 'requirement.filename.label', default: 'Filename')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${requirementInstanceList}" status="i" var="requirementInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${requirementInstance.id}">${fieldValue(bean: requirementInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: requirementInstance, field: "referenceId")}</td>
					
						<td>${fieldValue(bean: requirementInstance, field: "story")}</td>
					
						<td>${fieldValue(bean: requirementInstance, field: "filename")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${requirementInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
