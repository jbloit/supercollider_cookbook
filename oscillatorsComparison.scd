// Compare oscillators' sound for an F0 of  50 Hz.


{LFPar.ar(50, mul:0.3)!2}.play

{LFCub.ar(50, mul: 0.3)!2}.play

{LFTri.ar(50, mul:0.01)!2}.play

{SinOsc.ar(50, 0, 0.3)!2}.play;

{LFSaw.ar(50, 0, 0.01)!2}.play;

{LFGauss.ar(1/50, 0.3, 0, 1)*0.11!2}.play

(
s = Server.local;
b = Buffer.alloc(s, 512, 1);
b.sine1(1.0/[1,2,3,4,5,6], true, true, true);

SynthDef("help-Osc",{ arg out=0,bufnum=0;
    Out.ar(out,
        Osc.ar(bufnum, 50, 0, 0.04)!2
    )
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)


(
b = Buffer.alloc(s, 512, 1, {arg buf; buf.sine1Msg(1.0/[1,2,3,4,5,6,7,8,9,10])});
{ COsc.ar(b.bufnum, 50, 0.1, 0.05)!2 }.play;
)

{Blip.ar(50, 5, 0.1)!2}.play


play({ VarSaw.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1) });

play({
    VarSaw.ar(
        LFPulse.kr(3, 0, 0.3, 200, 200),
        0,
        LFTri.kr(1.0).range(0,1), //width
        0.1)
});

