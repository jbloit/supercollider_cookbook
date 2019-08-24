// from https://www.youtube.com/watch?v=7nrUBbmY1hE

ServerOptions.devices;
s.options.outDevice = "Built-in Output";
s.options.outDevice = "USB PnP Sound Device";




(
~wt = Array.fill(4, {
	var numSegs = rrand(4, 20);
	Env(
		[0] ++
		(({rrand(0.0, 1.0)}!(numSegs-1)) * [1, -1]).scramble
		++ [0],
		{exprand(1,20)}!numSegs,
		{rrand(-20, 20)}!numSegs
	).asSignal(1024).asWavetable;
});
)

~buf = Buffer.allocConsecutive(4, s, 2048);
(
~buf.do({|buf, i|
	buf.loadCollection(~wt[i]);
});
)

~wt.do({|n, i|
	n.plot(~buf[i].bufnum.asString)
});



(
SynthDef(\vosc, {|out=0, buf=0, numBufs=2, freq=300, amp=0.2|
	var sig, bufpos, detuneSig;
	detuneSig = LFNoise1.kr(0.2!8).bipolar(0.2).midiratio;
	bufpos = buf + MouseX.kr(0, numBufs-1);
	sig = VOsc.ar(bufpos, freq*detuneSig);
	sig = Splay.ar(sig);
	sig = LeakDC.ar(sig) * amp;
	Out.ar(out, sig);
}).add;
)

Synth(\vosc, [\freq, 30.midicps, \buf, ~buf[0].bufnum, \numBufs, 4]);