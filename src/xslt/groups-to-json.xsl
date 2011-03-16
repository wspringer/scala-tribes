<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>{ "docs": [</xsl:text>
    <xsl:for-each select="groups/group">
      <xsl:if test="not(position()=1)">
        <xsl:text>,</xsl:text>
      </xsl:if>
      
      <xsl:text>{</xsl:text>

      <xsl:text>"name":"</xsl:text>
      <xsl:value-of select="name"/>

      <xsl:text>",</xsl:text>
      <xsl:text>"url":"</xsl:text>
      <xsl:value-of select="url"/>
      <xsl:text>"</xsl:text>

      <xsl:text>,</xsl:text>
      <xsl:text>"woeid":</xsl:text>
      <xsl:value-of select="woeid"/>

      <xsl:if test="feeds/news">
        <xsl:text>,</xsl:text>
        <xsl:text>"rss":"</xsl:text>
        <xsl:value-of select="feeds/news"/>
        <xsl:text>"</xsl:text>
      </xsl:if>
      
      <xsl:if test="calendar">
        <xsl:text>,</xsl:text>
        <xsl:text>"ical":"</xsl:text>
        <xsl:value-of select="calendar"/>
        <xsl:text>"</xsl:text>
      </xsl:if>
      
      <xsl:text>}</xsl:text>

    </xsl:for-each>
    <xsl:text>]}</xsl:text>
  </xsl:template>

</xsl:stylesheet>