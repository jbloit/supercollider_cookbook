
// ----------------------------------------
// Map/Constrain a 0-1 value to an output range:
// ----------------------------------------
(
var roomSize = 0.5;

// see examples in Spec doc
// var mapper = \unipolar.asSpec;
// var mapper = \bipolar.asSpec;
// var mapper = \phase.asSpec;
var mapper = \rate.asSpec;
// check all other defined specs in doc

roomSize = mapper.map(roomSize)
)
