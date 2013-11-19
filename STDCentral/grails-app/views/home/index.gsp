<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Simple Tracking of Defects (STD)</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}

			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#status .red {
				text-transform: uppercase;
				text-decoration: none;
				font-style: italic;
				color: red !important;
			}

			#status a {
				text-decoration: none;
				color: #333333;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>

		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="status" role="complementary">
			<h1>Overview</h1>
			<ul>
				<li>Total Stories (Open): ${totalStories} (${storyOpenMap.get('open')})</li>
				<li>Total Defects (Open): ${totalDefects} (${defectOpenMap.get('open')})</li>

				<g:each var="state" in="${openStates}">
					<li>${state}: ${storyStateMap.get(state)} / ${defectStateMap.get(state)}</li>
				</g:each>
			</ul>
			<br>

			<h1>Open By User</h1>
			<ul>
				<g:each var="user" in="${allUsers}">
					<li><g:link controller="story" action="board" params="${['assignedTo.id': user?.id]}"><span class="${defectUserMap.get(user) > 0 ? 'red' : 'green'}">${user}</span></g:link>: ${storyUserMap.get(user)} / ${defectUserMap.get(user)}</li>
				</g:each>
			</ul>
			<br>

			<h1>Open Defects By Severity</h1>
			<ul>
				<g:each var="severity" in="${severities}">
					<li>${severity}: ${defectOpenMap.get(severity) ?: 0}</li>
				</g:each>
			</ul>
			<br>
			<h1>Open Stories By Priority</h1>
			<ul>
				<g:each var="priority" in="${priorities}">
					<li>${priority}: ${storyOpenMap.get(priority) ?: 0}</li>
				</g:each>
			</ul>

		</div>

		<div id="page-body" role="main">
			<h1>Simple Tracking of Development (STD) Central</h1>

			<p>STD Central is a safe place for talking about the many STD treatment options available.  After looking at a number of options, we believe that this is the best solution for promoting and maintaining healthy coding practices.

			<p>No one wants defects.  They can be avoided through careful
				and responsible behavior.
				Once you get a defect, you want to get rid of it ASAP.</p>

			<p>Practice safe coding.  Avoid defects.</p>

			<div id="controller-list" role="navigation">
				<h2>Available Actions:</h2>
				<ul>
					<li class="controller">
						<g:link controller="story">Manage Stories</g:link>
					</li>
					<li class="controller">
						<g:link controller="defect" action="list">Manage Defects</g:link>
					</li>
					<li style="list-style-type: none;">
						<h3>Reference Items:</h3>
						<ul>
							<li class="controller">
								<g:link controller="area" action="list">Screens</g:link>
							</li>
							<li class="controller">
								<g:link controller="user" action="list">Users</g:link>
							</li>
							<li class="controller">
								<g:link controller="status" action="list">Statuses</g:link>
							</li>
							<li class="controller">
								<g:link controller="severity" action="list">Severities</g:link>
							</li>
							<li class="controller">
								<g:link controller="env" action="list">Environments</g:link>
							</li>
							<li class="controller">
								<g:link controller="boardState" action="list">Story Board Stages</g:link>
							</li>
							<li class="controller">
								<g:link controller="functionalArea" action="list">Functional Areas</g:link>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

	</body>
</html>
