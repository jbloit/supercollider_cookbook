// This class is meant to hookup sensor data and a music process function.
// the mapping function could be anything, why not switching between several functions...

SensorMapper {
	// the name of a function to process the sensor value with
	var <>musicCallback;


	*new {|musicCallback |
		^super.newCopyArgs(musicCallback);
	}

	// dummy mapping function: process the sensor value, and
	// run the music callback function with the result
	map {|value=0|
		var state = if(value>0.5, {1}, {2});
		musicCallback.value(state);
	}

}