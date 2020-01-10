// From the routine doc

a = Routine({ 1.yield; 2.yield; });
a.next.postln;
a.next.postln;
a.next.postln;
a.reset;

//---------------

(
r = Routine { arg inval;
    inval.postln;
    inval = 123.yield;
    inval.postln;
}
)
r.value("hello routine");
r.value("goodbye routine");