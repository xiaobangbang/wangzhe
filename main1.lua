init("com.tencent.smoba",1)
initLog("wangzhe_log", 1)

qq="3172507458"
pwd="1234567890"

mSleep(1000)
if  isFrontApp("com.tencent.smoba") == 0 then
	mSleep(200)
	runApp("com.tencent.smoba")
	mSleep(1000)
end