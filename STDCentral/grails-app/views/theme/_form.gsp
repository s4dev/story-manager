<%@ page import="std.board.Theme" %>



<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'deliverable', 'error')} ">
	<label for="deliverable">
		<g:message code="theme.deliverable.label" default="Deliverable" />
		
	</label>
	<g:textArea name="deliverable" cols="60" rows="5" maxlength="1500" value="${themeInstance?.deliverable}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'build', 'error')} required">
	<label for="build">
		<g:message code="theme.build.label" default="Build" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="build" required="" value="${themeInstance.build}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'functionalArea', 'error')} required">
	<label for="functionalArea">
		<g:message code="theme.functionalArea.label" default="Functional Area" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="functionalArea" name="functionalArea.id" from="${std.board.FunctionalArea.list()}" optionKey="id" required="" value="${themeInstance?.functionalArea?.id}" class="many-to-one"/>
</div>

