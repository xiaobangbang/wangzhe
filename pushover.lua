function pushover( request )
    local sz = require("sz")
    local json = sz.json
    local http = require("szocket.http")
    local pushover_url = "https://api.pushover.net/1/messages.json"
 
    local data_str = {}
    for k,v in pairs(request) do
        table.insert(data_str, tostring(k) .. "=" .. tostring(v))
    end
    data_str = table.concat(data_str, "&")
 
    local res, code = http.request(pushover_url, data_str)
    local back = json.decode(res)
    if (code ~= 200) then
        local errstr = "发送请求错误。错误代码: " .. tostring(code) .. ", 错误信息: " .. tostring(res)
        return false, errstr
    elseif (back.status ~= 1) then
        local errstr = "信息推送错误: " .. tostring(res)
        return false, errstr
    end
 
    return true
 
end
 
 
function pushmsg(v_title,v_msg)
	-- body
	local ret 
	local request = { token   = "a9d4iup6c49ccu6r8npi13tmp3f1sn",   
                  user    = "uamcehhid43xd7ijegghhpxec6tob7",                      
                  title   = v_title,
                  message = v_msg
                }
 
local success, err = pushover( request )
 
if (success) then
	ret = true
  toast("推送成功")
else
	ret = false
  toast("推送失败:\n" .. err)
end
return ret
end 
 
 
