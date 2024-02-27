pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
	p=make_object(170,170,1,5,33,7,1)
	dog=make_object(160,160,11)
	initcrops()
end

function _update()
	player_movement()
 follow()
 updatecrops()
 plant_seeds()
end

function _draw()
	update_camera()
	cls(3)
	draw_map()
	draw_objects()
	drawcrops()
	print(p.sprite)
	print(p.sdown)
	print(p.sup)
	print(p.snumber)
end

-->8
--player

local framedelay = 15

function player_movement()
	dx=p.x
	dy=p.y
	if (btn(➡️)) then
	 p.x+=1
	 animation_right()
	 p.snumber=p.sright
	elseif (btn(⬅️)) then
		p.x-=1
		animation_left()
		p.snumber=p.sleft
	elseif (btn(⬇️)) then
		p.y+=1
		animation_down()
		p.snumber=p.sdown
	elseif (btn(⬆️)) then
		p.y-=1
	 animation_up()
	 p.snumber=p.sup
	else
	p.snumber=p.sprite
	end
	if  collide(p) then
		p.x=dx
		p.y=dy
	end
end

function plant_seeds()
 local plantx=(p.x+4)/8
 local planty=(p.y+7)/8
 
 if btnp(❎) then
	 if fget(mget(plantx,planty),1) then
		 mset(plantx,planty,13)
		 add (seeds,{
	   sx=flr(plantx),
	   sy=flr(planty),
	   tig=0 --time in ground
	   })
	 elseif fget(mget(plantx,planty),2) then
	 	--collect carrot
	 	mset(plantx,planty,0)
	 	for s in all(seeds) do
	 		if s.sx==flr(plantx) and s.sy==flr(planty) then
	 			del(seeds,s)
	 		end
	 	end--for
	 end
 end
end

function animation_down()
 
	if framedelay >0 then
		framedelay-=1
		return
 end
 
 framedelay = 15
 
	if p.sdown<4 then 
		p.sdown+=1
	else
		p.sdown=1
	end
end

function animation_right()
	
	if framedelay >0 then
		framedelay-=1
		return
 end
 
 framedelay = 15
 
	if p.sright<6 then 
		p.sright+=1
	else
		p.sright=5
	end
end

function animation_up()
	if framedelay >0 then
		framedelay-=1
		return
 end
 
 framedelay = 15
 
	if p.sup<10 then 
		p.sup+=1
	else
		p.sup=7
	end
end

function animation_left()
		
	if framedelay >0 then
		framedelay-=1
		return
 end
 
 framedelay = 15
 
	if p.sleft<34 then 
		p.sleft+=1
	else
		p.sleft=33
	end
end
-->8
--make_objects

objects={}

function make_object(x,y,sprite,sright,sleft,sup,sdown)
	local object = {}
	object.x = x
	object.y = y
	object.snumber = sprite
	object.sprite = sprite
	object.sright = sright
	object.sleft = sleft
	object.sup = sup
	object.sdown = sdown
	add(objects,object)
	return object
end

function draw_objects()
	spr(p.snumber,p.x,p.y)
	spr(dog.sprite,dog.x,dog.y)
end
-->8
--dog

function follow()

	local speed = 0.7 --deplacement pixel/frame
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

--check_flag
function check_flag(flag,x,y)
	local sprite = mget(x,y)
	return fget(sprite,flag)
end

-- collide
function collide(p)

local x1 = p.x/8
local y1 = p.y/8
local x2 = (p.x+7)/8
local y2 = (p.y+7)/8

local a=fget(mget(x1,y1),0)
local b=fget(mget(x1,y2),0)
local c=fget(mget(x2,y2),0)
local d=fget(mget(x2,y1),0)

	if a or b or c or d then
	 return true
	else 
	 return false
	end
end

--camera

function update_camera()
	camx=flr(p.x/128)*16
	camy=flr(p.y/128)*16
	camera(camx*8,camy*8)
end

function check_flag(x,y,flag)
	local sprite=mget(x,y)
	return fget(sprite,flag)
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
    mset(s.sx,s.sy,15)
   end
   
 end
end

function drawcrops()

end
__gfx__
0000000000999990000000000099999000000000000000000009999000000000009999000000000000999900009fff0000000000044444400444444004444440
000000000999ff99009999900999ff990099999000099990009999f0009999000999999000999900099999900471f170009fff004424444444244494444b4b44
00700700999cfc990999ff99999cfc990999ff99009999f000999fc00999999099999999099999909999999944fff4550471f17044444244444942444442b444
0007700099fffff9999cfc9999fffff9999cfc9900999fc000999ff0999999909999999999999990999999994499444444fff455444444444444444444499944
000770000926262999fffff90926262999fffff900999ff00099926099999999099999999999999909999999440880e044994444444244444442444444299944
007007000912111909262629091211190926262900999260000991200999999900999990099999990099999000fffa00440880e0444444444944494444299924
0000000000f111f009f211f900f111f009f211f9000991200001f10000f999f000f999f000f999f000f999f00ffff0000ffffa00424444244244442444422244
00000000000ddd00000ddd00000ddd00000ddd00000dfd00000ddd000009dd00000d9d00000dd900000d9d00f09f6600f09ff900044444400444444004444440
0000000000000000000000000000000000011000000000000000000000144100cccccccccccccccccccccccc0000555555555555555500005cc5454445444000
0000000000000000000000000005550000133100007000000000000000144100cccccccccccccccccccccccc000566666666666666665000cccc444444444400
0000000000b0000000000000005666500133b3100797000000000000015ff510cccccccccccccccccccccccc0056dddddddddddddddd65005cc5044544445440
00000000b00b00b00006660001d666100133b310007b0b000055500005ffff50cccccccccccccccccccccccc056dccccccccccccccccd650d44d004444444440
000000000b0b0b000066666001d66610018bb3100000b00005fff500014ff410cccccccccccccccccccccccc56dccccccccccccccccccd65d44d000444454440
000000000b000b000666666015dd66d11388bb310000bb700124410000144100cccccccddddddddddccccccc56dccccccccccccccccccd650440000004444444
000000000000000006666650155dddd1133bb48100bbb7970122440000144100ccccccd6666666666dcccccc56dccccccccccccccccccd650000000004444444
000000000000000005555500155555511333b841000000700000000000144100cccccd655555555556dccccc56dccccccccccccccccccd650000000000444454
000000000099990000000000000000001333b331000000000005500000144100cccccd650000000056dccccc56dccccccccccccccccccd650000000000445444
0000000000f9999000999900000000001384b33100c00000005ff50000144100cccccd650000000056dccccc56dccccccccccccccccccd650000000004444444
0000000000cf999000f99990000000000148b3310cac000015ffff50005ff500cccccd650000000056dccccc56dccccccccccccccccccd650009000444444444
0004400000ff999000cf9990000000001333b33100cb0b00444ff41005ffff50cccccd650000000056dccccc56dccccccccccccccccccd65009a944445444540
004114000062990000ff999000000000133113100000b00044444410015ff510cccccd650000000056dccccc56dccccccccccccccccccd650009445444444440
041a1140002691000062990000000000131441310000bbc01114410001455410cccccd650000000056dccccc56dccccccccccccccccccd6500044444444444a0
411111140001f10000269100000000001314413100bbbcac0014410000144100cccccd650000000056dccccc56dccccccccccccccccccd650004454444444a9a
11a11a11000ddd00000dfd000000000001144110000000c00014410000144100cccccd650000000056dccccc56dccccccccccccccccccd6500444444454440a0
1111111100000000000000000000000000000000000000000005500000055000cccccd655555555556dccccc56dccccccccccccccccccd650044544400000000
a114411a0000000000000000000000000000000000000000005ff500005ff500ccccccd6666666666dcccccc56dccccccccccccccccccd650444444400000000
11444411000000000000000000000000000000000000000005ffff5115ffff51cccccccddddddddddccccccc56dccccccccccccccccccd654444444400000000
144444410000000000000000000000000000000000000000014ff444444ff444cccccccccccccccccccccccc56dccccccccccccccccccd654544454000000000
4441144400000000000000000000000000000000000000000144444444444444cccccccccccccccccccccccc056dccccccccccccccccd6504444444000000000
0411114000000000000000000000000000000000000000000014411111144111cccccccccccccccccccccccc0056dddddddddddddddd65004444444000000000
0411114000000000000000000000000000000000000000000014410000144100cccccccccccccccccccccccc0005666666666666666650004444440000000000
0444444000000000000000000000000000000000000000000014410000144100cccccccccccccccccccccccc0000555555555555555500004544400000000000
00000000000440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000044444994444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00004449494994949444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004494a494a94949494400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0049494949499494a494940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04494949494994949494944000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494a494949a4a49494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4949494a494994949494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494a49494949949494a4949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494949494994949494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494949494994949494a4a400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4a494949494aa4949494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494949494a4114a49494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494a4949411111149494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4949494a11155111a494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494941155665511494949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494a115666666551a4949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49494115666666666514949400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
494a1156666666666651a49400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49411566666666666665149400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4a11566666666555666651a400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
41156644466664444446651400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11566414146665555555665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15664114114666666666665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15664114114666111166665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15664444444666111166665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15664114114661111115665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15664114114651911116665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15666444446661111116665100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01666666666661111116661000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00166666666664444446610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000a2c2c283939393939393d10000000000000000000000000000000000000000000000000000000000000000000000000000
00055500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
005666500000000000000000000000a2c2c2c2c2c2c2c2c2c2d20000000000000000000000000000000000000000000000000000000000000000000000000000
01d66610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01d666100000000000000000000000b3c3c3c3c3c3c3c3c3c3d30000000000000000000000000000000000000000000000000000000000000000000000000000
15dd66d1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
155dddd1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15555551000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000055500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000566650000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000001d66610000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000001d66610000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000015dd66d1000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000155dddd1000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000015555551000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0200000000000000000000000000000400020101010200010101010101010000000000000102010100000101010100000000000002000101010101010101000001010100000000000000000000000000010101000000000000000000000000000101010000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1700150014000014000000140014001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2700000024121424141211241424001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3711000000002400240000002400001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1700001500000000000000001200001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2700000000001100150000000000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3711001200250000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1b1c1c1c1c1c1c1d000000000013001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2b2c2c2c2c2c2c2d000000150000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2b2c2c2c2c2c2c2d110000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b19191a2c2c2c2d000000000011001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1100152b2c2c2c2d000013000000251000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000002b2c2c2c2d250000000015001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1200112b2c2c2c2d000000000000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1100003b3c3c1a2d001500000013131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1500001100153b3d000000001100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1500002500000000000000000000000000000000000000004041420000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000011000034110000140000005051520014001400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3737373700000013000025000000000000000014241400206061620024142400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1400142700000015000000000000000000000024002400307071720000240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
240024370011000000000000130000000000110000000000111e1f1100000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00140017000000000000000000000025000000000000110015002f0000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00240027000000001100000011000000001500110000003400001f2500120015000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1500143700000000000000001b1c1c1c1c1c1c1c1d000000162e2f0000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1400241700000000000015002b2c2c2c2c2c18193d0000002e2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2400002700000013000000002b2c2c2c2c2c28110000002e2f00340011000016000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000143700000000110000003b19191a2c2c280025002e2f0000000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1300241700110000000000000025002a2c2c2836372e3e1f3726110015000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000002700000000000000000000002a2c2c28170f0f0f0f0f17000000340000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1500122700000000000000000000002a2c2c28170f0f0f0f0f17150012000015000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3737373700150000001100120011002a2c2c28270f0f0f0f0f27110000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000002a2c2c28170f0f0f0f0f17000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
01020000000000b0500f050170501c0502005023050240502705028050290502a0502a0502a05029050280502705026050260502405022050200501c0501c0500000000000000000000000000000000000000000
011100000013500000001200414004130000000415005140051350000005110041400413507000041200214002135070000211000140001350010000120071400713500100091150714505145041450214500000
011100000c0433c2153c6150c0430c043006003c6150c0430c0433c2153c6150c0430c043000003c6150c0430c0433c2153c6150c0430c043000003c6150c0430c0433c2153c6150c0430c043000003c6153c615
011100002804527045280452b0452404523045240452b0452d0452c0452d045300452b0452a0452b04528045290452804529045260452804528045270452804524045260452404523045210451f045210451f045
0111000000120041400413500000041200514005135001000512004140041350000004120021400213500000021100014000135000000012007145091450b1450714500145001450000000000000000000000000
__music__
00 01020344
00 01040240
00 02010344
00 41404244
04 40414244
00 40414244
00 42414244

