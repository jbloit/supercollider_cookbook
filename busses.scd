//////////////////////////////////////////// AUDIO

// a trigger signal
(
SynthDef(\trig, {|out = 0|
	Out.ar(out, Impulse.ar(0.5));
}).add;
)

// a synth with a gated envelope. gate is received from input bus
(
SynthDef(\tosc, {|out=0, in=0|
	var sig, env, gate;
	gate = In.ar(in, 1);
	env = EnvGen.ar(Env.perc(), gate);
	sig = SinOsc.ar(mul:env);
	Out.ar(out,  Pan2.ar(sig, 0));
}).add;
)

(
Bus.clear;
b = Bus.audio(s, 1);
b.index
)

(
// order of execution is important here, new synths are added on top
c = Synth(\tosc, [\in, b.index]);
d = Synth(\trig, [\out, b.index]);
)

// more control over the order of execution:
(
e = Synth(\trig, [\out, b.index]);
f = Synth.after(e, \tosc, [\in, b.index]);
)
(
c.free;
d.free;
e.free;
f.free;
)

//////////////////////////////////////////// CONTROL
// From http://danielnouri.org/docs/SuperColliderHelp/Tutorials/Getting-Started/Busses.html


// There are some other powerful things that you can do with control rate busses. For instance, you can map any arg in a running synth to read from a control bus. This means you don't need an In UGen. You can also write constant values to control busses using Bus' 'set' method, and poll values using its 'get' method.



(

	// make two control rate busses and set their values to 880 and 884.

	b = Bus.control(s, 1); b.set(880);

	c = Bus.control(s, 1);	c.set(884);

	// and make a synth with two frequency arguments

	x = SynthDef("tutorial-map", { arg freq1 = 440, freq2 = 440;

		Out.ar(0, SinOsc.ar([freq1, freq2], 0, 0.1));

	}).play(s);

)

// Now map freq1 and freq2 to read from the two busses

x.map(\freq1, b.index, \freq2, c.index);


// Now make a Synth to write to the one of the busses

y = {Out.kr(b.index, SinOsc.kr(1, 0, 50, 880))}.play(addAction: \addToHead);



// free y, and b holds its last value

y.free;



// use Bus-get to see what the value is. Watch the post window

b.get({ arg val; val.postln; f = val; });



// set the freq2, this 'unmaps' it from c

x.set(\freq2, f / 2);



// freq2 is no longer mapped, so setting c to a different value has no effect

c.set(200);



x.free; b.free; c.free;

