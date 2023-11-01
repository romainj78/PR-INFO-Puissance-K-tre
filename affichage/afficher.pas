unit afficher;

interface

uses 
    types,
    sdl2 in 'affichage/SDL/units/sdl2.pas';

procedure affichage();
procedure ecranVictoire();
procedure afficherGrille();
procedure afficherPions(grilleJeu: Grille);

implementation

// On prend pour référentiel le bord inférieur gauche

procedure affichage();
var i, j: ShortInt;
begin
    // AFFICHAGE CONSOLE

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
end;

procedure ecranVictoire();
begin
    app.etape := ETAPE_FIN;

    writeln();
    writeln('Bravo Joueur ', app.joueur, ' ! Tu gagnes la partie !');
end;

procedure afficherGrille();
begin
    
end;

procedure afficherPions(grilleJeu: Grille);
begin
    
end;

end.