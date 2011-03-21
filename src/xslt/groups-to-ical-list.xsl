<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:for-each select="//calendar">
      <xsl:value-of select="text()"/>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
  </xsl:template>


</xsl:stylesheet>