~r = Routine({
	{
		// Do something
		rrand(0,9).postln;

		// and wait
		1.wait;
	}.loop;
}).play