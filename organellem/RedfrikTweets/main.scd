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

SynthDef(\t4, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

	//--tweet0017
	sig = {b=LocalBuf(8e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(p0*3.1,p1*4e4,4e4)),8e4);BufWr.ar(Blip.ar([p2*2,p3*3]),b,i);BufRd.ar(2,b,i)};//#SuperCollider

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t5, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

	//--tweet0019
	sig = {b=LocalBuf(1e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(p0*1,p1*2e3,5e3)),5e5);BufWr.ar(Saw.ar([p2*8, p3*50]),b,i);BufRd.ar(2,b,i)/3};//#SuperCollider

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t6, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

	//--tweet0030
	sig ={a=LFPar;GVerb.ar(VarSaw.ar(a.ar(p0*1,0,5,a.ar([0.05,0.04],0,p1*50,p2*160).round(50)),0,a.ar(0.2,0,0.5,a.ar(3,0,0.2,0.5)))/8,p3*80)};//#SuperCollider

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t7, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0033
	sig ={f=LFPar.ar(p0*10/14).round*(p2*20)+(p1*80);Splay.ar(LFPar.ar({|i|[i+1*f,i*f+(i+1/3)]}!4)>BrownNoise.ar(Pulse.ar({|i|i+1}!4,p3*0.35))/3)};//#SuperCollider


	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;

SynthDef(\t8, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0033
	sig ={f=LFPar.ar(p0*10/14).round*(p2*20)+(p1*80);Splay.ar(LFPar.ar({|i|[i+1*f,i*f+(i+1/3)]}!4)>BrownNoise.ar(Pulse.ar({|i|i+1}!4,p3*0.35))/3)};//#SuperCollider


	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;


SynthDef(\t9, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0041, remixed
	sig = {o=SinOsc.ar((p0 + 0.8 )/RunningMax.ar(Sweep.ar(LocalIn.ar(4)),Impulse.ar([0.749,p1*6,p2*12,p3*3])));LocalOut.ar(o);Splay.ar(o).tanh/2};//#SuperCollider

	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;


SynthDef(\t10, {
	|amp=0.1, pan=0, out=0, gate=1,p0=1, p1=1, p2=1, p3=1|
	var sig, env;

//--tweet0046
sig = {a=LFTri;GVerb.ar(Mix(Limiter.ar(BRF.ar(a.ar(50*p2,1e-4 ),a.ar(a.ar([1.01,1.0111])*a.ar(8e3)*1e3+4e3*p3, 55*p1),a.ar(p0*10)*3))))/9};//#SuperCollider


	env = EnvGen.ar(Env.adsr(),gate,doneAction:2, levelScale:amp);
	Out.ar(out, Pan2.ar(sig*env, pan));
}
).add;


/*
a = Synth(\t10)
a.set(\p0, 1)
a.set(\p1, 0.9)
a.set(\p2, 0.8)
a.set(\p3, 0.7)*/



/*
//--tweet0032
{Splay.ar({|i|l=LFTri.ar(1/6,i/1.5,2.5,3.5).round;SinOsc.ar(142.857*l,lag(l,i-3/6),1-poll(0.142857*l,10/6,"\t\t"))}!6)}.play//#SuperCollider

//--tweet0034
play{x=CombN.ar(Phasor.ar(0,{|i|i+1/20}!22),0.042,0.042);y=Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,400,500)),x);Splay.ar(y)*0.25}//#SuperCollider


//--tweet0041
play{o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(LocalIn.ar(6)),Impulse.ar([1,0.749,6,12,3,4])));LocalOut.ar(o);Splay.ar(o).tanh/2}//#SuperCollider


//--tweet0042
play{c=[97,99];l=3**9;a=LocalBuf(l,2).clear;BufWr.ar(Saw.ar(c/5),a,BPF.ar(VarSaw.ar(c),98,0.1)*l);PlayBuf.ar(2,a,1/4,1,0,1)}//#SuperCollider


//--tweet0045
play{a=SinOsc;a.ar(a.ar(a.ar(0.11)),a.ar(a.ar(95*a.ar(0.01,0,1,1),0,a.ar(5e-3,0,50),100),a.ar([98,97]),pi+a.ar(5e-4))).tanh}//#SuperCollider


//--tweet0046
play{a=LFTri;GVerb.ar(Mix(Limiter.ar(BRF.ar(a.ar(50,1e-4),a.ar(a.ar([1.01,1.0111])*a.ar(8e3)*1e3+4e3,55),a.ar(0.01)*3))))/9}//#SuperCollider


//--tweet0052
{Splay.ar(BLowPass.ar(Impulse.ar("sunday".ascii),LFTri.ar(3/"live".ascii)*1800+1900,LFTri.ar(4/"coding".ascii)+1.01))}.play// #SuperCollider

//--tweet0054
play{CombN.ar(SyncSaw.ar(Saw.ar([3,4],32,64),Saw.ar([4,3],99,Duty.kr(1,0,flop(Dseq(2!6++4++3,99)*(4**(0..4))))))/9,1,1/6,2)}//#SuperCollider

//--tweet0058
play{CombN.ar(SinOsc.ar(Saw.ar(3,64,99),Saw.ar([3,4],Saw.ar(1,32,128),Duty.ar(1,0,flop(Dseq([0,8,1,5])*[1,4,8]))))/9,1,1/6)}//#SuperCollider

//--tweet0065 // bass liner
format(a="play{SinOsc.ar(%/[%,%],LPF.ar(LFSaw.ar(Duty.ar(16/%,0,Dseq("+($%!96)+",inf)),%),%,%))}",*a.ascii).postln.interpret//#SuperCollider


//--tweet0070
play{a=LocalIn.ar(2);LocalOut.ar(a=Hasher.ar(a.round(SinOsc.ar(3.3e-4,a*2pi).round(5e-4))));a/3+CombN.ar(a,1,[1,0.9],3,0.4)}//#SuperCollider

//--tweet0077
play{a=SinOsc;b=a.ar(a.ar(1/[5,6])+[798,912],a.ar(1/16)*19+99*a.ar([9,8]),a.ar(a.ar(6)*a.ar(0.009)));a.ar([201,301],b).tanh}//#SuperCollider


//--tweet0078
play{a=GrayNoise.ar;b=(1..9);CombL.ar(a,1,b/Duty.ar(3,0,Dseq([0.5,1,2,3]*99,99)).lag3(1)).mean/2+Ringz.ar(a/99,b*99).mean!2}//#SuperCollider


//--tweet0080
play{a=SinOsc;b=a.ar(1/3);Duty.ar(SampleDur.ir,0,Dseq([0,1],inf)).bitXor(a.ar(b>0*30+60,0,a.ar(4,0,a.ar([3,2]/9,b*3,9))))/9}//#SuperCollider


//--tweet0083
play{a=LFCub;Splay.ar({|i|i=i+1;Formant.ar(*Sweep.ar(a.ar(i/[1,2,3])>a.ar(i/9,i/9,1/6,1/3),0.05)*99*i+99*i)*a.ar(0.1/i)}!6)}//#SuperCollider

//--tweet0084
play{a=Saw;Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+199,a.ar((1,3..13)*29)*199+299,a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3}//#SuperCollider


//--tweet0085
play({Duty.ar(1/9600,0,Dseq((0..255).collect{|i|[1]++(1-i.asBinaryDigits.reverse)++[0]}.flat,inf),2)!2},s,0,0)// #SuperCollider talks serial


//--tweet0086
play{a=LFNoise2.kr(1/(9..17));Splay.ar(Ringz.ar(BPF.ar(Dust2.ar(a.abs*1e4),a.exprange(99,1e4),1.1-a),(9..1)*99,a+1.1,a)/5)}// #SuperCollider


//--tweet0090 ASMR
play{FreeVerb.ar(Splay.ar(BBandPass.ar(Blip.ar(b=(1..8)+1,LFTri.ar(1/b)*9e3,LFTri.ar(3/4/b).max(0)),b*999,1/b),2,3),0.3,1)}// #SuperCollider

*/

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
			63, {
				~voices[note] = Synth.new(\t4, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			64, {
				~voices[note] = Synth.new(\t5, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			65, {
				~voices[note] = Synth.new(\t6, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			66, {
				~voices[note] = Synth.new(\t7, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			67, {
				~voices[note] = Synth.new(\t8, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			68, {
				~voices[note] = Synth.new(\t9, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
				~led.value(1);
			},
			69, {
				~voices[note] = Synth.new(\t10, [\out, ~master, \p0, ~params[note][0],\p1, ~params[note][1],\p2, ~params[note][2],\p3, ~params[note][3] ]);
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



