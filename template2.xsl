<?xml version="1.0" encoding="UTF-8"?>
<!--template pour faire la conversion de la configuration2-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="schema.xsd">

    <!-- Paramètre pour le titre de la partie -->
    <xsl:param name="title"/>

 <!-- Modèle pour l'élément 'configuration' -->
    <xsl:template match="configuration">
        <!-- Génération de l'en-tête SVG -->
        <svg width="700" height="600" xmlns="http://www.w3.org/2000/svg">
            <!-- Titre de la partie -->
            <text x="10" y="20" font-size="14" fill="black">
                <xsl:value-of select="$title"/>
            </text>
            <!-- Appel du modèle pour chaque colonne -->
            <xsl:apply-templates select="column"/>
        </svg>
    </xsl:template>

    <!-- Modèle pour l'élément 'column' -->
    <xsl:template match="column">
        <!-- Calcul de la position horizontale de la colonne -->
        <xsl:variable name="xPos" select="50+ (position() - 1) * 100"/>
        <!-- Appel du modèle pour chaque jeton dans la colonne -->
        <xsl:apply-templates select="row">
            <xsl:with-param name="xPos" select="$xPos"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Modèle pour l'élément 'row' -->
    <xsl:template match="row">
        <!-- Calcul de la position verticale du jeton -->
        <xsl:param name="xPos"/>
        <xsl:variable name="yPos" select="50 + (@rowNumber) * 100"/>
        <!-- Dessin du cercle représentant le jeton avec la grille -->
        <g>
            <!-- Grille -->
            <rect x="{$xPos - 50}" y="{$yPos - 50}" width="100" height="100" fill="white" stroke="black"/>
            <!-- Jeton -->
            <circle cx="{$xPos}" cy="{$yPos}" r="40">
                <!-- Couleur en fonction du joueur -->
                <xsl:attribute name="fill">
                    <xsl:choose>
                        <xsl:when test="@player='red'">red</xsl:when>
                        <xsl:when test="@player='yellow'">yellow</xsl:when>
                        <xsl:otherwise>white</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </circle>
        </g>
    </xsl:template>



</xsl:stylesheet>

