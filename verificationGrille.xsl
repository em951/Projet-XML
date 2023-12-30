<?xml version="1.0" encoding="UTF-8"?>
<!--template pour faire la vérification de la configuration-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="schema.xsd">

    <xsl:template match="/">
        <!-- Valeur de l'attribut 'title' -->
        <xsl:variable name="title" select="/configuration/@title" />

        <!-- Document de sortie -->
        <title>
            <!-- Titre de la configuration -->
            <xsl:value-of select="$title" />
        </title>

        <!-- Vérification de la configuration, Grille 6 X 7-->
            <xsl:if test="count(//column) = 7 and not(//column[count(row) &gt; 6])">
                <xsl:text>La configuration est valide : 7 colonnes et jusqu'à 6 lignes par colonne.</xsl:text>
            </xsl:if>
            <xsl:if test="count(//column) != 7">
                <xsl:text>La configuration n'a pas 7 colonnes.</xsl:text>
            </xsl:if>
            <xsl:if test="//column[count(row) &gt; 6]">
                <xsl:text>Il y a plus de 6 lignes dans au moins une colonne.</xsl:text>
            </xsl:if>

        <!-- Vérifier l'status du jeu -->
         <!-- Vérification Verticale -->
        <!-- Vérification Verticale pour le joueur red -->

        <xsl:variable name="winningPlayerRed">
            <xsl:for-each select="configuration/column">
                <xsl:variable name="redPieces" select="row[@player='red']"/>
                <xsl:if test="count($redPieces) &gt;= 4">
                    <xsl:text>red</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <!-- Vérification Verticale pour le joueur Yellow -->
        <xsl:variable name="winningPlayerYellow">
            <xsl:for-each select="configuration/column">
                <xsl:variable name="yellowPieces" select="row[@player='yellow']"/>
                <xsl:if test="count($yellowPieces) &gt;= 4">
                    <xsl:text>yellow</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="string-length($winningPlayerRed) &gt; 0">
                <text>Le joueur red a gagné verticalement!</text>
            </xsl:when>
            <xsl:when test="string-length($winningPlayerYellow) &gt; 0">
                <text>Le joueur yellow a gagné verticalement!</text>
            </xsl:when>
            <xsl:otherwise>
                <!-- Nenhuma vitória vertical -->
                <text>Aucune victoire verticale détectée.</text>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Vérification Horizontale -->
        <!-- Vérification de la victoire horizontale pour le joueur Rouge -->

        <xsl:variable name="horizontalRed">
            <xsl:for-each select="configuration/column[1]/row">
                <xsl:if test="count(../following-sibling::column/row[@rowNumber = current()/@rowNumber][@player='red']) >= 3">
                    <xsl:text>red</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification de la victoire horizontale pour le joueur Jaune -->

        <xsl:variable name="horizontalYellow">
            <xsl:for-each select="configuration/column[1]/row">
                <xsl:if test="count(../following-sibling::column/row[@rowNumber = current()/@rowNumber][@player='yellow']) >= 3">
                    <xsl:text>yellow</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="string-length($horizontalRed) &gt; 0">
                <text>Le joueur red a gagné horizontalement!</text>
            </xsl:when>
            <xsl:when test="string-length($horizontalYellow) &gt; 0">
                <text>Le joueur yellow a gagné horizontalement!</text>
            </xsl:when>
            <xsl:otherwise>
                <!-- Nenhuma vitória horizontal -->
                <text>Aucune victoire horizontale détectée.</text>
            </xsl:otherwise>
        </xsl:choose>


        <!-- Vérification Diagonale Haut-Bas -->
        <!-- Vérification Diagonale Haut-Bas Joueur Red-->
   

        <!-- Vérification Diagonale Haut-Bas Joueur yellow -->


        <!-- Vérification Diagonale Bas-Haut -->
       <!-- Vérification Diagonale Bas-Haut pour le joueur red -->


        <!-- Vérification Diagonale Bas-Haut pour le joueur yellow -->



        <!-- Vérifier si la grille est complètement remplie -->


        
        
    </xsl:template>

</xsl:stylesheet>