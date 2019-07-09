
// tweaked From Mark Polishook tutorial: 17_Delays_reverbs

(
{
	var s, z, y;
	// percussion
	s = Mix.ar(Ringz.ar(Impulse.ar(1), 3400, 0.3) );
	// reverb predelay time :
	z = DelayN.ar(s, 0.048);

	// 7 length modulated comb delays in parallel :
	y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05),  1) }));
	// two parallel chains of 4 allpass delays (8 total) :
	7.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
	// add original sound to reverb and play it :
	s+(0.2*y)
}.play
)


/// Similar but split in 2 synths

(
SynthDef(\beep, {|out=0, freq=3400|
	var sig;
	sig = EnvGen.ar(Env.perc(releaseTime:1), doneAction:2);
	sig = Ringz.ar(sig, freq, 1);
	Out.ar(out, sig);
}).add;
)


(
SynthDef(\reverb, {|in=0, out=0, dec=5|
	var s, z, y;
	s = In.ar(in, 1);
	// reverb predelay time :
	z = DelayN.ar(s, 0.048);
	// 7 length modulated comb delays in parallel :
	y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), dec) }));
	// two parallel chains of 4 allpass delays (8 total) :
	7.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand],1) });
	// add original sound to reverb and play it :
	s = s+(0.2*y);
	Out.ar(out, s);
}).add;
)

b = Bus.audio(s, 1);
r = Synth(\reverb, [\in, b, \out, 0, \dec, 5]);
Synth(\beep, [\out, b, \freq, 3400]);
Synth(\beep, [\out, b, \freq, 1000]);
Synth(\beep, [\out, b, \freq, 800]);

(
s.freeAll
)
