
<%@ page import="std.board.Theme" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'theme.label', default: 'Theme')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-theme" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-theme" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="deliverable" title="${message(code: 'theme.deliverable.label', default: 'Deliverable')}" />
					
						<g:sortableColumn property="build" title="${message(code: 'theme.build.label', default: 'Build')}" />
					
						<th><g:message code="theme.functionalArea.label" default="Functional Area" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${themeInstanceList}" status="i" var="themeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${themeInstance.id}">${fieldValue(bean: themeInstance, field: "deliverable")}</g:link></td>
					
						<td>${fieldValue(bean: themeInstance, field: "build")}</td>
					
						<td>${fieldValue(bean: themeInstance, field: "functionalArea")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${themeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
