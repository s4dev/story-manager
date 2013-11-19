<%@ page import="std.board.FunctionalArea" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
        <title><g:message code="buildPlan.label" default="Build Plan" /></title>
    </head>
    <body>
        <a href="#list-story" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <g:render template="storymenu"/>
        <div id="list-story" class="content scaffold-list" role="main">
            <h1><g:message code="buildPlan.label" default="Build Plan" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:each in="${builds}" var="build">
                <div class="build boxed"
                    style="text-align: center; padding: 1em; padding-top: 0px; margin-left: 1em; margin-right: 1em; margin-bottom: 5em;">
                    <h2>Build ${build.key}</h2>
                    <div class="floatLeft"
                         style="width: 32%; text-align:left;">
                        <div class="boxed guide" style=" padding: 0.5em;">
                            <h3>Guide Administration</h3><br>
                            <g:set var="functionalArea"
                                value="${build.value?.find{it.key?.name == 'Guide Administration'}}" />
                            <ul class="one-to-many">
                            <g:each in="${functionalArea?.value}" var="story">
                                <li><d:truncate>${story.statement}</d:truncate></li>
                            </g:each>
                            </ul>
                        </div>
                    </div>

                    <div class="floatLeft" style="width: 32%; text-align: left; margin-left: 1%">
                        <div class="boxed admin" style="padding: 0.5em;">
                            <h3>Publication</h3><br>
                            <g:set var="functionalArea"
                                value="${build.value?.find{it.key?.name == 'Publication'}}" />
                            <ul class="one-to-many">
                            <g:each in="${functionalArea?.value}" var="story">
                                <li><d:truncate>${story.statement}</d:truncate></li>
                            </g:each>
                            </ul>
                        </div>
                        <div class="boxed research"
                             style="padding: 0.5em; margin-top: 10px;">
                            <h3>Research</h3><br>
                            <g:set var="functionalArea"
                                value="${build.value?.find{it.key?.name == 'Research'}}" />
                            <ul class="one-to-many">
                            <g:each in="${functionalArea?.value}" var="story">
                                <li><d:truncate>${story.statement}</d:truncate></li>
                            </g:each>
                            </ul>
                        </div>
                    </div>

                    <div class="floatLeft" style="width: 32%; text-align:left; margin-left: 1%;">
                        <div class="boxed viewer"
                             style="padding: 0.5em;">
                            <h3>Guide Viewer</h3><br>
                            <g:set var="functionalArea"
                                value="${build.value?.find{it.key?.name == 'Guide Viewer'}}" />
                            <ul class="one-to-many">
                            <g:each in="${functionalArea?.value}" var="story">
                                <li><d:truncate>${story.statement}</d:truncate></li>
                            </g:each>
                            </ul>
                        </div>
                        <div class="boxed research"
                             style="padding: 0.5em; margin-top: 10px;">
                            <h3>Program Administration</h3><br>
                            <g:set var="functionalArea"
                                value="${build.value?.find{it.key?.name == 'Program Administration'}}" />
                            <ul class="one-to-many">
                            <g:each in="${functionalArea?.value}" var="story">
                                <li><d:truncate>${story.statement}</d:truncate></li>
                            </g:each>
                            </ul>
                        </div>
                    </div>
                    <div style="clear: both;">TODO: add all functional areas</div>
                </div>
                <div style="clear: both;"></div>
            </g:each>
        </div>
    </body>
</html>
