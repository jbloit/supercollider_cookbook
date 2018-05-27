// Parse OSC and send msg values to functions


~flexRange = 50;
~p1SonarChanged = {|i=0, v=0| (i+v).postln;};
~p1TopFlexChanged = {|i=0, v=0| (i+v).postln;};

// this maps analog index to composition functions
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