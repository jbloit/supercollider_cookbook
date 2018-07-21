// MIDI IN EXAMPLE

// see "https://github.com/sensestage/interface2instrument/blob/master/4_MIDI.scd"

MIDIClient.init;
MIDIIn.connectAll;

MIDIFunc.trace;
// to turn tracing off:
MIDIFunc.trace( false );

MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	postf("NOTE ON vel:% nn: %\n", [vel, nn]);
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
