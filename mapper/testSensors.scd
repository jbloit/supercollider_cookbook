// make sure you install the sensor<InstrumentType>.sc classes

MIDIClient.init;
MIDIIn.connectAll;

// Test sensor button, using midi in CC as sensor input

SynthDef("kick", {
	arg out=0,tu = 1,amp=1;
	var env0, env1, env1m, sig;
	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.3, 0], [0.01, 0.5, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([120, 43, 29], [0.03, 0.29], [-4, -5]));
	env1m = env1.midicps;
	sig = LFPulse.ar(env1m*tu, 0, 0.5, 1, -0.5);
	sig = sig + WhiteNoise.ar(1);
	sig = LPF.ar(sig, env1m*1.5, env0);
	sig = sig + SinOsc.ar(env1m*tu, 0.5, env0*4);
	sig = sig * amp;
	sig = sig.clip2(1);
	Out.ar(out, sig);
}).send(s);

SynthDef(\kick3,{arg out=0,amp=1,gate = 1, tu = 1, rel =3,freq=60;
	var env = EnvGen.ar(Env.perc(0,rel),gate,doneAction:2);
	var frequ = EnvGen.ar(Env([130,freq,30],[0.05,rel]));
	var sig = SinOsc.ar(freq*tu,0,env);
	Out.ar(out,sig * amp);
}).add;



SynthDef(\kicknoise,{arg out=0, amp=0.5;
	var env = EnvGen.ar(Env([0,1,0],[0.01,1]),doneAction:2);
	var freq =EnvGen.ar(Env([20000,100,30],[0.005,1]));
	var sig =  SinOsc.ar(freq,0,env)+(WhiteNoise.ar(1)*env);
	Out.ar(out,sig*amp);
}).add;

// will send a state=2 value when input crosses threshold
a=SensorKey.new(0.5);

MIDIdef.cc(\ccTest, {
	|val|
	var state = a.process(val/127).postln;
	if ((state==2),  {Synth(\kick)});
};);

MIDIdef.cc(\ccTest).free;

// will send a state=2 value when input changes direction
a=SensorMaracas.new(0.01, 120);

MIDIdef.cc(\ccMaracas, {
	|val|
	var state = a.process(val/127);
	// (val/127).postln;
	if ((state==2),  {Synth(\kick)});
};);

MIDIdef.cc(\ccMaracas).free;
