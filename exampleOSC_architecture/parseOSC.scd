// Parse OSC and send msg values to worker functions
// Allows to decouple the OSC message parsing and the composition


// this maps analog index to worker functions
~p1_sensor2functions = [~p1TopFlexChanged, ~p1SonarChanged];


OSCdef(\parseAnalogSensors).free;
OSCdef(\parseAnalogSensors, {
	| msg, time, addr, port |

	var val, index, mapped;
	index = msg[1] - 1;
	val = msg[2] / ~flexRange;
	mapped = (val * 10).ceil;

	~p1_sensor2functions[index].value(index, val);

}, '/plantoid/1/1/sonar', n);