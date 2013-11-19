
<%@ page import="std.board.Story" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
		<title>Stories By Functional Area</title>
	</head>
	<body>
		<a href="#show-story" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<g:render template="storymenu"/>
		<div id="show-story" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<g:each in="${storyInstanceList}" var="functionalArea">
					<tr>
						<td colspan="2"><h1>${functionalArea.key}</h1></td>
					</tr>
					<g:set var="themes" value="${themeList[functionalArea.key]}" />
					<g:if test="${themes?.size > 0}">
						<g:each in="${themes}" var="theme" >
							<tr>
								<td width="5"></td>
								<td>${theme}</td>
							</tr>
						</g:each>
					</g:if>
					<tr style="background:none;">
						<td width="5"></td>
						<td>
							<table>
								<thead>
									<tr>
										<th>ID</th>
										<th>Story</th>
										<th>Topic</th>
										<th>Phase</th>
										<th>Build</th>
										<th>State</th>
										<th>Priority</th>
										<th>Dev<br/>Assignment</th>
										<g:each in="${std.board.EstimateType}" var="type">
											<th>${type}</th>
										</g:each>
										<th>Total</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<g:each in="${functionalArea.value}" var="storyInstance" status="idx">
										<g:render template="storycardreport" model="${[storyInstance: storyInstance]}" />
									</g:each>
								</tbody>
								<tfoot>
									<tr>
										<th colspan="7"></th>
										<th nowrap="nowrap" style="text-align: right">
											Subtotals:
										</th>
										<g:set var="total" value="${0}"/>
										<g:each in="${std.board.EstimateType}" 
												var="type">
											<g:set var="tempAmt"
												value="${functionalArea.value*.totalHourEstimate(type).sum() ?: 0}"/>
											<g:set var="total" 
													value="${total + tempAmt}"/>
											<th>${tempAmt}</th>
										</g:each>
										<th>
											${total}
										</th>
										<th></th>
									</tr>
								</tfoot>
							</table>
						</td>
					</tr>
				</g:each>
			</table>
			<script>
				$(function() {
					$(".showextra").click(function() {
						//var divClass = $(this).attr("data");
						//var divId = $(this).attr("dataId");
						//$(".data"+divId).hide();
						//$("."+divClass+divId).show();
						$(this).closest("tr").next().find(".extra").show();
						return false;
					});
					$(".hideextra").click(function() {
						$(".extra").hide();
					})
				});
			</script>
		</div>
		<div class="nav">
		    <ul>
		    	<li style="width: 50%">&nbsp;</li>
				<li>Grand Totals</li>
				<g:each in="${grandTotalsMap}" var="entry">
					<li>${entry.key}</li><li>${entry.value}</li><li>&nbsp;&nbsp;</li>
				</g:each>
		  	</ul>
		</div>
	</body>
</html>
