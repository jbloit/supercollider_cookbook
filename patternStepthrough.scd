// this is not working yet.
// ask supercollider forum

t = Pbind( \freq, Pseq([440,880], inf) ).asStream;
t.next(Event.default);
t.next(Event.default);
t.next(Event.default);


(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.1), doneAction:2);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)

Synth(\help_sinegrain)

t = Pbind(
	\instrument, \help_sinegrain, \freq, Pseq([440,880], inf)
).asStream;


t.next(Event.default);
t.next(Event.default);
t.next(Event.default);
t.play;
t.next()
