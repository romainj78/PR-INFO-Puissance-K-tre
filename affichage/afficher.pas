unit afficher;

interface

uses 
    types,
    sysutils,
    Crt,
    sdl2 in 'affichage/SDL/units/sdl2.pas';

procedure affichage();
procedure ecranVictoire();
procedure afficherGrille();
procedure afficherPions(grilleJeu: Grille);
procedure initSDL();
procedure detruireSDL();

implementation

// On prend pour référentiel le bord inférieur gauche

procedure affichage();
var i, j: ShortInt;
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
end;

procedure detruireSDL();
begin
    // clear memory
    //SDL_DestroyTexture(sdlTexture1);
    //SDL_FreeSurface(sdlSurface1);
    SDL_DestroyRenderer(app.affichage.renderer);
    SDL_DestroyWindow (app.affichage.window);

    //closing SDL2
    SDL_Quit();
end;

end.