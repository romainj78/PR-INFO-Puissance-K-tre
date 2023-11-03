unit logique_modeSurprise;

interface

uses 
    types,
    sysutils,
    afficher in 'affichage/afficher.pas';

const PIEGE_CHANGEMENT_COULEUR = 1;
const PIEGE_DISPARITION = 2;
const PIEGE_DESTRUCTION_COLONNE = 3;

procedure placerPieges();
procedure actionPieges(col: ShortInt);
function checkSupperposition(x, y: ShortInt): Boolean;

implementation

procedure placerPieges();
var i, j, x, y, nb, piege: ShortInt;
begin
    // on initialise la grille piégée
    for i:=0 to app.hauteurGrille-1 do 
        for j:=0 to app.largeurGrille-1 do 
            app.grillePiegee[i][j] := CASE_VIDE;

    nb := app.n - 1; // nombre de pièges à placer
    for i:=0 to nb do begin 
        repeat
            x := Random(app.largeurGrille); // on choisit une colonne au hasard
            y := Random(app.hauteurGrille); // on choisit une ligne au hasard
        until app.grillePiegee[y][x] = CASE_VIDE; // pour être sûr de ne pas placer un piège sur un piège déjà existant
        piege := Random(3)+1; // on choisir un piège au hasard parmi les 3 versions disponibles

        // on place le piège dans la grille piégée
        app.grillePiegee[y][x] := piege;
    end;
end;

procedure actionPieges(col: ShortInt);
var i, x: ShortInt;
begin
    // on connait la colonne, mais on ne connait pas encore la ligne où le pion a été posé
    for i:=0 to app.hauteurGrille-1 do 
        if app.grilleJeu[i][col] <> CASE_VIDE then 
            x := i;

    // puis on vérifie si le pion posé supperpose un piège
    if checkSupperposition(x, col) then begin
        // on affiche d'abord la grille pendant 800ms avant d'actionner le piège
        affichage();
        sleep(800);

        // puis on actionne le piège 
        case app.grillePiegee[x][col] of 
            PIEGE_CHANGEMENT_COULEUR: begin 
                // on inverse la couleur du pion
                if (app.joueur = JOUEUR_2) or (app.joueur = JOUEUR_ORDI) then  
                    app.grilleJeu[x][col] := PION_J1
                else 
                    if (app.modeJeu = MODE_SOLO) or (app.modeJeu = MODE_SOLO_DIFF) then
                        app.grilleJeu[x][col] := PION_ORDI
                    else
                        app.grilleJeu[x][col] := PION_J2;
            end;

            PIEGE_DESTRUCTION_COLONNE: begin 
                // on détruit la colonne
                for i:=0 to x do 
                    app.grilleJeu[i][col] := CASE_VIDE;
            end;

            PIEGE_DISPARITION: begin 
                // on fait disparaitre le pion posé
                app.grilleJeu[x][col] := CASE_VIDE;
            end;
        end;

        // puis dans tous les cas on supprime le piège (un piège ne s'active qu'une seule fois)
        app.grillePiegee[x][col] := CASE_VIDE;
    end;
end;

function checkSupperposition(x, y: ShortInt): Boolean;
begin
    if app.grillePiegee[x][y] <> CASE_VIDE then
        checkSupperposition := true 
    else 
        checkSupperposition := false;
end;

end.