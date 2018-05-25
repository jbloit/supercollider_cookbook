// see "https://www.youtube.com/watch?v=VGs_lMw2hQg&index=14&list=RD_NpivsEva5o"

n = s.options.numOutputBusChannels + s.options.numInputBusChannels

~reverbBus = Bus.audio(s, 1);

(
SynthDef(
	\tri, { |out=0, amp=1|
    var sig;
		sig = LFPulse.kr(XLine.kr(1, 200, 10), 0, 0.2) * SinOsc.ar(440) * 0.1;
		Out.ar(out, sig*amp);
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
// the reverse order produces silence
y = Synth.new(\reverb, [\in, ~reverbBus]);
x = Synth.new(\tri, [\out, ~reverbBus]); // placed on head!


/// ------------------------ WITH GROUPS:

~srcGroup = Group.new;
~fxGroup = Group.after(~srcGroup); // makes sure it's placed on tail

// now the order of there doesn't matter anymore
x = Synth.new(\tri, [\out, ~reverbBus], ~srcGroup);
y = Synth.new(\reverb, [\in, ~reverbBus], ~fxGroup);

// set messages are conveyed to all synths in the group
~srcGroup. set(\amp, 0.2)


