// Disaply a visual feedback on the OLED screen of the organelle when touching the controls.

~oled.screen(1, "API tests ");


// create knob callback
~knobfunc = {
	arg func, msg, knob, value;
	~oled.screen(2, format("Knob % val:%", knob, value));
};
// register knob callback
~knobs.addDependant(~knobfunc);


// create notes callback
~notesfunc = {
	arg func, msg, note, vel;
	~oled.screen(3, format("Note % %", note, vel));
};
// register key callback
~notes.addDependant(~notesfunc);

// create aux button callback
~auxfunc = {
	arg func, msg, note, vel;
	~oled.screen(4, format("Aux %", note));
};
// register aux callback
~aux.addDependant(~auxfunc);



