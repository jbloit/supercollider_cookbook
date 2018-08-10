SensorMaracas {
	// Turn continuous values into note on/note off states, when sensor changes direction.
	// increase filter order (int values > 1) for smoother reaction.

	/*
	Returns a state index based on previous and current values of sensors:
	isNoteOn: 2
	isNoteOff: -1
	*/
	var <>thresh, filterOrder, prevVal, prevDirection, prevArray;
	*new {|thresh= 0.5, filterOrder=10|
		^super.newCopyArgs(thresh, filterOrder).reset;
	}
	reset {
		prevDirection = -1; // 1: up, -1: down
		prevVal = thresh;
		prevArray =Array.fill(filterOrder, 0);
	}

	// send a note On state whenever the sensor changes direction, or crosses the initial threshold.
	process {|newValue|
		var returnState, isNoteOn, isNoteOff, isOn, isOff, direction;

		direction = if ( (newValue > prevVal), {1}, {-1});

		// postf("Direction: %\n", direction);
		// state detection
		isNoteOn = (prevDirection != direction) && (newValue >= thresh);
		isNoteOff = (prevVal >= thresh) && (newValue <= thresh);

		// filter prevValue
		prevArray[0] = newValue;
		prevArray= prevArray.shift(1);
		prevVal = prevArray.median;

		prevDirection = direction;

		// return state value
		if (isNoteOn,  {returnState=2});
		if (isNoteOff,  {returnState= -1});

		^returnState
	}
}

/*
Usage:

a=SensorMaracas.new(0.5, 100)
-> a SensorMaracas

a.process(0.1)

*/