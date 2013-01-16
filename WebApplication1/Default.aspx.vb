Imports System.Threading
Imports System.Globalization

Public Class WebForm2

    Inherits System.Web.UI.Page
    'todo: Ajax refresh # trains & Last time
    'todo: convert map to use JSON feed with refresh
    'todo: add option to filter by time since (1 hr, etc)
    'todo: Filter radgrid
    'todo: click Radgrid row center/zoom map
    'todo: Auto Scrape
    'todo: custom icon
    'todo: Direction Indicator
    'todo: decode information from ARTC rules
    'todo: Add QLD Tracks
    'todo: Add Vic Tracks
    'todo: build geofence/alerting system

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Thread.CurrentThread.CurrentCulture = New CultureInfo("en-AU")
        Thread.CurrentThread.CurrentUICulture = New CultureInfo("en-AU")

        Dim TrainList = New List(Of String)
        Dim DetailList = New List(Of String)
        Dim BodyList = New List(Of String)

        Using Conn As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("SQLDB").ConnectionString)
            Conn.Open()
            Using Command As SqlClient.SqlCommand = Conn.CreateCommand()
                With Command
                    Dim SQL As String = "SELECT COUNT(distinct [TrainNumber]) as CNT FROM [TrainGPSData] WHERE GPSDateTime > DATEADD(Hour, " + TimeFilter.SelectedValue.ToString + ", DATEADD(Hour,11,GETDATE()))"
                    .CommandText = SQL
                    Dim Reader As SqlClient.SqlDataReader = .ExecuteReader
                    If Not Reader.HasRows Then
                        TrainCounter.Text = "0"
                    Else
                        Reader.Read()
                        TrainCounter.Text = Reader("CNT").ToString
                    End If
                    Reader.Close()
                End With

                With Command
                    Dim SQL As String = "SELECT MAX(GPSDateTime) AS DT FROM [TrainGPSData] WHERE GPSDateTime > DATEADD(Hour, " + TimeFilter.SelectedValue.ToString + ", DATEADD(Hour,11,GETDATE()))"
                    .CommandText = SQL
                    Dim Reader As SqlClient.SqlDataReader = .ExecuteReader
                    If Not Reader.HasRows Then
                        RefreshTime.Text = "-"
                    Else
                        Reader.Read()
                        If IsDBNull(Reader("DT")) Then
                            RefreshTime.Text = "??"
                        Else
                            RefreshTime.Text = CDate(Reader("DT")).ToShortTimeString
                        End If
                    End If
                    Reader.Close()
                End With

                With Command
                    Dim SQL As String = "SELECT t1.[TrainNumber], MAX(t1.GPSDateTime) AS MaxGPS, (SELECT TOP(1) LeadingLoco FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LeadingLoco, (SELECT TOP(1) lineKMs FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS lineKMs, (SELECT TOP(1) LineName FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineName, (SELECT TOP(1) LineNUmber FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineNumber, (SELECT TOP(1) longitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS longitude, (SELECT TOP(1) latitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS latitude FROM [TrainGPSData] AS t1 GROUP BY t1.[TrainNumber] HAVING(MAX(t1.GPSDateTime) > DateAdd(Hour, " + TimeFilter.SelectedValue.ToString + ", DATEADD(Hour,11,GETDATE()))) ORDER BY t1.TrainNumber, MAX(t1.GPSDateTime) desc"
                    .CommandText = SQL
                    Dim Reader As SqlClient.SqlDataReader = .ExecuteReader
                    While Reader.Read()
                        TrainList.Add("'" + Reader("Latitude").ToString + ", " + Reader("longitude").ToString + "'")
                        DetailList.Add("'<span class=formatText >" + Reader("TrainNumber").ToString.Trim + "</span>'")
                        Dim TrainString As String = "'<B>" + Reader("TrainNumber").ToString.Trim + "</B><BR><font size=-2><B>Leading Loco</B>: " + Reader("LeadingLoco").ToString + "<BR>"
                        TrainString = TrainString + "<B>Last Update:</B>" + Reader("MaxGPS").ToString + "<BR>"
                        TrainString = TrainString + "<B>Line: " + Reader("LineName").ToString + " (" + Reader("LineNumber").ToString + ") - " + Reader("LineKMs").ToString + "</B><BR>"
                        TrainString = TrainString + "<B>Location: " + Reader("Latitude").ToString + ", " + Reader("Longitude").ToString + "</B><BR>"
                        TrainString = TrainString + "<B>Additional Details:</B><BR>"
                        TrainString = TrainString + "</font>'"
                        BodyList.Add(TrainString)
                    End While
                End With


            End Using
        End Using
        Dim Message As String = String.Join(",", DetailList.ToArray())
        Dim TrainValues As String = String.Join(",", TrainList.ToArray())
        Dim BodyValues As String = String.Join(",", BodyList.ToArray())
        ClientScript.RegisterArrayDeclaration("locationList", TrainValues)
        ClientScript.RegisterArrayDeclaration("message", Message)
        ClientScript.RegisterArrayDeclaration("BodyMsg", BodyValues)
    End Sub
End Class