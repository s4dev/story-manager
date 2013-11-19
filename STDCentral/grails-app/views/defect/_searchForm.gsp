<%@ page import="std.defect.*" %>
<%@ page import="std.board.BoardState" %>

<h1 id="search">Search
    <img id="arrow" src="../images/skin/sorted_desc.gif">
</h1>

<div id="searchDiv"
    <g:if test="${! params.searching}">
        style="display:none;"
    </g:if>
>
    <g:form name="searchForm" action="list" method="get">
        <fieldset class="form">
            <g:hiddenField name="searching" value="true" />
            <div class="floatLeft fieldcontain">
                <label>Defect ID:</label>
                <g:textField name="id" value="${params?.id}" size="5"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label>Story ID:</label>
                <g:textField name="story.id" value="${params?.story?.id}" size="5"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label>Screen:</label>
                <g:textField name="area" value="${params?.area}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Target Date From:</label>
                <g:textField name="targetDateFrom" value="${params?.targetDateFrom}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>To:</label>
                <g:textField name="targetDateTo" value="${params?.targetDateTo}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label>Status:</label>
                <g:select name="status.id"
                    from="${Status.list()}" optionKey="id"
                    value="${params?.status?.id }" class="many-to-one"
                    noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Board State:</label>
                <g:select name="state.id"
                    from="${BoardState.list()}" optionKey="id"
                    value="${params?.state?.id }" class="many-to-one"
                    noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Severity:</label>
                <g:select name="severity.id"
                    from="${Severity.list()}" optionKey="id"
                    value="${params?.severity?.id}" class="many-to-one"
                    noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Target Date Equals:</label>
                <g:textField name="targetDate" value="${params?.targetDate}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label>Description:</label>
                <g:textField name="description"
                    value="${params?.description}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Dev Notes:</label>
                <g:textField name="developerNotes"
                    value="${params?.developerNotes}"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label>QA Notes:</label>
                <g:textField name="qaNotes"
                    value="${params?.qaNotes}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label>Reported By:</label>
                <g:select name="reportedBy.id"
                    from="${User.list()}" optionKey="id"
                    value="${params?.reportedBy?.id}" class="many-to-one"
                    noSelection="['': '']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label>Assigned To:</label>
                <g:select name="assignedTo.id"
                    from="${User.list()}" optionKey="id"
                    value="${params?.assignedTo?.id}" class="many-to-one"
                    noSelection="['': '']" />
            </div>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="Search"/>
            <input type="button" id="clearButton" value="Reset">
        </feildset>
    </g:form>
</div>

<script type="text/javascript">
    $(document).ready( function() {
        $("#search").click( toggleSearch );
        $("#clearButton").click( clearForm );
    });

    function toggleSearch() {
        if ( $('#searchDiv').is(':visible') ) {
            $('#searchDiv').hide();
            $('#arrow').attr('src','../images/skin/sorted_desc.gif')
        }
        else {
            $('#searchDiv').show();
            $('#arrow').attr('src','../images/skin/sorted_asc.gif')
        }
    }

    function clearForm() {
        $('#searchForm').find(':input:not(:button):not(:submit)').val('');
        $('#searching').val(true);
        //$('#searchForm').submit();
        return false;
    }
</script>
