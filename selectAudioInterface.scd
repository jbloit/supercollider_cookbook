ServerOptions.devices

//Set output device:
(
s.quit;
s=Server.local;
s.options.outDevice_("Fireface UC Mac (23669936)");
s.quit;
s.boot;
)

//test:
{SinOsc.ar()!2}.play;
