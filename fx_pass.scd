// Pass in audio, for testing

ServerOptions.devices;

(
s.options.inDevice = "Fireface UC Mac (23669936)";
s.options.outDevice = "Fireface UC Mac (23669936)";
s.reboot;
)


(
SynthDef.new(\mic, {
	|in=0, out=0, amp=1|
	var sig;
	sig = SoundIn.ar(in!2)*amp;
	Out.ar(out, sig);
}).add;

)
x = Synth(\mic);
x.free;