	<tr>
	
		<td rowspan="2"><g:link action="show" id="${storyInstance.id}">${fieldValue(bean: storyInstance, field: "id")}</g:link></td>

		<td>${fieldValue(bean: storyInstance, field: "statement")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "topic")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "phase")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "build")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "state")}</td>
		
		<td><g:fieldValue bean="${storyInstance}" field="priority"/></td>

		<td>${fieldValue(bean: storyInstance, field: "assignedTo")}</td>
		
		<g:each in="${std.board.EstimateType}" var="type">
			<g:set var="tempAmt" 
				value="${storyInstance?.totalHourEstimate(type) ?: 0}"/>
			<td>${tempAmt}</td>
		</g:each>
		<td>${storyInstance?.estimates*.calculateAmountByType(std.board.EstimateAmountType.HOURS)?.sum() ?: '-'}</td>
		<td><a class="showextra"><span class="small">show</a>&nbsp;<a class="hideextra"><span class="small">hide</a></td>
	
	</tr>
	<tr>
		<td colspan="${9 + std.board.EstimateType.collect{it}.size()}" style="padding-top: 0px; padding-bottom: 0px;">
			<table class="extra" style="display:none; width: 100%;">
				<tr>
					<td>
						<span id="comments-label" class="property-label">
							<a class="populate" data="comments" dataId="${storyInstance?.id}"><g:message code="story.comments.label" default="Comments" /></a>
						</span>
					</td>
					<td colspan="3">
						<div class="comments${storyInstance?.id} data${storyInstance?.id}">
							<g:each in="${storyInstance?.comments}" var="c">
								<span class="property-value" aria-labelledby="comments-label"><g:link controller="comment" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link></span><br/>
							</g:each>
							<span class="property-value" aria-labelledby="comments-label">
								<g:link controller="comment" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span id="assumptions-label" class="property-label">
							<a class="populate" data="assumptions" dataId="${storyInstance?.id}"><g:message code="story.assumptions.label" default="Assumptions" /></a>
						</span>
					</td>
					<td colspan="3">
						<div class="assumptions${storyInstance?.id} data${storyInstance?.id}">
							<g:each in="${storyInstance?.assumptions}" var="a">
								<span class="property-value" aria-labelledby="assumptions-label"><g:link controller="assumption" action="edit" id="${a.id}">${a?.encodeAsHTML()}</g:link></span><br/>
							</g:each>
							<span class="property-value" aria-labelledby="assumptions-label">
								<g:link controller="assumption" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'assumption.label', default: 'Assumption')])}</g:link>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span id="confirmations-label" class="property-label">
							<a class="populate" data="confirmations" dataId="${storyInstance?.id}"><g:message code="story.confirmations.label" default="Confirmations" /></a>
						</span>
					</td>
					<td colspan="3">
						<div class="confirmations${storyInstance?.id} data${storyInstance?.id}">
							<g:each in="${storyInstance?.confirmations}" var="c">
								<span class="property-value" aria-labelledby="confirmations-label"><g:link controller="confirmation" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link></span><br/>
							</g:each>
							<span class="property-value" aria-labelledby="confirmations-label">
								<g:link controller="confirmation" action="create" 
										params="['story.id': storyInstance?.id]">
									${message(code: 'default.add.label', 
											  args: [message(code: 'confirmation.label', 
											  				 default: 'Confirmation')])
									}
								</g:link>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span id="estimates-label" class="property-label">
							<a class="populate" data="estimates" dataId="${storyInstance?.id}"><g:message code="story.estimates.label" default="Estimates" /></a>
						</span>
					</td>
					<td colspan="3">
						<div class="estimates${storyInstance?.id} data${storyInstance?.id}">
							<g:each in="${storyInstance?.estimates}" var="e">
								<span class="property-value" aria-labelledby="estimates-label"><g:link controller="estimate" action="edit" id="${e.id}">${e?.encodeAsHTML()}</g:link></span><br/>
							</g:each>
							<span class="property-value" aria-labelledby="estimates-label">
								<g:link controller="estimate" action="create" params="['story.id': storyInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'estimate.label', default: 'Estimate')])}</g:link>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>


