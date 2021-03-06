// Parse OSC and send msg values to functions


~flexRange = 50;
~p1SonarChanged = {|i=0, v=0| (i+v).postln;};
~p1TopFlexChanged = {|i=0, v=0| (i+v).postln;};

// this maps analog index to composition functions
~p1_sensor2functions = [~p1TopFlexChanged, ~p1SonarChanged];


OSCdef(\multiballRecX).free;
OSCdef(\multiballRecX, {
	| msg, time, addr, port |

	var val, index, mapped;
	val  = msg[1] ;
	// val = msg[2] / ~flexRange;
	// mapped = (val * 10).ceil;
	postf("IN x: % \n", val);
	// ~p1_sensor2functions[index].value(index, val);

}, '/recXYHeavy/recObject/x', n);


OSCdef(\multiballRecY).free;
OSCdef(\multiballRecY, {
	| msg, time, addr, port |

	var val, index, mapped;
	val  = msg[1] ;
	// val = msg[2] / ~flexRange;
	// mapped = (val * 10).ceil;
	postf("IN y: % \n", val);
	// ~p1_sensor2functions[index].value(index, val);

}, '/recXYHeavy/recObject/y', n);