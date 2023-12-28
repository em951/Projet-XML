<?xml version="1.0" encoding="UTF-8"?>
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
    </xsl:template>

    <!-- Modèle pour l'élément 'row' -->
    <xsl:template match="row">
    <!-- Calcul de la position verticale du jeton -->
      <!-- Dessin du cercle représentant le jeton avec la grille -->
        <g>
            <!-- Grille -->
            <rect x="{$xPos - 45}" y="{$yPos - 45}" width="90" height="90" fill="blue"/>
        </g>    
    </xsl:template>



</xsl:stylesheet>

