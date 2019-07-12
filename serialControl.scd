SerialPort.devices;

~port  = SerialPort.new("/dev/ttyACM3",  115200);

~vals = [];

(
~charArray = [ ];
~getValues = Routine.new({
	var ascii;
	{
		ascii = ~port.read.asAscii;

		if (ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});

		if (ascii  == $bb, {
			~vals = ~charArray.collect(_.digit);

			~vals.postln;
			~charArray = [];
		});
	}.loop;
}).play;
)
~getValues.stop;


(
SynthDef(\notes, {|vel0 = 0, vel1 = 0|

	var	sig = SinOsc.ar([200, 300], mul: [vel0, vel1]*0.1);
	Out.ar(0, Splay.ar(sig, 0));
}
).add;

)

a  = Synth(\notes, [\vel0, 1, \vel1, 1]);
a.set(\vel0, 1);
a.set(\vel1, 1);

(
~control = Routine.new({
	{
		a.set(\vel0, ~vals[0]);
		a.set(\vel1, ~vals[1]);
		0.0001.wait;
	}.loop;
}).play;

)

~control.stop;
~port.close;

 