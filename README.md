# Deprecation

I am moving on from GameMaker in general. I will provide support for this library as best possible if people still express interest in it, but I will not be actively using it and will be unlikely to add new features. Not that this simple library needed any in the first place.

Pull requests and issues will still be addressed, but you may get better long-term mileage with a fork.

# Stopwatch
A simple, control-focused replacement for GameMaker: Studio 2.3 alarms.

## Why replace the default alarms?

GameMaker alarms are convenient but somewhat limited. They create code that is difficult to read (*what does alarm[7] do, again?*),
must be manually looped, and - worst of all - are unable to be paused in any convenient fashion.

Stopwatch addresses all of these issues in an efficient, easy-to-use fashion.

## Structs

```
Alarm(time, function, [loop], [resetTime])
```

A struct that will trigger a function once its internal timer has reached zero.

*Note: If not looped, an Alarm's internal timer will immediately be set to negative one when it reaches zero to prevent its function from running multiple times.*

| Argument | Description |
| :--- | :--- |
| time {int} | The starting value for the Alarm, and the default value to reset to if looped or `restart()`ed. |
| function {function} | The function to run when the Alarm reaches zero. Function variables are encouraged, but global-scope ones will work as well. |
| [loop] {bool} | Optional. False by default. Causes the Alarm to loop back to its initial `time` value once it reaches 0. |
| [resetTime] {int} | Optional. `time` by default. Custom value to use on `restart()` or loop. |

| Internal function | Description |
| :--- | :--- |
| run() | Causes the Alarm to tick down by one. Will trigger the `function` when it reaches zero and restart the countdown if `loop` was set to `true`. |
| restart() | Resets the Alarm timer to its initial value. |

## Functions

| Function | Description |
| :--- | :--- |
| run_alarm(alarm) | Safely runs a single Alarm, exiting if it does not exist. |
| run_alarms(array) | Safely runs an array of Alarms using `run_alarm`. |
| create_alarm_array(size) | Returns an array of the given size, initialized to `noone` and ready to be populated with Alarms. |

## How to use

First, you'll need to [download the latest version](https://www.github.com/Lojemiru/Stopwatch/releases/latest) and import the Stopwatch script into your project.
You could also be doing this in the repository demo project.

An Alarm can be instantiated as follows:

```gml
test_function = function() {
  show_debug_message("test function run!");
}
timer = new Alarm(60, test_function);
``` 

It can then be run in a step event as follows:

```gml
if (global.paused) exit;
run_alarm(timer); // You could use timer.run() instead, but this ensures that we will not induce a crash if timer is noone.
```
 
A global pause variable is shown here to demonstrate the primary purpose of Stopwatch: only causing Alarms to count down when you intend for them to.
This allows you to use Alarms in tandem with a global pause system without having to define your own timer logic in every object that needs to run an event on a delay!

## Other use cases

Want an Alarm to automatically loop instead of re-initializing it in the triggered function? Just set the optional `loop` parameter to true!

```gml
timer = new Alarm(120, test_function, true);
```

Need to have a different starting countdown from the loop time? Use the optional `resetTime` parameter to set the loop time value.

```gml
timer = new Alarm(1, test_function, true, 60);
```

Do you need to process Alarms in bulk or quickly replace default alarms? Use the array-based functions!

```gml
alarms = create_alarm_array(3);
alarms[0] = new Alarm(25, test_function);
// Skipping alarms[1] to show that you can leave this empty and instantiate it later when you want it to start counting!
alarms[2] = new Alarm(40, test_function, true);
```

In the step event:

```gml
if (global.paused) exit;
run_alarms(alarms);
```

## Licensing

This extension/repository is licensed under the MIT License. Attribution in the "special thanks" or similar section of your game credits is appreciated, but not required so long as the MIT License's conditions are met.

## Special thanks
YoYo Games: Creating this wonderful bowl of pixel-flavored spaghetti we call GameMaker.

M3D: Showing me how to pass function references to structs for a previous utility.

JuJu Adams: Leaving an interesting comment on a discussion about structs that got me to poke at the behavior of the `other` keyword in relation to structs.
