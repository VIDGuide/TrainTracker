<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="WebApplication1.WebForm2" %><%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function openRadWindow(button, args) {
            var oWnd = window.radopen("scrape.aspx", "RadWindow1"); //Pass parameter using URL   
            oWnd.center();
        }   
</script>  
</head>
<body>
    <form id="form1" runat="server">
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
    <telerik:RadWindowManager ID="RadWindowManager1" Width="400" Height="800" 
            modal="true" runat="server" Skin="Office2010Black">

    </telerik:RadWindowManager>
    <telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" 
        Skin="Office2010Black" />
    <div>


        
        <telerik:RadButton ID="RadButton1" runat="server" Skin="Office2010Black" 
            Text="Scrape Now" NavigateUrl="" 
            AutoPostBack="False" UseSubmitBehavior="False" OnClientClicked="openRadWindow">
        </telerik:RadButton>

        
<telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="TrainList" 
    GridLines="None" CellSpacing="0" Skin="Office2010Black" 
            AutoGenerateColumns="False">
    <MasterTableView datasourceid="TrainList">
        <CommandItemSettings ExportToPdfText="Export to Pdf">
        </CommandItemSettings>
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

<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>

        </telerik:RadGrid>
<asp:SqlDataSource ID="TrainList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SQLDB %>" 
    SelectCommand="SELECT t1.[TrainNumber], MAX(t1.GPSDateTime) AS MaxGPS, (SELECT TOP(1) LeadingLoco FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LeadingLoco, (SELECT TOP(1) lineKMs FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS lineKMs, (SELECT TOP(1) LineName FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineName, (SELECT TOP(1) LineNUmber FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineNumber, (SELECT TOP(1) longitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS longitude, (SELECT TOP(1) latitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS latitude FROM [TrainGPSData] AS t1 GROUP BY t1.[TrainNumber] HAVING(MAX(t1.GPSDateTime) > DateAdd(Hour, -1, GETDATE())) ORDER BY t1.TrainNumber, MAX(t1.GPSDateTime) desc">
    </asp:SqlDataSource>
    </div>
    </form>

</body>
</html>
