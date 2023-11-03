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
  logique_commune in 'jeu/logique_commune.pas',
  logique_modeSurprise in 'jeu/logique_modeSurprise.pas',
  logique_modeSolo in 'jeu/logique_modeSolo.pas';

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlSurface1: PSDL_Surface;
  sdlTexture1: PSDL_Texture;
  sdlRectangle: TSDL_Rect;

begin
  writeln('Hello World!');

  choixMode();
  choixN();
  jouer();

  //initilization of video subsystem
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(500, 500, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;

  // set scaling quality
  SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'nearest');

  // create surface from file
  sdlSurface1 := SDL_LoadBMP('fpsdl.bmp');
  if sdlSurface1 = nil then
    Halt;

  // load image file
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  if sdlTexture1 = nil then
    Halt;

  // prepare rectangle
  sdlRectangle.x := 12;
  sdlRectangle.y := 25;
  sdlRectangle.w := 178;
  sdlRectangle.h := 116;

  // render texture
  SDL_RenderCopy(sdlRenderer, sdlTexture1, @sdlRectangle, nil);
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, @sdlRectangle);

  // render to window for 2 seconds
  SDL_RenderPresent(sdlRenderer);
  SDL_Delay(2000);

  // clear memory
  SDL_DestroyTexture(sdlTexture1);
  SDL_FreeSurface(sdlSurface1);
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow (sdlWindow1);

  //closing SDL2
  SDL_Quit;

end.  
