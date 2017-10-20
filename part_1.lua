--[[
local open_app
local front_app
local mmsleep
local ttoast
local init_screen
local init_log
local wt_log
local wx_log
local findcolor
local getcolorr
local move2
local unlock_device
local is_device_lock 
local multi_col
local set_screen_light 
local get_screen_light
local keep_screen
local unkeep_screen
--]]

function xxtmoveto(x1,y1,x2,y2,step)
	touch.on(x1, y1):move(x2,y2):off() 
end

if TAB_ENV.LUA_VERSION == "TOUCH" then
	open_app= runApp
	front_app = frontAppBid
	mmsleep = mSleep
	init_screen = init
	init_log = initLog
	wt_log= wLog
	close_log = closeLog
	multi_col = multiColor
	ltap = tap
	move2 = moveTo
	findcolor = findMultiColorInRegionFuzzy
	ttoast = toast
	unlock_device = unlockDevice
	is_device_lock = deviceIsLock
	getcolorr = getColor
	set_screen_light = setBacklightLevel
	get_screen_light = getBacklightLevel
	keep_screen = keepScreen

elseif TAB_ENV.LUA_VERSION == "XXT" then
	open_app= app.run
	front_app = app.front_bid
	mmsleep = sys.msleep
	init_screen = screen.init
	wx_log= sys.log
	multi_col = screen.is_colors
	ltap = touch.tap
	move2 =xxtmoveto
	findcolor = screen.find_color
	ttoast = sys.toast
	unlock_device = device.unlock_screen
	is_device_lock = device.is_screen_locked
	getcolorr = screen.get_color
	set_screen_light = device.set_brightness
	get_screen_light = device.brightness
	keep_screen = screen.keep
	unkeep_screen = screen.unkeep
end

function f_keep_screen(flag)
	if TAB_ENV.LUA_VERSION == "TOUCH" then 
		if flag == true then
			keep_screen(true)
		else
			keep_screen(false)
		end
	elseif TAB_ENV.LUA_VERSION == "XXT" then
		if flag == true then
			keep_screen()
		else
			unkeep_screen()
		end
	end
end

if TAB_ENV.LUA_VERSION == "TOUCH" then
	init_log(log_file, 1)
end	

function wwlog(msg)
	if TAB_ENV.LUA_VERSION == "TOUCH" then		
		wt_log(log_file,msg)
	elseif TAB_ENV.LUA_VERSION == "XXT" then
		wx_log(msg)
	end	
	if TAB_ENV.DEBUG_MODE == true then
		nLog(msg)
	end
end

function f_is_device_locked()
	local ret = false
	if TOUCH_MODE == true then
		if is_device_lock() ~= 0 then
			ret = true	
		end
	elseif XXT_MODE == true then
		ret = is_device_lock()
	end	
	return ret
end

function shake_screen()
	local br = get_screen_light()
	mmsleep(200)
	for i = 1 ,30 do
		set_screen_light(1)
		mmsleep(200)
		set_screen_light(0)
		mmsleep(200)
	end
	set_screen_light(br)
end


function f_no_color_changed ()
	local tab_luoxia ={
		{ 1071,   50, 0xf0e9e9},
		{ 1072,   58, 0xeae3e3},
		{ 1079,   49, 0xdccaca},
		{ 1080,   54, 0xefe7e7},
		{ 1087,   54, 0xf5f0f0},
		{ 1093,   59, 0xebe8e6},
		{ 1100,   54, 0xf1ecec},
		{ 1108,   59, 0xf3f2f1},
		{ 1110,   52, 0xdcd2d2},
		{ 1117,   53, 0xeceae9},
	}

	return function (v_over_time) 
		local ret = true
		local over_time = v_over_time or 1
		over_time = over_time * 1000
		mmsleep(over_time)
		for k,v in  ipairs(tab_luoxia) do				
			local c = getcolorr(v[1],   v[2])		
			if c ~= v[3] then			
				v[3] = c
				ret = false
			end
		end
		return ret
	end
end


local tab_line = {
	{  329,  202, 0x68351b},
	{  440,  203, 0xc3976a},
	{  329,  260, 0x724024},
	{  444,  260, 0x643219},
	{  332,  317, 0x7e4f30},
	{  445,  316, 0x613118},
	{  330,  373, 0x653319},
	{  441,  373, 0x996844},
	{  328,  428, 0xf3c992},
	{  443,  428, 0x763c1d},
}


function get_line_xy(j)
	local ret,x,y
	for i,v in ipairs(tab_line) do
		if i == j then
			ret = true
			x = v[1]	
			y = v[2]			
			break		
		end
	end	
	return ret,x,y	
end
