//////////////////////////////////////////// AUDIO

// a trigger signal
(
SynthDef(\trig, {|out = 0|
	Out.ar(out, Impulse.ar(0.5));
}).add;
)

// a synth with a gated envelope. gate is received from input bus
(
SynthDef(\tosc, {|out=0, in=0|
	var sig, env, gate;
	gate = In.ar(in, 1);
	env = EnvGen.ar(Env.perc(), gate);
	sig = SinOsc.ar(mul:env);
	Out.ar(out,  Pan2.ar(sig, 0));
}).add;
)

(
Bus.clear;
b = Bus.audio(s, 1);
b.index
)

(
// order of execution is important here, new synths are added on top
c = Synth(\tosc, [\in, b.index]);
d = Synth(\trig, [\out, b.index]);
)

// more control over the order of execution:
(
e = Synth(\trig, [\out, b.index]);
f = Synth.after(e, \tosc, [\in, b.index]);
)
(
c.free;
d.free;
e.free;
f.free;
)

//////////////////////////////////////////// CONTROL 