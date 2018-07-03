// EXAMPLE SHOWS HOW TO CONTROL POLYPHONY,
// LIMIT THE NUMBER OF VOICES TO KEEP CPU UNDER CONTROL.

// synth voices handling: "http://forum.critterandguitari.com/t/supercollider-on-organelle/2051"

MIDIClient.init;
MIDIIn.connectAll;

~maxVoices = 3;
~voices = Dictionary.new(~maxVoices);

// TEST SYNTH
SynthDef(\testSynth,
    {
        arg freq=440,gate=1,cutoff=440;
        var sig,env,amp=0.3;
        sig = Saw.ar(freq);
        env = EnvGen.ar(Env.adsr(),gate,doneAction:2);
        sig = sig * env * amp;
        sig = LPF.ar(sig,cutoff.clip(10,24000));
        Out.ar(0,sig!2);
    }
).add;

MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	postf("NOTE ON vel:% nn: %\n", [vel, nn]);

	if(~voices[nn]!=nil,{
		~voices[nn].set(\gate,0);
		~voices[nn] = nil;
	}
	);
	if (~voices.size<~maxVoices, {
		~voices[nn] = Synth.new(\testSynth,[\freq, nn.midicps]);}
	);
};
);

MIDIdef.noteOff(\noteOffTest, {
	|vel, nn |
	[vel, nn].postln;

        if(~voices[nn]!=nil,{~voices[nn].set(\gate,0);});
        ~voices[nn] = nil;
};
);




