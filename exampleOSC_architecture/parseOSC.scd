// Parse OSC and send msg values to worker functions
// Allows to decouple the OSC message parsing and the composition

// this maps analog index to worker functions
// ~p1_sensor2functions = [~p1TopFlexChanged, ~p1SonarChanged];
// m=NetAddr("192.168.0.110", 9000);
// m = NetAddr("127.0.0.1", 9000);
OSCdef(\parseAnalogSensors).free;
OSCdef(\parseAnalogSensors, {
	| msg, time, addr, port |

	var val, index, mapped;
	// index = msg[1] ;
	"OSC_IN".postln;
}, '/pyramide/capteur1', n );
