// Exemple usage of SensorMapper:

// Define some callback functions (with a given signature defined in SensorMapper):
~aFunction = {|val=0|
	postf("A FUNCTION %\n", val);
};

~bFunction = {|val=0|
	postf("B FUNCTION %\n", val);
};


~p1_flower_sonar = {|i=0, v=0, state=0|
	postf("~p1_flower_sonar i:% v:% \n", i, v);

	switch(state,
		-1, {
			"----->OFFSET SONAR".postln;
		},
		0, {
			"----->OFF SONAR".postln;
		},
		1, {
			"----->CHANGE SONAR".postln;

		},
		2, {
			"----->ONSET SONAR".postln;
			Synth(\kick);
		},
	);
};

a = SensorMapper.new(~aFunction);
b = SensorMapper.new(~p1_flower_sonar);

// some dummy sensor value coming in
~sensorValue = 0.1;

// apply the mapping function, this sould run the proper callback:
a.map(~sensorValue);
b.map(~sensorValue);

