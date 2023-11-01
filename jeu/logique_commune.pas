unit logique_commune;

interface

uses types;

procedure checkVictoire(grilleJeu: Grille; var victoire: Boolean);
function checkColonne(grilleJeu: Grille; x, y: Integer): Boolean;
function checkLigne(grilleJeu: Grille; x, y: Integer): Boolean;
function checkDiago(grilleJeu: Grille; x, y: Integer): Boolean;
function choixColonne(): ShortInt;
procedure changementJoueur();
function colonnePleine(col: Integer): Boolean;
procedure placerPion(col: Integer);

implementation

procedure checkVictoire(grilleJeu: Grille; var victoire: Boolean);
begin

end;

function checkColonne(grilleJeu: Grille; x, y: Integer): Boolean;
begin

end;

function checkLigne(grilleJeu: Grille; x, y: Integer): Boolean;
begin

end;

function checkDiago(grilleJeu: Grille; x, y: Integer): Boolean;
begin

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