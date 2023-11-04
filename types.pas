unit types;

interface

uses 
    sysutils,
    {$ifdef unix}cthreads,{$endif}
    sdl2 in 'affichage/SDL2/units/sdl2.pas';

const MAX_ITER = 50;

const MODE_UNCONTREUN = 1;
const MODE_SURPRISE = 2;
const MODE_SOLO = 3;
const MODE_SOLO_DIFF = 4;

const ETAPE_CHOIX_MODE = 1;
const ETAPE_PUISSANCE_N = 2;
const ETAPE_JEU = 3;
const ETAPE_FIN = 4;

const JOUEUR_1 = 1;
const JOUEUR_2 = 2;
const JOUEUR_ORDI = 3;

const CASE_VIDE = 0;
const PION_J1 = 1;
const PION_J2 = 2;
const PION_ORDI = 3;

// type Grille = Array[1..7] of Array[1..7] of Integer;
type Grille = Array of Array of ShortInt; // tableau de taille dynamique

type Jeu = record
    etape: ShortInt;
    n: ShortInt;
    modeJeu: ShortInt;
    joueur: ShortInt;
    grilleJeu: Grille;
    grillePiegee: Grille;
    largeurGrille: ShortInt;
    hauteurGrille: ShortInt;
    victoire: Boolean;
    affichage: record
        surfaces: record
            fond: PSDL_Surface;
            grille: PSDL_Surface;
            pionJaune: PSDL_Surface;
            pionRouge: PSDL_Surface;
        end;
        textures: record 
            fond: PSDL_Texture;
            grille: PSDL_Texture;
            pionJaune: PSDL_Texture;
            pionRouge: PSDL_Texture;
        end;
        rects: Array[1..MAX_ITER] of TSDL_Rect;
        renderer: PSDL_Renderer;
        window: PSDL_Window;
        contextWindow: PSDL_Window;
        thread: TThreadID;
    end;
end;

// Variable globale
var app: Jeu;

implementation
end.