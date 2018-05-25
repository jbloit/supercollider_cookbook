// see "https://www.youtube.com/watch?v=VGs_lMw2hQg&index=14&list=RD_NpivsEva5o"

n = s.options.numOutputBusChannels + s.options.numInputBusChannels

~reverbBus = Bus.audio(s, 1);

(
SynthDef(
	\tri, { |out=0|
    var sig;
		sig = LFPulse.kr(XLine.kr(1, 200, 10), 0, 0.2) * SinOsc.ar(440) * 0.1;
		Out.ar(out, sig);
}).add;
)

(
SynthDef(\reverb, {
	|in=0, out = 0|
	var sig;
	sig = In.ar(in, 1);
	sig = FreeVerb.ar(sig)!2;
	Out.ar(out, sig);
}).add;
)

// order of execution is important here. Nodes are run from head to tail.
y = Synth.new(\reverb, [\in, ~reverbBus]);
x = Synth.new(\tri, [\out, ~reverbBus]); // placed on head!


