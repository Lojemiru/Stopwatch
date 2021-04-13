/// @func					Alarm(time, function)
/// @desc					Instantiates a new Alarm struct that will trigger a function
///							once its internal timer has reached 0. This timer must be run
///							by another object!
/// @arg {int} time			The amount of time the Alarm should wait before triggering.
/// @arg {method} function	The function to run when the Alarm is triggered.
/// @arg {bool} [loop]		Whether or not the Alarm should loop.
function Alarm(_time, _function) constructor {
	// Overload for loop parameter. Hacky, but this is as good as it gets in 2.3.
	loop = (argument_count > 2) ? argument[2] : false;
	
	// Count down, trigger the function, and optionally loop.
	run = function() {
		time = max(-1, time - 1);
		if (time == 0) {
			func();
			time = -1;
			if (loop) time = startTime;
		}
	}
	
	// Reset to the time given on creation.
	restart = function() {
		time = startTime;
	}
	
	time = _time;
	startTime = time;
	// This works with globally-defined methods too, surprisingly!
	func = method(other, _function);
}

#region BEHAVIOR WRAPPERS - you could do this manually, but most use cases will warrant using these.

/// @func				    run_alarm(alarm)
/// @desc					Safely runs a single Alarm, exiting if it does not exist.
/// @arg {struct} alarm		The Alarm to run.
function run_alarm(_alarm) {
	if (typeof(_alarm) == "struct") {
		_alarm.run();
	}
}

/// @func					run_alarms(array)
/// @desc					Safely runs an array of Alarms using run_alarm.
/// @arg {array} array		The array of Alarms to run.
function run_alarms(_array) {
	if (typeof(_array) == "array") {
		for (var i = 0; i < array_length(_array); i++) {
			run_alarm(_array[i]);
		}
	}
}

/// @func					create_alarm_array(size)
/// @desc					Returns an array of the given size, initialized to noone
///							and ready to be populated with Alarms.
/// @arg {int} size			The size of the Alarm array.
function create_alarm_array(_size) {
	var _arr;
	for (var i = 0; i < _size; i++) {
		_arr[i] = noone;
	}
	return _arr;
}

#endregion