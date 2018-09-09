// From Eli Fieldsteel tutorial 20
// https://www.youtube.com/watch?v=3vu4UbS2NMw

ServerOptions.devices;

(
s.options.inDevice = "Fireface UC Mac (23669936)";
s.options.outDevice = "Fireface UC Mac (23669936)";
s.reboot;
)


(
SynthDef.new(\mic, {
	|in=0, out=0, deltime=0.3, mix=(-0.5), decay=3, amp=1|
	var sig, delay;
	sig = SoundIn.ar(in!2)*amp;
	delay = CombL.ar(sig, 0.5, deltime, decay);
	sig = XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);
}).add;

)
x = Synth(\mic);
x.free;