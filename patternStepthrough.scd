// Step through a pattern's events


(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.1), doneAction:2);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)

// test synth
Synth(\help_sinegrain);

// define pattern
(
t = Pbind(
	\instrument, \help_sinegrain, \freq, Pseq([440,880], inf), \sustain, 0.9;
).asStream;
)

// step through
t.next(Event.default).play;

// reset pattern
t.reset;

