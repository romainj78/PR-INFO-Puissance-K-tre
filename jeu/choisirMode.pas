unit choisirMode;

interface 

uses types;

procedure choixMode();
procedure choixN();

implementation

procedure choixMode();
var choix: ShortInt;
begin
    app.etape := ETAPE_CHOIX_MODE;

    writeln('Choix du mode :');
    writeln('  1) Mode Un contre un');
    writeln('  2) Mode Surprise');
    writeln('  3) Mode Contre l''ordinateur (facile)');
    writeln();

    repeat
        write('Votre choix : ');
        readln(choix);
    until (choix = MODE_UNCONTREUN) or (choix = MODE_SURPRISE) or (choix = MODE_SOLO);

    app.modeJeu := choix;
end;

procedure choixN();
var choix: ShortInt;
var i, j: ShortInt;
begin
    app.etape := ETAPE_PUISSANCE_N;

    repeat
        write('Choix de la puissance N (entre 3 et 10) : ');
        readln(choix);
    until (choix >= 3) and (choix <= 10);

    app.n := choix;

    // on définit la taille de notre grille
    app.largeurGrille := app.n*2 - 1;
    app.hauteurGrille := app.n + app.n div 2;
    
    setLength(app.grilleJeu, app.hauteurGrille, app.largeurGrille); // hauteur x largeur
    setLength(app.grillePiegee, app.hauteurGrille, app.largeurGrille); 

    // puis on initialise la grille de jeu
    for i:=0 to app.hauteurGrille-1 do 
        for j:=0 to app.largeurGrille-1 do 
            app.grilleJeu[i][j] := CASE_VIDE;
end;

end.