<%@ page import="std.board.Story" %>
<!--
<div class="floatleft fieldcontain ${hasErrors(bean: storyInstance, field: 'epic', 'error')} " style="width:100%">
	<label for="epic">
		<g:message code="story.epic.label" default="Set Parent" />

	</label>
	<g:select id="epic" name="epic.id" from="${std.board.Story.list()}" optionKey="id" value="${storyInstance?.epic?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="clearLeft"></div>

-->
<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'functionalArea', 'error')} ">
	<label for="functionalArea">
		<g:message code="story.functionalArea.label" default="Functional Area" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="functionalArea" name="functionalArea.id" from="${std.board.FunctionalArea.list()}" optionKey="id" required="" value="${storyInstance?.functionalArea?.id}" class="many-to-one"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'phase', 'error')} ">
	<label for="phase">
		<g:message code="story.phase.label" default="Phase" />
	</label>
	<g:textField name="phase" size="5" maxLength="30" value="${storyInstance?.phase}"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'build', 'error')} ">
	<label for="build">
		<g:message code="story.build.label" default="Build" />
	</label>
	<g:textField name="build" size="5" maxLength="30" value="${storyInstance?.build}"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'topic', 'error')} ">
	<label for="topic">
		<g:message code="story.topic.label" default="Topic" />
	</label>
	<g:textField name="topic" size="43" maxLength="255" value="${storyInstance?.topic}"/>
</div>

<div class="clearLeft" style="width:100%"></div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'priority', 'error')} required">
	<label for="priority">
		<g:message code="story.priority.label" default="Priority" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="priority" from="${std.board.Priority?.values()}" keys="${std.board.Priority.values()*.name()}" required="" value="${storyInstance?.priority?.name()}"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="story.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="state" name="state.id" from="${std.board.BoardState.list()}" optionKey="id" required="" value="${storyInstance?.state?.id}" class="many-to-one"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'assignedTo', 'error')}">
	<label for="assignedTo">
		<g:message code="story.assignedTo.label" default="Assigned To" />
	</label>
	<g:select name="assignedTo.id" from="${std.defect.User.list()}" optionKey="id" value="${storyInstance?.assignedTo?.id}" noSelection="${['':' ']}"/>
</div>

<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'targetDate', 'error')}">
	<label for="targetDate">
		<g:message code="story.targetDate.label" default="Target Date" />
	</label>

	<i:datepicker name="targetDate" size="10" value="${storyInstance?.targetDate}"/>
</div>


<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'statement', 'error')} " style="width:100%;">
		<label for="statement">
			<g:message code="story.statement.label" default="Story" />
		</label><br/>
		<g:textArea name="statement" rows="5" cols="60" maxlength="1500" value="${storyInstance?.statement}" style="width:98%"/>
</div>

<g:if test="${storyInstance?.id}">

	<st:displayAssociation fieldname="defects" width="103%" truncateSize="0"
						   list="${storyInstance?.defects?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'assumptions', 'error')}"/>

	<st:displayAssociation fieldname="assumptions"
						   list="${storyInstance?.assumptions?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'assumptions', 'error')}"/>

	<st:displayAssociation fieldname="comments"
						   list="${storyInstance?.comments?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'comments', 'error')}"/>

	<div class="clearLeft"></div>

	<st:displayAssociation fieldname="confirmations"
						   list="${storyInstance?.confirmations?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'confirmations', 'error')}"/>

	<st:displayAssociation fieldname="requirements"
						   list="${storyInstance?.requirements?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'requirements', 'error')}"/>

	<div class="clearLeft"></div>

	<st:displayAssociation fieldname="estimates"
						   list="${storyInstance?.estimates?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'estimates', 'error')}"/>

	<st:displayAssociation fieldname="detailStories"
						   list="${storyInstance?.detailStories?.sort{it.id}}"
						   errorClass="${hasErrors(bean: storyInstance, field: 'detailStories', 'error')}"/>

	<div class="clearLeft"></div>

	<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'blocked', 'error')}">
		<label for="blocked">
			<g:message code="story.blocked.label" default="Blocked" />
		</label>
		<g:checkBox name="blocked" value="${true}" checked="${storyInstance?.blocked}" />
	</div>

	<div class="floatLeft fieldcontain ${hasErrors(bean: storyInstance, field: 'cancelled', 'error')}">
		<label for="cancelled">
			<g:message code="story.cancelled.label" default="Cancelled" />
		</label>
		<g:checkBox name="cancelled" value="${true}" checked="${storyInstance?.cancelled}" />
	</div>
</g:if>

<script>
	$(function(){
		$("#cancelled").click(function() {
			if ($(this).attr('checked'))
				$("#blocked").attr('checked', false);
		});

		$("#blocked").click(function() {
			if ($("#cancelled").attr('checked'))
				$("#blocked").attr('checked', false);
		});

		if ($("#cancelled").attr('checked')) {
			$("#blocked").attr('checked', false);
		}

		$("#targetDate").datepicker({dateFormat: 'yy/mm/dd'});
	});
</script>

