<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output method="xml"/>

  <xsl:template match="/">
    <html>
      <body>
        <h3>What is this about?</h3>
        <p>
          Are you looking for Scala enthusiasm somewhere near? This site is keeping track of all Scala user groups (more commonly referred to as Scala enthusiasts) across the globe.
        </p>
        <h3>Where's the rest?</h3>
        <p>
          If you feel there is something missing from the list below, feel free to <em><a href="http://twitter.com/?status=@scalatribes ">send us a tweet</a></em>, and we will update the list.
        </p>
        <h3>Where are the Tribes?</h3>
        <p>The following table lists all of the groups currently registered. Note that in some cases, a community of enthusiasts is accommodating an entire country. In other cases, it's just a local community. The <em>area</em> refers to the area accommodated by a group.</p>
        <xsl:apply-templates select="groups"/>
        <h3>How's Scala World Dominance Getting Along?</h3>
        <xsl:call-template name="generate-image"/>
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
    <xsl:variable name="uri">
      <xsl:text disable-output-escaping="yes">http://maps.google.com/maps/api/staticmap?size=550x400&amp;sensor=false&amp;markers=color:red</xsl:text>
      <xsl:for-each select="groups/group[woeid]">
        <xsl:text disable-output-escaping="yes">|</xsl:text>
        <xsl:value-of select="latitude"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="longitude"/>
      </xsl:for-each>
    </xsl:variable>
    <img src="{$uri}"/>
  </xsl:template>
  
</xsl:stylesheet>