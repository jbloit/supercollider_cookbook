// Play a sound file from disk


(
b=Buffer.cueSoundFile(s,"/Users/bloit/Dropbox/hammaniProject_media/audio/chant_julien.wav",0, 1);
SynthDef(\diskin,{Out.ar(0,DiskIn.ar(1, b.bufnum))});

a = Synth(\diskin);

)

(
Buffer.freeAll;
a.free;
b.free;
)

