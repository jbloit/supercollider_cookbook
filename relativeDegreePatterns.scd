// how to make a freq pattern (for instance [ 100, 50, 50, 120] ) relative to transpose*degreePattern*scale

(
~transpose=0;
Pdefn(\degree, Pseq([0,1,2], inf));
~scale = [0,4,11];
)

(Pdef(\pattern,
Pbind(\note, PdegreeToKey(
		Pdefn(\degree),
	            Pfunc({~scale}),
            12
        )+Pfunc({~transpose}),
    \dur, 0.25
)
).play;
)

Pdef(\pattern).stop;

(
~transpose=0;
Pdefn(\degree, Pseq([0,1,5], inf));
~scale = [0,4,7,12];
)

(
~transpose = 3;
Pdefn(\degree, Pseq([0,1,5], inf));
~scale = [0,4,7,12];
)

(
~transpose = 1;
Pdefn(\degree, Pseq([0,1,5], inf));
~scale = Scale.choose;
)


(
~transpose = 1;
Pdefn(\degree, Pseq([0,1,5], inf));
~scale = Scale.choose;
)


Pdef(\pattern).stop;