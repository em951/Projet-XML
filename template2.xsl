<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <!-- Criação do en-tête SVG -->
        <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400">
            <!-- Dessine la grille -->
            <rect x="0" y="0" width="350" height="300" fill="#3498db"/>
            
            <!-- Génère les cercles pour les jetons -->
            <xsl:apply-templates select="//column/row"/>
            
            <!-- Ajoute des espaces entre les lignes -->
            <xsl:call-template name="addVerticalSpace"/>
        </svg>
    </xsl:template>

    <!-- Template pour les éléments 'row' -->
    <xsl:template match="row">
        <!-- Récupère les attributs -->
        <xsl:variable name="player" select="@player"/>
        <xsl:variable name="move" select="@move"/>
        <xsl:variable name="rowNumber" select="@rowNumber"/>
        
        <!-- Calcul des coordonnées pour placer les jetons -->
        <xsl:variable name="xCoord" select="($move - 1) * 50"/>
        <xsl:variable name="yCoord" select="($rowNumber * 50) + 25"/>
        
        <!-- Placer les jetons en fonction du joueur -->
        <xsl:choose>
            <xsl:when test="$player = 'red'">
                <circle cx="{$xCoord}" cy="{$yCoord}" r="20" fill="red"/>
            </xsl:when>
            <xsl:when test="$player = 'yellow'">
                <circle cx="{$xCoord}" cy="{$yCoord}" r="20" fill="yellow"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour ajouter des espaces verticaux -->
    <xsl:template name="addVerticalSpace">
        <!-- Espacement vertical -->
        <rect x="0" y="50" width="350" height="10" fill="transparent"/>
        <rect x="0" y="150" width="350" height="10" fill="transparent"/>
        <rect x="0" y="250" width="350" height="10" fill="transparent"/>
        <!-- Ajoutez plus de rectangles selon le nombre de lignes que vous souhaitez -->
    </xsl:template>

</xsl:stylesheet>
