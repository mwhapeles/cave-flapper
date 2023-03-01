pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--my game morgan whapeles
--citation: from the pico 8 manual


--cave diver
--step 7

function _init()
 game_over=false
 make_cave()
 make_player()
end
 
function _update()
 if (not game_over) then
  update_cave()
  move_player()
  check_hit()
 else
  if (btnp(5)) _init() --restart
 end
end
 
function _draw()
 cls()
 draw_cave()
 draw_player()
 
 if (game_over) then
  print("game over! try again!",44,44,7)
  print("your score:"..player.score,34,54,9)
  print("pressれ❎ to play again!",18,72,6)
 else
  print("score:"..player.score,2,2,7)
 end
end
 
function make_player()
 player={}
 player.x=24    --position
 player.y=60
 player.dy=2    --fall speed
 player.rise=1  --sprites
 player.fall=2
 player.dead=3
 player.speed=3 --fly speed
 player.score=0
end
 
function draw_player()
 if (game_over) then
  spr(player.dead,player.x,player.y)
 elseif (player.dy<0) then
  spr(player.rise,player.x,player.y)
 else
  spr(player.fall,player.x,player.y)
 end
end

function move_player()
 gravity=0.3 --bigger means more gravity!
 player.dy+=gravity --add gravity
 	
 --jump
 if (btnp(2)) then
  player.dy-=7
  sfx(0)
 end
 	
 --move to new position
 player.y+=player.dy
 
 --update score
 player.score+=player.speed
end

function check_hit()
 for i=player.x,player.x+7 do
  if (cave[i+1].top>player.y 
   or cave[i+1].btm<player.y+7) then
   game_over=true
   sfx(1)
  end
 end
end

function make_cave()
 cave={{["top"]=12,["btm"]=300}}
 top=45 --how low can the ceiling go?
 btm=99 --how high can the floor get?
end

function update_cave()
 --remove the back of the cave
 if (#cave>player.speed) then
  for i=1,player.speed do
   del(cave,cave[1])
  end
 end
 
 --add more cave
 while (#cave<128) do
  local col={}
  local up=flr(rnd(7)-3)
  local dwn=flr(rnd(7)-3)
  col.top=mid(3,cave[#cave].top+up,top)
  col.btm=mid(btm,cave[#cave].btm+dwn,124)
  add(cave,col)
 end
end

function draw_cave()
 top_color=4 --play with these!
 btm_color=2 --choose your own colors!
 for i=1,#cave do
  line(i-1,0,i-1,cave[i].top,top_color)
  line(i-1,127,i-1,cave[i].btm,btm_color)
 end
end
__gfx__
000000000777f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007000007777f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0077700000777f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777700eee777eeeeeeeeeeeeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777000eeeee7eeeeee77eeeeee7eee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000000000000007770000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000077770007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000077700007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200002505028060270302107023010250301e0300d050090200e01008070150501e0501b05017050150101903015050110500d0300c0400b0201505026050280102005013060170500d030150501307013050
001000002605025040230601d05017050130500e0500e020110500c0000d0500d0500b0700c0500f0201a0501c040220501701010060000001d0501e0501a030180601e050240602c05027020280503107000000
0010000039050000000000000000000003505000000000001f0503d05027050000003d05000000000003b050000002505000000000001105000000000000000022050000000c050000002d050000000d0502c050
0010000021050260502702028060280602805025030220701d05019060110500d0500b0500b0400d050130501906023050290302a0502a06025050120300c0600a0300b0600c0501d03015050070501b05000000
