
<%@ page import="std.board.Story" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-story" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<g:render template="storymenu"/>
		<div id="list-story" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="story.id.label" default="ID" /></th>
					
						<th><g:message code='story.statement.label' default='Statement' /></th>
					
						<th><g:message code="story.functionArea.label" default="Functional Area" /></th>
					
						<th><g:message code='story.topic.label' default='Topic' /></th>
					
						<th><g:message code="story.state.label" default="State" /></th>
						
						<th><g:message code="story.build.label" default="Build" /></th>
						
						<th>
							Assigned To <a class="editAssigned showme"><span class="small">edit</span></a><a class="showAssigned editme" style="display:none"><span class="small">show</span></a>
						</th>
						
						<th>Estimate Total</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${storyInstanceList}" status="i" var="storyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${storyInstance.id}">${fieldValue(bean: storyInstance, field: "id")}</g:link></td>
					
						<td>${fieldValue(bean: storyInstance, field: "statement")}</td>
					
						<td>${fieldValue(bean: storyInstance, field: "functionalArea")}</td>
					
						<td>${fieldValue(bean: storyInstance, field: "topic")}</td>
					
						<td>${fieldValue(bean: storyInstance, field: "state")}</td>
						
						<td>${fieldValue(bean: storyInstance, field: "build")}</td>
						
						<td>
							<div class="showme">
								${fieldValue(bean: storyInstance, field: "assignedTo")}
							</div>
							<div class="editme" style="display:none">
								<g:formRemote name="assigned" onSuccess="updatedDone()" 
										url="[controller: 'story', action:'updateAssignedTo']">
									<input type="hidden" name="id" value="${storyInstance?.id}"/>
									<g:select class="assignedTo" name="story.assignedTo.id" 
											  from="${std.defect.User.list()}" optionKey="id" 
											  value="${storyInstance?.assignedTo?.id}" 
											  noSelection="${['':' ']}"/>
								</g:formRemote>
							</div>
						</td>
						
						<td>${storyInstance?.estimates*.calculateAmountByType(std.board.EstimateAmountType.HOURS)?.sum() ?: '-'}</td>
					
					</tr>
				</g:each>
					<tr>
						<td colspan="8"><hr/></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<th>Subtotals</th>
						<th>Assigned To</th>
						<th># Stories</th>
						<g:each in="${std.board.EstimateType}" var="type">
							<th>${type}</th>
						</g:each>
						<th>Total</th>
					</tr>
					<g:each in="${storyInstanceList.groupBy{it.assignedTo}.sort{it.key}}" var="assignment">
						<tr>
							<td></td>
							<td>${assignment.key}</td>
							<td>${assignment.value?.size() ?: 0}
								(${assignment.value?.collect {it.id}.join(", ")})</td>
							<g:each in="${std.board.EstimateType}" var="type">
								<td>${assignment.value*.totalHourEstimate(type)?.sum() ?: 0}</td>
							</g:each>
							<td>${assignment.value*.totalHourEstimate()?.sum() ?: 0}</td>
						</tr>
					</g:each>
					<tr>
						<th colspan="7" style="text-align: right;">Total Estimate</th>
						
						<th>${totalEstimate}</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div id="updated" style="display:none">Saved</div>
		<script>
			$(function() {
				$(".assignedTo").change(function() {
					alert('submitting...');
					$(this).closest("form").submit();
					$(this).closest("td").children('.showme').html($(this).children("[selected]").text());
				});
				
				$(".editAssigned").click(function() {
					$('.showme').fadeOut("slow", function() {
						$(".editme").fadeIn("slow");
					});
				});
				
				$(".showAssigned").click(function() {
					$('.editme').fadeOut("slow", function() {
						$(".showme").fadeIn("slow");
					});
				});
			})
			function updatedDone(data) {
				$("#updated").fadeIn("slow");
				$("#updated").fadeOut("slow");
			}
		</script>
	</body>
</html>
