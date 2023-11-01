unit logique_modeSurprise;

interface

uses types;

const PIEGE_CHANGEMENT_COULEUR = 1;
const PIEGE_DISPARITION = 2;
const PIEGE_DESTRUCTION_COLONNE = 3;

procedure placerPieges();
procedure actionPieges(var grilleJeu, grillePiegee: Grille);
function checkSupperposition(grilleJeu, grillePiegee: Grille; x, y: Integer): Boolean;

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
        until app.grillePiegee[y][x] <> CASE_VIDE; // pour être sûr de ne pas placer un piège sur un piège déjà existant
        piege := Random(3)+1; // on choisir un piège au hasard parmi les 3 versions disponibles

        // on place le piège dans la grille piégée
        app.grillePiegee[y][x] := piege;
    end;
end;

procedure actionPieges(var grilleJeu, grillePiegee: Grille);
begin

end;

function checkSupperposition(grilleJeu, grillePiegee: Grille; x, y: Integer): Boolean;
begin

end;

end.