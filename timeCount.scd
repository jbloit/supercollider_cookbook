
~currTime = 0;
(
AppClock.sched(0,{
	~currTime = ~currTime + 1;
	~currTime.postln;
	1});
)