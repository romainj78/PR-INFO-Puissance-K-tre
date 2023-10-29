unit logique_commune;

interface

uses types;

procedure checkVictoire(grilleJeu: Grille; var victoire: Boolean);
function checkColonne(grilleJeu: Grille; x, y: Integer): Boolean;
function checkLigne(grilleJeu: Grille; x, y: Integer): Boolean;
function checkDiago(grilleJeu: Grille; x, y: Integer): Boolean;
procedure choixColonne(var joueur: Integer; var grilleJeu: Grille);
function colonnePleine(grilleJeu: Grille; x, y: Integer): Boolean;
procedure placerPion(x, y: Integer; joueur: Integer; var grilleJeu: Grille);

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

procedure choixColonne(var joueur: Integer; var grilleJeu: Grille);
begin

end;

function colonnePleine(grilleJeu: Grille; x, y: Integer): Boolean;
begin

end;

procedure placerPion(x, y: Integer; joueur: Integer; var grilleJeu: Grille);
begin

end;

end.