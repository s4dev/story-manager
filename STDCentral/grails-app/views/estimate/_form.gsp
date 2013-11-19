<%@ page import="std.board.Estimate" %>



<div class="fieldcontain ${hasErrors(bean: estimateInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="estimate.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" min="0" required="" value="${estimateInstance.amount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estimateInstance, field: 'amountType', 'error')} required">
	<label for="amountType">
		<g:message code="estimate.amountType.label" default="Amount Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="amountType" from="${std.board.EstimateAmountType?.values()}" keys="${std.board.EstimateAmountType.values()*.name()}" required="" value="${estimateInstance?.amountType?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estimateInstance, field: 'story', 'error')} required">
	<label for="story">
		<g:message code="estimate.story.label" default="Story" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="story" name="story.id" from="${std.board.Story.list()}" optionKey="id" required="" value="${estimateInstance?.story?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estimateInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="estimate.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${std.board.EstimateType?.values()}" keys="${std.board.EstimateType.values()*.name()}" required="" value="${estimateInstance?.type?.name()}"/>
</div>

