<g:each in="${defectInstanceList}" var="defectInstance" status="idx" >
    <g:if test="${0==idx%2}">
        <div class="clearLeft"></div>
    </g:if>
    <div class="bordered floatLeft" style="padding-left: 1em;">
        <g:render template="/defect/defectcard" model="${[defectInstance: defectInstance]}" />
    </div>
</g:each>