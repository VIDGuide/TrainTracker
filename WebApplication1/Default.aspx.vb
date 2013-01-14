Imports System.Threading
Imports System.Globalization

Public Class WebForm2

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Thread.CurrentThread.CurrentCulture = New CultureInfo("en-AU")
        Thread.CurrentThread.CurrentUICulture = New CultureInfo("en-AU")
    End Sub

    Protected Sub RadButton1_Click(sender As Object, e As EventArgs) Handles RadButton1.Click

    End Sub
End Class