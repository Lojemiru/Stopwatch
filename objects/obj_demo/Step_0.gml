/// @desc Primitive input/run Alarms.

// Primitive keyboard controls
if (keyboard_check_pressed(ord("P"))) global.paused = !global.paused;
if (keyboard_check_pressed(ord("R"))) alarms[5].restart();

// Don't run the rest of the event if we're paused!
if (global.paused) exit;

// Run alarms - this must be called manually; that's the whole point of this extension.
run_alarms(alarms);