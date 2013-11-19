<%@ page import="std.defect.*" %>
<%@ page import="std.board.BoardState" %>


<div style="float:left; width:50%;">

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'area', 'error')} required">
		<label for="area">
			Screen <span class="required-indicator">*</span>
		</label>
		<g:textField id="area" name="area" value="${defectInstance?.area?.name}"/>
		<g:hiddenField id="areaId" name="areaId" value="${defectInstance?.area?.id}"/>
%{-- 		<g:select id="area.id" name="area.id"
			from="${Area.list()}" optionKey="id" required=""
			value="${defectInstance?.area?.id}" class="many-to-one"
			noSelection="['null': '']" />
 --}%	</div>

%{-- 	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'status', 'error')} required">
		<label for="status">
			Status <span class="required-indicator">*</span>
		</label>
		<g:select id="status" name="status.id" required=""
			from="${Status.list()}" optionKey="id"
			value="${defectInstance?.status?.id}" class="many-to-one"/>
	</div>
 --}%
	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'state', 'error')} required">
		<label for="state">
			Board State <span class="required-indicator">*</span>
		</label>
		<g:select id="state" name="state.id" required=""
			from="${BoardState.list()}" optionKey="id"
			value="${defectInstance?.state?.id}" class="many-to-one"/>
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'severity', 'error')} required">
		<label for="severity">
			Severity <span class="required-indicator">*</span>
		</label>
		<g:select id="severity" name="severity.id"
			from="${Severity.list()}" optionKey="id" required=""
			value="${defectInstance?.severity?.id}" class="many-to-one" />
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'description', 'error')} required">
		<label for="description">
			Description <span class="required-indicator">*</span>
		</label>
		<g:textArea name="description" cols="40" rows="5" maxlength="2147483646"
			required="" value="${defectInstance?.description}"/>
	</div>

	<g:if test="${defectInstance?.id}">
		<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'developerNotes', 'error')} ">
			<label for="developerNotes">
				Developer Notes
			</label>
			<g:textArea name="developerNotes" cols="40" rows="5"
				maxlength="2147483646" value="${defectInstance?.developerNotes}"/>
		</div>
	</g:if>

</div>


<!-- second column -->
<div style="float:right; width:50%;">

	<div class="floatLeft fieldcontain ${hasErrors(bean: defectInstance, field: 'env', 'error')} ">
		<label for="env">
			Environment
		</label>
		<g:select id="env" name="env.id" from="${Env.list()}"
			optionKey="id" value="${defectInstance?.env?.id ?: Env.findByName('Dev')?.id}" class="many-to-one"
			noSelection="['null': '']" />
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'targetDate', 'error')} ">
		<label for="targetDate">
			Target Date
		</label>
		<i:datepicker name="targetDate" size="10" value="${defectInstance?.targetDate}"/>
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'reportedBy', 'error')} required">
		<label for="reportedBy">
			Reported By	<span class="required-indicator">*</span>
		</label>
		<g:select id="reportedBy" name="reportedBy.id" required=""
			from="${User.list()}" optionKey="id"
			value="${defectInstance?.reportedBy?.id}" class="many-to-one"
			noSelection="['null': '']" />
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'assignedTo', 'error')} ">
		<label for="assignedTo">
			Assigned To
		</label>
		<g:select id="assignedTo" name="assignedTo.id"
			from="${User.list()}" optionKey="id"
			value="${defectInstance?.assignedTo?.id}" class="many-to-one"
			noSelection="['null': '']" />
	</div>

	<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'qaNotes', 'error')} ">
		<label for="qaNotes">
			QA Notes
		</label>
		<g:textArea name="qaNotes" cols="40" rows="5" maxlength="2147483646"
			value="${defectInstance?.qaNotes}"/>
	</div>

	<g:if test="${defectInstance?.id}">
		<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'resolution', 'error')} ">
			<label for="resolution">
				Resolution
			</label>
			<g:textArea name="resolution" cols="40" rows="5" maxlength="2147483646"
				value="${defectInstance?.resolution}"/>
		</div>
	</g:if>

</div>

<div style="clear:both;"></div>

<div class="fieldcontain ${hasErrors(bean: defectInstance, field: 'story', 'error')}">
	<label for="story">
		<g:message code="defect.story.label" default="Story" />
	</label>
	<g:select id="story" name="story.id" from="${storyList}"
		optionKey="id" value="${defectInstance?.story?.id}"
		noSelection="${['':'']}" class="many-to-one"/>
</div>

<script>
	$(function() {
		$("#area").autocomplete({
			source: ${Area.list().collect{"{label:'${it.toString()}', value:'${it.id}'}"}},
			delay: 500,
			select: function( event, ui ) {
				//update text field with selected item label
				//update hidden field with selected item id
				$("#area").val(ui.item.label);
				$("#areaId").val(ui.item.value);
				return false;
			},
			focus: function( event, ui ) {
				//update text field with focused label
				$("#area").val(ui.item.label);
				return false;
			},
			change: function( event, ui ) {
				//check to see if the value in the text box matches
				// the last list of values
				var matched = false;
				$( "#area" ).autocomplete( "widget" ).find("a").each(function() {
					if ($("#area").val() == $(this).html()) {
						matched = true;
					}
				});
				//if it doesn't match, consider it a new value and clear the id
				if (!matched)
					$("#areaId").val('');
			}
		});
	});
	var area_id;
</script>
