// load buffers from a folder

~samples = Array.new;

Buffer.freeAll;

// ~samplesDir = thisProcess.nowExecutingPath.dirname +/+ "../soundfiles";
~samplesDir = "/home/jbloit/sounds/countdown";

~folder = PathName.new(~samplesDir);

~folder.entries.do({
	arg path;
	path.postln;
	~samples = ~samples.add(Buffer.read(s, path.fullPath));
});


~samples.at(1).play;
~samples.at(2).play;
~samples.at(3).play;
~samples[1].play;


// the max number of buffers the server can read.
s.options.numBuffers
