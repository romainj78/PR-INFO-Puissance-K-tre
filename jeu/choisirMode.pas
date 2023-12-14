unit choisirMode;

interface 

uses 
    types,
    sysutils,
    Crt,
    sdl2 in 'affichage/SDL2/units/sdl2.pas',
    sdl2_image in 'affichage/SDL2/units/sdl2_image.pas',
    //sdl2,
    //sdl2_image,
    afficher in 'affichage/afficher.pas';

procedure choixMode();
procedure choixModeSurprise();
procedure choixN();

implementation

procedure choixMode();
//var choix: ShortInt;
var event: TSDL_Event;
var x, y: Integer;
begin
    app.etape := ETAPE_CHOIX_MODE;

    // CONSOLE

    {writeln('Choix du mode :');
    writeln('  1) Mode Un contre un');
    //writeln('  2) Mode Surprise');
    writeln('  2) Mode Contre l''ordinateur (facile)');
    //writeln('  3) Mode contre l''ordinateur (difficile)');
    writeln();

    repeat
        write('Votre choix : ');
        readln(choix);
    until (choix = MODE_UNCONTREUN) or (choix = MODE_SOLO);
    
    app.modeJeu := choix;}

    // SDL 2

    afficherChoixMode();
    app.modeJeu := 0;

    while app.modeJeu = 0 do
        while SDL_PollEvent(@event) = 1 do begin
            case event.type_ of
                SDL_MOUSEBUTTONUP: begin 
                    x := event.button.x;
                    y := event.button.y;

                    if (x >= 50) and (x <= 350) and (y >= 450) and (y <= 600) then  
                        app.modeJeu := MODE_UNCONTREUN
                    else if (x >= 450) and (x <= 750) and (y >= 450) and (y <= 600) then  
                        app.modeJeu := MODE_SOLO
                    else if (x >= 850) and (x <= 1150) and (y >= 450) and (y <= 600) then  
                        app.modeJeu := MODE_SOLO_DIFF;
                end;
                SDL_QUITEV:  detruireSDL();
            end;

            afficherChoixMode();
            SDL_Delay(50);
        end;
end;

procedure choixModeSurprise();
//var choix: String;
var event: TSDL_Event;
var x, y: Integer;
var loop: Boolean = true;
begin
    // CONSOLE

    {repeat
        write('Voulez-vous jouer en mode surprise ? (y/n) ');
        readln(choix);
    until (choix = 'y') or (choix = 'n');

    if choix = 'y' then 
        app.modeSurprise := true 
    else 
        app.modeSurprise := false;}

    // SDL2

    afficherChoixSurprise();

    while loop do
        while SDL_PollEvent(@event) = 1 do begin
            case event.type_ of
                SDL_MOUSEBUTTONUP: begin 
                    x := event.button.x;
                    y := event.button.y;

                    if (x >= 250) and (x <= 550) and (y >= 450) and (y <= 600) then  begin 
                        app.modeSurprise := true;
                        loop := false;
                    end else if (x >= 650) and (x <= 950) and (y >= 450) and (y <= 600) then begin 
                        app.modeSurprise := false;
                        loop := false;
                    end;
                end;
                SDL_QUITEV:  detruireSDL();
            end;

            afficherChoixSurprise();
            SDL_Delay(50);
        end;
end;

procedure choixN();
//var choix: ShortInt;
var i, j: ShortInt;
var event: TSDL_Event;
var x, y: Integer;
var nomFichier: PChar;
begin
    app.etape := ETAPE_PUISSANCE_N;

    // CONSOLE
    
    {repeat
        write('Choix de la puissance N (entre 3 et 10) : ');
        readln(choix);
    until (choix >= 3) and (choix <= 7);

    app.n := choix;

    // on définit la taille de notre grille
    app.largeurGrille := app.n*2 - 1;
    app.hauteurGrille := app.n + app.n div 2;
    
    setLength(app.grilleJeu, app.hauteurGrille, app.largeurGrille); // hauteur x largeur
    setLength(app.grillePiegee, app.hauteurGrille, app.largeurGrille); }

    // SDL 2

    afficherChoixPuissance();
    app.n := 0;

    while app.n = 0 do
        while SDL_PollEvent(@event) = 1 do begin
            case event.type_ of
                SDL_MOUSEBUTTONUP: begin 
                    x := event.button.x;
                    y := event.button.y;

                    if (x >= 125) and (x <= 275) and (y >= 450) and (y <= 600) then  
                        app.n := 3
                    else if (x >= 325) and (x <= 475) and (y >= 450) and (y <= 600) then  
                        app.n := 4
                    else if (x >= 525) and (x <= 675) and (y >= 450) and (y <= 600) then  
                        app.n := 5
                    else if (x >= 725) and (x <= 875) and (y >= 450) and (y <= 600) then  
                        app.n := 6
                    else if (x >= 925) and (x <= 1075) and (y >= 450) and (y <= 600) then  
                        app.n := 7;
                end;
                SDL_QUITEV:  detruireSDL();
            end;

            afficherChoixPuissance();
            SDL_Delay(50);
        end;

    // on définit la taille de notre grille
    app.largeurGrille := app.n*2 - 1;
    app.hauteurGrille := app.n + app.n div 2;
    
    setLength(app.grilleJeu, app.hauteurGrille, app.largeurGrille); // hauteur x largeur
    setLength(app.grillePiegee, app.hauteurGrille, app.largeurGrille);

    // puis on initialise la grille de jeu
    for i:=0 to app.hauteurGrille-1 do 
        for j:=0 to app.largeurGrille-1 do 
            app.grilleJeu[i][j] := CASE_VIDE;

    // Chargement de la grille
    nomFichier := StrAlloc(length('affichage/assets/Grille-Puissance-K-tre-N.png')+2);
    strpcopy(nomFichier, 'affichage/assets/Grille-Puissance-K-tre-N' + IntToStr(app.n) + '.png');
    app.affichage.surfaces.grille := IMG_LOAD(nomFichier);
    if app.affichage.surfaces.grille = nil then Halt();
    app.affichage.textures.grille := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.grille);
    if app.affichage.textures.grille = nil then Halt();

    // Chargement des pions
    strpcopy(nomFichier, 'affichage/assets/Pion-Jaune-Puissance-K-tre-N' + IntToStr(app.n) + '.png');
    app.affichage.surfaces.pionJaune := IMG_LOAD(nomFichier);
    if app.affichage.surfaces.pionJaune = nil then Halt();
    app.affichage.textures.pionJaune := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.pionJaune);
    if app.affichage.textures.pionJaune = nil then Halt();
    strpcopy(nomFichier, 'affichage/assets/Pion-Rouge-Puissance-K-tre-N' + IntToStr(app.n) + '.png');
    app.affichage.surfaces.pionRouge := IMG_LOAD(nomFichier);
    if app.affichage.surfaces.pionRouge = nil then Halt();
    app.affichage.textures.pionRouge := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.pionRouge);
    if app.affichage.textures.pionRouge = nil then Halt();
    StrDispose(nomFichier);

    app.affichage.posPion.w := (550 div app.hauteurGrille) - 20;
    app.affichage.posPion.h := (550 div app.hauteurGrille) - 20;
end;

end.