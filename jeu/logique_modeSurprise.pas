unit logique_modeSurprise;

interface

uses types;

const PIEGE_CHANGEMENT_COULEUR = 1;
const PIEGE_DISPARITION = 2;
const PIEGE_DESTRUCTION_COLONNE = 3;

procedure placerPieges(var grillePiegee: Grille);
procedure actionPieges(var grilleJeu, grillePiegee: Grille);
function checkSupperposition(grilleJeu, grillePiegee: Grille; x, y: Integer): Boolean;

implementation

procedure placerPieges(var grillePiegee: Grille);
begin

end;

procedure actionPieges(var grilleJeu, grillePiegee: Grille);
begin

end;

function checkSupperposition(grilleJeu, grillePiegee: Grille; x, y: Integer): Boolean;
begin

end;

end.