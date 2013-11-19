<%@ page import="std.board.StoryStatus" %>

<g:if test="${storyInstance.storyStatus?.size()}">
    <div class="story-icons">
        <g:if test="${storyInstance?.storyStatus?.contains(StoryStatus.BLOCKED)}">
            <div class="floatLeft blocked"></div>
        </g:if>
        <g:if test="${storyInstance?.storyStatus?.contains(StoryStatus.CANCELLED)}">
            <div class="floatLeft cancelled"></div>
        </g:if>
        <g:if test="${storyInstance?.storyStatus?.contains(StoryStatus.COMPLETED)}">
            <div class="floatLeft completed"></div>
        </g:if>
    </div>
</g:if>
