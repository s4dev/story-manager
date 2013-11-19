
<%@ page import="std.board.Story" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-story" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<g:render template="storymenu"/>
		<div id="show-story" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:render template="storyicons" />
			<div class="clearLeft"></div>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="clearLeft"></div>
<fieldset>
<!--
<div class="fieldcontain ${hasErrors(bean: storyInstance, field: 'epic', 'error')} ">
	<span id="epic-label" class="property-label">
		<g:message code="story.epic.label" default="Epic" />
	</span>
	<span class="property-show" aria-labelledby="epic-label">
		<g:link controller="story" action="show" id="${storyInstance?.epic?.id}">${storyInstance?.epic?.encodeAsHTML()}</g:link>
	</span>
</div>

<div class="clearLeft"></div>

-->
<div class="floatLeft fieldcontain">
	<span id="id-label" class="property-label">
		<g:message code="story.id.label" default="ID" />
	</span>
	<span class="property-show" aria-labelledby="id-label">
		<g:link controller="story" action="edit" id="${storyInstance?.id}">${storyInstance?.id?.encodeAsHTML()}</g:link>
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="functionalArea-label" class="property-label">
		<g:message code="story.functionalArea.label" default="Functional Area" />
	</span>
	<span class="property-show" aria-labelledby="functionalArea-label">
		<g:link controller="functionalArea" action="edit" id="${storyInstance?.functionalArea?.id}">${storyInstance?.functionalArea?.encodeAsHTML()}</g:link>
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="phase-label" class="property-label">
		<g:message code="story.phase.label" default="Phase.Build" />
	</span>
	<span class="property-show" aria-labelledby="phase-label">
		<g:fieldValue bean="${storyInstance}" field="phase"/>.<g:fieldValue bean="${storyInstance}" field="build"/>
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="topic-label" class="property-label">
		<g:message code="story.topic.label" default="Topic" />
	</span>
	<span class="property-show" aria-labelledby="topic-label">
		${"${storyInstance?.topic?.encodeAsHTML()?.padRight(43,' ')}".replace(' ', '&nbsp;')}
	</span>
</div>

<div class="floatRight fieldcontain">
	<span id="assignedTo-label" class="property-label">
		<g:message code="story.assignedTo.label" default="Assigned To" />
	</span>
	<span class="property-show" aria-labelledby="assignedTo-label" style="border: 1px none;">
		<g:link controller="user" action="show" id="${storyInstance?.assignedTo?.id}" ><i:avatar filename="${storyInstance?.assignedTo?.imageFilename}" username="${storyInstance?.assignedTo}"/></g:link>
	</span>
</div>

<div class="clearLeft"></div>

<div class="floatLeft fieldcontain">
	<span id="state-label" class="property-label">
		<g:message code="story.state.label" default="State" />
	</span>
	<span class="property-show" aria-labelledby="state-label">
		<g:link controller="boardState" action="show" id="${storyInstance?.state?.id}">${storyInstance?.state?.encodeAsHTML()}</g:link>
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="priority-label" class="property-label">
		<g:message code="story.priority.label" default="Priority" />
	</span>
	<span class="property-show" aria-labelledby="priority-label">
		<g:fieldValue bean="${storyInstance}" field="priority"/>
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="targetDate-label" class="property-label">
		<g:message code="story.targetDate.label" default="Target Date" />
	</span>
	<span class="property-show" aria-labelledby="targetDate-label">
		${storyInstance?.targetDate?.format('MM/dd/yyyy')}
	</span>
</div>

<div class="clearLeft"></div>

<div class="floatLeft fieldcontain" style="width:45%;">
	<span id="statement-label" class="property-label">
		<g:message code="story.statement.label" default="Story" />
	</span>
	<br/>
	<div class="fieldlist">
		<span class="label">
		<g:fieldValue bean="${storyInstance}" field="statement"/>
		</span>
	</div>
</div>

<st:editAssociation fieldname="confirmations" list="${storyInstance?.confirmations?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<div class="clearLeft"></div>

<st:editAssociation fieldname="assumptions" list="${storyInstance?.assumptions?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<st:editAssociation fieldname="defects" list="${storyInstance?.defects?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<div class="clearLeft"></div>

<st:editAssociation fieldname="comments" list="${storyInstance?.comments?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<st:editAssociation fieldname="requirements" list="${storyInstance?.requirements?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<div class="clearLeft"></div>

<st:editAssociation fieldname="estimates" list="${storyInstance?.estimates?.sort{it.id}}" parentId="${storyInstance?.id}"/>

<st:editAssociation fieldname="detailStories" list="${storyInstance?.detailStories?.sort{it.id}}" parentId="${storyInstance?.id}" controller="story"/>

<div class="clearLeft"></div>

<div class="floatLeft fieldcontain">
	<span id="blocked-label" class="property-label">
		<g:message code="story.blocked.label" default="Blocked" />
	</span>
	<span class="property-show" aria-labelledby="blocked-label">
		<g:checkBox disabled="disabled" name="blocked" value="${true}" checked="${storyInstance?.blocked}" />
	</span>
</div>

<div class="floatLeft fieldcontain">
	<span id="cancelled-label" class="property-label">
		<g:message code="story.cancelled.label" default="Cancelled" />
	</span>
	<span class="property-show" aria-labelledby="cancelled-label">
		<g:checkBox disabled="disabled" name="cancelled" value="${true}" checked="${storyInstance?.cancelled}" />
	</span>
</div>

</fieldset>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${storyInstance?.id}" />
					<g:link class="edit" action="edit" id="${storyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
