unit types;

interface

uses sdl2 in 'affichage/SDL2/units/sdl2.pas';

const MAX_ITER = 50;

const MODE_UNCONTREUN = 1;
const MODE_SURPRISE = 2;
const MODE_SOLO = 3;
const MODE_PUISSANCEN = 4;
const MODE_SOLO_DIFF = 5;

const ETAPE_CHOIX_MODE = 1;
const ETAPE_PUISSANCE_N = 2;
const ETAPE_JEU = 3;
const ETAPE_FIN = 4;

const JOUEUR_1 = 1;
const JOUEUR_2 = 2;
const JOUEUR_ORDI = 3;

const PION_J1 = 1;
const PION_J2 = 2;
const PION_ORDI = 3;

// type Grille = Array[1..7] of Array[1..7] of Integer;
type Grille: Array of Array of ShortInt; // tableau de taille dynamique

type App = record
    etape: ShortInt;
    jeu: record
        n: ShortInt;
        modeJeu: ShortInt;
        grilleJeu: Grille;
        grillePiegee: Grille;
        victoire: Boolean;
    end; 
    affichage: record
        textures: Array[1..MAX_ITER] of PSDL_Texture;
        surfaces: Array[1..MAX_ITER] of PSDL_Surface;
        rects: Array[1..MAX_ITER] of TSDL_Rect;
        renderers: Array[1..MAX_ITER] of PSDL_Renderer;
        window: PSDL_Window;
        contextWindow: PSDL_Window;
    end;
end;

implementation
end.