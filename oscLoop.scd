
~remote = NetAddr("127.0.0.1", 57120);

// sending a message locally
fork {
    loop {
		        "OSC_OUT".postln;
		~remote.sendMsg("/amessage", 1, 2, 3);
        1.wait;
    }
};


// receive message locally
OSCdef(\parseInput).free;
OSCdef(\parseInput, {
	| msg, time, addr, port |

	var val, index, mapped;
	postf("OSC IN, %\n", msg);
}, '/amessage', n );