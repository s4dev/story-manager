<%@ page import="std.board.StoryStatus" %>

<table class="card ${storyInstance?.storyStatus?.collect{it.toString().toLowerCase()}?.join(' ')}">
	<tr>
		<td nowrap="" style="width: 40px; padding-left: 10px;">
			<i:avatar filename="${storyInstance?.assignedTo?.imageFilename}"
				username="${storyInstance?.assignedTo}"/>
			<span id="id-label" class="property-label"><g:message code="story.id.label" default="ID" /></span>&nbsp;
			<span class="property-value" aria-labelledby="id-label">
				<g:link controller="story" action="edit" id="${storyInstance?.id}"><g:fieldValue bean="${storyInstance}" field="id"/></g:link>
			</span>
		</td>
		<td style="width: 100px;">
			<span class="property-value" aria-labelledby="functionalArea-label">${storyInstance?.functionalArea?.encodeAsHTML()}</span>
		</td>
		<td style="width: 100px;">
			<span class="property-value" aria-labelledby="topic-label"><g:fieldValue bean="${storyInstance}" field="topic"/></span>
		</td>
		<td colspan="2" nowrap="" style="width: 80px;">
			<span id="build-label" class="property-label"><g:message code="story.build.label" default="Build" /></span>&nbsp;
			<span class="property-value" aria-labelledby="build-label"><g:fieldValue bean="${storyInstance}" field="build"/></span><br/>
			<span class="property-value" aria-labelledby="state-label">${storyInstance?.state?.encodeAsHTML()}</span>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<span class="property-value" aria-labelledby="statement-label"><g:fieldValue bean="${storyInstance}" field="statement"/></span>
		</td>
		<td>
			<span id="priority-label" class="property-label"><g:message code="story.priority.label" default="Priority" /></span><br>
			<span class="property-value" aria-labelledby="priority-label"><g:fieldValue bean="${storyInstance}" field="priority"/></span>

		</td>
		<td>
			<span id="targetDate-label" class="property-label"><g:message code="story.targetDate.label" default="Target" /></span><br/>
			<span class="property-value" aria-labelledby="targetDate-label">${storyInstance?.targetDate?.format('MM/dd/yyyy')}</span>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<span id="defects-label" class="property-label">
				<a class="populate" data="defects" dataId="${storyInstance?.id}">
					<g:message code="story.defects.label" default="Defects" />
					<span class="small">(${storyInstance?.defects?.size() ?: 0})</span>
				</a>
			</span>&nbsp;
			<span id="comments-label" class="property-label">
				<a class="populate" data="comments" dataId="${storyInstance?.id}">
					<g:message code="story.comments.label" default="Comments" />
					<span class="small">(${storyInstance?.comments?.size() ?: 0})</span>
				</a>
			</span>&nbsp;
			<span id="assumptions-label" class="property-label">
				<a class="populate" data="assumptions" dataId="${storyInstance?.id}">
					<g:message code="story.assumptions.label" default="Assumptions" />
					<span class="small">(${storyInstance?.assumptions?.size() ?: 0})</span>
				</a>
			</span><br/>
			<span id="confirmations-label" class="property-label">
				<a class="populate" data="confirmations" dataId="${storyInstance?.id}">
					<g:message code="story.confirmations.label" default="Confirmations" />
					<span class="small">(${storyInstance?.confirmations?.size() ?: 0})</span>
				</a>
			</span>&nbsp;
			<span id="estimates-label" class="property-label">
				<a class="populate" data="estimates" dataId="${storyInstance?.id}">
					<g:message code="story.estimates.label" default="Estimates" />
					<span class="small">(${storyInstance?.estimates?.size() ?: 0})</span>
				</a>
			</span>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<div class="defects${storyInstance?.id} data${storyInstance?.id}" style="display:none">
				<g:each in="${storyInstance?.defects}" var="d">
					<span class="property-value" aria-labelledby="defects-label"><li>${d.defectStatus?.collect{"(${it.toString().toLowerCase().capitalize()})"}?.join(' ')} <g:link controller="defect" action="edit" id="${d.id}">${d?.encodeAsHTML()}</g:link></li></span><br/>
				</g:each>
				<span class="property-value" aria-labelledby="defects-label">
					<g:link controller="defect" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'defect.label', default: 'Defect')])}</g:link>
				</span>
				<span class="property-value"><a class="populate small" data="hide" dataId="${storyInstance?.id}">hide</a></span>
			</div>
			<div class="comments${storyInstance?.id} data${storyInstance?.id}" style="display:none">
				<g:each in="${storyInstance?.comments}" var="c">
					<span class="property-value" aria-labelledby="comments-label"><li><g:link controller="comment" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link></li></span><br/>
				</g:each>
				<span class="property-value" aria-labelledby="comments-label">
					<g:link controller="comment" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
				</span>
				<span class="property-value"><a class="populate small" data="hide" dataId="${storyInstance?.id}">hide</a></span>
			</div>
			<div class="assumptions${storyInstance?.id} data${storyInstance?.id}" style="display:none">
				<g:each in="${storyInstance?.assumptions}" var="a">
					<span class="property-value" aria-labelledby="assumptions-label"><li><g:link controller="assumption" action="edit" id="${a.id}">${a?.encodeAsHTML()}</g:link></li></span><br/>
				</g:each>
				<span class="property-value" aria-labelledby="assumptions-label">
					<g:link controller="assumption" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'assumption.label', default: 'Assumption')])}</g:link>
				</span>
				<span class="property-value"><a class="populate small" data="hide" dataId="${storyInstance?.id}">hide</a></span>
			</div>
			<div class="confirmations${storyInstance?.id} data${storyInstance?.id}" style="display:none">
				<g:each in="${storyInstance?.confirmations}" var="c">
					<span class="property-value" aria-labelledby="confirmations-label"><li><g:link controller="confirmation" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link></li></span><br/>
				</g:each>
				<span class="property-value" aria-labelledby="confirmations-label">
					<g:link controller="confirmation" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'confirmation.label', default: 'Confirmation')])}</g:link>
				</span>
				<span class="property-value"><a class="populate small" data="hide" dataId="${storyInstance?.id}">hide</a></span>
			</div>
			<div class="estimates${storyInstance?.id} data${storyInstance?.id}" style="display:none">
				<g:each in="${storyInstance?.estimates}" var="e">
					<span class="property-value" aria-labelledby="estimates-label"><li><g:link controller="estimate" action="edit" id="${e.id}">${e?.encodeAsHTML()}</g:link></li></span><br/>
				</g:each>
				<span class="property-value" aria-labelledby="estimates-label">
					<g:link controller="estimate" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'estimate.label', default: 'Estimate')])}</g:link>
				</span>
				<span class="property-value"><a class="populate small" data="hide" dataId="${storyInstance?.id}">hide</a></span>
			</div>
		</td>
	</tr>
</table>
