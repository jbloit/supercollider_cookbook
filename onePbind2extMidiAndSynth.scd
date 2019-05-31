// from James Harkins" answer to my question on scsynth.org
// https://scsynth.org/t/control-hardware-and-server-synth-with-one-pbind/950/5

s.latency = 0.1;
s.reboot;

(
Event.addEventType(\midisynth, { |server|
	Event.eventTypes[\note].value(server);
	Event.eventTypes[\midi].value(server);
});
)

m.allNotesOff(0);

MIDIClient.init;
m = MIDIOut(1).latency_(0.1); // pick the same latency as server

(
SynthDef(\tone,
	{
		|amp=0.1, pan=0, gate=1, freq = 440|
		var sig;
		sig = SinOsc.ar(freq, mul: EnvGen.ar(Env.adsr(), doneAction:2, gate:gate));
		Out.ar(0, Pan2.ar(sig*amp, pan));
}).add;
)

(
p =	Pbind(
	\type, \midisynth,

	// synth
	\instrument, \tone,
	\dur, Pseq([3/4, 6/4, 3/4, 3/4, 9/4]/2, inf),
	\pan, 1,
	\timbre, 0,
	\bufnum, 0,
	\amp, 0.5,
	\out, 0,

	// midi
	\midicmd, \noteOn,
	\midiout, m,
	\chan, 0,
	\note, Pwhite(0, 3),
	\legato, 0.1,
);

p.play;
)