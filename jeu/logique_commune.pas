unit logique_commune;

interface

uses types;

procedure checkVictoire();
function checkColonne(): Boolean;
function checkLigne(): Boolean;
function checkDiago(): Boolean;
function choixColonne(): ShortInt;
procedure changementJoueur();
function colonnePleine(col: Integer): Boolean;
procedure placerPion(col: Integer);

implementation

procedure checkVictoire();
begin
    if checkColonne() or checkLigne() or checkDiago() then
        app.victoire := true;

    writeln(app.victoire);
end;

function checkColonne(): Boolean;
var i, j, k, qte, val: ShortInt;
begin
    // on initialise la valeur de retour à false
    checkColonne := false;

    // si on trouve une colonne avec n piosn alignés, on passe la valeur à true
    // on parcourt toutes les colonnes
    for j:=0 to app.largeurGrille-1 do begin   
        for i:=0 to app.hauteurGrille - app.n do begin // ligne de départ (on retire n pour ne pas dépasser de la grille)
            qte := 0;
            val := app.grilleJeu[0][j];
            
            if val <> CASE_VIDE then begin // on vérifie que la première case ne soit pas une case vide 
                for k:=i to i + app.n do // on parcourt les n lignes au-dessus pour voir si les pions se succèdent
                    if app.grilleJeu[k][j] = val then // on compte le nombre de même symbole d'affilée
                        qte := qte+1
                    else 
                        break;
            end;

            // on peut sortir plus tôt de la boucle
            if qte = app.n then begin 
                checkColonne := true;
                break;
            end;
        end;

        // on peut sortir plus tôt de la boucle
        if checkColonne then break;     
    end;
end;

function checkLigne(): Boolean;
begin
    checkLigne := false;
end;

function checkDiago(): Boolean;
begin
    checkDiago := false;
end;

function choixColonne(): ShortInt;
var col: ShortInt;
begin
    repeat
        write('Joueur ', app.joueur, ', c''est à ton tour ! Quelle colonne choisis-tu ? ');
        readln(col);
    until (col > 0) and (col <= app.largeurGrille) and (not colonnePleine(col)); // il faut que la colonne existe et ne soit pas déjà pleine

    choixColonne := col;
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
    if app.grilleJeu[app.hauteurGrille-1][col] <> CASE_VIDE then
        colonnePleine := true 
    else
        colonnePleine := false;
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