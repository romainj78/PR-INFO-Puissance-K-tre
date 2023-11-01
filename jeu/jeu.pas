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
    while not app.victoire do begin
        affichage(); // affichage de la grille

        case app.modeJeu of 
            MODE_UNCONTREUN: unContreUn();
            MODE_SURPRISE: surprise();
            MODE_SOLO: solo();
        end;
    end;
end;

procedure unContreUn();
var col: ShortInt;
begin
    repeat
        write('Joueur ', app.joueur, ', c''est à ton tour ! Quelle colonne choisis-tu ? ');
        readln(col);
    until (col >= 0) and (col <= app.largeurGrille) and (not colonnePleine(col));

    // on change de joueur
    if (app.joueur = JOUEUR_2) or (app.joueur = JOUEUR_ORDI) then  
        app.joueur := JOUEUR_1
    else 
        if (app.modeJeu = MODE_SOLO) or (app.modeJeu = MODE_SOLO_DIFF) then
            app.joueur := JOUEUR_ORDI
        else
            app.joueur := JOUEUR_2;
end;

procedure surprise();
begin

end;

procedure solo();
begin
    
end;

end.