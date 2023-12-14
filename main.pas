program main;

uses 
    types,
    sysutils,
    Crt,
    choisirMode in 'jeu/choisirMode.pas',
    jeu in 'jeu/jeu.pas',
    afficher in 'affichage/afficher.pas',
    //sdl2 in 'affichage/SDL2/units/sdl2.pas',
    //sdl2_image in 'affichage/SDL2/units/sdl2_image.pas',
    sdl2,
    sdl2_image,
    logique_commune in 'jeu/logique_commune.pas',
    logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
    logique_modeSolo in 'jeu/logique_modeSolo.pas';

begin
    initSDL();
    choixMode();
    choixModeSurprise();
    choixN();
    jouer();
    detruireSDL();
end.  
