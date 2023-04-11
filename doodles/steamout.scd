Ndef(\a).play;
Ndef(\a).stop;
Ndef(\a).fadeTime = 1;

(
Ndef(\a, { |freq=600, modF=20, distoAmp=0.3|
	var a,b,c;
	a = SinOsc.ar((1,4..20)/100*freq, 0, SinOsc.kr(modF).max(0) * 0.2);
	// a = SinOsc.ar((1,3..39)*freq, 0, SinOsc.kr(modF).max(0) * 0.2);

	b = CrossoverDistortion.ar(a, distoAmp, 0.4, 1, 0)!2;
	// c = Compander.ar(b,b,0.4,1,0.55,0.8,0.1)!2;
}
);
)

Ndef(\a).set(\freq, 200)
Ndef(\a).set(\modF, 44)
Ndef(\a).set(\distoAmp, 0.22)
