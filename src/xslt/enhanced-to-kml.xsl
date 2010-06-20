<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns="http://www.opengis.net/kml/2.2"
                xmlns:atom="http://www.w3.org/2005/Atom">

  <xsl:template match="/">
    <kml>
      <Document>
        <name>Scala User Groups Across the Globe</name>    
        <atom:author>      
          <atom:name>Wilfred Springer</atom:name>    
        </atom:author>    
        <atom:link href="http://scala-tribes.org/"/>
        <xsl:apply-templates/>
        <!--
        <Placemark>      
          <name>Hogwarts</name>      
          <Point>        
            <coordinates>-3.576327,50.620920</coordinates>      
          </Point>    
        </Placemark>    
        <Placemark>
          <name>Little Hangleton</name>
          <Point>
            <coordinates>-0.006660,52.409369</coordinates>
          </Point>    
        </Placemark>  
        -->
      </Document>
    </kml>
  </xsl:template>

  <xsl:template match="groups">
    <xsl:apply-templates select="group"/>
  </xsl:template>
  
  <xsl:template match="group">
    <Placemark>
      <name><xsl:value-of select="name"/></name>
      <atom:link href="{url[position()=1]}"/>
      <Point>
        <coordinates>
          <xsl:value-of select="longitude"/>
          <xsl:text>,</xsl:text>
          <xsl:value-of select="latitude"/>
        </coordinates>
      </Point>
    </Placemark>
  </xsl:template>

</xsl:stylesheet>