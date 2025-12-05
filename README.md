Код преобразования : 

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:key name="cities" match="item" use="@city" />
<xsl:key name="orgs-by-city" match="item" use="concat(@city, '|', @org)" />

<xsl:template match="/">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Города</title>
</head>
<body>
<h1>Города и компании</h1>
<ul>
<xsl:for-each select="orgs/item[generate-id() = generate-id(key('cities', @city)[1])]">
<xsl:sort select="@city" />
<xsl:variable name="city" select="@city" />
<li>
<h3><xsl:value-of select="$city" /></h3>
<p>Всего товаров: <xsl:value-of select="count(key('cities', $city))" /></p>
<ul>
<xsl:for-each select="key('cities', $city)[generate-id() = generate-id(key('orgs-by-city', concat($city, '|', @org))[1])]">
<xsl:sort select="@org" />
<xsl:variable name="org" select="@org" />
<xsl:variable name="org-items" select="key('orgs-by-city', concat($city, '|', $org))" />
<li>
<h4><xsl:value-of select="$org" /></h4>
<p>Всего товаров: <xsl:value-of select="count($org-items)" /></p>
<ul>
<xsl:for-each select="$org-items">
<xsl:sort select="@title" />
<xsl:if test="position() = 1 or not(@title = preceding-sibling::item[1]/@title)">
<li><xsl:value-of select="@title" /></li>
</xsl:if>
</xsl:for-each>
</ul>
</li>
</xsl:for-each>
</ul>
</li>
</xsl:for-each>
</ul>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
