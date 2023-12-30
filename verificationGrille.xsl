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
            <xsl:for-each select="configuration/column">
                <xsl:for-each select="row[@player='red']">
                    <xsl:variable name="rowNumber" select="@rowNumber"/>
                    <xsl:if test="count(../following-sibling::column/row[@rowNumber = $rowNumber][@player='red']) >= 3">
                        <xsl:text>red</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification de la victoire horizontale pour le joueur Jaune -->
        <xsl:variable name="horizontalYellow">
            <xsl:for-each select="configuration/column">
                <xsl:for-each select="row[@player='yellow']">
                    <xsl:variable name="rowNumber" select="@rowNumber"/>
                    <xsl:if test="count(../following-sibling::column/row[@rowNumber = $rowNumber][@player='yellow']) >= 3">
                        <xsl:text>yellow</xsl:text>
                    </xsl:if>
                </xsl:for-each>
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
                <!-- Aucune victoire horizontale -->
                <text>Aucune victoire horizontale détectée.</text>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Vérification Diagonale Haut-Bas -->
        <!-- Vérification première Diagonale Haut-Bas Joueur Red-->
        <xsl:variable name="diagonalRedTopBottom">
            <xsl:choose>
                <xsl:when test="configuration/column[1]/row[@player='red'][@rowNumber='0']
                                and configuration/column[2]/row[@player='red'][@rowNumber='1']
                                and configuration/column[3]/row[@player='red'][@rowNumber='2']
                                and configuration/column[4]/row[@player='red'][@rowNumber='3']">
                    <xsl:text>red diagonale</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>red n'as pas gangné en diagonale</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Vérification première Diagonale Haut-Bas Joueur yellow -->
        <xsl:variable name="diagonalYellowTopBottom">
            <xsl:choose>
                <xsl:when test="configuration/column[1]/row[@player='yellow'][@rowNumber='0']
                                and configuration/column[2]/row[@player='yellow'][@rowNumber='1']
                                and configuration/column[3]/row[@player='yellow'][@rowNumber='2']
                                and configuration/column[4]/row[@player='yellow'][@rowNumber='3']">
                    <xsl:text>yellow diagonale</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>yellow n'as pas gangné en diagonale</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Vérification Diagonale Bas-Haut -->
       <!-- Vérification Diagonale Bas-Haut pour le joueur red -->
        <xsl:variable name="diagonalRedBottomTop">
            <xsl:choose>
                <xsl:when test="configuration/column[1]/row[@player='red'][@rowNumber='5']
                                and configuration/column[2]/row[@player='red'][@rowNumber='4']
                                and configuration/column[3]/row[@player='red'][@rowNumber='3']
                                and configuration/column[4]/row[@player='red'][@rowNumber='2']">
                    <xsl:text>red diagonale</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>red n'as pas gangné en diagonale</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Vérification Diagonale Bas-Haut pour le joueur yellow -->
        <xsl:variable name="diagonalYellowBottomTop">
            <xsl:choose>
                <xsl:when test="configuration/column[1]/row[@player='yellow'][@rowNumber='5']
                                and configuration/column[2]/row[@player='yellow'][@rowNumber='4']
                                and configuration/column[3]/row[@player='yellow'][@rowNumber='3']
                                and configuration/column[4]/row[@player='yellow'][@rowNumber='2']">
                    <xsl:text>yellow diagonale</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>yellow n'as pas gangné en diagonale</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <!-- Vérifier si la grille est complètement remplie -->
        <!-- Compter le nombre total de cases -->
        <xsl:variable name="totalSlots" select="count(configuration/column/row)"/>

        <!-- Compter le nombre de cases occupées -->
        <xsl:variable name="occupiedSlots" select="count(configuration/column/row[@player])"/>

        <xsl:choose>
            <xsl:when test="$occupiedSlots = $totalSlots">
                <text>Le tableau est complètement rempli !</text>
            </xsl:when>
            <xsl:otherwise>
                <text>Le tableau n'est pas complètement rempli.</text>
            </xsl:otherwise>
        </xsl:choose>

        
        
    </xsl:template>

</xsl:stylesheet>