// play tweets by redfrik

/*// test
a=Synth(\t1)
a.set(\p0, 0.3)
a.set(\p1, 0.1)
a.set(\p2, 0.2)
a.set(\p3, 0.9)
a.set(\p0, 1,\p1,1,\p2,1,\p3,1)
a.free*/

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
	|amp=0.1, pan=0, out=0, gate=1, p0=1, p1=1, p2=1, p3=1|
	var sig, a, env;
	a=LFTri;
	sig=LFPulse.ar(a.ar(Duty.ar(1/(p0*7+1),0,Dswitch([Dseq((1..8),4),Dseq([60,1,2],[4,3])]/2,Dseq([0,1],(p1*99)))*(p2*99)),0,3e3,(p3*300)));
	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t2, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

	//--tweet0000 (LOUD!)
	sig = {GlitchRHPF.ar(GbmanN.ar([p0*2300,1150]),LFSaw.ar(Pulse.ar(p1*3+1,[1,2]/8,1,LFPulse.ar(1/(1+p2*7))/5+1))+(p3+1))};

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t3, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0008
	sig = {x=LFNoise1.ar((p2*0.5)!2);Formlet.ar(Crackle.ar(x.range(p0*0.8 +1,1.98)),TExpRand.ar(p1*200,2e3,x).lag(2),x.range(5e-4,1e-3),p3* 0.0012)};

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t4, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0008
	sig = {x=LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(200,2e3,x).lag(2),x.range(5e-4,1e-3),0.0012)};

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;


~masterGain = Synth(\masterGain);


~oled.screen(1, "Redfrik Tweets");
~currentPressedNote = -1;
~isAuxOn = false;

// create knob callback
~knobfunc = {
	arg func, msg, knob, value;
	~oled.screen(2, format("Knob % val:%", knob, value));

	// knob4 is the volume knob on the organelle
	if (knob==4, {~masterGain.set(\amp, value)},

		{

			// if aux on, assign the 4 first knobs
			if (~isAuxOn,{
					switch(knob,
						0, {if (~voices[~currentPressedNote]!=nil, {~voices[~currentPressedNote].set(\p0,value);});},
						1, {if (~voices[~currentPressedNote]!=nil, {~voices[~currentPressedNote].set(\p1,value);});},
						2, {if (~voices[~currentPressedNote]!=nil, {~voices[~currentPressedNote].set(\p2,value);});},
						3, {if (~voices[~currentPressedNote]!=nil, {~voices[~currentPressedNote].set(\p3,value);});},
					);

			},{

			});
		}
	);
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

		~currentPressedNote = note;

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
		~currentPressedNote = -1;
		if(~voices[note]!=nil,{~voices[note].set(\gate,0);});
		~voices[note] = nil;
		~led.value(0);
	};)
};

// register key callback
~notes.addDependant(~notesfunc);

// create aux button callback
// aux is either true or false

~auxfunc = {
	arg func, msg, note, vel;
	~oled.screen(4, format("Aux %", note));
	~led.value(2);
	~isAuxOn = note;
};
// register aux callback
~aux.addDependant(~auxfunc);



