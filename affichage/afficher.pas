unit afficher;

interface

uses 
    types,
    sysutils,
    {$ifdef unix}cthreads,{$endif}
    Crt,
    sdl2 in 'affichage/SDL2/units/sdl2.pas',
    sdl2_image in 'affichage/SDL2/units/sdl2_image.pas';

procedure affichage();
procedure ecranVictoire();
procedure afficherGrille();
procedure afficherPions(grilleJeu: Grille);
procedure initSDL();
procedure detruireSDL();
procedure boucleSDL();

implementation

// On prend pour référentiel le bord inférieur gauche

procedure affichage();
var i, j: ShortInt;
var sdlEvent: TSDL_Event;
begin
    // AFFICHAGE CONSOLE
    Clrscr();

    writeln();
    // bordure supérieure
    for i:=1 to app.largeurGrille*2+1 do 
        write('-');
    writeln();
    //affichage de chaque ligne
    for i:=app.hauteurGrille-1 downto 0 do begin
        //affichage de chaque colonne
        for j:=0 to app.largeurGrille-1 do begin
            write('|');
            if (app.grilleJeu[i][j] = PION_J1) then 
                write('x')
            else if (app.grilleJeu[i][j] = PION_J2) or (app.grilleJeu[i][j] = PION_ORDI) then   
                write('o')
            else
                write(' ');
        end;
        writeln('|');
        // affichage de la bordure inférieure de chaque ligne
        for j:=0 to app.largeurGrille*2 do
            write('-');
        writeln();
    end;
    writeln();

    // AFICHAGE SDL2

    {
    TO DO
    }
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.fond, nil, nil);
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.grille, nil, nil);
    SDL_RenderPresent(app.affichage.renderer);

    // exit loop if mouse button pressed
    while SDL_PollEvent(@sdlEvent) = 1 do
      if sdlEvent.type_ = SDL_MOUSEBUTTONDOWN then
        writeln('anngke');

    // render to window for 2 seconds
    //SDL_RenderPresent(app.affichage.renderer);
end;

procedure ecranVictoire();
begin
    app.etape := ETAPE_FIN;
    
    writeln();
    if app.victoire then
        writeln('Bravo Joueur ', app.joueur, ' ! Tu gagnes la partie !')
    else    
        writeln('Match nul...');
end;

procedure afficherGrille();
begin
    
end;

procedure afficherPions(grilleJeu: Grille);
begin
    
end;

procedure initSDL();
begin
    //initilization of video subsystem
    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt();

    // full set up
    app.affichage.window := SDL_CreateWindow('Puissance K-tre', SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1200, 800, SDL_WINDOW_SHOWN);
    if app.affichage.window = nil then Halt();

    app.affichage.renderer := SDL_CreateRenderer(app.affichage.window, -1, 0);
    if app.affichage.renderer = nil then Halt();

    // set scaling quality
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'nearest');

    // Chargement du fond
    app.affichage.surfaces.fond := IMG_LOAD('affichage/assets/Fond-Blanc-Puissance-K-tre.png');
    if app.affichage.surfaces.fond = nil then Halt();
    app.affichage.textures.fond := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.fond);
    if app.affichage.textures.fond = nil then Halt();

    // Chargement de la grille
    app.affichage.surfaces.grille := IMG_LOAD('affichage/assets/Grille-Puissance-K-tre-N4.png');
    if app.affichage.surfaces.grille = nil then Halt();
    app.affichage.textures.grille := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.grille);
    if app.affichage.textures.grille = nil then Halt();

    // Chargement des pions
    app.affichage.surfaces.pionJaune := IMG_LOAD('affichage/assets/Pion-Jaune-Puissance-K-tre-N4.png');
    if app.affichage.surfaces.pionJaune = nil then Halt();
    app.affichage.textures.pionJaune := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.pionJaune);
    if app.affichage.textures.pionJaune = nil then Halt();
    app.affichage.surfaces.pionRouge := IMG_LOAD('affichage/assets/Pion-Rouge-Puissance-K-tre-N4.png');
    if app.affichage.surfaces.pionRouge = nil then Halt();
    app.affichage.textures.pionRouge := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.pionRouge);
    if app.affichage.textures.pionRouge = nil then Halt();

    // On crée le thread pour la boucle infinie pour garder le focus de l'application 
    app.affichage.thread := BeginThread(TThreadFunc(@boucleSDL));
end;

procedure detruireSDL();
begin
    // clear memory
    SDL_DestroyTexture(app.affichage.textures.fond);
    SDL_FreeSurface(app.affichage.surfaces.fond);
    SDL_DestroyTexture(app.affichage.textures.grille);
    SDL_FreeSurface(app.affichage.surfaces.grille);
    SDL_DestroyRenderer(app.affichage.renderer);
    SDL_DestroyWindow(app.affichage.window);

    //closing SDL2
    SDL_Quit();

    // on ferme le thread
    EndThread(app.affichage.thread);
end;

procedure boucleSDL();
var exitLoop: Boolean;
var sdlEvent: TSDL_Event;
begin 
    exitLoop := false;
    while not exitLoop do begin
        {if SDL_PollEvent(@sdlEvent) = 1 then
            if sdlEvent.type_ = SDL_QUITEV then begin 
                app.victoire := true;
                exitLoop := true;
            end;}
        
        SDL_RenderPresent(app.affichage.renderer);
        // affichage();
        SDL_Delay(2000);
        writeln('a');
    end;
    
end;

end.