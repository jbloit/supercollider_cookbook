// ----------------------------------------
// Enveloppe by Low pass filter of impulse
// ----------------------------------------
(
var decayTime = 0.1;
a = {Impulse.kr(1).lag(decayTime)*SinOsc.ar(440)!2};
a.play;
s.scope
)

