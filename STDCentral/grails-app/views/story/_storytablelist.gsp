<table>
    <thead>
        <tr>

            <th><g:message code="story.id.label" default="ID" /></th>

            <g:sortableColumn property="statement" title="${message(code: 'story.statement.label', default: 'Statement')}" />

            <th><g:message code="story.functionalArea.label" default="Functional Area" /></th>

            <th><g:message code="story.topic.label" default="Topic" /></th>

            <th><g:message code="story.build.label" default="Build" /></th>

            <g:sortableColumn property="priority" title="${message(code: 'story.priority.label', default: 'Priority')}" />

            <th><g:message code="story.state.label" default="State" /></th>

            <th><g:message code="story.assignedTo.label" default="Assigned To" /></th>

            <th>Estimate Total</th>

        </tr>
    </thead>
    <tbody>
        <g:each in="${storyInstanceList}" status="i" var="storyInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>
                    <g:link action="show" id="${storyInstance.id}">
                        ${fieldValue(bean: storyInstance, field: "id")}
                    </g:link>
                    <g:render template="storyicons"
                        model="${[storyInstance: storyInstance]}"/>
                </td>

                <td>${fieldValue(bean: storyInstance, field: "statement")}</td>

                <td>${fieldValue(bean: storyInstance, field: "functionalArea")}</td>

                <td>${fieldValue(bean: storyInstance, field: "topic")}</td>

                <td>${fieldValue(bean: storyInstance, field: "build")}</td>

                <td>${fieldValue(bean: storyInstance, field: "priority")}</td>

                <td>${fieldValue(bean: storyInstance, field: "state")}</td>

                <td>${fieldValue(bean: storyInstance, field: "assignedTo")}</td>

                <td>${storyInstance?.estimates*.calculateAmountByType(std.board.EstimateAmountType.HOURS)?.sum() ?: '-'}</td>

            </tr>
        </g:each>
    </tbody>
</table>