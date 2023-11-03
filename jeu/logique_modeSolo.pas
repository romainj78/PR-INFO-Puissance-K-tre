unit logique_modeSolo;

interface

uses 
    types,
    logique_commune;

function choixOrdiAlea(): ShortInt;

implementation

function choixOrdiAlea(): ShortInt;
var col: ShortInt;
begin
    repeat
        col := Random(app.largeurGrille);
    until not colonnePleine(col); // il faut que la colonne existe et ne soit pas déjà pleine

    choixOrdiAlea := col;
end;

end.