TempoClock.tempo = 1;
c1 = [0, 3, 7];
c2 = [0, 4, 7];

(
SynthDef(\tone, {
	|amp=0.1, freq=440, rel=1, pan=1|
	var sig, env;

	// mod = SinOsc.kr(10);
	// /	mod = 0;
	sig = SinOsc.ar(freq );
	env = Env.perc(releaseTime:rel);
	sig = EnvGen.ar(env, doneAction:2) * sig;
	Out.ar(0, Pan2.ar(sig*amp, pos: pan));
}).add;
)



(
Pbind(
	\instrument, \tone,
	\dur, 1,
	\midinote, 42
).play;
)

(
Pbind(
	\instrument, \tone,
	\dur, Prand([1/16, 1/8, 1/4], inf),
	\pan, Prand([-1, 1], inf),
	\midinote, 110 + Pkey(\pan),
	\amp, 0.05,
	\rel, 0.01,
).play;
)



(
SynthDef(\perc, {
	|out=0, amp=0.1, rel=0.5|
	var env, sig, sig2;
	env = Env.perc(releaseTime:rel);
	sig = BrownNoise.ar(0.1) * EnvGen.kr(env, doneAction:2);
	sig = GVerb.ar(sig);
	Out.ar(0, sig!2 * amp);
}
).add;

)


(
Pbind(
	\instrument, \perc,
	\dur, Prand([1/4, 1/8, 1/8, 1/16 ], inf),
	\rel, Pkey(\dur),
).play;
)
