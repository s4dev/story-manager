	<tr style='mso-data-placement: same-cell;'>
		<td>${fieldValue(bean: storyInstance, field: "id")}</td>

		<td>${fieldValue(bean: storyInstance, field: "functionalArea")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "topic")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "statement")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "phase")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "build")}</td>
	
		<td>${fieldValue(bean: storyInstance, field: "state")}</td>
		
		<td><g:fieldValue bean="${storyInstance}" field="priority"/></td>

		<td>${fieldValue(bean: storyInstance, field: "assignedTo")}</td>
		
		<g:each in="${std.board.EstimateType}" var="type">
			<td>${storyInstance?.totalHourEstimate(type) ?: 0}</td>
		</g:each>
		<td>${storyInstance?.estimates*.calculateAmountByType(std.board.EstimateAmountType.HOURS)?.sum() ?: '-'}</td>
		<td>
			${storyInstance?.comments?.join("<br style='mso-data-placement: same-cell;'>")}
		</td>
		<td>
			${storyInstance?.assumptions?.join("<br style='mso-data-placement: same-cell;'>")}
		</td>
		<td>
			${storyInstance?.confirmations?.join("<br style='mso-data-placement: same-cell;'>")}
		</td>
	</tr>


