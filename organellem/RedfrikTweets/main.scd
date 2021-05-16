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

// init parameteters dict
~params = Dictionary.new;
(60..83).do(
	{|i|
		~params[i] = 1!4;
	}
);

//master audio bus that all synths output to
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

//--tweet0016
sig = {b=LocalBuf(9e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(p0*12,3e4,p3*4e4)),9e4);BufWr.ar(Saw.ar([p1*8, p2*9]),b,i);BufRd.ar(2,b,i)/2};

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



~masterGain = Synth(\masterGain);
~oled.screen(1, "Redfrik Tweets");
~currentNote = -1;
~isAuxOn = false;

// create knob callback
~knobfunc = {
	arg func, msg, knob, value;
	~oled.screen(2, format("Knob % val:%", knob, value));

	// knob4 is the volume knob on the organelle
	if (knob==4, {~masterGain.set(\amp, value)},
		{
			// assign the 4 first knobs to parameters, when the note is pressed. octatrack style.
			switch(knob,
				0, {if (~voices[~currentNote]!=nil, {
					~voices[~currentNote].set(\p0,value);
					~params[~currentNote][0] =value;
				});},
				1, {if (~voices[~currentNote]!=nil, {~voices[~currentNote].set(\p1,value);
					~params[~currentNote][1] =value;
				});},
				2, {if (~voices[~currentNote]!=nil, {~voices[~currentNote].set(\p2,value);
					~params[~currentNote][2] =value;
				});},
				3, {if (~voices[~currentNote]!=nil, {~voices[~currentNote].set(\p3,value);
					~params[~currentNote][3] =value;
				});},
			);
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

		~currentNote = note;

		if(~voices[note]!=nil,{~voices[note].set(\gate,0);});

		switch(note,
			60, {
				~voices[note] = Synth.new(\t1, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			61, {
				~voices[note] = Synth.new(\t2, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			62, {
				~voices[note] = Synth.new(\t3, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
		);

	} , {
		~currentNote = -1;
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



