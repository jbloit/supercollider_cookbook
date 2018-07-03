
// FIELD CRICKET
(
a= {
	var modulator, mod1, mod2, mod3;
	modulator = LFSaw.ar(1.43, 1, 0.5, 0.5);
	mod2 = (modulator *40.6*2pi).cos.squared;
	mod3 = mod2*3147;
	mod3 = (mod3 *2pi).cos + ( (mod3 *2 * 2pi).cos  * 0.3);
	mod1 = ((Wrap.ar(modulator.min(0.1714)*5.84) - 0.5).squared * (-4) + 1) * (mod2*mod3);
	mod1 = (mod1 * 0.1)!2;
}.play;
)
a.free;