--引入中控库
local ts_enterprise_lib = require("ts_enterprise_lib")
assert(ts_enterprise_lib,"无法引入企业专用库")
--[[
请注意注入代码的安全,不安全的代码会导致中控器崩溃
--]]
local ok,msg = ts_enterprise_lib:controller_injection(
[[    
    local f = io.open("data/test.txt", "wb")
    if f then
        f:write("1234567890\r\n")
        f:close()
    end
]]
)
assert(ok,msg)
nLog("注入中控器运行代码成功!")
--[[
    简单的发账号示例
    script/account.txt内保存账号密码
--]]
local ok,account = ts_enterprise_lib:controller_injection(
[[
    local f = io.open("data/game_acct3.txt", "r")
    if f then
        local account_tab = {} 
        local account = f:read()
        while account do 
            table.insert(account_tab,account) 
            account = f:read() 
        end
        f:close()
        if #account_tab > 0 then
            local f = io.open("data/account.txt", "w")
            if f then
                for i = 2,#account_tab do
                    f:write(account_tab[i].."\n")
                end
                f:close()
            end
            return account_tab[1]
        else
            return false
        end     
    end
    return false
]]
)
assert(ok,account)
if account then
    nLog("获取账号:"..account)
    toast("获取账号:"..account)
else
    nLog("获取账号失败")
    toast("获取账号失败")
end
mSleep(1000)