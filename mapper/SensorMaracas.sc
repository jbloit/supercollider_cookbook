SensorMaracas {
	// Turn continuous values into note on/note off states, when sensor changes direction.

	/*
	Returns a state index based on previous and current values of light sensors:
	isNoteOn: 2
	isNoteOff: -1
	isOn: 1
	isOff: 0
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
// WARNING: the triggerUpwards mode doesn't work yet...
a=SensorButton.new(0.5, true)
-> a SensorButton

a.process(0.1)
-> -1

a.process(0.2)
-> 0

a.process(0.8)
-> 2

*/