unit afficher;

interface

uses 
    types,
    sysutils,
    logique_commune in 'jeu/logique_commune.pas',
    Crt,
    sdl2 in 'affichage/SDL2/units/sdl2.pas',
    sdl2_image in 'affichage/SDL2/units/sdl2_image.pas';
    //sdl2,
    //sdl2_image;

procedure affichage();
procedure ecranVictoire();
procedure afficherGrille();
procedure afficherPions(grilleJeu: Grille);
procedure afficherPiege(piege: ShortInt);
procedure afficherChoixMode();
procedure afficherChoixSurprise();
procedure afficherChoixPuissance();
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

    // On affiche le fond et la grille
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.fond, nil, nil);
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.grille, nil, nil);

    for i:=app.hauteurGrille-1 downto 0 do begin
        for j:=0 to app.largeurGrille-1 do begin
            if app.grilleJeu[i][j] <> CASE_VIDE then begin
                app.affichage.posPion.x := round(150 + ((900 div app.largeurGrille) * (j+0.5)) - app.affichage.posPion.w / 2);
                app.affichage.posPion.y := round(800 - 150 - ((550 div app.hauteurGrille) * (i+0.5)) - app.affichage.posPion.h / 2);
                
                if app.grilleJeu[i][j] = PION_J1 then 
                    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.pionRouge, nil, @app.affichage.posPion)
                else
                    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.pionJaune, nil, @app.affichage.posPion);
            end;
        end;
    end;

    SDL_RenderPresent(app.affichage.renderer);
end;

procedure ecranVictoire();
var loop: Boolean = true;
var event: TSDL_Event;
begin
    app.etape := ETAPE_FIN;
    
    // Affichage console

    writeln();
    if app.victoire then
        writeln('Bravo Joueur ', app.joueur, ' ! Tu gagnes la partie !')
    else    
        writeln('Match nul...');

    // Affichage SDL2

    if app.victoire then begin 
        if app.joueur = JOUEUR_1 then 
            SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.victoireJoueur1, nil, nil)
        else if app.joueur = JOUEUR_2 then 
            SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.victoireJoueur2, nil, nil)
        else 
            SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.victoireJoueur3, nil, nil)
    end else  
        SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.victoireMatchNul, nil, nil);

    SDL_RenderPresent(app.affichage.renderer);

    // on boucle jusqu'à de que l'utilisateur clique sur la croix pour fermer la fenêtre et terminer le jeu 
    while loop do begin
        while SDL_PollEvent(@event) = 1 do begin
            case event.type_ of
                SDL_QUITEV: loop := false;
            end;

            SDL_Delay(50);
        end;
    end;
end;

procedure afficherGrille();
begin
    
end;

procedure afficherPions(grilleJeu: Grille);
begin
    
end;

procedure afficherPiege(piege: ShortInt);
begin
    // Affichage terminal 
    case piege of 
        PIEGE_CHANGEMENT_COULEUR: writeln('Piège changement de couleur !');
        PIEGE_DESTRUCTION_COLONNE: writeln('Piège destruction de colonne !');
        PIEGE_DISPARITION: writeln('Piège disparition du pion !');
    end;

    // Affichage SDL
    affichage();

    case piege of 
        PIEGE_CHANGEMENT_COULEUR: SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.piegeChangementCouleur, nil, nil);
        PIEGE_DESTRUCTION_COLONNE: SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.piegeDestructionColonne, nil, nil);
        PIEGE_DISPARITION: SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.piegeDisparitionPion, nil, nil);
    end;

    SDL_RenderPresent(app.affichage.renderer);
end;

procedure afficherChoixMode();
begin 
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.choixMode, nil, nil);
    SDL_RenderPresent(app.affichage.renderer);
end;

procedure afficherChoixSurprise();
begin 
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.choixSurprise, nil, nil);
    SDL_RenderPresent(app.affichage.renderer);
end;

procedure afficherChoixPuissance();
begin 
    SDL_RenderCopy(app.affichage.renderer, app.affichage.textures.choixPuissance, nil, nil);
    SDL_RenderPresent(app.affichage.renderer);
end;

procedure initSDL();
//var nomFichier: PChar;
begin
    // On initialise le sous-système vidéo
    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt();

    // On crée la fenêtre et le Renderer
    app.affichage.window := SDL_CreateWindow('Puissance K-tre', SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1200, 800, SDL_WINDOW_SHOWN);
    //app.affichage.window := SDL_CreateWindow('Puissance K-tre', 50, 50, 1200, 800, SDL_WINDOW_SHOWN);
    if app.affichage.window = nil then Halt();

    app.affichage.renderer := SDL_CreateRenderer(app.affichage.window, -1, 0);
    if app.affichage.renderer = nil then Halt();

    // On définit la qualité de l'échelle
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'nearest');

    // Chargement du fond
    app.affichage.surfaces.fond := IMG_LOAD('affichage/assets/Fond-Blanc-Puissance-K-tre.png');
    if app.affichage.surfaces.fond = nil then Halt();
    app.affichage.textures.fond := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.fond);
    if app.affichage.textures.fond = nil then Halt();

    {// Chargement de la grille
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
    StrDispose(nomFichier);}

    // Chargement des pièges
    app.affichage.surfaces.piegeChangementCouleur := IMG_LOAD('affichage/assets/Texte-Piege-ChangementCouleur.png');
    if app.affichage.surfaces.piegeChangementCouleur = nil then Halt();
    app.affichage.textures.piegeChangementCouleur := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.piegeChangementCouleur);
    if app.affichage.textures.piegeChangementCouleur = nil then Halt();
    app.affichage.surfaces.piegeDestructionColonne := IMG_LOAD('affichage/assets/Texte-Piege-DestructionColonne.png');
    if app.affichage.surfaces.piegeDestructionColonne = nil then Halt();
    app.affichage.textures.piegeDestructionColonne := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.piegeDestructionColonne);
    if app.affichage.textures.piegeDestructionColonne = nil then Halt();
    app.affichage.surfaces.piegeDisparitionPion := IMG_LOAD('affichage/assets/Texte-Piege-DisparitionPion.png');
    if app.affichage.surfaces.piegeDisparitionPion = nil then Halt();
    app.affichage.textures.piegeDisparitionPion := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.piegeDisparitionPion);
    if app.affichage.textures.piegeDisparitionPion = nil then Halt();

    // Chargement des victoires/défaites
    app.affichage.surfaces.victoireJoueur1 := IMG_LOAD('affichage/assets/Texte-Victoire-Joueur1.png');
    if app.affichage.surfaces.victoireJoueur1 = nil then Halt();
    app.affichage.textures.victoireJoueur1 := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.victoireJoueur1);
    if app.affichage.textures.victoireJoueur1 = nil then Halt();
    app.affichage.surfaces.victoireJoueur2 := IMG_LOAD('affichage/assets/Texte-Victoire-Joueur2.png');
    if app.affichage.surfaces.victoireJoueur2 = nil then Halt();
    app.affichage.textures.victoireJoueur2 := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.victoireJoueur2);
    if app.affichage.textures.victoireJoueur2 = nil then Halt();
    app.affichage.surfaces.victoireJoueur3 := IMG_LOAD('affichage/assets/Texte-Victoire-Joueur3.png');
    if app.affichage.surfaces.victoireJoueur3 = nil then Halt();
    app.affichage.textures.victoireJoueur3 := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.victoireJoueur3);
    if app.affichage.textures.victoireJoueur3 = nil then Halt();
    app.affichage.surfaces.victoireMatchNul := IMG_LOAD('affichage/assets/Texte-Victoire-MatchNul.png');
    if app.affichage.surfaces.victoireMatchNul = nil then Halt();
    app.affichage.textures.victoireMatchNul := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.victoireMatchNul);
    if app.affichage.textures.victoireMatchNul = nil then Halt();

    // Chargement des écrans de début 
    app.affichage.surfaces.choixMode := IMG_LOAD('affichage/assets/Ecran-Choix-Mode.png');
    if app.affichage.surfaces.choixMode = nil then Halt();
    app.affichage.textures.choixMode := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.choixMode);
    if app.affichage.textures.choixMode = nil then Halt();
    app.affichage.surfaces.choixSurprise := IMG_LOAD('affichage/assets/Ecran-Choix-Surprise.png');
    if app.affichage.surfaces.choixSurprise = nil then Halt();
    app.affichage.textures.choixSurprise := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.choixSurprise);
    if app.affichage.textures.choixSurprise = nil then Halt();
    app.affichage.surfaces.choixPuissance := IMG_LOAD('affichage/assets/Ecran-Choix-Puissance.png');
    if app.affichage.surfaces.choixPuissance = nil then Halt();
    app.affichage.textures.choixPuissance := SDL_CreateTextureFromSurface(app.affichage.renderer, app.affichage.surfaces.choixPuissance);
    if app.affichage.textures.choixPuissance = nil then Halt();

    {// On initialise la taille du rectangle position
    app.affichage.posPion.w := (550 div app.hauteurGrille) - 20;
    app.affichage.posPion.h := (550 div app.hauteurGrille) - 20;}
end;

procedure detruireSDL();
begin
    // On libère la mémoire
    SDL_DestroyTexture(app.affichage.textures.fond);
    SDL_FreeSurface(app.affichage.surfaces.fond);
    SDL_DestroyTexture(app.affichage.textures.grille);
    SDL_FreeSurface(app.affichage.surfaces.grille);
    SDL_DestroyTexture(app.affichage.textures.pionJaune);
    SDL_FreeSurface(app.affichage.surfaces.pionJaune);
    SDL_DestroyTexture(app.affichage.textures.pionRouge);
    SDL_FreeSurface(app.affichage.surfaces.pionRouge);
    SDL_DestroyRenderer(app.affichage.renderer);
    SDL_DestroyWindow(app.affichage.window);

    // On ferme la SDL2
    SDL_Quit();
end;

end.