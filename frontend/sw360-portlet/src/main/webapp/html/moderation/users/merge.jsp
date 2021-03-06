<%--
  ~ Copyright Siemens AG, 2013-2016. Part of the SW360 Portal User.
  ~
  ~ All rights reserved. This program and the accompanying materials
  ~ are made available under the terms of the Eclipse Public License v1.0
  ~ which accompanies this distribution, and is available at
  ~ http://www.eclipse.org/legal/epl-v10.html
  --%>
<%@include file="/html/init.jsp"%>



<portlet:defineObjects />
<liferay-theme:defineObjects />

<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="com.liferay.portlet.PortletURLFactoryUtil" %>
<%@ page import="com.siemens.sw360.portal.common.PortalConstants" %>
<%@ page import="com.siemens.sw360.datahandler.thrift.moderation.DocumentType" %>

<jsp:useBean id="newuser" type="com.siemens.sw360.datahandler.thrift.users.User" scope="request"/>
<jsp:useBean id="moderationRequest" class="com.siemens.sw360.datahandler.thrift.moderation.ModerationRequest" scope="request"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sw360.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/external/jquery-ui.css">
<script src="<%=request.getContextPath()%>/js/external/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/jquery.validate.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/additional-methods.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/jquery-ui.min.js"></script>

<div id="header"></div>
<p class="pageHeader"><span class="pageHeaderBigSpan">Moderation New User:  <sw360:UserName user="${newuser}"/></span>
</p>
<input type="button" onclick="acceptDelete()" id="edit" value="Accept Request"    class="acceptButton">&nbsp;
<input type="button" onclick="removeFromModerators()" id="edit" value="Remove Me from Moderators"    class="ignoreButton">&nbsp;
<input type="button" onclick="declineDelete()" id="edit" value="Decline Request"    class="addButton">&nbsp;
<input type="button" onclick="postPone()" id="edit" value="Postpone Request"    class="postponeButton">&nbsp;
<input type="button" onclick="cancel()" id="edit" value="Cancel"    class="cancelButton">

<h2>Proposed User Attributes</h2>
<div id="content">
<table class="table info_table" id="userOverview" title="User details">
    <thead>
    <tr>
        <th colspan="2"><sw360:out value="User Details: ${newuser.fullname}"/></th>
    </tr>
    </thead>
    <tr>
        <td>First Name:</td>
        <td><sw360:out value="${newuser.givenname}"/></td>
    </tr>
    <tr>
        <td>Last Name:</td>
        <td><sw360:out value="${newuser.lastname}"/></td>
    </tr>
    <tr>
        <td>Email:</td>
        <td><sw360:out value="${newuser.email}"/></td>
    </tr>
    <tr>
        <td>Group:</td>
        <td><sw360:out value="${newuser.department}"/></td>
    </tr>
    <tr>
        <td>Role:</td>
        <td><sw360:DisplayEnum value="${newuser.userGroup}"/></td>
    </tr>
    <tr>
        <td>External Id:</td>
        <td><sw360:out value="${newuser.externalid}"/></td>
    </tr>
</table>
</div>

<script>
    function getBaseURL(){
        var baseUrl = '<%= PortletURLFactoryUtil.create(request, portletDisplay.getId(), themeDisplay.getPlid(), PortletRequest.RENDER_PHASE) %>';
        var portletURL = Liferay.PortletURL.createURL(baseUrl)
                .setParameter('<%=PortalConstants.PAGENAME%>', '<%=PortalConstants.PAGENAME_ACTION%>')
                .setParameter('<%=PortalConstants.MODERATION_ID%>', '${moderationRequest.id}')
                .setParameter('<%=PortalConstants.DOCUMENT_TYPE%>', '<%=DocumentType.USER%>');

        return portletURL;
    }

    function acceptDelete() {
        var portletURL = getBaseURL().setParameter('<%=PortalConstants.ACTION%>', '<%=PortalConstants.ACTION_ACCEPT%>');
        window.location = portletURL.toString();
    }

    function removeFromModerators() {
        var portletURL = getBaseURL().setParameter('<%=PortalConstants.ACTION%>', '<%=PortalConstants.ACTION_REMOVEME%>');
        window.location = portletURL.toString();
    }

    function declineDelete() {
        var portletURL = getBaseURL().setParameter('<%=PortalConstants.ACTION%>', '<%=PortalConstants.ACTION_DECLINE%>');
        window.location = portletURL.toString();
    }

    function postPone() {
        var portletURL = getBaseURL().setParameter('<%=PortalConstants.ACTION%>', '<%=PortalConstants.ACTION_POSTPONE%>');
        window.location = portletURL.toString();
    }

    function cancel() {
        var portletURL = getBaseURL().setParameter('<%=PortalConstants.ACTION%>', '<%=PortalConstants.ACTION_CANCEL%>');
        window.location = portletURL.toString();
    }
</script>
