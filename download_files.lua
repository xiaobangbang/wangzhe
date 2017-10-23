require "socket"
require("TSLib")

function funct1(...)
	-- body
	local i = 1
	while (true) do
		-- body
		i = i +1
		nLog("func1"..tostring(i))
		mSleep(1000)
		if getRandomNum() %2 == 0 then
			nLog ("coroutine.yield (func1)")
			mSleep(1000)
			coroutine.yield("func1")
		end
		nLog("return 1true")
	end

end

function funct2(...)
	-- body
	local i = 1
	while (true) do
		-- body
		i = i +1
		nLog("func2"..tostring(i))
		mSleep(1000)
		if getRandomNum() %3 == 0 then
			nLog ("coroutine.yield (func2)")
			mSleep(1000)
			coroutine.yield("func2")
		end
		nLog("return 2true")
	end
end

function funct3(...)
	-- body
	local i = 1
	while (true) do
		-- body
		i = i +1
		nLog("func3"..tostring(i))
		mSleep(1000)
		if getRandomNum() %5 == 0 then
			nLog ("coroutine.yield (func3)")
			mSleep(1000)
			coroutine.yield("func3")
		end
		nLog("return 3true")
	end
end


function funct4(...)
	-- body
	local i = 1
	while (true) do
		-- body
		i = i +1
		nLog("func4"..tostring(i))
		mSleep(1000)
		if getRandomNum() %6 == 0 then
			nLog ("coroutine.yield (func4)")
			mSleep(1000)
			coroutine.yield("func4")
		end
		nLog("return 4true")
	end
end

function getRandomNum(...)	
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	local var1 = math.random(1,100) 		
	return var1
end

--f1 = assert( load(" dialog2('sdfsd',2)"))
--f1 = load(" dialog2('sdfsd',2)")

--f1()

threads = {}

function setExeFunc (func_name)
	
		local co = coroutine.create(
			function()
				f1 = load("return "..func_name.."()")
				f1()
			end
		)
		table.insert(threads,co)	
end

function dispatch()
	local i = 1
	while true do
		if i>4 then i  =1 end
		mSleep(1000)
		local retfunc,abc = coroutine.resume( threads[i])
		nLog("return from yeild:"..tostring(retfunc)..abc)
		i = i + 1
	end
	dialog("end dispatch",20)
end

--host ="http://localhost"

host ="www.w3help.org"
--get (host,"/tomcat-9.0-doc/index.html")

setExeFunc ("funct1")

--get (host,"/tomcat-9.0-doc/security-manager-howto.html")

setExeFunc ("funct2")

--get (host,"/tomcat-9.0-doc/introduction.html")
setExeFunc ("funct3")

setExeFunc ("funct4")

--get (host,"/zh-cn/home/glossary.html")

dispatch()



