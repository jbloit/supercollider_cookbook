// Ducking

(
{
    var y,z;

    z = Decay2.ar(
        Impulse.ar(8, 0, LFSaw.kr(0.3, 1, -0.3, 0.3)),
        0.001,
        0.3
    )
    * Pulse.ar([80, 81], 0.3);

	y = LFPar.ar([160, 320], mul:0.2);

    Compander.ar(y, z,
        thresh: MouseX.kr(0.01, 0.3),
        slopeBelow: 30,
		slopeAbove:  1,
        clampTime:   0.01,
        relaxTime:   0.01
    ) + z;
}.play;
)
