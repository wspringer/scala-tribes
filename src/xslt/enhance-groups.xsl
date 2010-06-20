<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:where="http://where.yahooapis.com/v1/schema.rng">
  <xsl:output method="xml"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="groups">
    <groups>
      <xsl:apply-templates/>
    </groups>
  </xsl:template>
  
  <xsl:template match="group">
    <group>
      <xsl:copy-of select="*"/>
      <xsl:if test="woeid">
        <xsl:variable name="uri">
          <xsl:text>http://where.yahooapis.com/v1/place/</xsl:text>
          <xsl:value-of select="woeid"/>
          <xsl:text>?appid=1wh0zPDV34EfjQvy48AmqVEdKUh3nR2Ik6Jo3zOPLTrzujTggvUeRFtatzDM05kVt3Mbi7IzBA--</xsl:text>
        </xsl:variable>
        <xsl:apply-templates select="document($uri)"/>
      </xsl:if>
    </group>
  </xsl:template>  

  <xsl:template match="where:place">
    <location><xsl:value-of select="where:name"/></location>
    <country><xsl:value-of select="where:country"/></country>
    <latitude><xsl:value-of select="where:centroid/where:latitude"/></latitude>
    <longitude><xsl:value-of select="where:centroid/where:longitude"/></longitude>
  </xsl:template>

</xsl:stylesheet>