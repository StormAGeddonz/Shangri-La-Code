// Comment this out if the external btime library is unavailable
#define PRECISE_TIMER_AVAILABLE

#ifdef PRECISE_TIMER_AVAILABLE
var/global/__btime__lastTimeOfHour = 0
var/global/__btime__callCount = 0
var/global/__btime__lastTick = 0
var/global/__btime__dll = "[world.system_type==MS_WINDOWS ? "btime.dll":"./btime.so"]"
#define TimeOfHour __btime__timeofhour()
#define __extern__timeofhour text2num(call("[__btime__dll]", "gettime")())
proc/__btime__timeofhour()
	if (!(__btime__callCount++ % 50))
		if (world.time > __btime__lastTick)
			__btime__callCount = 0
			__btime__lastTick = world.time
		global.__btime__lastTimeOfHour = __extern__timeofhour
	return global.__btime__lastTimeOfHour
#else
#define TimeOfHour world.timeofday % 36000
#endif