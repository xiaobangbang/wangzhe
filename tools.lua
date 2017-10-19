local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] =M
setmetatable(M,{__index=_G})
--setfenv(1,M)

function trim1(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function split(input, delimiter)
	--print("string.split(input, delimiter)")
	nLog("tools.split")
	input = tostring(input)
	delimiter = tostring(delimiter)
	if (delimiter=='') then return false end
	local pos,arr = 0, {}
	-- for each divider found
	for st,sp in function() return string.find(input, delimiter, pos, true) end do
		table.insert(arr, string.sub(input, pos, st - 1))
		pos = sp + 1
	end
	table.insert(arr, string.sub(input, pos))
	return arr
end

function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end


function fetch_v ( t,k )
	local v
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
						if pos==k then
							v = val
							break
						end
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
						if pos==k then
							v = tostring(val)
							break
						end
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
	return v
end

TAB_ENV2={
	DEBUG_MODE =true,
	LUA_VERSION="XXT",
	SCRIPT_VERSION = "1.3.0",
--选区
	STUDIO_PARA_DAQU= 25,

--换线
	STUDIO_PARA_LINE = 4,

--交易坐标
	STUDIO_PARA_XY = "367 440",


	STUDIO_PARA_JUE_SE = 1,

--备用，买药间隔，调节买药速度,单位秒
	STUDIO_PARA_BUY_TIME =1,

--画面静止检测的时间间隔--单位秒
	STANDING_SECONDS= 5
}

function gettable_value(...)
	return #TAB_ENV
end
