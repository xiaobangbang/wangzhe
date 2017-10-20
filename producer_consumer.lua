function receive(prod) 
	print("before receive(prod) ")
	local status, value = coroutine.resume(prod)
	print("after receive(prod) ")
	return value
end

function send(x)
	coroutine.yield(x)
end

function producer()
	return coroutine.create(
		function()
			while true do
				local x = io.read()
				send(x)
			end
		end
		)	
end	

function filter (prod)
	print("function filter (prod)")
	return coroutine.create(
		function() 
			for line = 1, math.huge do
				print ("before local x = receive(prod)")
				local x = receive(prod)
				x = string.format("%5d %s",line,x)
				print ("filter:"..x)
			end
		end)
end

function consumer (prod) 
	while  true do
		print("before receive")
		local x = receive(prod)
		--io.write(x,"\n")
		--print ("receive "..x)
	end
end

p = producer()
f =filter(p)
consumer(f)
