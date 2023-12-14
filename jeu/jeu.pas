unit jeu;

interface

uses 
    types,
    sysutils,
    //sdl2 in 'affichage/SDL2/units/sdl2.pas',
    sdl2,
    logique_commune in 'jeu/logique_commune.pas',
    logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
    logique_modeSolo in 'jeu/logique_modeSolo.pas',
    afficher in 'affichage/afficher.pas';

procedure jouer();
{procedure unContreUn();
procedure surprise();
procedure solo();}

implementation

procedure jouer();
var loop: Boolean = true;
var event: TSDL_Event;
var x, y: Integer;
var col: ShortInt;
begin
    app.etape := ETAPE_JEU;
    app.victoire := false;
    app.joueur := JOUEUR_1;

    Randomize(); // pour les modes de jeu surprise et solo

    // si on a choisit le mode de jeu surprise, on initialise la grille piégée
    if app.modeSurprise then
        placerPieges();

    affichage();

    // à chaque tour, on fait jouer le joueur, en fonction du mode de jeu choisi
    while loop and (not app.victoire) and (not grillePleine()) do begin
        while SDL_PollEvent(@event) = 1 do begin
            case event.type_ of
                SDL_MOUSEBUTTONUP: begin 
                    x := event.button.x;
                    y := event.button.y;

                    // On regarde si le clic est dans la grille : 
                    if (x >= 150) and (x <= 1200-150) and (y >= 100) and (y <= 800-150) then begin 
                        col := choixColonne(x, y);

                        // Si on a cliqué sur un colonne qui n'est pas pleine
                        if col <> -1 then begin 
                            placerPion(col);

                            if app.modeSurprise then
                                actionPieges(col);

                            changementJoueur();
                            checkVictoire();

                            if (not app.victoire) and ((app.modeJeu = MODE_SOLO) or (app.modeJeu = MODE_SOLO_DIFF)) and (app.joueur = JOUEUR_ORDI) then begin 
                                affichage();
                                sleep(300);
                                if app.modeJeu = MODE_SOLO then 
                                    col := choixOrdiAlea()
                                else  
                                    col := choixOrdiDiff();
                                placerPion(col);
                                changementJoueur();
                                checkVictoire();
                            end;
                        end;
                    end;

                    affichage(); // affichage de la grille
                end;
                SDL_QUITEV:  begin 
                    //app.victoire := true;
                    loop := false;
                end;
            end;

            SDL_Delay(50);
        end;

        {case app.modeJeu of 
            MODE_UNCONTREUN: unContreUn();
            MODE_SURPRISE: surprise();
            MODE_SOLO: solo();
        end;}
    end;

    affichage();
    changementJoueur();
    if loop then begin 
        sleep(1000);
        ecranVictoire();
    end;
end;

{procedure unContreUn();
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
end;}

end.