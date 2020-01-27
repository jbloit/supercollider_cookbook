// Record multiple synths at the same time. Useful for multitrack recording.

(
SynthDef(\a, {|out=0|
	Out.ar(out, SinOsc.ar(330, 0, 0.2));
}).add;

SynthDef(\b, {|out=1|
	Out.ar(out, LFPar.ar(440, 0, 0.2));
}).add;

SynthDef(\c, {|out=2|
	Out.ar(out, LFTri.ar(550, 0, 0.2));
}).add;

)

(
a = Synth(\a);
b = Synth(\b);
c = Synth(\c);
)

// Explicitly set the path, or else all recordings get the same file name, since they are triggered at the same time.
(
~ar = Recorder(s);
~ar.prepareForRecord(path: "~/a.aiff", numChannels:1);

~br = Recorder(s);
~br.prepareForRecord(path: "~/b.aiff", numChannels:1);

~cr = Recorder(s);
~cr.prepareForRecord(path: "~/c.aiff", numChannels:1);

)


(
~ar.record(bus:0, duration:1);
~br.record(bus:1, duration:1);
~cr.record(bus:2, duration:1);
)