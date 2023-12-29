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

        <!-- Vérification Horizontale -->
        <!-- Vérification de la victoire horizontale pour le joueur Rouge -->
        <xsl:variable name="horizontalWinRed">
            <!-- Parcours de chaque ligne -->
            <xsl:for-each select="column[1]/row">
                <!-- Parcours de chaque colonne -->
                <xsl:variable name="rowNumber" select="@rowNumber"/>
                <xsl:variable name="countHorizontalRed">
                    <xsl:value-of select="count(../row[@rowNumber = $rowNumber and @player = 'red'])"/>
                </xsl:variable>
                <!-- Condition de victoire horizontale pour le joueur Rouge -->
                <xsl:if test="$countHorizontalRed &gt;= 4">
                    <xsl:text>1</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification de la victoire horizontale pour le joueur Jaune -->
        <xsl:variable name="horizontalWinYellow">
            <!-- Parcours de chaque ligne -->
            <xsl:for-each select="column[1]/row">
                <!-- Parcours de chaque colonne -->
                <xsl:variable name="rowNumber" select="@rowNumber"/>
                <xsl:variable name="countHorizontalYellow">
                    <xsl:value-of select="count(../row[@rowNumber = $rowNumber and @player = 'yellow'])"/>
                </xsl:variable>
                <!-- Condition de victoire horizontale pour le joueur Jaune -->
                <xsl:if test="$countHorizontalYellow &gt;= 4">
                    <xsl:text>1</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

       <!-- Vérification Verticale -->
       <!-- Vérification Verticale pour le joueur yellow -->
        <xsl:variable name="verticalWinYellow">
            <!-- Vérifier chaque colonne -->
            <xsl:for-each select="column">
                <!-- Vérifier chaque jeton dans une colonne pour le joueur yellow -->
                <xsl:variable name="countVerticalYellow">
                    <xsl:value-of select="count(row[@player = 'yellow'])"/>
                </xsl:variable>
                <!-- Condition de victoire verticale pour le joueur yellow -->
                <xsl:if test="$countVerticalYellow &gt;= 4">
                    <xsl:text>1</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Verticale pour le joueur red -->
        <xsl:variable name="verticalWinRed">
            <!-- Vérifier chaque colonne -->
            <xsl:for-each select="column">
                <!-- Vérifier chaque jeton dans une colonne pour le joueur red -->
                <xsl:variable name="countVerticalRed">
                    <xsl:value-of select="count(row[@player = 'red'])"/>
                </xsl:variable>
                <!-- Condition de victoire verticale pour le joueur red -->
                <xsl:if test="$countVerticalRed &gt;= 4">
                    <xsl:text>1</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Diagonale Haut-Bas -->
        <!-- Vérification Diagonale Haut-Bas Joueur Red-->
        <xsl:variable name="diagonalWinRed">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[1 + ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonalRed">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber + position() and @player = 'red'])"/>
                    </xsl:variable>
                    <xsl:if test="$countDiagonalRed &gt;= 4">
                        <xsl:text>1</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Diagonale Haut-Bas Joueur yellow -->
        <xsl:variable name="diagonalWinYellow">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[1 + ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonalYellow">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber + position() and @player = 'yellow'])"/>
                    </xsl:variable>
                    <xsl:if test="$countDiagonalYellow &gt;= 4">
                        <xsl:text>1</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Diagonale Bas-Haut -->
       <!-- Vérification Diagonale Bas-Haut pour le joueur red -->
        <xsl:variable name="diagonalReverseWinRed">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[last() - ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonalReverseRed">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber - position() and @player = 'red'])"/>
                    </xsl:variable>
                    <!-- Condition de victoire diagonale bas-haut pour le joueur red -->
                    <xsl:if test="$countDiagonalReverseRed &gt;= 4">
                        <xsl:text>1</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>

        <!-- Vérification Diagonale Bas-Haut pour le joueur yellow -->
        <xsl:variable name="diagonalReverseWinYellow">
            <xsl:for-each select="column[position() &lt;= last() - 3]">
                <xsl:variable name="columnIndex" select="position()"/>
                <xsl:for-each select=".">
                    <xsl:variable name="startRow" select="row[last() - ($columnIndex - 1)]"/>
                    <xsl:variable name="countDiagonalReverseYellow">
                        <xsl:value-of select="count(following-sibling::column[$columnIndex]/row[$startRow/@rowNumber = @rowNumber - position() and @player = 'yellow'])"/>
                    </xsl:variable>
                    <!-- Condition de victoire diagonale bas-haut pour le joueur yellow -->
                    <xsl:if test="$countDiagonalReverseYellow &gt;= 4">
                        <xsl:text>1</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>


        <!-- Vérifier si la grille est complètement remplie -->
        <xsl:variable name="allCellsFilled">
            <xsl:choose>
                <!-- 42 jettons dans la grille -->
                <xsl:when test="count(configuration/column/row[@player]) = 42">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

         <!--Afficher le status-->
        <!--1 = vrai, 0 = faux-->
        <xsl:choose>
            <xsl:when test="$horizontalWinRed = '1' or $verticalWinRed = '1' or $diagonalWinRed = '1' or $diagonalReverseWinRed = '1'">
                <text>Victoire du joueur rouge!</text>
            </xsl:when>
            <xsl:when test="$horizontalWinYellow = '1' or $verticalWinYellow = '1' or $diagonalWinYellow = '1' or $diagonalReverseWinYellow = '1'">
                <text>Victoire du joueur jaune!</text>
            </xsl:when>
            <xsl:when test="$allCellsFilled='1' and not($horizontalWinRed = '1' or $verticalWinRed = '1' or $diagonalWinRed = '1' or $diagonalReverseWinRed = '1') and not($horizontalWinYellow = '1' or $verticalWinYellow = '1' or $diagonalWinYellow = '1' or $diagonalReverseWinYellow = '1')">
                <text>Égalité!</text>
            </xsl:when>
            <xsl:otherwise>
                <text>Partie en cours</text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>