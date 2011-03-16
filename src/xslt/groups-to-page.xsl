<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:where="http://where.yahooapis.com/v1/schema.rng">
  <xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="groups">
    <table>
      <xsl:apply-templates/>
    </table>
    <xsl:call-template name="generate-map"/>
  </xsl:template>

  <xsl:template match="group">
    <tr>
      <td>
        <xsl:choose>
          <xsl:when test="url">
            <a href="{url[position()=1]}">
              <xsl:value-of select="name"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="name"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="woeid">
            <xsl:variable name="document">
              <xsl:call-template name="get-place-details">
                <xsl:with-param name="woeid" select="woeid"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:message>
              <xsl:copy-of select="$document/where:place"/>
            </xsl:message>
            <xsl:value-of select="$document/where:place/where:name"/>
          </xsl:when>
          <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="generate-map">
    <h3>How's Scala's world domination coming along?</h3>
    <iframe frameborder="0" height="350" marginheight="0" marginwidth="0" scrolling="no" src="http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;msid=108777204394927481205.0004853728d3c2e5c127b&amp;ll=43.068888,13.359375&amp;spn=144.085444,298.828125&amp;z=1&amp;output=embed" width="425"></iframe>
    <small>View <a href="http://maps.google.com/maps/ms?ie=UTF8&amp;hl=en&amp;msa=0&amp;msid=108777204394927481205.0004853728d3c2e5c127b&amp;ll=43.068888,13.359375&amp;spn=144.085444,298.828125&amp;z=1&amp;source=embed" style="color: blue; text-align: left;">Scala User Groups Across the Globe</a> in a larger map</small>
<!--     <xsl:variable name="uri"> -->
<!--       <xsl:text disable-output-escaping="yes">http://maps.google.com/maps/api/staticmap?sensor=false&amp;markers=color:red</xsl:text> -->
<!--       <xsl:for-each select="group"> -->
<!--         <xsl:text>|</xsl:text> -->
<!--         <xsl:variable name="document"> -->
<!--           <xsl:call-template name="get-place-details"> -->
<!--             <xsl:with-param name="woeid" select="woeid"/> -->
<!--           </xsl:call-template> -->
<!--         </xsl:variable> -->
<!--         <xsl:value-of select="$document//where:latitude"/> -->
<!--         <xsl:text>,</xsl:text> -->
<!--         <xsl:value-of select="$document//where:longitude"/> -->
<!--       </xsl:for-each> -->
<!--     </xsl:variable> -->
  </xsl:template>

  <xsl:template name="get-place-details">
    <xsl:param name="woeid"/>
    <xsl:variable name="uri">
      <xsl:text>http://where.yahooapis.com/v1/place/</xsl:text>
      <xsl:value-of select="$woeid"/>
      <xsl:text>?appid=1wh0zPDV34EfjQvy48AmqVEdKUh3nR2Ik6Jo3zOPLTrzujTggvUeRFtatzDM05kVt3Mbi7IzBA--</xsl:text>
    </xsl:variable>
    <xsl:copy-of select="document($uri)"/>
  </xsl:template>

</xsl:stylesheet>