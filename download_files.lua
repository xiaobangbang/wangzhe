require "socket"


function download22 (host,file)
	local c = assert(socket.connect(host,80))
	local count = 0
	c:send("GET "..file.." Http/1.0\r\n\r\n")
	while true do
		local s, status, partial = receive(c)
		dialog(status, 3)
		dialog(s, 3)
		
		count = count+ #(s or partial)
		if status == "closed" then break end

	end
	c:close()
	dialog (file,2)
	mSleep(3000)
	dialog (count,2)
end



function download (host,file)
	
	dialog (file,2)	
	
end


function receive(connection)
	connection:settimeout(0)
	local s,status,partial = connection:receive(2^10)
	if status == "timeout" then
		print ("timeout")
		coroutine.yield(connection)
	end
	return s or partial,status
end

threads = {}

function get (host,file)
	local co = coroutine.create(
	function()
		download(host,file)
	end
	)
	table.insert(threads,co)
end

function dispatch()
	local i = 1
	while true do
		if threads[i] == nil then
			if threads[1] == nil then break end
			i = 1
		end
		local status ,res = coroutine.resume( threads[i])
		if not res then
			--print(i)
			table.remove(threads,i)
		else
			i = i+1
			--print ("50 overtime"..i)
		end
	end
end

--host ="http://localhost"

host ="www.w3help.org"
get (host,"/tomcat-9.0-doc/index.html")

get (host,"/tomcat-9.0-doc/security-manager-howto.html")

get (host,"/tomcat-9.0-doc/introduction.html")

get (host,"/zh-cn/home/glossary.html")

dispatch()



