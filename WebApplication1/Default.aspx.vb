Imports System.Threading
Imports System.Globalization

Public Class WebForm2

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Thread.CurrentThread.CurrentCulture = New CultureInfo("en-AU")
        Thread.CurrentThread.CurrentUICulture = New CultureInfo("en-AU")

        Dim TrainList = New List(Of String)
        Dim DetailList = New List(Of String)

        Using Conn As New SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("SQLDB").ConnectionString)
            Conn.Open()
            Using Command As SqlClient.SqlCommand = Conn.CreateCommand()
                With Command
                    Dim SQL As String = "SELECT COUNT(distinct [TrainNumber]) as CNT FROM [TrainGPSData] WHERE GPSDateTime > DATEADD(Hour, -1, GETDATE())"
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
                    Dim SQL As String = "SELECT MAX(GPSDateTime) AS DT FROM [TrainGPSData] WHERE GPSDateTime > DATEADD(Hour, -1, GETDATE())"
                    .CommandText = SQL
                    Dim Reader As SqlClient.SqlDataReader = .ExecuteReader
                    If Not Reader.HasRows Then
                        RefreshTime.Text = "-"
                    Else
                        Reader.Read()
                        RefreshTime.Text = CDate(Reader("DT")).ToShortTimeString
                    End If
                    Reader.Close()
                End With

                With Command
                    Dim SQL As String = "SELECT t1.[TrainNumber], MAX(t1.GPSDateTime) AS MaxGPS, (SELECT TOP(1) LeadingLoco FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LeadingLoco, (SELECT TOP(1) lineKMs FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS lineKMs, (SELECT TOP(1) LineName FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineName, (SELECT TOP(1) LineNUmber FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS LineNumber, (SELECT TOP(1) longitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS longitude, (SELECT TOP(1) latitude FROM [TrainGPSData] AS t2 WHERE t2.TrainNumber = t1.TrainNumber AND t2.GPSDateTime =  MAX(t1.GPSDateTime)) AS latitude FROM [TrainGPSData] AS t1 GROUP BY t1.[TrainNumber] HAVING(MAX(t1.GPSDateTime) > DateAdd(Hour, -1, GETDATE())) ORDER BY t1.TrainNumber, MAX(t1.GPSDateTime) desc"
                    .CommandText = SQL
                    Dim Reader As SqlClient.SqlDataReader = .ExecuteReader
                    While Reader.Read()
                        TrainList.Add("'" + Reader("Latitude").ToString + ", " + Reader("longitude").ToString + "'")
                        DetailList.Add("'<span class=formatText >" + Reader("TrainNumber").ToString.Trim + "</span>'")
                    End While
                End With


            End Using
        End Using
        Dim Message As String = String.Join(",", DetailList.ToArray())
        Dim TrainValues As String = String.Join(",", TrainList.ToArray())
        ClientScript.RegisterArrayDeclaration("locationList", TrainValues)
        ClientScript.RegisterArrayDeclaration("message", Message)
    End Sub
End Class