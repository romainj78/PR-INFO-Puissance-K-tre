unit logique_modeSolo;

interface

uses 
    types,
    logique_commune;

function choixOrdiAlea(): ShortInt;
function choixOrdiDiff(): ShortInt;

implementation

function choixOrdiAlea(): ShortInt;
var col: ShortInt;
begin
    repeat
        Randomize();
        col := Random(app.largeurGrille);
    until not colonnePleine(col); // il faut que la colonne existe et ne soit pas déjà pleine

    choixOrdiAlea := col;
end;

function choixOrdiDiff(): ShortInt;
var alignementHorizontal, alignementVertical, alignementDiago, coupJoue: Boolean; 
var pion, col: ShortInt;
var proba: Integer;
begin 
    Randomize();
    proba := random(100) + 1;
    coupJoue := false;

    // On regarde d'abord s'il y a n-1 pions alignés en horizontal
    checkLigne(app.n-1, pion, col, alignementHorizontal);
    if alignementHorizontal then begin 
        coupJoue := true; // l'IA a joué, on ne regardera pas les lignes ni les diagonales
        if pion = PION_ORDI then begin // attaque
            if (proba <= 65) and (not colonnePleine(col)) then // 65% de proba de poser le pion et gagner
                choixOrdiDiff := col 
            else
                choixOrdiDiff := choixOrdiAlea();
        end else begin // défense
            if (proba <= 70) and (not colonnePleine(col)) then // 70% de proba de poser le pion et empêcher le joueur de gagner 
                choixOrdiDiff := col 
            else
                choixOrdiDiff := choixOrdiAlea();
        end;
    end else if not coupJoue then begin 
        // On regarde maintenant s'il n'y a pas n-1 pions alignés en vertical
        checkColonne(app.n-1, pion, col, alignementVertical);
        if alignementVertical then begin 
            coupJoue := true; // l'IA a joué, on ne regardera pas les diagonales
            if pion = PION_ORDI then begin // attaque
                if (proba <= 65) and (not colonnePleine(col)) then // 65% de proba de poser le pion et gagner
                    choixOrdiDiff := col 
                else
                    choixOrdiDiff := choixOrdiAlea();
            end else begin // défense
                if (proba <= 70) and (not colonnePleine(col)) then // 70% de proba de poser le pion et empêcher le joueur de gagner
                    choixOrdiDiff := col 
                else
                    choixOrdiDiff := choixOrdiAlea();
                end;
        end else if not coupJoue then begin 
            // On regarde enfin s'il n'y a pas n-1 pions alignés en diagonal
            checkDiago(app.n-1, pion, col, alignementDiago);
            if alignementDiago then begin 
                coupJoue := true;
                if pion = PION_ORDI then begin // attaque
                    if (proba <= 55) and (not colonnePleine(col)) then // 55% de proba de poser le pion et gagner
                        choixOrdiDiff := col 
                    else
                        choixOrdiDiff := choixOrdiAlea();
                end else begin // défense
                    if (proba <= 60) and (not colonnePleine(col)) then // 60% de proba de poser le pion et empêcher le joueur de gagner
                        choixOrdiDiff := col 
                    else
                        choixOrdiDiff := choixOrdiAlea();
                end;
            end else begin // Choix par défaut 
                choixOrdiDiff := choixOrdiAlea();
            end;
        end;
    end;

end; 

end.