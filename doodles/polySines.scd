// polysines

(
SynthDef(\test, {|freq=300, amp=0.2, pan, gate=1, rel=0.2|
	var sig = SinOsc.ar(freq:freq, mul:amp);
	sig = sig * EnvGen.ar(Env.perc(releaseTime:rel), gate:gate, doneAction:2);
	Out.ar(0, Pan2.ar(sig, pos:pan));
};).add;
)

(
Pdef(\myPattern,
	Pbind(\instrument, \test, \octave, 4, \degree, Prand([0,4,7], inf), \dur, Prand([1/4, 1/8, 1/8], inf), \pan, Pwhite(-1, 1, inf), \amp, 0.1)
).play
)

(
Pdef(\myPattern2,
	Pbind(\instrument, \test, \octave, 5, \degree, Prand([4,8], inf), \dur, Prand([1/4, 1/8, 1/8], inf), \pan, Pwhite(-1, 1, inf), \amp, 0.1)
).play
)

(
Pdef(\myPattern3,
	Pbind(\instrument, \test, \octave, 6, \degree, Pseq([4,5,7], inf), \dur, Pseq([3/8, 1/8, 1/8, 1/8], inf), \pan, Pwhite(-1, 1, inf), \amp, 0.1)
).play(quant:1);
)

Pdef(\myPattern).stop;
Pdef(\myPattern).play;

Pdef(\myPattern2).stop;
Pdef(\myPattern2).play;

Pdef(\myPattern3).stop;
Pdef(\myPattern3).play;
