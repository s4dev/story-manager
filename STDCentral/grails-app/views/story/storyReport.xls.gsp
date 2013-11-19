
<%@ page import="std.board.Story" %>

<html xmlns:x="urn:schemas-microsoft-com:office:excel">
    <head>
        <meta name="layout" content="main2">
        <g:set var="entityName" value="${message(code: 'story.label', default: 'Story')}" />
        <title>Stories By Functional Area</title>
    </head>
    <body>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Functional Area</th>
                    <th>Topic</th>
                    <th>Story</th>
                    <th>Phase</th>
                    <th>Build</th>
                    <th>State</th>
                    <th>Priority</th>
                    <th>
                        Dev<br style='mso-data-placement: same-cell;'/>Assignment
                    </th>
                    <g:each in="${std.board.EstimateType}" var="type">
                        <th>${type}</th>
                    </g:each>
                    <th>Total</th>
                    <th>Comments</th>
                    <th>Assumptions</th>
                    <th>Confirmations</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${storyInstanceList}" var="functionalArea">
                    <g:each in="${functionalArea.value}" var="storyInstance" 
                            status="idx">
                        <g:render template="storycardreport.xls" 
                                    model="${[storyInstance: storyInstance]}" />
                    </g:each>
                </g:each>
            </tbody>
        </table>
    </body>
</html>
