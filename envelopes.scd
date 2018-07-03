// ----------------------------------------
// Enveloppe by Low pass filter of impulse
// ----------------------------------------
(
var decayTime = 0.1;
a = {Impulse.kr(1).lag(decayTime)*SinOsc.ar(440)!2};
a.play;
s.scope
)



// perc envelope
(
var env;
env = Env.perc();
a = {SinOsc.ar(mul:EnvGen.kr(env, doneAction:2))!2};
a.play;
)
