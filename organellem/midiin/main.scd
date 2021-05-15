// MIDI IN EXAMPLE

// see "https://github.com/sensestage/interface2instrument/blob/master/4_MIDI.scd"

// s.latency = 0.01;
// s.reboot;
// s.options.hardwareBufferSize = 512;
// s.options.blockSize = 512;
// s.options.blockSize;

// s.latency = 0.01;

~oled.screen(5,"MIDIIN patch loaded");


SynthDef(\perc,
	{
		|amp=0.1, pan=0|
		var sig;
		sig = SinOsc.ar(mul: EnvGen.ar(Env.perc(0.001), doneAction:2));
		Out.ar(0, Pan2.ar(sig*amp, pan));
}).add;


// create notes callback
~notesfunc = {
	arg func, msg, note, vel;
	Synth(\perc, [\amp, vel/127]);

};
// register key callback
~notes.addDependant(~notesfunc);


MIDIClient.init;
MIDIIn.connectAll;

MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	~oled.screen(2,"note vel " + vel );
	Synth(\perc, [\amp, vel/256]);
};
);

MIDIdef.noteOff(\noteOffTest, {
	|vel, nn |
	// [vel, nn].postln;
};
);

MIDIdef.cc(\ccTest, {
	|val|
	// val.postln;
};);



// Try reducing latency
// s.latency;
// s.latency = 0.001;
// s.reboot;