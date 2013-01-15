<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebForm3.aspx.vb" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmgE5BAlybs-U19w0gueveSSpxJSKI2U0&sensor=false">
    </script>
    <script type="text/javascript">
        function initialize() {
            alert("starting map");
            var mapOptions = {
                center: new google.maps.LatLng(-34.397, 150.644),
                zoom: 8,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
            alert("map started")
        }
        google.maps.event.addDomListener(window, "load", initialize);
    </script>
</head>
<body>
<div id="map_canvas" style="width:100%; height:100%"></div>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
