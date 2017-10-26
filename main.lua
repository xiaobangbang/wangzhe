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
List.pushlast(list1,page_login_auth_qq.button_login)


function task_by_loop(list1)
	-- body
	while (true) do
		for k,v in pairs (list1) do
			--print(k)
			if k ~= 'first' and k ~= 'last' then
				nLog("k:"..k)
				if multiColor(v) then
					nLog("multiColor(v)")			
					local click_x,click_y = getClickXY(v)	
					tap(click_x,  click_y)
				end 
				--print_r(v)
			end
			mSleep(1000)
		end
		mSleep(1000)
	end
end

function  getListSize(list1)
	-- body
	--[[
	local size =0
	for k,v in pairs (list1) do		
		if k ~= 'first' and k ~= 'last' then
			size = size +1
		end
	end
	return size
	--]]
	return list1.last + 1
end	

function task_by_order(list1)
	-- body	
	--for i =1, getListSize(list1) do
	while (true) do
		-- body
		local first_value = List.getfirst(list1)

		local click_x,click_y = getClickXY(first_value)	
		if multiColor(first_value) then
			nLog("multiColor(first_value)")
			List.popfirst(list1)			
			tap(click_x,  click_y)
		end
		if getListSize(list1) == 0 then
			break
		end
		mmsleep(1000)
	end
end