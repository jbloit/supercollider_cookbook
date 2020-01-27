// Trigger a callback when synth is freed

(
SynthDef(\a, {|out=0, amp=0.1|
	var env = EnvGen.kr(Env.perc(),levelScale:amp, doneAction:2);
	Out.ar(out, SinOsc.ar(220!2, mul:env));
}
).add;
)


(
var detector = Synth(\a);
// Watch the node, and stop recording when it frees itself.
NodeWatcher.register(detector);
detector.onFree({
	"a is done".postln;
});
)