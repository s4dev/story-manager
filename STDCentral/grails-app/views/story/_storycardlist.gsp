<g:each in="${storyInstanceList}" var="storyInstance" status="idx" >
    <g:if test="${0==idx%2}">
        <div class="clearLeft"></div>
    </g:if>
    <div class="bordered floatLeft" style="padding-left: 1em;">
        <g:render template="storycard" model="${[storyInstance: storyInstance]}" />
    </div>
</g:each>