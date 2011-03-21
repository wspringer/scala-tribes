<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output method="html" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Scala Tribes</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
        <link rel="alternate" type="application/rss+xml" title="Scala Tribe Buzz" href="http://www.google.com/reader/public/atom/user/12748925457857596371/label/scala-tribes"/>
        <link href="style.css" 
              rel="stylesheet"
              type="text/css"/>
        <script src="jquery-1.5.1.min.js" type="text/javascript"></script>
        <script src="slides.min.jquery.js" type="text/javascript"></script>
        <script src="http://www.google.com/jsapi?key=ABQIAAAA3UtwfN1DKB34v1Q8xkn-lxQKvmA8BgVoVEj2eqzgYZ8E-J9qnRSQHWdKsJvZj6wDWnVioH0QvrgHfA" type="text/javascript"></script>
    <script src="http://www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.js"
            type="text/javascript"></script>
    <script type="text/javascript"><![CDATA[
google.load('feeds', '1');

function OnLoad() {
  var feeds = [
    {
      title: 'Buzz',
      url: 'http://www.google.com/reader/public/atom/user/12748925457857596371/label/scala-tribes'
    }
  ];

  var options = {
    stacked : true,
    numResults: 16,
    horizontal : false
  };

  new GFdynamicFeedControl(feeds, 'buzz', options);
}

google.setOnLoadCallback(OnLoad);
]]>
    </script>
        <script type="text/javascript"
                src="http://maps.google.com/maps/api/js?sensor=false">
        </script>
        <script type="text/javascript">
  function initialize() {

    var stylez = [
        {
          featureType: "all",
          elementType: "all",
          stylers: [
            { saturation: -100 }
          ]
        }
    ];
    var latlng = new google.maps.LatLng(29.53523,-8.789062);
    var mapOptions = {
      zoom: 2,
      disableDefaultUI: true,
      zoomControl: true,
      center: latlng,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'hiphop']
      }
    }
    var map = new google.maps.Map(document.getElementById("map_canvas"),
        mapOptions);
    var styledMapOptions = {
       name: "Hip-Hop"
    }
    var jazzMapType = new google.maps.StyledMapType(stylez, styledMapOptions);
    map.mapTypes.set('hiphop', jazzMapType);
    map.setMapTypeId('hiphop');
    var kmlLayer = new google.maps.KmlLayer('http://s3.amazonaws.com/www.scala-tribes.org/scala-tribes.kml');
    kmlLayer.preserveViewport = true;
    kmlLayer.setMap(map);

    $.ajax({
      type: "GET",
      url: "http://ical-combinator.appspot.com/calendars/all-scala-tribes/jsonp",
      dataType: "jsonp",
      success: function (content) {
        $("#events").html(content);
          $("#slides").slides({
            preload: true,
            generatePagination: false,
            generateNextPrev: true,
            play: 0,
            pause: 2500,
            hoverPause: true
          });
      }
    });
}
            </script>
      </head>
      <body onload="initialize()">
        <div id="main">
          <div id="masthead">
            <div id="titlebar">
              <div id="titleblock">
                <img src="logo.png"/>
                <!--
                <div id="title">Scala Tribes</div>
                <div id="subtitle">Scala communities across the globe</div>
                -->
              </div>
              <div id="menu">
                <a href="http://twitter.com/scalatribes">Contact</a>
              </div>
            </div>
            <div style="clear: both"></div>
            <div id="map_canvas" style="width: 100%; height: 300"></div>
            <div id="message">
              <div id="events"/>
              <div style="clear:both"/>
              <script type="text/javascript">
              </script>
            </div>
          </div>
          <div id="body">
            <div id="banner">
              <div id="left"> 
                <h3><img src="scala-tribes.png"/> What is this about?</h3>
                <p>Are you looking for Scala enthusiasm somewhere
                near?  This site is keeping track of all Scala user
                groups (more commonly referred to as Scala
                enthusiasts) across the globe. We have counted
                <xsl:value-of select="count(//group)"/> so far.</p>
              </div>
              <div id="middle">
                <h3><img src="scala-tribes.png"/> Where's the rest?</h3>
                <p>
                  If you feel there is something missing from the list below, feel free to <em><a href="http://twitter.com/?status=@scalatribes ">send us a tweet</a></em>, and we will update the list.
                </p>
              </div>
              <div id="right">
                <h3><img src="scala-tribes.png"/> Buzz</h3>
                <div id="buzz"></div>
              </div>
            </div>
            <div id="remainder">
              <h3>Where are the tribes?</h3>
              <p>The following table lists all of the groups currently registered. Note that in some cases, a community of enthusiasts is accommodating an entire country. In other cases, it's just a local community. The <em>area</em> refers to the area accommodated by a group.</p>
              <xsl:apply-templates select="groups"/>
            </div>
          </div>
          <div id="footer">
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="groups">
    <table id="groups">
      <thead>
        <tr>
          <th align="left">Name</th>
          <th align="left">Area</th>
          <th>Country</th>
          <th align="left">Calendar</th>
          <th align="left">News</th>
        </tr>
      </thead>
      <xsl:apply-templates select="group"/>
    </table>
  </xsl:template>
  
  <xsl:template match="group">
    <tr style="height:18px">
      <td>
        <xsl:choose>
          <xsl:when test="url">
            <a href="{url[position()=1]/text()}">
              <xsl:value-of select="name"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="name"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td><xsl:value-of select="location"/></td>
      <td><xsl:value-of select="country"/></td>
      <td align="center" style="text-align: center">
        <xsl:if test="calendar">
          <a href="{calendar}">
            <img style="border:0px; padding: 0px; margin: 0px;" src="http://lh3.ggpht.com/_S3C3xc3P7WU/TB5apw5JJUI/AAAAAAAANLo/i42jwr8Xx7A/1277057622_schedule.png"/>
          </a>
        </xsl:if>
      </td>
      <td align="center" style="text-align: center">
        <xsl:if test="feeds/news">
          <a href="{feeds/news[position()=1]}">
            <img style="border:0px; padding: 0px; margin: 0px;" src="http://lh5.ggpht.com/_S3C3xc3P7WU/TB5blp4EcUI/AAAAAAAANLw/Vp7UKxrmrQw/1277057870_rss.png"/>
          </a>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="generate-image">
    <iframe frameborder="0" height="350" marginheight="0" marginwidth="0" scrolling="no" src="http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;msid=108777204394927481205.0004853728d3c2e5c127b&amp;ll=43.068888,13.359375&amp;spn=144.085444,298.828125&amp;z=1&amp;output=embed" width="425"></iframe>
    <small>View <a href="http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;msid=108777204394927481205.0004853728d3c2e5c127b&amp;ll=43.068888,13.359375&amp;spn=144.085444,298.828125&amp;z=1&amp;source=embed" style="color: blue; text-align: left;">Scala User Groups Across the Globe</a> in a larger map</small>    
    <!--     <xsl:variable name="uri"> -->
    <!--       <xsl:text disable-output-escaping="yes">http://maps.google.com/maps/api/staticmap?size=550x400&amp;sensor=false&amp;markers=color:red</xsl:text> -->
    <!--       <xsl:for-each select="groups/group[woeid]"> -->
    <!--         <xsl:text disable-output-escaping="yes">|</xsl:text> -->
    <!--         <xsl:value-of select="latitude"/> -->
    <!--         <xsl:text>,</xsl:text> -->
    <!--         <xsl:value-of select="longitude"/> -->
    <!--       </xsl:for-each> -->
    <!--     </xsl:variable> -->
    <!--     <img src="{$uri}"/> -->
  </xsl:template>
  
</xsl:stylesheet>