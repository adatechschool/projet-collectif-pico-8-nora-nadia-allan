pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
	p=make_object(80,80,2)
	dog=make_object(30,30,0)
	initcrops()
end

function _update()
	player_movement()
 animation_sprite()
 follow()
 updatecrops()
 planter()
end

function _draw()
	update_camera()
	cls(3)
	draw_map()
	draw_objects()
	drawcrops()
end

-->8
--player

local framedelay = 15		

function player_movement()
	dx=p.x
	dy=p.y
	if (btn(➡️)) dx+=1
	if (btn(⬅️)) dx-=1
	if (btn(⬇️)) dy+=1
	if (btn(⬆️)) dy-=1
	
	if not check_flag(0,dx/8,dy/8) then
		p.x=dx
		p.y=dy
	end
end

function planter()
		 --plant seeds--
 local ptx=(p.x+4)/8
 local pty=(p.y+7)/8
 
 if btnp(❎) then
 mset(ptx,pty,12)
 add (seeds,{
     sx=ptx,
     sy=pty,
     tig=0 -- time in grow--
     })
 end
end

function animation_sprite()

	if framedelay >0 then
		framedelay-=1
		return
 end
 
 framedelay = 15
 
	if p.sprite<5 then 
		p.sprite+=1
	else
		p.sprite=2
	end
end


-->8
--make_objects

objects={}

function make_object(x,y,sprite)
	local object = {}
	object.x = x
	object.y = y
	object.sprite = sprite
	add(objects,object)
	return object
end

function draw_objects()
	spr(p.sprite,p.x,p.y)
	spr(dog.sprite,dog.x,dog.y)
end
-->8
--dog

function follow()
 -- vitesse de deplacement du chien
	local speed = 0.5 
	-- seuil de distance pour s'arreter avant d'atteindre le joueur
 distancethreshold = 9 

	if abs(dog.x - p.x) > distancethreshold then
		if dog.x < p.x then
		    dog.x += speed
		elseif dog.x > p.x then
		    dog.x -= speed
		end
  end

  if abs(dog.y - p.y) > distancethreshold then
   if dog.y < p.y then
       dog.y += speed
   elseif dog.y > p.y then
       dog.y -= speed
   end
  end
end

-->8
--map

function draw_map()
	map(0,0,0,0,128,64)
end

--collision

function check_flag(flag,x,y)
	local sprite = mget(x,y)
	return fget(sprite,flag)
end

function update_camera()
	camx=flr(p.x/128)*16
	camy=flr(p.y/128)*16
	camera(camx*8,camy*8)
end
-->8
--crops

function initcrops()
	croptimer=300
	seeds={ }
end

function updatecrops()
	for s in all(seeds) do
    s.tig+=1
    
   if s.tig>300  then
    mset(s.sx,s.sy,14)
   end
   
 end
end

function drawcrops()
	print(croptimer)
end

--function growcrops()
	--for x=0,15 do
		--for y=0,15 do
			--if mget(x,y)==70 then
				--mset(x,y,71)
				--elseif mget(x,y)==71 then
				--mset(x,y,72) 
			--end
		--end
	--end
--end
__gfx__
009fff00000000000099999000000000009999900000000000000000000999900000000000999900000000000099990004444440044444400444444000000000
0471f170009fff000999ff99009999900999ff990099999000099990009999f0009999000999999000999900099999904424444444244494444b4b4400000000
44fff4550471f170999cfc990999ff99999cfc990999ff99009999f000999fc00999999099999999099999909999999944444244444942444442b44400000000
4499444444fff45599fffff9999cfc9999fffff9999cfc9900999fc000999ff09999999099999999999999909999999944444444444444444449994400000000
440880e0449944440926262999fffff90926262999fffff900999ff0009992609999999909999999999999990999999944424444444244444429994400000000
00fffa00440880e00932333909262629093233390926262900999260000993200999999900999990099999990099999044444444494449444429992400000000
0ffff0000ffffa0000f333f009f233f900f333f009f233f9000993200003f30000f999f000f999f000f999f000f999f042444424424444244442224400000000
f09f6600f09ff900000ddd00000ddd00000ddd00000ddd00000dfd00000ddd000009dd00000d9d00000dd900000d9d0004444440044444400444444000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000330000000b00000b3b3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bb00000000400003bb300000a000003b3b3b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00bbbb0000000a00003bb30000aaa000b3b3b3b300000000044449400444f440044444400444b4400444444004444e4004244440044444400000000000000000
000330000000aa0003bbbb3000aaa000b3b3b3b300000000049444400444444004a4a44004b444400446444004e4444004444240043443400000000000000000
00033000000aaa0003bbbb30000a0000b3b3b3b3000000000444944004f44f400444444004444b4004644640044e4e4004242440044434400000000000000000
0000000000aaa0000033330000000000b3b3b3b300000000044444400444444004a44440044b4440044464400444444004444440043444400000000000000000
000000000aaa00000000000000000000b3b3b3b30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaa00000000000000000000003b3b3b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000b3b3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000bbbbbbbbbbbbbbbb003bbbbbbbbbb3000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000300000000000bbbbbbb3bbbbbbbb03bbbbbbbbbbbb300000000000000000000000000000000000000000000000000000000000000000
000000000000000000033300000000003bbbbb33bbbb33bb3bbbbbbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000
00000000000000000033333000000000333bbb343bb3343b3bbbbbb33bbbbbb30000000000000000000000000000000000000000000000000000000000000000
000000000000000003333333000000004433b334433344433b333b3333b33b330000000000000000000000000000000000000000000000000000000000000000
000000000000000000044400000000004e4434442434e44443444344e43443440000000000000000000000000000000000000000000000000000000000000000
0000000000000000000444000000000044444e42444444e44424444e444244480000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000084244444e48424448444444444444e440000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000044442444844444e499999999009aa9000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000004444444444e44444aaaa9aaa009a99000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000004484448444444444aaa9aaaa009aa9009999999900000000000000000000000000000000000000000000000000000000
000000000000000000000000000000004e44444424444244999999990099a9009aaa9aaa00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000444442444484444ea9aaaa9a009aa900aa9aaa9a00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000444244e444444444aa9aaa9a009a99009999999900000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000048444444444e444499999999009aa9000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044449400444344004444b4000000000044444400444434004444b400000000004444440044434400444444000000000000000000000000000000000
00000000049444400443b440044994400000000004a4a44004443b400444a44000000000044644400443b44004b44b4000000000000000000000000000000000
0000000004449440043b44400499994000000000044444400443b440044aaa400000000004644640043b44400144144000000000000000000000000000000000
000000000444444004444440044994400000000004a44440044444400444a4400000000004446440044444400444444000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000444f4400444344004444440000000000444b440044434400444b4400000000004444e4004443440044b444000000000000000000000000000000000
00000000044444400443b4400444a4400000000004b444400443b440044bbb400000000004e444400443b4400422224000000000000000000000000000000000
0000000004f44f40043b4440044aa4400000000004444b40043b44400444344000000000044e4e40043b44400442244000000000000000000000000000000000
00000000044444400444444004aa444000000000044b444004444440044444400000000004444440044444400444444000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000042444400444344004444440000000000444444004443440044bb4400000000000000000000000000000000000000000000000000000000000000000
00000000044444400443b4400444b44000000000043443400443b440043bb3400000000000000000000000000000000000000000000000000000000000000000
0000000004244240043b4440044848400000000004443440043b4440033bb3300000000000000000000000000000000000000000000000000000000000000000
00000000044424400444444004444440000000000434444004444440043333400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000003f26b454a4906ba3efe121255aeb1c3873fa34d200000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
__gff__
0000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
