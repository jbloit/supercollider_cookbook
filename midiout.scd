MIDIClient.init;

m = MIDIOut.newByName("ESI-ROMIO", "ESI-ROMIO MIDI 1").latency = (0.2555);

// or on Linux (each message will be sent to all ports connected to SuperCollider's first MIDI output.)
m = MIDIOut(0);

(
~midiPattern = Pbind(
    //specifies type of message sent
    \type, \midi,
    //specifies type of midi message
    \midicmd, \noteOn,
    //the MIDI Out used
    \midiout, m,
  //the MIDI channel
    \chan, 0,
    //The rest of the pattern
    \scale,Scale.minor,
    \degree, Pseq([0,2,4],inf),
    \octave, 3,
    \dur, 0.5,
    \legato, 0.4
).play;
)

/*
If this doesn't work, there's possibly a routing issue. If you're using Linux, load up Qjackctl, select connect, then go to ALSA and connect output SuperCollider to your MIDI interface.

*/