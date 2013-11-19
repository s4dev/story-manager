<%@ page import="std.board.*" %>

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
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div id="tabs-min" class="tabs-min">
                <ul>
                    <li><a href="#preiterationtabs">Pre-Iteration</a></li>
                    <li><a href="#iterationtabs">Iteration</a></li>
                    <li><a href="#postiterationtabs">Post-Iteration</a></li>
                </ul>
                <div id="preiterationtabs">
                    <ul>
                        <g:each in="${boardStates.findAll {BoardStateCategory.PRE_ITERATION == it.category}}" var="state" status="i">
                            <li>
                                <a href="#preiterationtabs-${i}">${state?.name}<br/>
                                    <span class="small">${listByState[state?.name]?.size() ?: 0} ${listByState[state?.name]?.size() == 1 ? 'Story' : 'Stories'} / ${defectListByState[state?.name]?.size() ?: 0} ${ 1 == defectListByState[state?.name]?.size() ? 'Defect' : 'Defects'}</span>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                    <g:each in="${boardStates.findAll {BoardStateCategory.PRE_ITERATION == it.category}}" var="state" status="i">
                        <div class="tabbed" id="preiterationtabs-${i}">
                            <g:render template="/defect/defectcardlist"
                                model="${[defectInstanceList: defectListByState[state?.name]]}"/>

                            <g:render template="storycardlist"
                                model="${[storyInstanceList: listByState[state?.name]]}"/>
                            <div class="clearLeft"><br/></div>
                        </div>
                    </g:each>
                </div>
                <div id="iterationtabs">
                    <ul>
                        <g:each in="${boardStates.findAll {BoardStateCategory.ITERATION == it.category}}" var="state" status="i">
                            <li>
                                <a href="#iterationtabs-${i}">${state?.name}<br/>
                                    <span class="small">${listByState[state?.name]?.size() ?: 0} ${listByState[state?.name]?.size() == 1 ? 'Story' : 'Stories'} / ${defectListByState[state?.name]?.size() ?: 0} ${ 1 == defectListByState[state?.name]?.size() ? 'Defect' : 'Defects'}</span>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                    <g:each in="${boardStates.findAll {BoardStateCategory.ITERATION == it.category}}" var="state" status="i">
                        <div class="tabbed" id="iterationtabs-${i}">
                            <g:render template="/defect/defectcardlist"
                                model="${[defectInstanceList: defectListByState[state?.name]]}"/>

                            <g:render template="storycardlist"
                                model="${[storyInstanceList: listByState[state?.name]]}"/>
                            <div class="clearLeft"><br/></div>
                        </div>
                    </g:each>
                </div>
                <div id="postiterationtabs">
                    <ul>
                        <g:each in="${boardStates.findAll {BoardStateCategory.POST_ITERATION == it.category}}" var="state" status="i">
                            <li>
                                <a href="#postiterationtabs-${i}">${state?.name}<br/>
                                    <span class="small">${listByState[state?.name]?.size() ?: 0} ${listByState[state?.name]?.size() == 1 ? 'Story' : 'Stories'} / ${defectListByState[state?.name]?.size() ?: 0} ${ 1 == defectListByState[state?.name]?.size() ? 'Defect' : 'Defects'}</span>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                    <g:each in="${boardStates.findAll {BoardStateCategory.POST_ITERATION == it.category}}" var="state" status="i">
                        <div class="tabbed" id="postiterationtabs-${i}">
                            <g:render template="/defect/defectcardlist"
                                model="${[defectInstanceList: defectListByState[state?.name]]}"/>

                            <g:render template="storycardlist"
                                model="${[storyInstanceList: listByState[state?.name]]}"/>
                            <div class="clearLeft"><br/></div>
                        </div>
                    </g:each>
                </div>
            </div>
            <div class="pagination">
                Story Card Count: ${storyInstanceTotal}&nbsp;&nbsp;
                Defect Card Count: ${defectInstanceTotal}
            </div>
        </div>
        <script>
            $(function() {
                $("#tabs-min").tabs({
                    selected: 1
                });

                $("#preiterationtabs").tabs({
                    collapsible: true,
                    selected: 0
                });

                $("#iterationtabs").tabs({
                    collapsible: true,
                    selected: 0
                });

                $("#postiterationtabs").tabs({
                    collapsible: true,
                    selected: 0
                });

                $(".populate").click(function() {
                    var divClass = $(this).attr("data");
                    var divId = $(this).attr("dataId");

                    if ($("."+divClass+divId).is(":hidden")) {
                        $(".data"+divId).hide();
                        $("."+divClass+divId).show();
                    } else {
                        $(".data"+divId).hide();
                    }
                });
            });
        </script>
    </body>
</html>