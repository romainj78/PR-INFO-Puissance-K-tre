unit jeu;

interface

uses 
    types,
    logique_commune in 'jeu/logique_commune.pas',
    logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
    logique_modeSolo in 'jeu/logique_modeSolo.pas',
    choixMode in 'jeu/choixMode.pas',
    afficher in 'affichage/afficher.pas';

procedure jouer(modeJeu: Integer);
procedure surprise(grilleJeu: Grille);
procedure unContreUn(grilleJeu: Grille);
procedure solo(grilleJeu: Grille);

implementation

procedure jouer(modeJeu: Integer);
begin
    
end;

procedure surprise(grilleJeu: Grille);
var grillePiegee: Grille;
begin

end;

procedure unContreUn(grilleJeu: Grille);
begin

end;

procedure solo(grilleJeu: Grille);
begin

end;

end.