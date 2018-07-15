b = {a=Saw;Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+199, a.ar((1,3..13)*29)*199+299, a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3}//#SuperCollider
(
SynthDef(\roof , {
	|out=0, amp=0.5, root=99, root2=199|
	var sig;
	sig = {a=Saw;Splay.ar(Formant.ar(a.ar((5,7..15)*19)*root+root2, a.ar((1,3..13)*29)*199+299, a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3};
	Out.ar(0, sig*amp);
}).add;
)


a = Synth(\roof);
a.set(\amp, 0.1);
a.set(\root, 30);
a.set(\root2, 1200);
a.free;


(
SynthDef(\harshDrone, {

	|out=0, amp=0.1|
	var sig;
	sig = {a=SinOscFB;c=a.ar([50,99],0.4);RecordBuf.ar(InFeedback.ar(0,2)+c/3,b=LocalBuf(8e4,2).clear);BufRd.ar(2,b,a.ar(c)*6e4)};
	Out.ar(0, sig*amp);
}).add;
)

b = Synth(\harshDrone);
b.set(\amp, 0.1);
b.free