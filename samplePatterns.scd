// pattern with one shot samples

// ~samplesDir = thisProcess.nowExecutingPath.dirname +/+ "../soundfiles";
~samplesDir = "/home/jbloit/sounds/DataBending";
~tac = Buffer.read(s, ~samplesDir +/+ "blipGlitch_comic_book.wav");

(
SynthDef(\sampler, {
	|out=0, bufNum=0, amp=0.3, rate=1|
	var sig;
	sig = PlayBuf.ar(2, bufNum, rate, doneAction:2);
	Out.ar(out, sig);
}).add;
)

y = Synth(\sampler, [\bufNum, ~tac.bufnum]);


TempoClock.tempo = 1;


(
Pbind(\instrument, \sampler,
	\dur, 1/4,
	\rate, Pexprand(0.4, 2),
).play;
)