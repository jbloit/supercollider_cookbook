// Exemple usage of SensorMapper:

// Define some callback functions (with a given signature defined in SensorMapper):
~aFunction = {|val=0|
	postf("A FUNCTION %\n", val);
};

~bFunction = {|val=0|
	postf("B FUNCTION %\n", val);
};


a = SensorMapper.new(~aFunction);
b = SensorMapper.new(~bFunction);

// some dummy sensor value coming in
~sensorValue = 0.1;

// apply the mapping function, this sould run the proper callback:
a.map(~sensorValue);
b.map(~sensorValue);

