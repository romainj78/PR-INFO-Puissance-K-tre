unit types;

interface

uses 
    sysutils,
    sdl2 in 'affichage/SDL2/units/sdl2.pas';
    //sdl2;

const MAX_ITER = 50;

const MODE_UNCONTREUN = 1;
const MODE_SOLO = 2; 
const MODE_SOLO_DIFF = 3; 

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

const PIEGE_CHANGEMENT_COULEUR = 1;
const PIEGE_DISPARITION = 2;
const PIEGE_DESTRUCTION_COLONNE = 3;

// type Grille = Array[1..7] of Array[1..7] of Integer;
type Grille = Array of Array of ShortInt; // tableau de taille dynamique

type Jeu = record
    etape: ShortInt;
    n: ShortInt;
    modeJeu: ShortInt;
    modeSurprise: Boolean;
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
            piegeChangementCouleur: PSDL_Surface;
            piegeDestructionColonne: PSDL_Surface;
            piegeDisparitionPion: PSDL_Surface;
            victoireJoueur1: PSDL_Surface;
            victoireJoueur2: PSDL_Surface;
            victoireJoueur3: PSDL_Surface;
            victoireMatchNul: PSDL_Surface;
            choixMode: PSDL_Surface;
            choixSurprise: PSDL_Surface;
            choixPuissance: PSDL_Surface;
        end;
        textures: record 
            fond: PSDL_Texture;
            grille: PSDL_Texture;
            pionJaune: PSDL_Texture;
            pionRouge: PSDL_Texture;
            piegeChangementCouleur: PSDL_Texture;
            piegeDestructionColonne: PSDL_Texture;
            piegeDisparitionPion: PSDL_Texture;
            victoireJoueur1: PSDL_Texture;
            victoireJoueur2: PSDL_Texture;
            victoireJoueur3: PSDL_Texture;
            victoireMatchNul: PSDL_Texture;
            choixMode: PSDL_Texture;
            choixSurprise: PSDL_Texture;
            choixPuissance: PSDL_Texture;
        end;
        rects: Array[1..MAX_ITER] of TSDL_Rect;
        renderer: PSDL_Renderer;
        window: PSDL_Window;
        contextWindow: PSDL_Window;
        thread: TThreadID;
        posPion: TSDL_Rect;
    end;
end;

// Variable globale
var app: Jeu;

implementation
end.