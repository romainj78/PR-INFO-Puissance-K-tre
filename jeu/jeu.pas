unit jeu;

interface

uses 
    types,
    logique_commune in 'jeu/logique_commune.pas',
    logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
    logique_modeSolo in 'jeu/logique_modeSolo.pas',
    afficher in 'affichage/afficher.pas';

procedure jouer();
procedure unContreUn();
procedure surprise();
procedure solo();

implementation

procedure jouer();
begin
    app.etape := ETAPE_JEU;
    app.victoire := false;
    app.joueur := JOUEUR_1;

    if app.modeJeu = MODE_SURPRISE then
        placerPieges();

    // à chaque tour, on fait jouer le joueur, en fonction du mode de jeu choisi
    while (not app.victoire) and (not grillePleine()) do begin
        affichage(); // affichage de la grille

        case app.modeJeu of 
            MODE_UNCONTREUN: unContreUn();
            MODE_SURPRISE: surprise();
            MODE_SOLO: solo();
        end;
    end;

    affichage();
    changementJoueur();
    ecranVictoire();
end;

procedure unContreUn();
var col: ShortInt;
begin
    col := choixColonne() - 1;
    placerPion(col);
    changementJoueur();
    checkVictoire();
end;

procedure surprise();
begin

end;

procedure solo();
begin
    
end;

end.