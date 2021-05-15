// play tweets by redfrik




~synth;

~master = Bus.audio(s, 2);
SynthDef(\masterGain,
	{ |amp=0.2|
		var sig;
		sig = In.ar(~master, 2);
		Out.ar(0, sig*amp);
	}
).add;


SynthDef(\t1, {
	|amp=0.1, pan=0, out=0|
	var sig, a;
	a=LFTri;
	sig=LFPulse.ar(a.ar(Duty.ar(1/8,0,Dswitch([Dseq((1..8),4),Dseq([60,1,2],[4,3])]/2,Dseq([0,1],99))*99),0,3e3,300));
	Out.ar(out, Pan2.ar(sig*amp, pan));
}
).add;

~masterGain = Synth(\masterGain);


~oled.screen(1, "Redfrik Tweets");

// create knob callback
~knobfunc = {
	arg func, msg, knob, value;
	~oled.screen(2, format("Knob % val:%", knob, value));
	if (knob==4, {~masterGain.set(\amp, value)});
};
// register knob callback
~knobs.addDependant(~knobfunc);


// create notes callback
// notes on the organelle go from 60 to 83.
// velocity is reported as a float and is either 0 (note off) or 0.7874 (note on) value.
// (100/127 = 0.7874...)

~notesfunc = {
	arg func, msg, note, vel;
	~oled.screen(3, format("Note % %", note, vel));

	if ( vel==0, {~synth.free},
		{
			~synth = Synth(\t1, [\out, ~master]);
		}
	);
};
// register key callback
~notes.addDependant(~notesfunc);

// create aux button callback
~auxfunc = {
	arg func, msg, note, vel;
	~oled.screen(4, format("Aux %", note));
};
// register aux callback
~aux.addDependant(~auxfunc);



