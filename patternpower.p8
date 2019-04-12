pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- pattern power
-- by bart snapp

-- complete patterns

cartdata("pattern_power_1")

function _init()
   pause=0
   state="two_d_pattern"
   spr1=flr(rnd(3))*2
   spr2=flr(rnd(3))*2
   spr3=flr(rnd(3))*2
   missing=flr(rnd(8)) -- missing location
   mspr=32 -- missing sprite
end

-- a and b btn
abin={{0,1,1,1,1,1,0},
 	{1,1,1,0,1,1,1},
 	{1,1,0,0,0,1,1},
 	{1,1,0,1,0,1,1},
 	{0,1,1,1,1,1,0}}

bbin={{0,1,1,1,1,1,0},
 	{1,1,0,0,1,1,1},
 	{1,1,0,1,0,1,1},
 	{1,1,0,0,0,1,1},
 	{0,1,1,1,1,1,0}}
 	
function abtn(x,y,c)
   for i=1,5 do
      for j=1,7 do
	 if abin[i][j] == 0 then else
	    pset(j+x-1,i+y-1,c*abin[i][j])
	 end
      end
   end	
end

function bbtn(x,y,c)
   for i=1,5 do
      for j=1,7 do
	 if bbin[i][j] == 0 then else
	    pset(j+x-1,i+y-1,c*bbin[i][j])
	 end
      end	
   end
end
-->8
-- main update and draw

function _update()
   if state=="two_d_pattern"
   then update_two_d_pattern()
   elseif state=="success"
   then update_success()
   elseif state=="fail"
   then update_fail()
   end
end

function _draw()
   if state=="two_d_pattern"
   then draw_two_d_pattern()
   elseif state=="success"
   then draw_success()
   elseif state=="fail"
   then draw_fail()
   end
end
-->8
-- update

function update_two_d_pattern()
	if btnp(0) or
		btnp(1) or
		btnp(2) or
		btnp(3)
	then -- cycles through sprites
		mspr=(mspr+2)%6 -- mod total numebr of sprites
	end
	if (btnp(4) or btnp(5)) and mspr !=32 then
	   function validate(m,s) -- checks when btn 4 is pressed
	      if (m*16)%48==0 then -- identifies what correct sprite is
		 if spr1==s then state="success" sfx(1) else state="fail" end -- checks aginst correct sprite
	      elseif (m*16)%48==16 then
		 if spr2==s then state="success" sfx(1) else state="fail" end
	      elseif (m*16)%48==32 then
		 if spr3==s then state="success" sfx(1) else state="fail" end
	      end
	   end
	else
	   function validate(m,s) end
	end
end

function update_success()
   function validate(m,s) end
end

function update_fail()
   function validate(m,s) end
end
-->8
-- draw



function two_d_pattern(s1,s2,s3,m,s)
   for i=0,2 do
      spr(s1,0+48*i,56,2,2)
      spr(s2,16+48*i,56,2,2)
      spr(s3,32+48*i,56,2,2)
   end
   rectfill(128,56,144,71,0) -- removes hidden sprite
   rectfill(16*m,
	    56,
	    16*m+15,
	    71,0) 
   spr(s,16*m,56,2,2)
end


function draw_two_d_pattern()
   cls()
   camera(0,0)
   two_d_pattern(spr1,spr2,spr3,missing,mspr)
   validate(missing,mspr)
   
   print("⬆️⬇️⬅️➡️ cycles patterns", 10,110,7)
   abtn(10,120,7)
   bbtn(18,120,7)
   print("checks your answer", 30,120,7)
end


function draw_success()
   cls()
   pause+=1
   print("nice work!",10,63,7)
   if pause == 25 then
      pause = 0
      state="two_d_pattern"
      spr1=flr(rnd(3))*2
      spr2=flr(rnd(3))*2
      spr3=flr(rnd(3))*2
      missing=flr(rnd(8)) -- missing location
      mspr=32 -- missing spriteend
   end   
 --  abtn(10,120,7)
  -- bbtn(18,120,7)
   --print("for next pattern", 30,120,7)
end

function draw_fail()
   pause+=1
   camera(3-rnd(3),0)
   cls()
   two_d_pattern(spr1,spr2,spr3,missing,mspr)
   if pause == 25 then
      pause = 0
      state="two_d_pattern"
      spr1=flr(rnd(3))*2
      spr2=flr(rnd(3))*2
      spr3=flr(rnd(3))*2
      missing=flr(rnd(8)) -- missing location
      mspr=32 -- missing spriteend
   end
end

__gfx__
77777777777777770000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
78888888888888870000004aa4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
78999999999999870000009aa90000000000eeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000
789bbbbbbbbbb9870000009aa9000000000ee888888ee00000000000000000000000000000000000000000000000000000000000000000000000000000000000
789b11111111b987000009aaaa90000000ee88888888ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1cccccc1b98749999aaaaaa999940ee8899999988ee000000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1caaaac1b98704aaaaaaaaaaaa40ee8899aaaa9988ee00000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1ca33ac1b9870049aaaaaaaa9400e8899aabbaa9988e00000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1ca33ac1b98700049aaaaaa940008899aabbbbaa998800000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1caaaac1b98700004aaaaaa40000899aabbccbbaa99800000000000000000000000000000000000000000000000000000000000000000000000000000000
789b1cccccc1b98700049aaaaaa9400099aabbccccbbaa9900000000000000000000000000000000000000000000000000000000000000000000000000000000
789b11111111b98700049aaaaaa94000aaabbcc11ccbbaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000
789bbbbbbbbbb9870049aaa99aaa9400bbbbcc1111ccbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
78999999999999870049aa9009aa9400ccccc112211ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
7888888888888887049a94000049a940111111222211111100000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777774994000000004994222222222222222200000000000000000000000000000000000000000000000000000000000000000000000000000000
00005666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00057777776000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00067655557600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00067600057600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00056500007600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000057765000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000067600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000067600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000056500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000056500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000067600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000056500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000b1500b1500b1500c1500d1500f15011150131501515016150191501b1501e1502115023150271502c1502f150351503715038150391503815038150391502a150191500000000000000000000000000
0003000012050120501205015e5012050130501405015050180501b0501d0502bf500b0500e05020f50140501a0501d0502405033f5015050170501b0501e05024050270502f0503605039050000000000000000
