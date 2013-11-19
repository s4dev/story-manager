
<%@ page import="std.board.Story" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
		<title>Stories By Build and State</title>
	</head>
	<body>
		<a href="#show-story" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<g:render template="storymenu"/>
		<div id="show-story" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:each in="${storyInstanceList}" var="functionalArea">
				<div class="clearLeft medium" style="padding-top: 1em;"><h1>${functionalArea.key}</h1>
					<g:set var="themes" value="${themeList[functionalArea.key]}" />
					<g:if test="${themes?.size > 0}">
						<div class="bordered floatLeft small" style="padding-left: 3em;">
							<g:each in="${themes}" var="theme" >
								${theme}<br/>
							</g:each>
						</div>
					</g:if>
					<g:each in="${functionalArea.value}" var="storyInstance" status="idx">
						<g:if test="${0==idx%2}">
							<div class="clearLeft"></div>
						</g:if>
						<div class="bordered floatLeft" style="padding-left: 1em;">
							<g:render template="storycard"
								model="${[storyInstance: storyInstance]}" />
						</div>
					</g:each>
				</div>
			</g:each>
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
		</div>
	</body>
</html>
