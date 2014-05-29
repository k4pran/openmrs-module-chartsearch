<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:htmlInclude file="/dwr/interface/DWRCommands.js"/>

<openmrs:require privilege="Add synonym Groups" otherwise="/login.htm"
                 redirect="/module/chartsearch/addsynonymgroup.form"/>

<%@ include file="/WEB-INF/template/header.jsp" %>

<openmrs:htmlInclude file="/moduleResources/chartsearch/js/commands.js"/>

<%@ include file="template/localHeader.jsp" %>


<script>
    var $ = jQuery;
    var count = 0;
    function addInput() {
        count += 1;
        var rowId = "rowAdd" + count;
        var boxName = "synonymNameAdd" + count;


        var newRow = "<p class=\"inputRow\" id=" + rowId + "> <input type=\"text\" name=" + boxName + ">" +
                " <button type=\"button\" class=\"deleteBtn\" onclick=\"deleteInput(" + rowId + ")\">Delete Synonym</button> </p>";

        /* var deleteBtn = "<button type=\"button\" class=\"deleteBtn\" onclick=\"deleteInput(" + deleteRowId + ")\">Delete</button>";*/
        /* $('.addBtn').last().replaceWith(deleteBtn);*/
        /*"<button type=\"button\" class=\"addBtn\" onclick=\"addInput()\">Add</button> </p>"*/
        $('.inputRow').last().after(newRow);

    }

    function deleteInput(row) {
        $(row).remove();
    }

</script>

<div id="synonymDiv">
    <h3> Add synonym group page </h3>


    <form id="addSynonymGroupForm" method="post">
        <button type="button" class="addBtn" onclick="addInput()">Add Synonym</button>
        <br> <br>
        <input type="text" name="groupName" value="${synonymGroup.groupName}" placeholder="Group name">

        <input type="checkbox" name="category" ${isCategory}>Is Category
        <br>

        <c:forEach items="${synonymGroup.synonymSet}" var="synonym" varStatus="loop">
            <p class="inputRow" id="rowEdit${synonym.synonymId}">
                <input type="text" name="synonymNameEdit${synonym.synonymId}" value="${synonym.synonymName}">
                <%--<button type="button" class="deleteBtn" onclick="deleteInput(rowEdit${synonym.synonymId})">Delete
                    Synonym
                </button>--%>
            </p>
        </c:forEach>

        <p hidden class="inputRow"></p>

        <c:choose>
            <c:when test="${!empty synonymGroup.groupName}">
                <input type="text" name="save" id="groupName" value="${synonymGroup.groupName}" hidden>
            </c:when>
            <c:otherwise>
                <input type="text" name="save" value="save" hidden>
            </c:otherwise>
        </c:choose>

        <br>
        <input type="submit" value="Save Synonym Group">
        <input type="button" value='<spring:message code="general.cancel"/>'
               onclick="javascript:window.location='<openmrs:contextPath />/admin'"/>
        <c:choose>
            <c:when test="${!empty synonymGroup.groupName}">
                <input type="button" id="deleteSynGrpBtn" value="Delete Synonym Group"/>
            </c:when>
        </c:choose>

    </form>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %>