// MIDI IN EXAMPLE

// see "https://github.com/sensestage/interface2instrument/blob/master/4_MIDI.scd"

SynthDef(\perc,
	{
		|amp=0.1, pan=0|
		var sig;
		sig = SinOsc.ar(mul: EnvGen.ar(Env.perc(0.001)));
		Out.ar(0, Pan2.ar(sig*amp, pan));
}).add;


MIDIClient.init;
MIDIIn.connectAll;

MIDIFunc.trace;
// to turn tracing off:
MIDIFunc.trace( false );

MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	Synth(\perc, [\amp, vel/127]);
	postf("NOTE ON vel:% nn: %\n", vel, nn);

};
);

MIDIdef.noteOff(\noteOffTest, {
	|vel, nn |
	[vel, nn].postln;
};
);

MIDIdef.cc(\ccTest, {
	|val|
	val.postln;
};);



MIDIdef.cc( \testerCC, { arg ...args; args.postln; } );
MIDIdef(\testerCC).free;

// Try reducing latency
// s.latency;
// s.latency = 0.001;
// s.reboot;