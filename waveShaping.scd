// from https://youtu.be/7nrUBbmY1hE?t=584

// "tf" = transfer function


(
~tfBuf = Buffer.alloc(s, 2048);
~tf = Signal.newClear(1025).waveFill({
	|x, old, i|
	sin(x)
}, -pi/2, pi/2);

~tf = ~tf.waveFill({
	|x, old,  i|
	old * ((cos(x*0.08) / 4) + 0.3);
}, 0.50pi).normalize;

// ~tf.plot;
~tfBuf.loadCollection(~tf.asWavetableNoWrap);
)

(
{
	var sig, input;
	input = LFTri.ar(50!2).lincurve(-1, 1, -1, 1, MouseX.kr(-70, 0));
	sig = Shaper.ar(~tfBuf, input);
	sig = LeakDC.ar(sig);
}.play;

)