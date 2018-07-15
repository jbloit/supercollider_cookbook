fork {
// Control a sound texture with recMultiball lemur patch

SynthDef(\roof , {
	|out=0, amp=0.5, root=99, root2=199|
	var sig;
	sig = {a=Saw;Splay.ar(Formant.ar(a.ar((5,7..15)*19)*root+root2, a.ar((1,3..13)*29)*199+299, a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3};
	Out.ar(0, sig*amp);
}).add;

s.sync;


a = Synth(\roof);



OSCdef(\multiballRecX).free;
OSCdef(\multiballRecX, {
	| msg, time, addr, port |

	var val, index, mapped;
	val  = msg[1] ;
	// val = msg[2] / ~flexRange;
	// mapped = (val * 10).ceil;
	postf("IN x: % \n", val);
	a.set(\root2, val*1200);
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
	a.set(\amp, val);
	// ~p1_sensor2functions[index].value(index, val);

}, '/recXYHeavy/recObject/y', n);
};