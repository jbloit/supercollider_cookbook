// In this main file, write the composition worker functions:

// for the sake of the example, just printing out some message:


~flexRange = 50;
~p1SonarChanged = {|i=0, v=0| (i+v).postln;};
~p1TopFlexChanged = {|i=0, v=0| (i+v).postln;};

// this needs to be called last, since it refers to the worker functions above:
"parseOSC.scd".loadRelative(true, {"loaded".postln});