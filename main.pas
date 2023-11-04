program main;

// {$UNITPATH affichage/SDL/units}

uses 
    types,
    sysutils,
    Crt,
    choisirMode in 'jeu/choisirMode.pas',
    jeu in 'jeu/jeu.pas',
    afficher in 'affichage/afficher.pas',
    //SDL2,
    sdl2 in 'affichage/SDL2/units/sdl2.pas',
    sdl2_image in 'affichage/SDL2/units/sdl2_image.pas',
    logique_commune in 'jeu/logique_commune.pas',
    logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
    logique_modeSolo in 'jeu/logique_modeSolo.pas';

begin
    writeln('Hello World!');    

    choixMode();
    choixN();
    initSDL();
    jouer();
    detruireSDL();

end.  
