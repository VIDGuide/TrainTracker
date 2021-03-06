﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="WebApplication1.WebForm2" %><%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<html>
<!DOCTYPE html>
<head runat="server">
    <title>TrainTracker</title>
    <meta http-equiv="X-UA-Compatible" content="IE=9">
    <link rel="stylesheet" href="Styles/bootstrap.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="Styles/core.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="Styles/site.css" type="text/css" media="all"/>
    
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmgE5BAlybs-U19w0gueveSSpxJSKI2U0&sensor=false"></script>
    <script type="text/javascript" src="Scripts/jquery.1.7.1.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>

    <script type="text/javascript">
function openRadWindow(button, args) {
	var oWnd = window.radopen("scrape.aspx", "RadWindow1"); //Pass parameter using URL   
	oWnd.center();
}

function openCreditsWindow(button, args) {
    var oWnd = window.radopen("Credits.aspx", "RadWindow2"); //Pass parameter using URL   
    oWnd.center();
}

var map;
var TrackLayer;
var Collieries;

function ToggleTrack(obj) {
    if (obj == true) {
        TrackLayer.setMap(map);
    } else {
        TrackLayer.setMap(null);
    }
}

function ToggleCollieries(obj) {
    if (obj == true) {
        Collieries.setMap(map);
    } else {
        Collieries.setMap(null);
    }
}

function initialize() {
    var mapOptions = {
        center: new google.maps.LatLng(-34.397, 150.644),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    setTimeout('google.maps.event.trigger(map, "resize");map.setZoom(map.getZoom());', 200);
    for (var i = 0; i < locationList.length; i++) {
        var args = locationList[i].split(",");
        var location = new google.maps.LatLng(args[0], args[1])
        var marker = new google.maps.Marker({
            position: location,
            map: map,
            title: message[i].replace(/(<([^>]+)>)/ig,"")
        });
        var j = i + 1;
        //marker.setTitle(message[i].replace(/(<([^>]+)>)/ig,""));
        attachSecretMessage(marker, i);
    }

}

function SetUpLayers() {
    TrackLayer = new google.maps.KmlLayer('http://traintracker.apphb.com/Resources/NSW.kmz');
    TrackLayer.setMap(map);

    Collieries = new google.maps.KmlLayer('http://traintracker.apphb.com/Resources/Collieries.kmz');
    //Collieries.setMap(map);
}

function attachSecretMessage(marker, number) {
    var infowindow = new google.maps.InfoWindow(
        { content: BodyMsg[number],
            size: new google.maps.Size(50, 50)
        });
        google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
    });
}

$(document).ready(function () {
    initialize();
    SetUpLayers();
}
);
</script>
    <style type="text/css">
        .style1
        {
            width: 200px;
        }
    </style>
</head>
<body runat="server">
<form id="form1" runat="server">
	<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
	<tr style="height:42px;"><td colspan="2">
	 <div class="ui-layout-north topbar">
		<h1><img src="Images/train.png" alt="Clarity" />Train Tracker</h1>
		<a class="btn theme-btn" onclick="openRadWindow();"><i class="icon-refresh icon-white"></i> Scrape Now</a>
	</div>    
	</td></tr>
	<tr><td class="style1" valign="top">
    <table width="200px" style="height:100%;" class="ui-layout-west"">
    <tr><td height="100%" valign="top"><b>Map Options</b>:
    <label><asp:CheckBox ID="ShowTrack" runat="server" Checked="True" onclick="ToggleTrack(this.checked);" />&nbsp;Show NSW Tracks</label>
    <label><asp:CheckBox ID="ShowCollieries" runat="server" Checked="False" onclick="ToggleCollieries(this.checked);" />&nbsp;Show Collieries</label><br /><br />
    Show Trains From:
    <telerik:RadComboBox ID="TimeFilter" Runat="server" Skin="Office2010Black" 
            AutoPostBack="True">
        <Items>
            <telerik:RadComboBoxItem runat="server" Selected="True" Text="Last 1 Hour" 
                Value="-1" />
            <telerik:RadComboBoxItem runat="server" Text="Last 2 Hours" Value="-2" />
            <telerik:RadComboBoxItem runat="server" Text="Last 4 Hours" Value="-4" />
            <telerik:RadComboBoxItem runat="server" Text="Last 6 Hours" Value="-6" />
            <telerik:RadComboBoxItem runat="server" Text="Last 12 Hours" Value="-12" />
            <telerik:RadComboBoxItem runat="server" Text="Last 24 Hours" Value="-24" />
        </Items>
        </telerik:RadComboBox>
    </td></tr>
    <tr><td>
    <div class="sidebarFooterStats">
		<div>
			<strong><asp:Label ID="TrainCounter" runat="server" Text="Label"></asp:Label></strong>
			<p>Trains</p> 
		</div>
		<div>
			<strong><asp:Label ID="RefreshTime" runat="server" Text="Label"></asp:Label></strong>
			<p>Last Refresh</p> 
		</div>
	</div>
	<div class="sidebarFooter">
		<button id="newb">New</button>
		<button id="settingsb">Settings</button>
        <font size="-3"><a onclick="openCreditsWindow();">Credits</a></font>
	</div>
    </td></tr>
    </table>
    </td><td>
    <div id="map_canvas" style="width:100%; height:100%"></div>
    </td></tr>
	<tr style="height:300px;"><td colspan="2">
<telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="TrainList" 
	GridLines="None" CellSpacing="0" Skin="Office2010Black" 
			AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
	<MasterTableView datasourceid="TrainList" HierarchyLoadMode="Client">
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

		<RowIndicatorColumn>
			<HeaderStyle Width="20px"></HeaderStyle>
		</RowIndicatorColumn>
		<ExpandCollapseColumn>
			<HeaderStyle Width="20px"></HeaderStyle>
		</ExpandCollapseColumn>
		<Columns>
			<telerik:gridboundcolumn DataField="TrainNumber" 
				HeaderText="Train Number" SortExpression="TrainNumber" 
				UniqueName="TrainNumber">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="MaxGPS" DataType="System.DateTime" 
				HeaderText="Date/Time" SortExpression="MaxGPS" UniqueName="MaxGPS" 
				ReadOnly="True">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="LeadingLoco" 
				HeaderText="Leading Loco" SortExpression="LeadingLoco" 
				UniqueName="LeadingLoco" ReadOnly="True">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="lineKMs" HeaderText="Line KMs" 
				SortExpression="lineKMs" UniqueName="lineKMs" ReadOnly="True" 
				AllowSorting="False">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="LineName" HeaderText="Line Name" 
				SortExpression="LineName" UniqueName="LineName" ReadOnly="True">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="LineNumber" 
				HeaderText="Line Number" SortExpression="LineNumber" 
				UniqueName="LineNumber" ReadOnly="True">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="longitude" DataType="System.Double" 
				HeaderText="Longitude" SortExpression="longitude" 
				UniqueName="longitude" ReadOnly="True" AllowSorting="False">
			</telerik:gridboundcolumn>
			<telerik:gridboundcolumn DataField="latitude" 
				HeaderText="Latitude" SortExpression="latitude" 
				UniqueName="latitude" DataType="System.Double" ReadOnly="True" 
				AllowSorting="False">
			</telerik:gridboundcolumn>
		</Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
	</MasterTableView>

	<PagerStyle Mode="NextPrev" />

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>

		</telerik:RadGrid>    
	    
	</td></tr>
	</table>
<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
	</telerik:RadStyleSheetManager>
	<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
		<Scripts>
			<asp:ScriptReference Assembly="Telerik.Web.UI" 
				Name="Telerik.Web.UI.Common.Core.js">
			</asp:ScriptReference>
			<asp:ScriptReference Assembly="Telerik.Web.UI" 
				Name="Telerik.Web.UI.Common.jQuery.js">
			</asp:ScriptReference>
			<asp:ScriptReference Assembly="Telerik.Web.UI" 
				Name="Telerik.Web.UI.Common.jQueryInclude.js">
			</asp:ScriptReference>
		</Scripts>
	</telerik:RadScriptManager>
	<telerik:RadWindowManager ID="RadWindowManager1" Width="400" Height="600" top="100"
			modal="true" runat="server" Skin="Office2010Black">

	</telerik:RadWindowManager>
	<telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" 
		Skin="Office2010Black" />
<asp:SqlDataSource ID="TrainList" runat="server" 
	ConnectionString="<%$ ConnectionStrings:SQLDB %>" 
	
        SelectCommand="SELECT t1.[TrainNumber], MAX(t1.GPSDateTime) AS MaxGPS, (SELECT TOP(1) LeadingLoco FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LeadingLoco, (SELECT TOP(1) lineKMs FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS lineKMs, (SELECT TOP(1) LineName FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineName, (SELECT TOP(1) LineNUmber FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineNumber, (SELECT TOP(1) longitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS longitude, (SELECT TOP(1) latitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS latitude FROM [TrainGPSData] AS t1 GROUP BY t1.[TrainNumber] HAVING(MAX(t1.GPSDateTime) &gt; DateAdd(Hour, @TimeParameter, DATEADD(Hour,11,GETDATE()))) ORDER BY t1.TrainNumber, MAX(t1.GPSDateTime) desc">
    <SelectParameters>
        <asp:ControlParameter ControlID="TimeFilter" DbType="Int16" DefaultValue="-1" 
            Name="TimeParameter" PropertyName="SelectedValue" />
    </SelectParameters>
	</asp:SqlDataSource>
	<telerik:RadAjaxManager runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
	</form>
	
</body>
</html>
