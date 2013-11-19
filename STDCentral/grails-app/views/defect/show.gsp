
<%@ page import="std.defect.Defect" %>

<!doctype html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'defect.label', default: 'Defect')}" />
	<title>Show Defect</title>
</head>
<body>

	<a href="#show-defect" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
	</div>

	<div id="show-defect" class="content scaffold-show" role="main">

		<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
		</g:if>
		<ol class="property-list defect">

			<li class="fieldcontain">
				<span id="id-label" class="property-label">Defect ID</span>
					<span class="property-value">
						${defectInstance?.id}
					</span>
			</li>

			<li class="fieldcontain">
				<span id="story-label" class="property-label">Story ID</span>
					<span class="property-value">
						${defectInstance?.story?.id}
					</span>
			</li>

			<li class="fieldcontain">
				<span id="area-label" class="property-label">Screen</span>
					<span class="property-value" aria-labelledby="area-label">
						<g:link controller="area" action="show" id="${defectInstance?.area?.id}">
							${defectInstance?.area?.encodeAsHTML()}
						</g:link>
					</span>
			</li>

%{-- 			<li class="fieldcontain">
				<span id="status-label" class="property-label">Status</span>

					<span class="property-value" aria-labelledby="status-label"><g:link controller="status" action="show" id="${defectInstance?.status?.id}">${defectInstance?.status?.encodeAsHTML()}</g:link></span>
			</li>
 --}%
			<li class="fieldcontain">
				<span id="state-label" class="property-label">Board State</span>

					<span class="property-value" aria-labelledby="state-label"><g:link controller="boardState" action="show" id="${defectInstance?.state?.id}">${defectInstance?.state?.encodeAsHTML()}</g:link></span>
			</li>

			<li class="fieldcontain">
				<span id="severity-label" class="property-label">Severity</span>

					<span class="property-value" aria-labelledby="severity-label"><g:link controller="severity" action="show" id="${defectInstance?.severity?.id}">${defectInstance?.severity?.encodeAsHTML()}</g:link></span>
			</li>

			<g:if test="${defectInstance?.targetDate}">
			<li class="fieldcontain">
				<span id="targetDate-label" class="property-label">Target Date</span>

					<span class="property-value" aria-labelledby="targetDate-label">${defectInstance?.targetDate?.format('MM/dd/yyyy')}</span>
			</li>
			</g:if>

			<g:if test="${defectInstance?.env}">
			<li class="fieldcontain">
				<span id="env-label" class="property-label"><g:message code="defect.env.label" default="Environment" /></span>

					<span class="property-value" aria-labelledby="env-label"><g:link controller="env" action="show" id="${defectInstance?.env?.id}">${defectInstance?.env?.encodeAsHTML()}</g:link></span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.reportedBy}">
			<li class="fieldcontain">
				<span id="reportedBy-label" class="property-label"><g:message code="defect.reportedBy.label" default="Reported By" /></span>

					<span class="property-value" aria-labelledby="reportedBy-label"><g:link controller="user" action="show" id="${defectInstance?.reportedBy?.id}">${defectInstance?.reportedBy?.encodeAsHTML()}</g:link></span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.assignedTo}">
			<li class="fieldcontain">
				<span id="assignedTo-label" class="property-label"><g:message code="defect.assignedTo.label" default="Assigned To" /></span>

					<span class="property-value" aria-labelledby="assignedTo-label">
						<i:avatar filename="${defectInstance?.assignedTo?.imageFilename}"
							username="${defectInstance?.assignedTo}"/>
						<g:link controller="user" action="show"
							id="${defectInstance?.assignedTo?.id}">
							${defectInstance?.assignedTo?.encodeAsHTML()}
						</g:link>
					</span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.description}">
			<li class="fieldcontain">
				<span id="description-label" class="property-label"><g:message code="defect.description.label" default="Description" /></span>

					<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${defectInstance}" field="description"/></span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.developerNotes}">
			<li class="fieldcontain">
				<span id="developerNotes-label" class="property-label"><g:message code="defect.developerNotes.label" default="Developer Notes" /></span>

					<span class="property-value" aria-labelledby="developerNotes-label"><g:fieldValue bean="${defectInstance}" field="developerNotes"/></span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.qaNotes}">
			<li class="fieldcontain">
				<span id="qaNotes-label" class="property-label"><g:message code="defect.qaNotes.label" default="QA Notes" /></span>

					<span class="property-value" aria-labelledby="qaNotes-label"><g:fieldValue bean="${defectInstance}" field="qaNotes"/></span>

			</li>
			</g:if>

			<g:if test="${defectInstance?.resolution}">
			<li class="fieldcontain">
				<span id="resolution-label" class="property-label"><g:message code="defect.resolution.label" default="Resolution" /></span>

					<span class="property-value" aria-labelledby="resolution-label"><g:fieldValue bean="${defectInstance}" field="resolution"/></span>
			</li>
			</g:if>

			<li class="fieldcontain">
				<span id="dateCreated-label" class="property-label">Create Date</span>
					<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${defectInstance?.createDT}" format="MM/dd/yyyy" /></span>
			</li>

			<g:if test="${defectInstance?.updateDT}">
			<li class="fieldcontain">
				<span id="lastUpdated-label" class="property-label">Review Date</span>
					<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${defectInstance?.updateDT}" format="MM/dd/yyyy" /></span>
			</li>
			</g:if>

		</ol>

		<g:form>
			<fieldset class="buttons">
				<g:hiddenField name="id" value="${defectInstance?.id}" />
				<g:link class="edit" action="edit" id="${defectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>

				<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" style="float:right;" />
			</fieldset>
		</g:form>

	</div>
</body>
</html>
