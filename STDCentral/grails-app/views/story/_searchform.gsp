<%@ page import="std.board.*"%>
<%@ page import="std.defect.*"%>

<h1 id="search">Search
    <img id="arrow" src="../images/skin/sorted_desc.gif">
</h1>

<div id="searchDiv"
    <g:if test="${! params.searching}">style="display:none;"</g:if>>

    <g:form name="searchForm" action="list" method="get">
        <fieldset class="form">
            <g:hiddenField name="searching" value="true" />
            <g:hiddenField name="viewBy" value="${params?.viewBy}"/>
            <div class="floatLeft fieldcontain">
                <label for="id">ID:</label>
                <g:textField name="id" value="${params?.id}" size="10"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label for="epic.id">Parent ID:</label>
                <g:textField name="epic.id" value="${params?.epic?.id}" size="10"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label for="functionalArea.id">Functional Area:</label>
                <g:select name="functionalArea.id"
                    from="${FunctionalArea.list()}" optionKey="id"
                    value="${params?.functionalArea?.id}" class="many-to-one"
                    noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="targetDateFrom">Target Date From:</label>
                <i:datepicker name="targetDateFrom" size="10" value="${params?.targetDateFrom}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="targetDateTo">To:</label>
                <i:datepicker name="targetDateTo" size="10" value="${params?.targetDateTo}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label for="phase">Phase:</label>
                <g:select name="phase"
                    from="${Story.listPhases()}" value="${params?.phase}"
                    class="many-to-one" noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="build">Build:</label>
                <g:select name="build"
                    from="${Story.listBuilds()}" value="${params?.build}"
                    class="many-to-one" noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="topic">Topic:</label>
                <g:textField name="topic" size="43" maxLength="255"
                    value="${params?.topic}"/>
            </div>
            <div class="floatLeft fieldcontain">
                <label for="targetDateFrom">Target Date Equals:</label>
                <i:datepicker name="targetDate" size="10" value="${params?.targetDate}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label for="priority">Priority:</label>
                <g:select name="priority" from="${Priority?.values()}"
                    value="${params?.priority}" noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="comment">Comment:</label>
                <g:textField name="comment" size="43" maxLength="255"
                    value="${params?.comment}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label for="state">State:</label>
                <g:select id="state" name="state.id" from="${BoardState.list()}"
                    optionKey="id" value="${params?.state?.id}"
                    class="many-to-one" noSelection="['':'']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="assumption">Assumption:</label>
                <g:textField name="assumption" size="43" maxLength="255"
                    value="${params?.assumption}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label for="assignedTo.id">Assigned To:</label>
                <g:select name="assignedTo.id"
                    from="${User.list()}" optionKey="id"
                    value="${params?.assignedTo?.id}" class="many-to-one"
                    noSelection="['': '']" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="confirmation">Confirmation:</label>
                <g:textField name="confirmation" size="43" maxLength="255"
                    value="${params?.confirmation}" />
            </div>
            <div class="clearLeft"></div>
            <div class="floatLeft fieldcontain">
                <label for="story">Story:</label>
                <g:textField name="story" size="43" maxLength="255"
                    value="${params?.story}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="blocked">Blocked:</label>
                <g:checkBox name="blocked"
                    value="${params?.blocked}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="notblocked">Not Blocked:</label>
                <g:checkBox name="notblocked"
                    value="${params?.notblocked}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="cancelled">Cancelled:</label>
                <g:checkBox name="cancelled"
                    value="${params?.cancelled}" />
            </div>
            <div class="floatLeft fieldcontain">
                <label for="notcancelled">Not Cancelled:</label>
                <g:checkBox name="notcancelled"
                    value="${params?.notcancelled}" />
            </div>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="clear" action="list" value="${message(code: 'default.button.search.label', default: 'Search')}"/>
            <input type="button" id="clearButton" class="clear" value="Reset">
        </fieldset>
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
