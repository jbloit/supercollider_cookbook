/*
Run a pitch analysis periodically and send values over OSC
*/

// s.options.inDevice_("UMC202HD 192k");
// s.options.outDevice_("UMC202HD 192k");

s.waitForBoot({
	//////////////////////////////////// synth def and busses
	~inputCount = 2;
	~oscSendPeriod = 0.05; //sec

	Bus.clear;
	// bus arrays, group per audio input
	~meterBusses = Array.new;
	~pitchBusses = Array.new;
	~voicedBusses = Array.new;

	~inputCount.do{|i|
		~meterBusses = ~meterBusses.add(Bus.control(s, 1));
		~pitchBusses = ~pitchBusses.add(Bus.control(s, 1));
		~voicedBusses = ~voicedBusses.add(Bus.control(s, 1));
	};

	// Analyze audio features and copy them in control busses
	SynthDef(\audioAnalyzer, {
		|in=0, meterOut=0, pitchOut=0, voicedOut=0|

		var input, amp, pitch, hasFreq, minFreq, maxFreq;
		minFreq = 90;
		maxFreq = 800;
		input = SoundIn.ar(in);
		amp = Amplitude.kr(input, releaseTime: 0.1).lag;
		# pitch, hasFreq = Pitch.kr(input, minFreq:minFreq, maxFreq:maxFreq, downSample:2, median:10);

		Out.kr(meterOut, amp);
		Out.kr(pitchOut, (pitch * hasFreq / maxFreq).lag(1));
		// Out.kr(voicedOut, (amp *10* hasFreq.linlin(0, 1, -1, 1)).lag(1));
		Out.kr(voicedOut, hasFreq.lag(1));
	}).add;

	s.sync;


	// Poll the value of a signal periodically, and send over the value via OSC.

	~uiMachine = NetAddr.new("127.0.0.1", 12000);

	SystemClock.sched(0.0,
		{

			~inputCount.do({|i|

				~pitchBusses[i].get({|pitchVal|

					~meterBusses[i].get({|ampVal|

						~voicedBusses[i].get({|voicedVal|
							// pitchVal.postln;
							~uiMachine.sendMsg("/audio/chan_"++i, pitchVal, ampVal, voicedVal);

						});
					});
				};
				);
			});

			~oscSendPeriod;
		};
	);

	~player1 = Synth(\audioAnalyzer, [\in, 0, \meterOut, ~meterBusses[0].index, \voicedOut, ~voicedBusses[0], \pitchOut, ~pitchBusses[0].index ] );
	~player2 = Synth(\audioAnalyzer, [\in, 1, \meterOut, ~meterBusses[1].index, \voicedOut, ~voicedBusses[1], \pitchOut, ~pitchBusses[1].index ] );
};
);

