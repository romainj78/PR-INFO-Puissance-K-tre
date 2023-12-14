unit logique_commune;

interface

uses types;

procedure checkVictoire();
//function checkColonne(): Boolean;
procedure checkColonne(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
//function checkLigne(): Boolean;
procedure checkLigne(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
//function checkDiago(): Boolean;
procedure checkDiago(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
// function choixColonne(): ShortInt;
function choixColonne(x, y: Integer): ShortInt;
procedure changementJoueur();
function colonnePleine(col: Integer): Boolean;
function grillePleine(): Boolean;
procedure placerPion(col: Integer);

implementation

procedure checkVictoire();
var alignementHorizontal, alignementVertical, alignementDiago: Boolean;
var pion, col: ShortInt;
begin
    checkColonne(app.n, pion, col, alignementVertical);
    checkLigne(app.n, pion, col, alignementHorizontal);
    checkDiago(app.n, pion, col, alignementDiago);

    //if checkColonne() or checkLigne() or checkDiago() then
    if alignementV or alignementH or alignementD then
        app.victoire := true;
end;

//function checkColonne(): Boolean;
procedure checkColonne(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
var i, j, k, qte, val: ShortInt;
begin
    // on initialise la valeur de retour à false
    alignement := false;

    // si on trouve une colonne avec n pions alignés, on passe la valeur à true
    // on parcourt toutes les colonnes
    for j:=0 to app.largeurGrille-1 do begin   
        for i:=0 to app.hauteurGrille - app.n do begin // ligne de départ (on retire n pour ne pas dépasser de la grille)
            qte := 0;
            val := app.grilleJeu[i][j]; // valeur de référence

            if val <> CASE_VIDE then begin // on vérifie que la première case ne soit pas une case vide 
                for k:=i to i + n - 1 do // on parcourt les n lignes au-dessus pour voir si les pions se succèdent
                    if app.grilleJeu[k][j] = val then // on compte le nombre de même symbole d'affilée
                        qte := qte+1
                    else 
                        break;
            end;

            // on peut sortir plus tôt de la boucle
            if qte = n then begin 
                if n = app.n then begin 
                    alignement := true; // on passe la veleur à true car n pions sont alignés
                    col := j;
                    pion := app.grilleJeu[i][j];
                    break;
                end else begin // si c'est pour l'IA, on vérifie que la case d'après est vide
                    if (app.grilleJeu[k+1][j] = CASE_VIDE) then begin 
                        alignement := true; // on passe la veleur à true car n pions sont alignés
                        col := j; // on renvoie la colonne où l'IA doit placer son pion 
                        pion := app.grilleJeu[i][j]; // on renvoie la couleur des pions alignés pour que l'IA sache si elle doit se défendre ou attaquer 
                        break;
                    end;
                end;
            end;
        end;

        // on peut sortir plus tôt de la boucle
        if alignement then break;     
    end;
end;

//function checkLigne(): Boolean;
procedure checkLigne(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
var i, j, k, qte, val: ShortInt;
begin
    // on initialise la valeur de retour à false
    alignement := false;

    // si on trouve une ligne avec n pions alignés, on passe la valeur à true
    // on parcourt toutes les lignes
    for i:=0 to app.hauteurGrille-1 do begin 
        for j:=0 to app.largeurGrille - app.n do begin // colonne de départ (on retire n pour ne pas dépasser de la grille)
            qte := 0;
            val := app.grilleJeu[i][j]; // valeur de référence
            
            if val <> CASE_VIDE then begin // on vérifie que la première case ne soit pas une case vide 
                for k:=j to j + n - 1 do // on parcourt les n colonnes à droite pour voir si les pions se succèdent
                    if app.grilleJeu[i][k] = val then // on compte le nombre de même symbole d'affilée
                        qte := qte+1
                    else 
                        break;
            end;

            // on peut sortir plus tôt de la boucle
            if qte = n then begin 
                if n = app.n then begin 
                    alignement := true; // on passe la veleur à true car n pions sont alignés
                    col := j+n;
                    pion := app.grilleJeu[i][j];
                    break;
                end else begin // si c'est pour l'IA, on vérifie que la case d'après est vide
                    if (app.grilleJeu[i][k+1] = CASE_VIDE) then begin 
                        alignement := true; // on passe la veleur à true car n pions sont alignés
                        col := j+n; // on renvoie la colonne où l'IA doit placer son pion 
                        pion := app.grilleJeu[i][j]; // on renvoie la couleur des pions alignés pour que l'IA sache si elle doit se défendre ou attaquer 
                        break;
                    end;
                end;
            end;
        end;

        // on peut sortir plus tôt de la boucle
        if alignement then break;     
    end;
end;

//function checkDiago(): Boolean;
procedure checkDiago(n: ShortInt ; var pion, col: ShortInt ; var alignement: Boolean);
var i, j, k, qteD, qteG, val: ShortInt;
begin
    // on initialise la valeur de retour à false
    alignement := false;

    // si on trouve une daigonale avec n pions alignés, on passe la valeur à true
    for i := 0 to app.hauteurGrille - app.n do begin 
        for j := 0 to app.largeurGrille - app.n do begin // colonne de départ (on retire n pour ne pas dépasser de la grille)
            qteD := 0;
            val := app.grilleJeu[i][j]; // valeur de référence
            
            if val <> CASE_VIDE then begin // on vérifie que la première case ne soit pas une case vide 
                // on vérifie la colonne montante droite
                for k:=0 to n - 1 do // on parcourt les n colonnes à droite pour voir si les pions se succèdent en diagonale montanten droite
                    if app.grilleJeu[i+k][j+k] = val then // on compte le nombre de même symbole d'affilée
                        qteD := qteD+1
                    else 
                        break;
            end;

            // on peut sortir plus tôt de la boucle
            if qteD = n then begin 
                if n = app.n then begin 
                    alignement := true; // on passe la veleur à true car n pions sont alignés
                    col := j+n;
                    pion := app.grilleJeu[i][j];
                    break;
                end else begin // si c'est pour l'IA, on vérifie que la case d'après est vide
                    if (app.grilleJeu[i+k+1][j+k+1] = CASE_VIDE) then begin 
                        alignement := true; // on passe la veleur à true car n pions sont alignés
                        col := j+n; // on renvoie la colonne où l'IA doit placer son pion 
                        pion := app.grilleJeu[i][j]; // on renvoie la couleur des pions alignés pour que l'IA sache si elle doit se défendre ou attaquer 
                        break;
                    end;
                end;
            end;
        end;

        if not alignement then begin 
            for j := app.n - 1 to app.largeurGrille - 1 do begin // colonne de départ (on retire n pour ne pas dépasser de la grille)
                qteG := 0;
                val := app.grilleJeu[i][j]; // valeur de référence
                
                if val <> CASE_VIDE then begin // on vérifie que la première case ne soit pas une case vide 
                    // on vérifie la colonne montante gauche
                    for k:=0 to n - 1 do // on parcourt les n colonnes à gauche pour voir si les pions se succèdent en diagonale montanten gauche
                        if app.grilleJeu[i+k][j-k] = val then // on compte le nombre de même symbole d'affilée
                            qteG := qteG+1
                        else 
                            break;
                end;

                // on peut sortir plus tôt de la boucle
                if qteG = n then begin 
                    if n = app.n then begin 
                        alignement := true; // on passe la veleur à true car n pions sont alignés
                        col := j-n;
                        pion := app.grilleJeu[i][j];
                        break;
                    end else begin // si c'est pour l'IA, on vérifie que la case d'après est vide
                        if (app.grilleJeu[i+k+1][j-k-1] = CASE_VIDE) then begin 
                            alignement := true; // on passe la veleur à true car n pions sont alignés
                            col := j-n; // on renvoie la colonne où l'IA doit placer son pion 
                            pion := app.grilleJeu[i][j]; // on renvoie la couleur des pions alignés pour que l'IA sache si elle doit se défendre ou attaquer 
                            break;
                        end;
                    end;
                end;
            end;
        end;

        // on peut sortir plus tôt de la boucle
        if alignement then break;     
    end;
end;

// function choixColonne(): ShortInt;
function choixColonne(x, y: Integer): ShortInt;
// var col: ShortInt;
begin
    // CONSOLE

    {repeat
        write('Joueur ', app.joueur, ', c''est à ton tour ! Quelle colonne choisis-tu ? ');
        readln(col);
    until (col > 0) and (col <= app.largeurGrille) and (not colonnePleine(col)); // il faut que la colonne existe et ne soit pas déjà pleine

    choixColonne := col;}

    // SDL

    choixColonne := (x - 150) div (900 div app.largeurGrille);

    if colonnePleine(choixColonne) then 
        choixColonne := -1; // le choix de la colonne est incorrect
end;

procedure changementJoueur();
begin 
    if (app.joueur = JOUEUR_2) or (app.joueur = JOUEUR_ORDI) then  
        app.joueur := JOUEUR_1
    else 
        if (app.modeJeu = MODE_SOLO) or (app.modeJeu = MODE_SOLO_DIFF) then
            app.joueur := JOUEUR_ORDI
        else
            app.joueur := JOUEUR_2;
end;

function colonnePleine(col: Integer): Boolean;
begin
    //if app.grilleJeu[app.hauteurGrille-1][col-1] <> CASE_VIDE then
    if app.grilleJeu[app.hauteurGrille-1][col] <> CASE_VIDE then
        colonnePleine := true 
    else
        colonnePleine := false;
end;

function grillePleine(): Boolean;
var i, j: ShortInt;
begin
    // on initialise la valeur de retour à true
    grillePleine := true;
    // on parcourt toutes les lignes et colonnes jusqu'à trouver une case vide
    for i:=0 to app.hauteurGrille-1 do begin
        for j:=0 to app.largeurGrille-1 do begin
            if app.grilleJeu[i][j] = CASE_VIDE then begin // s'il y a une case vide, la grille n'est pas plein
                grillePleine := false;
                break;
            end;
        end;
        // on peut sortir de la boucle plus tôt
        if not grillePleine then break;
    end;
end;

procedure placerPion(col: Integer);
var i, num: ShortInt;
begin
    // on recherche d'abord la première ligne dont la case est vide pour la colonne sélectionnée
    for i:=app.hauteurGrille-1 downto 0 do 
        if app.grilleJeu[i][col] = CASE_VIDE then
            num := i;

    // on place ensuite le pion correspondant au joueur
    case app.joueur of 
        JOUEUR_1: app.grilleJeu[num][col] := PION_J1;
        JOUEUR_2: app.grilleJeu[num][col] := PION_J2;
        JOUEUR_ORDI: app.grilleJeu[num][col] := PION_ORDI;
    end;
end;

end.