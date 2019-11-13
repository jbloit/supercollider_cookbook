// Loop an audio buffer and write the playback phase to a control bus.
(
b = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav");
~phase = Bus.control(s, 1);

SynthDef(\loop, {|buf, out = 0|
	var sig, phase;
	phase = Phasor.ar(0, BufRateScale.kr(b), 0, BufFrames.kr(b));
	sig = BufRd.ar(1, b, phase);
	Out.ar(out, sig);

	// the playback phase scaled to 0-1
	Out.kr(~phase.index, phase / BufFrames.kr(b));
}).add;

~loop = Synth(\loop, [\buf, b]);
)

// query the phase
(
~phase.get({|val|
	val.postln;
});
)

// stop this
~loop.free;