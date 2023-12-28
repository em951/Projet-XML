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

   <!-- Vérification de la victoire pour le joueur rouge -->
    <xsl:template match="configuration">
        <!-- ... -->
        <xsl:if test="contains(util:checkWinner('red'), 'true')">
            <text>Victoire du joueur rouge!</text>
        </xsl:if>
        <!-- ... -->
    </xsl:template>

    <!-- Vérification de la victoire pour le joueur jaune -->
    <xsl:template match="configuration">
        <!-- ... -->
        <xsl:if test="contains(util:checkWinner('yellow'), 'true')">
            <text>Victoire du joueur jaune!</text>
        </xsl:if>
        <!-- ... -->
    </xsl:template>

    <!-- Vérification d'égalité -->
    <xsl:template match="configuration">
        <!-- ... -->
        <xsl:if test="not(util:checkWinner('red')) and not(util:checkWinner('yellow')) and util:boardFilled()">
            <text>Égalité!</text>
        </xsl:if>
        <!-- ... -->
    </xsl:template>

    <!-- Vérification d'une partie en cours -->
    <xsl:template match="configuration">
        <!-- ... -->
        <xsl:if test="not(util:checkWinner('red')) and not(util:checkWinner('yellow')) and not(util:boardFilled())">
            <text>Partie en cours</text>
        </xsl:if>
        <!-- ... -->
    </xsl:template>

    <!-- Fonction pour vérifier le vainqueur -->
    <xsl:function name="util:checkWinner">
        <xsl:param name="player"/>
        <!-- Logique pour vérifier la victoire -->
        <!-- Vérification Horizontale -->
        <xsl:variable name="horizontalWin">
            <!-- Vérifier chaque ligne -->
            <xsl:for-each select="column[1]/row">
                <!-- Vérifier chaque colonne -->
                <xsl:variable name="rowNumber" select="@rowNumber"/>
                <xsl:variable name="countHorizontal">
                    <xsl:value-of select="count(../row[@rowNumber = $rowNumber and @player = $player])"/>
                </xsl:variable>
                <!-- Condition de victoire horizontale -->
                <xsl:if test="$countHorizontal &gt;= 4">
                    <xsl:value-of select="true()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Verticale -->
        <xsl:variable name="verticalWin">
            <!-- Vérifier chaque colonne -->
            <xsl:for-each select="column">
                <!-- Vérifier chaque jeton dans une colonne -->
                <xsl:variable name="countVertical">
                    <xsl:value-of select="count(row[@player = $player])"/>
                </xsl:variable>
                <!-- Condition de victoire verticale -->
                <xsl:if test="$countVertical &gt;= 4">
                    <xsl:value-of select="true()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

         <!-- Vérification Diagonale Haut-Bas -->
        <xsl:variable name="diagonalWin">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[1 + ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonal">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber + position()])"/>
                    </xsl:variable>
                    <!-- Condition de victoire diagonale haut-bas -->
                    <xsl:if test="$countDiagonal &gt;= 4">
                        <xsl:value-of select="true()"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Diagonale Bas-Haut -->
        <xsl:variable name="diagonalReverseWin">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[last() - ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonalReverse">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber - position()])"/>
                    </xsl:variable>
                    <!-- Condition de victoire diagonale bas-haut -->
                    <xsl:if test="$countDiagonalReverse &gt;= 4">
                        <xsl:value-of select="true()"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Logique pour retourner la victoire du joueur -->
        <xsl:choose>
            <xsl:when test="$horizontalWin or $verticalWin or $diagonalWin or $diagonalReverseWin">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:function>

    <!-- Fonction pour vérifier si la grille est complètement remplie et si personne n'a gagné -->
    <xsl:function name="util:boardIncomplete">
        <!-- Logique pour vérifier si la grille est incomplète et personne n'a gagné -->
        <xsl:variable name="totalCount" select="count(configuration/column/row)"/>
        <xsl:variable name="filledCount" select="count(configuration/column/row[@player])"/>
        <xsl:variable name="winnerRed" select="util:checkWinner('red')"/>
        <xsl:variable name="winnerYellow" select="util:checkWinner('yellow')"/>

        <xsl:choose>
            <xsl:when test="$filledCount &lt; $totalCount and not($winnerRed) and not($winnerYellow)">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>

