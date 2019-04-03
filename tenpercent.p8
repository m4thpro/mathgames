pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- 10% game
-- bart snapp

-- identify a solution 
-- that is correct for a 
-- problem within 10%

-- multiple answers by either 1.05 or .95 (correct)
-- then by 1.15 or .85
-- then by 1.25 or .75
-- take integers as needed.


-- 6th grade math
-- 7th grade math
-- 8th grade math
-- algebra
-- geometry
-- 3d geometry
-- calculus


function _init()
   choices={}
   permutations={
      {1,2,3},
      {1,3,2},
      {2,1,3},
      {2,3,1},
      {3,1,2},
      {3,2,1}
   }
   choice_order=ceil(rnd(6))
   x = flr(rnd(90))+10
   y = flr(rnd(90))+10
   z = x*y
   choice_builder(choices,z) -- builds first answer list
   pos=0;
end
-->8
-- draw

-- two digit multiplication
function question()--x,y)
	print(x,40,63)
	print("x",50,63)
	print(y,56,63)
	print("=",65,63)
end

function choice_builder()--choices,z)
   if flr(rnd(2))==1 then 
      choices[1]=ceil(.95*z)
   else
      choices[1]=flr(1.05*z)
   end
   if flr(rnd(2))==1 then 
      choices[2]=ceil(.85*z)
   else
      choices[2]=flr(1.15*z)
   end
   if flr(rnd(2))==1 then 
      choices[3]=ceil(.75*z)
   else
      choices[3]=flr(1.25*z)
   end
end

--choice_order=ceil(rnd(6))

function answers(p)--permutations,choices,choice_order)
   print(choices[permutations[choice_order][1]],10,100,7)
   print(choices[permutations[choice_order][2]],10,110,7)
   print(choices[permutations[choice_order][3]],10,120,7)
   rectfill(0,99+10*p,127,105+10*p,5)
   print(choices[permutations[choice_order][1+p]],10,100+10*p,0)
end

function _draw()
   cls()
   print("every answer below is wrong",10,10,7)
   print("which answer is closest?",10,20,7)
   question()--x,y)
   answers(pos)--permutations,choices,choice_order)
end




-->8
-- update

-- two digit multiplication

function _update()
   if btnp(1) or btnp(3) then
      pos+=1
   end
   if btnp(0) or btnp(2) then
      pos-=1
   end
   pos%=3
   if btnp(4) or btnp(5) then
      if 1==permutations[choice_order][pos+1] then
	 sfx(0)
      x = flr(rnd(90))+10
      y = flr(rnd(90))+10
      z = x*y
      choice_order=ceil(rnd(6))
      choice_builder(choices,z)
   	end
   end
end
__sfx__
00010000350502c050250501e05016050100500b050080500505004050030500205001050010500105001050010500105001050010500205006050080500b0500e05012050160501b0502005023050320503b050
