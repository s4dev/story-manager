<%@ page import="std.defect.User" %>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="user.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="40" required="" value="${userInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="user.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="60" required="" value="${userInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" maxlength="100" required="" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'imageFilename', 'error')} ">
	<label for="newImage">
		<g:message code="user.imageFilename.label" default="Current Avatar" />

	</label>
	<i:avatar filename="${userInstance?.imageFilename}"
  				username="${userInstance}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'imageFilename', 'error')} ">
	<label for="avatar">
		<g:message code="user.imageFilename.label" default="New Avatar" />

	</label>
	<input type="file" name="avatar" id="avatar" />
</div>
