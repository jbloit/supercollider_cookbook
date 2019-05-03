// Poll the value of a signal periodically, and send over the value via OSC.

a = NetAddr.new("127.0.0.1", 7771);
b = Bus.control(s, 1);

// send a synth to an audio bus and a control bus
{
	var sig = SinOsc.ar(220);
	Out.ar(0, sig);
	Out.kr(b.index, sig);
}.play;


// poll the synth value over OSC every second:
(
SystemClock.sched(0.0,
	{
		b.get({|val|
			a.sendMsg("/value",  val );
		});
		1;
	}
)

)
