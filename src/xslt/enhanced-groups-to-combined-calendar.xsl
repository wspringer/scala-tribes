<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:text>
</xsl:text>
<xsl:apply-templates select="//calendar"/>
</xsl:template>

<xsl:template match="calendar">
</xsl:template>

</xsl:stylesheet>