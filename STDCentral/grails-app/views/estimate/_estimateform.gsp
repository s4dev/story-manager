<div class="fieldcontain ${hasErrors(bean: estimateInstance, field: 'amount', 'error')} ${hasErrors(bean: estimateInstance, field: 'amountType', 'error')}">
	<input type="hidden" name="estimates[${i}].id" value="${estimateInstance?.id}"/>
	<g:select name="estimates[${i}].type" from="${std.board.EstimateType?.values()}" keys="${std.board.EstimateType.values()*.name()}" value="${estimateInstance?.type?.name()}"/>
	<g:field type="number" name="estimates[${i}].amount" min="0" value="${estimateInstance?.amount}"/>
	<g:select name="estimates[${i}].amountType" from="${std.board.EstimateAmountType?.values()}" keys="${std.board.EstimateAmountType.values()*.name()}" value="${estimateInstance?.amountType?.name()}"/>
</div>
