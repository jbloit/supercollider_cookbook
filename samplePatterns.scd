// pattern with one shot samples

Buffer.freeAll;

// ~samplesDir = thisProcess.nowExecutingPath.dirname +/+ "../soundfiles";
~samplesDir = "/home/jbloit/sounds/DataBending";
~tac = Buffer.read(s, ~samplesDir +/+ "blipGlitch_comic_book.wav");
// See num frames:
~tac.numFrames;

// see num channels
~tac.numChannels;

// see sample rate:
~tac.sampleRate;

// see a summary:
~tac.query;

// y = Synth(\sampler, [\bufNum, ~tac.bufnum]);

(
SynthDef(\sampler, {
	|out=0, bufNum=0, amp=0.3, rate=1|
	var sig;
	sig = PlayBuf.ar(2, bufNum, rate, doneAction:2);
	Out.ar(out, sig*amp);
}).add;
)

TempoClock.tempo = 1;

// ternaire
(
Pbind(\instrument, \sampler,
	\dur, 1/3,
	\amp, Pexprand(0.01, 0.7),
	\rate, Pexprand(0.4, 2),
).play;
)

// binaire
(
Pbind(\instrument, \sampler,
	\dur, 1/2,
	\amp, Pexprand(0.01, 1),
	\rate, Pexprand(1, 2),
).play;
)

// dict with samples from dir?




// frees the buffer.
~tac.free;