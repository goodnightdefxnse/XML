<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:key name="cities" match="item" use="@city"/>
<xsl:key name="orgs-by-city" match="item" use="concat(@city, '|', @org)"/>
<xsl:key name="titles-by-org" match="item" use="concat(@city, '|', @org, '|', @title)"/>

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
<xsl:sort select="@city"/>
<xsl:variable name="city" select="@city"/>
<li>
<h3><xsl:value-of select="$city"/></h3>
<p>Всего товаров: <xsl:value-of select="count(key('cities', $city))"/></p>
<xsl:for-each select="key('cities', $city)[generate-id() = generate-id(key('orgs-by-city', concat($city, '|', @org))[1])]">
<ul><li>
<h4><xsl:value-of select="@org"/></h4>
<xsl:variable name="org-key" select="concat($city, '|', @org)"/>
<p>Всего товаров: <xsl:value-of select="count(key('orgs-by-city', $org-key))"/></p>
<ul>
<xsl:for-each select="key('orgs-by-city', $org-key)[generate-id() = generate-id(key('titles-by-org', concat($city, '|', @org, '|', @title))[1])]">
<xsl:sort select="@title"/>
<li><xsl:value-of select="@title"/></li>
</xsl:for-each>
</ul>
</li></ul>
</xsl:for-each>
</li>
</xsl:for-each>
</ul>
</body>
</html>
</xsl:template>
</xsl:stylesheet>