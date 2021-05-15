// play tweets by redfrik

// test
// a=Synth(\t3)
// a.free

~voices = Dictionary.new;

~master = Bus.audio(s, 2);
SynthDef(\masterGain,
	{ |amp=0.2|
		var sig;
		sig = In.ar(~master, 2);
		Out.ar(0, sig*amp);
	}
).add;


SynthDef(\t1, {
	|amp=0.1, pan=0, out=0, gate=1|
	var sig, a, env;
	a=LFTri;
	sig=LFPulse.ar(a.ar(Duty.ar(1/8,0,Dswitch([Dseq((1..8),4),Dseq([60,1,2],[4,3])]/2,Dseq([0,1],99))*99),0,3e3,300));
	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t2, {
	|amp=0.1, pan=0, out=0, gate=1|
	var sig, env;

	//--tweet0000 (LOUD!)
	sig = {GlitchRHPF.ar(GbmanN.ar([2300,1150]),LFSaw.ar(Pulse.ar(4,[1,2]/8,1,LFPulse.ar(1/8)/5+1))+2)};

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t3, {
	|amp=0.1, pan=0, out=0, gate=1|
	var sig, env;

//--tweet0008
	sig = {x=LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(200,2e3,x).lag(2),x.range(5e-4,1e-3),0.0012)};

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
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

	if(vel>0 , {
		if(~voices[note]!=nil,{~voices[note].set(\gate,0);});

		switch(note,
			60, {
				~voices[note] = Synth.new(\t1, [\out, ~master]);
				~led.value(1);
			},
			61, {
				~voices[note] = Synth.new(\t2, [\out, ~master]);
				~led.value(1);
			},
			62, {
				~voices[note] = Synth.new(\t3, [\out, ~master]);
				~led.value(1);
			},
		);

	} , {
		if(~voices[note]!=nil,{~voices[note].set(\gate,0);});
		~voices[note] = nil;
		~led.value(0);
	};)
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



