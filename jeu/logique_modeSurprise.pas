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
var i, j: ShortInt;
begin
    // on initialise la grille piégée
    for i:=0 to app.hauteurGrille do 
        for j:=0 to app.largeurGrille do 
            app.grilleJeu[i][j] := CASE_VIDE;
end;

procedure actionPieges(var grilleJeu, grillePiegee: Grille);
begin

end;

function checkSupperposition(grilleJeu, grillePiegee: Grille; x, y: Integer): Boolean;
begin

end;

end.