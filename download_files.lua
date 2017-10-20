require "socket"


function download (host,file)
	local c = assert(socket.connect(host,80))
	local count = 0
	c:send("GET "..file.." Http/1.0\r\n\r\n")
	while true do
		local s, status, partial = receive(c)
		count = count+ #(s or partial)
		if status == "closed" then break end

	end
	c:close()
	print (file,count)
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

host ="www.w3.org"
get (host,"/TR/html401/html40.txt")

--get (host,"/test4.php")

--get (host,"/test.html")

--get (host,"/check_box.html")

dispatch()



