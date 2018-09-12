// step sequencer

~steps = [0,1,1,0];
~degrees = [11, 22, 33, 44];

~degrees.select({ arg item, i; ~steps[i]>0 });
