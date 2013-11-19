<table class="defectcard card ${defectInstance?.defectStatus?.collect{it.toString().toLowerCase()}?.join(' ')}">
    <tr>
        <td nowrap="" style="width: 40px; padding-left: 10px;">
            <i:avatar filename="${defectInstance?.assignedTo?.imageFilename}"
                username="${defectInstance?.assignedTo}"/>
            <span id="id-label" class="property-label"><g:message code="defect.id.label" default="ID" /></span>&nbsp;
            <span class="property-value" aria-labelledby="id-label">
                <g:link controller="defect" action="edit" id="${defectInstance?.id}"><g:fieldValue bean="${defectInstance}" field="id"/></g:link>
            </span>
        </td>
        <td style="width: 100px;">
            <span class="property-value" aria-labelledby="functionalArea-label">${defectInstance?.area?.encodeAsHTML()}</span>
        </td>
        <td style="width: 100px;">
            <span id="env-label" class="property-label">
                <g:message code="defect.env.label" default="Env:" />
            </span>&nbsp;
            <span class="property-value" aria-labelledby="env-label">
                <g:fieldValue bean="${defectInstance}" field="env"/>
            </span>
            <g:if test="${defectInstance?.story}">
                <br/>
                <span id="story-label" class="property-label"><g:message code="defect.story.label" default="Story" /></span>&nbsp;
                <span class="property-value" aria-labelledby="story-label">
                    <g:link controller="story" action="edit" id="${defectInstance?.story?.id}">${defectInstance?.story?.id}</g:link>
                </span>
            </g:if>
        </td>
        <td colspan="2" nowrap="" style="width: 80px;">
            <span class="property-value" aria-labelledby="status-label">${defectInstance?.status?.encodeAsHTML()}</span>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${defectInstance}" field="description"/></span>
        </td>
        <td>
            <span id="severity-label" class="property-label"><g:message code="defect.severity.label" default="Severity" /></span><br/>
            <span class="property-value" aria-labelledby="severity-label"><g:fieldValue bean="${defectInstance}" field="severity"/></span>
        </td>
        <td>
            <span id="severity-label" class="property-label"><g:message code="defect.targetDate.label" default="Target" /></span><br/>
            <span class="property-value" aria-labelledby="targetDate-label">${defectInstance?.targetDate?.format('MM/dd/yyyy')}</span>
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <span id="developerNotes-label" class="property-label">
                <a class="populate" data="developerNotes" dataId="${defectInstance?.id}"><g:message code="defect.developerNotes.label" default="Dev Notes" />${defectInstance?.developerNotes ? '*' : ''}</a>
            </span>&nbsp;
            <span id="qaNotes-label" class="property-label">
                <a class="populate" data="qaNotes" dataId="${defectInstance?.id}"><g:message code="defect.qaNotes.label" default="QA Notes" />${defectInstance?.qaNotes ? '*' : ''}</a>
            </span>&nbsp;
            <span id="resolution-label" class="property-label">
                <a class="populate" data="resolution" dataId="${defectInstance?.id}"><g:message code="defect.resolution.label" default="Resolution" />${defectInstance?.resolution ? '*' : ''}</a>
            </span>
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <div class="developerNotes${defectInstance?.id} data${defectInstance?.id}" style="display:none">
                <span class="property-value" aria-labelledby="developerNotes-label">${defectInstance?.developerNotes?.encodeAsHTML()}</span><br/>
                <span class="property-value"><a class="populate small" data="hide" dataId="${defectInstance?.id}">hide</a></span>
            </div>
            <div class="qaNotes${defectInstance?.id} data${defectInstance?.id}" style="display:none">
                <span class="property-value" aria-labelledby="qaNotes-label">${defectInstance?.qaNotes?.encodeAsHTML()}</span><br/>
                <span class="property-value"><a class="populate small" data="hide" dataId="${defectInstance?.id}">hide</a></span>
            </div>
            <div class="resolution${defectInstance?.id} data${defectInstance?.id}" style="display:none">
                <span class="property-value" aria-labelledby="resolution-label">${defectInstance?.resolution?.encodeAsHTML()}</span><br/>
                <span class="property-value"><a class="populate small" data="hide" dataId="${defectInstance?.id}">hide</a></span>
            </div>
        </td>
    </tr>
</table>