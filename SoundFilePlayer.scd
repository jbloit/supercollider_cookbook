// Play a sound file from disk, and send to a revebr bus.


~playerBus = Bus.audio(s, 1);

(
b=Buffer.cueSoundFile(s,"/Users/bloit/Dropbox/hammaniProject_media/audio/chant_julien.wav",0, 1);
SynthDef(\diskin,{|out=0|
	Out.ar(out, DiskIn.ar(1, b.bufnum))};
).add;

~player = Synth(\diskin, [\out, ~playerBus.index]);
)

(
Buffer.freeAll;
~player.free;
b.free;
)



(
SynthDef(\src, {|in=0,out=0, mix = 0.25, room = 0.15, damp = 0.5|
	Out.ar(out,
		FreeVerb.ar(
			In.ar(in),
			mix,
			room,
			damp
		)
	);
}).add;
)

~reverb = Synth.after(~player, \src, [\in, ~playerBus.index]);

(
~reverb.set(\room, 0.7);
~reverb.set(\mix, 0.4);
~reverb.set(\damp, 0.2);
)

~reverb.free