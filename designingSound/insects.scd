// https://en.wikibooks.org/wiki/Designing_Sound_in_SuperCollider/Insects

// synth voices handling: "http://forum.critterandguitari.com/t/supercollider-on-organelle/2051"

MIDIClient.init;
MIDIIn.connectAll;

~maxVoices = 2;
~voices = Dictionary.new(~maxVoices);

// FIELD CRICKET
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
		~voices[nn] = Synth.new(\cricket,[\rate, nn/50]);}
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


// field cricket 2
(
b = {
	var trig, seq, demand, cricket;

	// instead of [metro], Impulse.kr is used here. Delta t = 17 ms equates to 58.82 Hz.
	trig = Impulse.kr(58.82);

	// the main idea of the following line was to use an approach
	// that uses the same coefficients as described in the pd patch
	seq = Dseq(Array.fill(41, {|i| if(i<7, {(i+2)/9},{0}) }),inf);
	demand = Demand.kr(trig,0,seq);

	// Implementation of the pd code for pulses including amplitude grow:
	// cricket = EnvGen.ar(Env.new([0, 1, 1, 0], [0.0001, 0.0001, 0]), trig) * demand;

	// 2nd implementation: pure data seemed to slightly disobey its own specifications,
	// so I analysed the waveform and came up with this:
	cricket = EnvGen.ar(Env.new([0, 1, 0], [4/44100, 0]), trig) * demand;


	cricket = OnePole.ar(cricket, exp(-2pi * (1000 * SampleDur.ir)));
	cricket = (
			// changed the Q factor of the first 3 BPFs to approximate farnells sound
			BPF.ar(cricket, 4500 + ((0..2)*50), 300.reciprocal, 100)).sum
			+ BPF.ar(cricket, 9000, 500.reciprocal, 42
	);
	cricket = ((cricket - OnePole.ar(cricket, exp(-2pi * (4000 * SampleDur.ir)))) * 0.5)!2;
}.play;
)

// To stop:
b.free;


// CICADA
(
c = {
	var sig, trig, seq, freq, mul, vals;

	trig = Impulse.kr(0.2);
	vals = [
		[0.5, 128],
		[8,6],
		[30,3]
	];
	freq = TChoose.kr(trig, vals);


	sig = WhiteNoise.ar;
	// The one pole filters in pure data and SC differ, so I changed the coefficents
	// a little. Also the  multiplication by 5 is not in the book, but helps to
	// approach the audible result of Farnells patch.
	sig = (sig - OnePole.ar(sig, exp(-2pi * (8000 * SampleDur.ir))));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (8000 * SampleDur.ir))));
	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = sig * 5;


	sig = BPF.ar(sig, [7500, 5500], 40.reciprocal).sum * SinOsc.ar(500);
	sig = sig * (1 / (SinOsc.ar( freq[0], 0, freq[1] ).squared + 1));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (4000 * SampleDur.ir)))) * 4.dup;
}.play;
)

// To stop:
c.free;

// HOUSEFLY
(
SynthDef(\houseflyWing, { |out=0|
	var sig, downstroke, upstroke, wingFreq, wingRes;

	// this is already a preparation for fig 50.14 and is not described
	// in the pure data patch on fig 50.13
	wingFreq = In.ar(10,2);
	wingRes = In.ar(20,2);

	// Also, it is prepared for some other input from a different source,
	// to not only control the patch with the mouse movement.
	// See also the following URL for more information about the next lines:
	// http://supercollider.sourceforge.net/wiki/index.php/Boolean_logic_in_the_server
	wingFreq = Select.ar(wingFreq > 0, [K2A.ar(MouseX.kr(0, 300)), wingFreq]);
	wingRes = Select.ar(wingRes > 0, [K2A.ar(MouseY.kr(3,5)), wingRes]);

	sig = LFSaw.ar(wingFreq, 1, 0.5, 0.5);
	sig = ((sig * 0.2).min(sig * (-1) + 1)).min(sig.min(sig * (-1) + 1));
	sig = (sig * 6 - 0.5) * 2;

	downstroke = (wingRes) * sig.min(0);
	downstroke = (Wrap.ar(downstroke) * 2pi).cos * sig.min(0) * 0.5 + sig.min(0);
	upstroke = sig.max(0).cubed * 2;

	sig = downstroke + upstroke;
	sig = (sig - OnePole.ar(sig, exp(-2pi * (700 * SampleDur.ir)))).dup * 0.05;
	Out.ar(out, sig);
}).add;

)

x = Synth(\houseflyWing);

// Leave it running while you run the other blocks of code below...

(
SynthDef(\buzzingHousefly, {
	var beatingFreq, resonanceMod;

	beatingFreq = OnePole.ar(WhiteNoise.ar, exp(-2pi * (4 * SampleDur.ir)));
	beatingFreq = OnePole.ar(beatingFreq, exp(-2pi * (4 * SampleDur.ir)));
	beatingFreq = beatingFreq * 700 + 220;

	resonanceMod = OnePole.ar(WhiteNoise.ar, exp(-2pi * (5 * SampleDur.ir)));
	resonanceMod = OnePole.ar(resonanceMod, exp(-2pi * (5 * SampleDur.ir)));

	Out.ar(10, [beatingFreq, (resonanceMod * 3) + beatingFreq]);
	Out.ar(20, (resonanceMod * 40 + 5)!2 );
}).add;

)
y = Synth(\buzzingHousefly);

// If the Synth(\buzzingHousefly) was executed before the Synth(\houseflyWing) you'll have to execute the following line to hear the effects of the Synth(\buzzingHousefly). This is because In.ar and Out.ar are used in this example to communicate between both patches, and when working with In.ar it is always necessary to have the Order of execution of synths on the server in mind. (see also Helpfile: Order of execution).

Synth(\buzzingHousefly, addAction: \addToHead);

x.free;
y.free;




