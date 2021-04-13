/// @desc Define functions/variables/Alarms.

global.paused = false;

// A dummy function to demonstrate Alarms.
testFunc = function() {
	show_debug_message("testFunc triggered!");
}

// A dummy function to demonstrate Alarms.
testFunc2 = function() {
	show_debug_message("testFunc2 triggered!");
}

// Create an array of alarms; we could simply assign each alarm to its own variable,
// and you will likely often do so, but this allows us to process many alarms in bulk.
// Also useful for replacing the default GameMaker alarms with minimal changes!
alarms = create_alarm_array(8);
alarms[5] = new Alarm(300, testFunc);
alarms[7] = new Alarm(120, testFunc2, true);