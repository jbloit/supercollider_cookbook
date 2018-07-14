//Read only parts of a buffer

Buffer.freeAll;

// ~samplesDir = thisProcess.nowExecutingPath.dirname +/+ "../soundfiles";
~samplesDir = "/home/jbloit/sounds/countdown";

b= Buffer.read(s, ~samplesDir +/+ "countdown.wav");
b.query;


b= Buffer.read(s, ~samplesDir +/+ "countdown.wav", 0, 2300);
b.query;

