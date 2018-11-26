// Most basic synth

(
SynthDef(\perc,
	{
		|amp=0.1, pan=0|
		var sig;
		sig = SinOsc.ar(mul: EnvGen.ar(Env.perc(0.001), doneAction:2));
		Out.ar(0, Pan2.ar(sig*amp, pan));
}).add;
)

Synth(\perc)