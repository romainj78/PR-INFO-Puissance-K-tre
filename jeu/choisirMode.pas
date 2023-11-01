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
begin
    app.etape := ETAPE_PUISSANCE_N;

    repeat
        writeln('Choix de la puissance N (entre 4 et 10) : ');
        readln(choix);
    until (choix >= 4) and (choix <= 10);

    app.n := choix;
end;

end.