// Use a control bus to send a generated kr signal to a synth's param.

// from "11. Busses" tutorial

(
SynthDef(\fmSine, {
	|busFreq, freqOffset|
	Out.ar(0, SinOsc.ar(In.kr(busFreq) + freqOffset, 0, 0.3));
}).add;

SynthDef(\krFreq, {
	|freq = 400, busFreq|
	Out.kr(busFreq, SinOsc.kr(1, 0, freq / 40, freq));
}).add;

b = Bus.control(s, 1);
)

(
x = Synth(\krFreq, [\busFreq, b]);
y = Synth.after(x, \fmSine, [\busFreq, b]);
z = Synth.after(x, \fmSine, [\busFreq, b, \freqOffset, 300]);
)