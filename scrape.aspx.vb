Imports HtmlAgilityPack

Public Class WebForm1
    Inherits System.Web.UI.Page

    Private Structure TrainInformation
        Public TrainNumber As String
        Public LeadingLoco As String
        Public LineKMs As String
        Public LineName As String
        Public LineNumber As String
        Public Latitude As Decimal
        Public Longitude As Decimal
        Public GPSDateTime As DateTime
    End Structure

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Write(ConfigurationManager.ConnectionStrings("SQLDB").ConnectionString)
        Dim TrainCount As Integer = 0
        Const strURL As String = "http://waynet.artc.com.au/ctlsexternal/AllMapDisplay.asp"
        Dim webGet = New HtmlWeb()
        Dim document = webGet.Load(strURL)
        Dim Tables = document.DocumentNode.SelectNodes("//table[starts-with(@id,'T')]")
        If Not IsNothing(Tables) Then
            For Each Table In Tables
                Dim HTMLStr = Table.InnerHtml
                HTMLStr = HTMLStr.Replace("</font></td></tr>", "")
                HTMLStr = HTMLStr.Replace("<tr><td bgcolor='rgb(255,200,200)'><font style='color:rgb(0,0,0); font-size:10pt; font-weight:400;font-family:Arial'>", "")
                HTMLStr = HTMLStr.Replace("<tr><td bgcolor='rgb(255,200,200)'><font style='color:rgb(0,0,0); font-size:10pt; font-weight:400;font-family:Arial'>", "")
                Dim TrainData() As String = HTMLStr.Split("<")
                Dim Train As New TrainInformation
                Train.TrainNumber = CleanString(TrainData(0))
                Train.LeadingLoco = CleanString(TrainData(1))
                Train.LineKMs = CleanString(TrainData(2))
                Train.LineName = CleanString(TrainData(3))
                Train.LineNumber = CleanString(TrainData(4))
                Train.Latitude = CDec(CleanString(TrainData(5)))
                Train.Longitude = CDec(CleanString(TrainData(6)))
                Train.GPSDateTime = CDate(CleanString(TrainData(7)))
                TrainCount += 1
                Response.Write("Scraped: " + Train.TrainNumber + " on " + Train.LineName + " (" + Train.LineNumber.ToString + ") at " + Train.Longitude.ToString + "," + Train.Latitude.ToString + "<BR>")
            Next
        End If
        Response.Write(TrainCount.ToString)
    End Sub

    Private Function CleanString(Input As String) As String
        Dim Output As String
        Output = Input.Replace("br>", "")
        Output = Output.Replace("Train Number - ", "")
        Output = Output.Replace("Leading Loco - ", "")
        Output = Output.Replace("Loco line kms - ", "")
        Output = Output.Replace("Line name - ", "")
        Output = Output.Replace("Line number - ", "")
        Output = Output.Replace("Latitude - ", "")
        Output = Output.Replace("Longitude - ", "")
        Output = Output.Replace("GPS Date Time - ", "")
        Return Output
    End Function

End Class
