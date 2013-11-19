<div class="nav" role="navigation">
    <ul>
        <li>
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        </li>
        <li>
            <g:if test="${actionName!='board'}">
                <g:link class="list" action="board">
                    Story Board
                </g:link>
            </g:if>
            <g:else>
                <g:form action="board">
                    <label for="assignedTo" ><a class="show">Assigned To:</a></label>
                    <g:select id="assignedTo" name="assignedTo.id" from="${std.defect.User.list()}"
                        optionKey="id" noSelection="${['':'All']}"
                        value="${params?.assignedTo?.id}"/>
                </g:form>
                <script>
                    $(function() {
                        $("#build").change(function() {
                            $(this).closest("form").submit();
                        });
                        $("#assignedTo").change(function() {
                            $(this).closest("form").submit();
                        });
                    });
                </script>
            </g:else>
        </li>
        <li>
            <g:link class="list" action="list">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li>
            <g:if test="${actionName!='listByState'}">
                <g:link class="list" action="listByState"
                    params="${[build: storyInstance?.build,
                                'state.id': std.board.BoardState.findByName('Backlog')?.id]}">
                    Stories By State
                </g:link>
            </g:if>
            <g:else>
                <g:form action="listByState">
                    <label for="build" ><a class="show">Build:</a></label>
                    <g:select id="build" name="build" from="${buildNumbers}"
                        value="${params.build}"/>
                    <g:select id="stateId" name="state.id" from="${std.board.BoardState.list()}"
                        optionKey="id" optionValue="name" value="${params?.state?.id}"/>
                </g:form>
                <script>
                    $(function() {
                        $("#build").change(function() {
                            $(this).closest("form").submit();
                        });
                        $("#stateId").change(function() {
                            $(this).closest("form").submit();
                        });
                    });
                </script>
            </g:else>
        </li>
        <li>
            <g:if test="${actionName!='listByBuild'}">
                <g:link class="list" action="listByBuild" params="${[build: storyInstance?.build]}">
                    Stories By Build
                </g:link>
            </g:if>
            <g:else>
                <g:form action="listByBuild">
                    <label for="build" ><a class="show">Build:</a></label>
                    <g:select id="build" name="build" from="${buildNumbers}"
                        value="${params.build}"/>
                </g:form>
                <script>
                    $(function() {
                        $("#build").change(function() {
                            $(this).closest("form").submit();
                        });
                        $("#next").click(function() {
                            var b = $('#build option:selected').next();
                            $('#build').val(b.attr("value"));
                            $('#build').closest("form").submit();
                        });
                    });
                </script>
                </li>
                <li>
                    <g:submitButton id="next" name="next" value="Next"/>
            </g:else>
        </li>
        <li>
            <g:if test="${actionName!='storyReport'}">
                <g:link class="list" action="storyReport">Stories By Area</g:link>
            </g:if>
            <g:else>
                <g:form action="storyReport">
                    <label for="area" ><a class="show">Functional Area:</a></label>
                    <g:select id="area" name="area" from="${std.board.FunctionalArea.list()}"
                        optionKey="id" noSelection="${['':'All Areas']}" value="${params.area}"/>
                </g:form>
                <script>
                    $(function() {
                        $("#area").change(function() {
                            $(this).closest("form").submit();
                        });
                    });
                </script>
                </li>
                <li>
                <g:link class="export" action="storyReport" params="${[format:"xls"]}">
                    <g:message code="default.export.label" default="Export to Excel" />
                </g:link>
            </g:else>
        </li>
        <li>
            <g:link class="create" action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </li>
    </ul>
</div>