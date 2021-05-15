ServerOptions.devices

//Set output device:
(
s.quit;
s=Server.local;
s.options.inDevice_("Fireface UC Mac (23669936)");
/*s.options.outDevice_("Fireface UC Mac (23669936)");*/
// s.options.outDevice_("USB PnP Sound Device");
s.options.outDevice_("Built-in Output");
s.options.outDevice_("Soundflower (16ch)");
s.quit;
s.boot;
)

//test:
{SinOsc.ar()!2}.play;
