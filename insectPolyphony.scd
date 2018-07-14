// EXAMPLE SHOWS HOW TO CONTROL POLYPHONY,
// LIMIT THE NUMBER OF VOICES TO KEEP CPU UNDER CONTROL.

// play insects

// synth voices handling: "http://forum.critterandguitari.com/t/supercollider-on-organelle/2051"

MIDIClient.init;
MIDIIn.connectAll;

~maxVoices = 3;
~voices = Dictionary.new(~maxVoices);

SynthDef(\cricket,
	{
		|out=0, rate=1.5, gate = 1|
		var modulator, mod1, mod2, mod3, env, sig;

		// repeat time is 0.7s: equates to 1.43 Hz.
		modulator = LFSaw.ar(rate, 1, 0.5, 0.5);
		mod2 = (modulator * 40.6 * 2pi).cos.squared;
		mod3 = modulator * 3147;
		mod3 = (mod3 * 2pi).cos + ((mod3 * 2 * 2pi).cos * 0.3);
		mod1 = ((Wrap.ar(modulator.min(0.1714) * 5.84) - 0.5).squared * (-4) + 1) * (mod2 * mod3);
		mod1 = (mod1 * 0.1);

		env = Env.adsr();
		sig = mod1 * EnvGen.kr(env, gate, doneAction:2);

		Out.ar(0, sig!2);
}).add;


MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	postf("NOTE ON vel:% nn: %\n", [vel, nn]);

	if(~voices[nn]!=nil,{
		~voices[nn].set(\gate,0);
		~voices[nn] = nil;
	}

	);
	if (~voices.size<~maxVoices, {
		~voices[nn] = Synth.new(\cricket, [\rate, (nn/60)]);}
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




