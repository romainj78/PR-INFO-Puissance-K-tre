unit jeu;

interface

uses 
    types,
    sysutils,
    sdl2 in 'affichage/SDL2/units/sdl2.pas',
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
var exitLoop: Boolean;
var sdlEvent: TSDL_Event;
begin
    app.etape := ETAPE_JEU;
    app.victoire := false;
    app.joueur := JOUEUR_1;

    Randomize(); // pour les modes de jeu surprise et solo

    // si on a choisit le mode de jeu surprise, on initialise la grille piégée
    if app.modeJeu = MODE_SURPRISE then
        placerPieges();

    exitLoop := false;
    // à chaque tour, on fait jouer le joueur, en fonction du mode de jeu choisi
    while (not app.victoire) and (not grillePleine()) and (not exitLoop) do begin
        affichage(); // affichage de la grille

        case app.modeJeu of 
            MODE_UNCONTREUN: unContreUn();
            MODE_SURPRISE: surprise();
            MODE_SOLO: solo();
        end;

        // exit loop if mouse button pressed
        while SDL_PollEvent(@sdlEvent) = 1 do
            if sdlEvent.type_ = SQL_QUIT then
                exitLoop := true;
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
var col: ShortInt;
begin
    col := choixColonne() - 1;
    placerPion(col);
    actionPieges(col);
    changementJoueur();
    checkVictoire();
end;

procedure solo();
var col: ShortInt;
begin
    if app.joueur = JOUEUR_ORDI then begin 
        col := choixOrdiAlea();
        sleep(300);
    end else 
        col := choixColonne() - 1;
    placerPion(col);
    changementJoueur();
    checkVictoire();
end;

end.