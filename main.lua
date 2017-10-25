--[[
2017-10-19
QQ登陆
王者荣耀
--]]
require("TSLib")
--require "req_tab1"
--require "abc"
require "tools"

iphone_path="/var/mobile/Media/TouchSprite/lua/"

dofile(iphone_path.."TAB_ENV.lua")
dofile(iphone_path.."var1.lua")
dofile(iphone_path.."part_1.lua")
dofile(iphone_path.."pushover.lua")

function set_jue_se(...)
	wwlog("298 判断是否是仓库号")
	mmsleep(100)	
	
		wwlog(tostring(var1.tianlei_flag))
		var1.tianlei_flag = true
		wwlog(tostring(var1.tianlei_flag))
		var1.init_setup = true
		fuli_flag = true
		in_game = false
		
		var1.bag_is_ready = true
		wwlog("340 是仓库号,直接去交易")
	
	-- body
end


function record_var1(o)
	local out =assert(io.open(iphone_path.."var1.lua","w"))
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

mmsleep(200)

while (f_is_device_locked()) do
	unlock_device()
	mmsleep(1000)
end
ttoast("屏幕已解锁，脚本开始")

init_screen(1)
init("com.tencent.smoba",1)

dofile(iphone_path.."main1.lua")

set_jue_se()
record_var1(var1)

co1 = coroutine.create( function() 
		while true do
		--for i = 1,2 do
			ttoast("before yield")
			coroutine.yield("sdfsdfsfdsdf")
			mmsleep(3000)
			ttoast("after yield")
		end
	end ) 

function cor_pop_up1()
	local a,b = coroutine.resume(co1)
	if a then
		ttoast(tostring(b))
	end
	
	return b
end

--pushmsg("title","msg11")

--shake_screen()

--cor_pop_up1()
--mmsleep(3000)
--cor_pop_up1()


dofile(iphone_path.."pick_color.lua")
mmsleep(1000)

list1= List.new()

List.pushlast(list1,page_login_entrance.button_qq)

--local first_value = List.getfirst(list1)

--nLog(#first_value)

List.pushlast(list1,page_login_auth_qq.button_login)

--nLog(#first_value)

--nLog(list1.last)


for i =1, 20 do
	-- body
local first_value = List.getfirst(list1)
local click_index = #first_value


local click_xy = first_value[click_index] 
local click_x = click_xy[1]
local click_y = click_xy[2]
if multiColor(first_value) then
	nLog("click qq button")
	
	List.popfirst(list1)
	--nLog(#List.getfirst(list1))
	tap(click_x,  click_y)
end 
nLog(i)
mmsleep(1000)

end