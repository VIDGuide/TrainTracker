<%@ Page Title="Home Page" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Default.aspx.vb" Inherits="WebApplication1._Default" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="TrainList" 
    GridLines="None">
    <MasterTableView autogeneratecolumns="False" datasourceid="TrainList">
        <CommandItemSettings ExportToPdfText="Export to Pdf">
        </CommandItemSettings>
        <RowIndicatorColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </RowIndicatorColumn>
        <ExpandCollapseColumn>
            <HeaderStyle Width="20px"></HeaderStyle>
        </ExpandCollapseColumn>
        <Columns>
            <telerik:GridBoundColumn DataField="TrainNumber" 
                HeaderText="TrainNumber" SortExpression="TrainNumber" 
                UniqueName="TrainNumber">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="MaxGPS" DataType="System.DateTime" 
                HeaderText="MaxGPS" SortExpression="MaxGPS" UniqueName="MaxGPS" 
                ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="LeadingLoco" 
                HeaderText="LeadingLoco" SortExpression="LeadingLoco" 
                UniqueName="LeadingLoco" ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="lineKMs" HeaderText="lineKMs" 
                SortExpression="lineKMs" UniqueName="lineKMs" ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="LineName" HeaderText="LineName" 
                SortExpression="LineName" UniqueName="LineName" ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="LineNumber" 
                HeaderText="LineNumber" SortExpression="LineNumber" 
                UniqueName="LineNumber" ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="longitude" DataType="System.Double" 
                HeaderText="longitude" SortExpression="longitude" 
                UniqueName="longitude" ReadOnly="True">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="latitude" 
                HeaderText="latitude" SortExpression="latitude" 
                UniqueName="latitude" DataType="System.Double" ReadOnly="True">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>
<asp:SqlDataSource ID="TrainList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SQLDB %>" 
    SelectCommand="SELECT t1.[TrainNumber], MAX(t1.GPSDateTime) AS MaxGPS,
(SELECT TOP(1) LeadingLoco FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LeadingLoco,
(SELECT TOP(1) lineKMs FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS lineKMs,
(SELECT TOP(1) LineName FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineName,
(SELECT TOP(1) LineNUmber FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineNumber,
(SELECT TOP(1) longitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS longitude,
(SELECT TOP(1) latitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS latitude
 FROM [TrainGPSData] AS t1
GROUP BY t1.[TrainNumber]
HAVING(MAX(t1.GPSDateTime) &gt; DateAdd(Hour, -1, GETDATE()))
ORDER BY t1.TrainNumber, MAX(t1.GPSDateTime) desc"></asp:SqlDataSource>

</asp:Content>
