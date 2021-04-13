/// @desc Simple loop to display Alarm statuses

var c = 0;

for (var i = 0; i < array_length(alarms); i++) {
	if (alarms[i] != noone) {
		
		draw_text(8, 8 + c * 48, "Alarm " + string(i) + " time: " + string(alarms[i].time) + "\n       loop: " + (alarms[i].loop ? "true" : "false"));
		c++;
	}
}

draw_text(8, 8 + c * 48, "Press P to toggle pause.\nPress R to manually restart alarms[5].\nSee console output for alarm readouts!");