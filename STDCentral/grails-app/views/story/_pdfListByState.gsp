<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
		<div id="show-story" class="content scaffold-show" role="main">
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
						<g:if test="${0==idx%3}">
							<div class="clearLeft">
						</g:if>
								<div class="bordered floatLeft" style="padding-left: 1em;">
									<g:render template="storycard" model="${[storyInstance: storyInstance]}" />
								</div>
						<g:if test="${2==idx%3}">
							</div>
						</g:if>
					</g:each>
				</div>
			</g:each>
		</div>
