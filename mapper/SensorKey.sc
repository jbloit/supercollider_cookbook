SensorKey {
	// Turn continuous values into note on/note off states.

	/*
	Returns a state index based on previous and current values of light sensors:
	isNoteOn: 2
	isNoteOff: -1
	isOn: 1
	isOff: 0
	*/
	var <>thresh, prevVal, <>triggerUpwards;
	*new {|thresh= 0.5, triggerUpwards=true|
		^super.newCopyArgs(thresh, triggerUpwards).reset;
	}
	reset {
		prevVal = thresh;
	}
	process {|newValue|
		var returnState, isNoteOn, isNoteOff, isOn, isOff;

		// TODO: fix this mode
		// if ((triggerUpwards != true), {newValue = 1-newValue; prevVal = 1-prevVal;}, {});

		// state detection
		isNoteOn = (prevVal <= thresh) && (newValue >= thresh);
		isNoteOff = (prevVal >= thresh) && (newValue <= thresh);
		isOn = (prevVal >= thresh) && (newValue >= thresh);
		isOff = (prevVal < thresh) && (newValue < thresh);

		// store previous value
		prevVal = newValue;

		// return state value
		if (isNoteOn,  {returnState=2});
		if (isNoteOff,  {returnState= -1});
		if (isOn,  {returnState=1});
		if (isOff,  {returnState=0});
		^returnState
	}
}


/*
Usage:
// WARNING: the triggerUpwards mode doesn't work yet...
a=SensorKey.new(0.5, true)
-> a SensorKey

a.process(0.1)
-> -1

a.process(0.2)
-> 0

a.process(0.8)
-> 2

*/