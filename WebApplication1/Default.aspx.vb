Imports System.Threading
Imports System.Globalization

Public Class WebForm2

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Thread.CurrentThread.CurrentCulture = New CultureInfo("en-AU")
        Thread.CurrentThread.CurrentUICulture = New CultureInfo("en-AU")
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
            End Using
        End Using

    End Sub
End Class