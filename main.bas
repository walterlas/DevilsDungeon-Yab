#!yab
import tools

dim r(16),l(65),f(16),x(19),b(16)
l=1:g=0:e=0:x=16
d=1:ys=101:yd=101

sub setRooms()	// 5-140
	for i = 0 to 65:l(i)=0:next i
	for i = 1 to x
		n = int(3*rnd()+1)
		if i = 1 then 
			n = 3
		endif
		for j=1 to n
			r = int(64*rnd()+1)
			if l(r)<>0 then 
				continue
			endif
			l(r)=i
		next j
		r(i)=int(524287*rnd())
		b(i)=0
	next i
	b(l)=1
	r(1)=24576
	for i = 1 to 19
		x(i)=0
	next i
end sub

sub hazards()	// 145-180
	if rnd()<.01 then
		print "Tremor"
		for i = 1 to 20
			l(i)=int(x*rnd()+1)
		next i
	endif
	if rnd()<.01 then
		print "Tremor"
		for i=1 to 20
			l(i)=0
		next i
	endif
	if x(1)*x(12)=1 and rnd()<.4 then
		print "Cursed by demon!"
		yd=int(.5*yd)
	endif
	if x(9)*x(11)=1 and rnd()<.4 then
		print "Gassed!"
		ys=int(.5*ys)
	endif
end sub

sub decrementTest()	// 185-210
	yd=yd-d
	ys=ys-d
	if ys<=0 or yd<=0 then
		print "You're dead"
		end
	endif
end sub

sub outputStatus()	// 215-240
	print "Gold: "+str$(g)+"    ";
	print "Exp: "+str$(e)+" Depth: "+str$(d)
	print "Speed:    "+str$(yd)+" Strength:    "+str$(ys)
	adjacentRooms()
end sub

sub adjacentRooms() // 245-300
	local i

	for i = 1 to x
		f(i)=0
	next i

	for i = 1 to 64
		if l<>l(i) then
			continue
		endif
		if l(i+1)<>0 and l(I+1)<>l then
			f(l(i+1))=1
		endif
		if l(i-1)<>0 and l(i-1)<>l then
			f(l(i-1))=1
		endif
	next i
end sub

sub convert()	// 305-320
	local i
	
	n=r(l)
	for i = 1 to 19
		q=int(n/2)
		x(i)=2*(n/2-q)
		n=q
	next i
end sub

sub monstersDemonsGas()	// 325-390
	if x(2)=0 then
		ms = 0 
		goto demongas
	endif
	if f=1 then
		goto monster
	endif
	ms=d*(x(3)+2*x(4)+4*x(5)+l)
	md=d*(x(6)+2*x(7)+4*x(8)+l)
	label monster
	print "Monster's Speed: "+str$(md)+" Strength: "+str$(ms)
	label demongas
	if x(1)*x(12)=1 then
		print "Demons"
	endif
	if x(9)*x(11)=1 then
		print "Poisonous gas"
	endif
end sub

sub treasure()	// 395-420
	if x(10)<>1 then
		t = 0
		return
	endif
	t=x(11)+2*x(12)+4*x(13)+1
	print "Maximum Gold: "+str$(t*l*d+1)
end sub

sub slidesDropoffs()	// 425-480
	s=x(15)+2*x(16)+4*x(17)+8*x(18)+1
	if s>x then
		s=1
	elsif s=0 then
		s=1
	endif
	if x(14)=0 or s=l then
		goto dropoff
	endif
	print "Slide To: "+str$(s)
	label dropoff
	if x(19)*x(13)=1 then
		print "Dropoff"
	endif
end sub

sub inputMove()
	local i,m
	
	print "Move from "+str$(l)+" to ";
	for i=1 to x
		if f(i)=1 and i<>l then
			print i;
		endif
	next i
	input m
	return m
end sub

// Main
setRooms()
hazards()
decrementTest()
outputStatus()
convert()
monstersDemonsGas()
treasure()
slidesDropoffs()
m = inputMove()

switch m
	case 88:printRooms():break
end switch
