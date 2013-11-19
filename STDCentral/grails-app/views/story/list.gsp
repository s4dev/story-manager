
<%@ page import="std.board.Story" %>
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
			<g:render template="searchform" />

			<h1><g:message code="default.list.label" args="[entityName]" />
				<span class="small"><g:link action="list" params="${(([:] << params) << [viewBy:'card'])?.encodeAsSortableMap()}">Card View</g:link></span>
				<span class="small"><g:link action="list" params="${(([:] << params) << [viewBy:'list'])?.encodeAsSortableMap()}">List View</g:link></span>
			</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<g:if test="${params?.viewBy?.equals('card')}">
			    <g:render template="storycardlist"
			    	model="${[storyInstanceList: storyInstanceList]}"/>
			    <div class="clearLeft"><br/></div>
			</g:if>
			<g:else>
				<g:render template="storytablelist" />
			</g:else>

			<table>
			    <tfoot>
                    <tr>
                        <th>Subtotals</th>
                        <th>Assigned To</th>
                        <th>Story Count (IDs)</th>
                        <g:each in="${std.board.EstimateType}" var="type">
                            <th>${type}</th>
                        </g:each>
                        <th>Total</th>
                    </tr>
                    <g:set var="totalEstimate" value="${0}" />
                    <g:each in="${storyAssignmentSummary}" var="assignment">
                        <tr>
                            <td></td>
                            <td>${assignment.key ?: 'Not Assigned'}</td>
                            <td>${assignment.value?.size() ?: 0}
                                (${assignment.value?.collect {it.id}.join(", ")})</td>
                            <g:each in="${std.board.EstimateType}" var="type">
                                <td>${assignment.value*.totalHourEstimate(type)?.sum() ?: 0}</td>
                            </g:each>
                            <g:set var="estSubtotal"
                                value="${assignment.value*.totalHourEstimate()?.sum() ?: 0}" />
                            <g:set var="totalEstimate" value="${totalEstimate + estSubtotal}"/>
                            <td>${estSubtotal}</td>
                        </tr>
                    </g:each>
                    <tr>
                        <th colspan="7" style="text-align: right;">Total Estimate</th>

                        <th>${totalEstimate}</th>
                    </tr>
                </tfoot>
            </table>
			<div class="pagination">
				<g:paginate total="${storyInstanceTotal}"
					params="${params?.encodeAsSortableMap()}"/>
				(${storyInstanceTotal} total results)
			</div>
		</div>
        <script>
            $(function() {
                $(".populate").click(function() {
                    var divClass = $(this).attr("data");
                    var divId = $(this).attr("dataId");
                    $(".data"+divId).hide();
                    $("."+divClass+divId).show();
                });
            });
        </script>
	</body>
</html>
