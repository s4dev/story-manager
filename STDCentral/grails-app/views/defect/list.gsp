
<%@ page import="std.defect.*" %>


<!doctype html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'defect.label', default: 'Defect')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
	<a href="#list-defect" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
	</div>

	<div id="list-defect" class="content scaffold-list" role="main">

		<g:render template="searchForm" />

		<h1 style="padding-top:10px;">Defect List</h1>

		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>

		<table>
		<thead>
			<tr>
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="id" title="ID" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="createDT" title="Date" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="area" title="Screen" />
				<th>Description</th>
%{-- 				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="status" title="Status" /> --}%
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="state" title="State" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="severity" title="Severity" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="assignedTo" title="Assigned To" />
				<th>Developer Notes</th>
				<th>QA Notes</th>
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="reportedBy" title="Reported By" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="env" title="Env" />
				<g:sortableColumn params="${params?.encodeAsSortableMap()}" property="story" title="Story" />
			</tr>
		</thead>

		<tbody>

		<g:each in="${defectInstanceList}" status="i" var="defect">

			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

				<td><g:link action="show" id="${defect.id}">${defect.id}</g:link></td>
				<td><g:formatDate format="MM/dd/yy" date="${defect.createDT}" /></td>
				<td>${defect.area}</td>
				<td><d:truncate>${defect.description}</d:truncate></td>
%{-- 				<td>${defect.status}</td> --}%
				<td>${defect.state}</td>
				<td>${defect.severity}</td>
				<td>${defect.assignedTo}</td>
				<td><d:truncate>${defect.developerNotes}</d:truncate></td>
				<td><d:truncate>${defect.qaNotes}</d:truncate></td>
				<td>${defect.reportedBy}</td>
				<td>${defect.env}</td>
				<td>
					<g:if test="${defect.story?.id}">
						<g:link controller="story" action="show" id="${defect.story?.id}">
							${defect.story?.id}
						</g:link>
					</g:if>
 				</td>
			</tr>
		</g:each>

		</tbody>
		</table>

		<div class="pagination">
			<g:paginate total="${defectInstanceTotal}"
				params="${params?.encodeAsSortableMap()}" />
			(${defectInstanceTotal} total results)
		</div>

	</div>


</body>
</html>
