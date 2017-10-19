--[[
2017-10-19
QQ登陆
王者荣耀
--]]
require("TSLib")
--require "req_tab1"
--require "abc"
require "tools"
dofile("/var/mobile/Media/TouchSprite/lua/TAB_ENV.lua")
dofile("/var/mobile/Media/TouchSprite/lua/var1.lua")
mSleep(200)
dialog(trim1(" sssdfsf  sdfs "), 1)


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

local jy_x
local jy_y

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



dialog(TAB_ENV.LUA_VERSION,1)


function set_jue_se(...)
	wwlog("298 判断是否是仓库号")
	mmsleep(100)	
	
		wwlog(tostring(var1.tianlei_flag))
		var1.tianlei_flag = true
		wwlog(tostring(var1.tianlei_flag))
		var1.init_setup = true
		fuli_flag = true
		in_game = false
		choose_flag = false

		before_game =true
		main_task = false
		mail_get =false
		bag_clean = true
		bag_full = true  
		jiaoyi_flag =false
		first_mail = true
		var1.bag_is_ready = true
		wwlog("340 是仓库号,直接去交易")
	
	-- body
end


function record_var1(o)
	local out =assert(io.open("/var/mobile/Media/TouchSprite/lua/var1.lua","w"))
	out:write("var1 = ")
	f_abc = function(o)
		if type(o) == "number" then
			out:write(o)
		elseif type(o) == "string" then
			out:write(string.format("%q",o) )		
		elseif type(o) == "boolean" then
			if o ==true then
				out:write( "true")
			else
				out:write( "false")
			end
		elseif type(o) == "table" then		
			out:write("{\n")
			for k,v in pairs(o) do
				out:write(" ",k,"=")
				f_abc(v)
				out:write(",\n")
			end
			out:write("}\n")
		else
			error("cannot serialize a "..type(o))
		end
	end

	f_abc(o)
	assert (out:close())

end


while (f_is_device_locked()) do
	unlock_device();
	mmsleep(1000)
end
ttoast("屏幕已解锁，脚本开始")

mmsleep(200)
init_screen(1)
mmsleep(200)
dofile("/var/mobile/Media/TouchSprite/lua/main1.lua")
mmsleep(200)
set_jue_se()
record_var1(var1)