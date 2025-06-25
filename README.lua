-------------------------------------------------------------------------------

--! json library

--! cryptography library

local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;

local lEncode, lDecode, lDigest = a3, aw, Z;

-------------------------------------------------------------------------------



-------------------------------------------------------------------------------

--! platoboost library



--! configuration

local service = 4484;  -- your service id, this is used to identify your service.

local secret = "8b86bb16-a2d5-46ef-9e17-e3fe2f7e89db";  -- make sure to obfuscate this if you want to ensure security.

local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.



--! callbacks

local onMessage = function(message) end;



--! wait for game to load

repeat task.wait(1) until game:IsLoaded();



--! functions

local requestSending = false;

local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end

local cachedLink, cachedTime = "", 0;



--! pick host

local host = "https://api.platoboost.com";

local hostResponse = fRequest({

    Url = host .. "/public/connectivity",

    Method = "GET"

});

if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then

    host = "https://api.platoboost.net";

end



--!optimize 2

function cacheLink()

    if cachedTime + (10*60) < fOsTime() then

        local response = fRequest({

            Url = host .. "/public/start",

            Method = "POST",

            Body = lEncode({

                service = service,

                identifier = lDigest(fGetHwid())

            }),

            Headers = {

                ["Content-Type"] = "application/json"

            }

        });



        if response.StatusCode == 200 then

            local decoded = lDecode(response.Body);



            if decoded.success == true then

                cachedLink = decoded.data.url;

                cachedTime = fOsTime();

                return true, cachedLink;

            else

                onMessage(decoded.message);

                return false, decoded.message;

            end

        elseif response.StatusCode == 429 then

            local msg = "you are being rate limited, please wait 20 seconds and try again.";

            onMessage(msg);

            return false, msg;

        end



        local msg = "Failed to cache link.";

        onMessage(msg);

        return false, msg;

    else

        return true, cachedLink;

    end

end



cacheLink();



--!optimize 2

local generateNonce = function()

    local str = ""

    for _ = 1, 16 do

        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)

    end

    return str

end



--!optimize 1

for _ = 1, 5 do

    local oNonce = generateNonce();

    task.wait(0.2)

    if generateNonce() == oNonce then

        local msg = "platoboost nonce error.";

        onMessage(msg);

        error(msg);

    end

end



--!optimize 2

local copyLink = function()

    local success, link = cacheLink();

    

    if success then

        fSetClipboard(link);

    end

end



--!optimize 2

local redeemKey = function(key)

    local nonce = generateNonce();

    local endpoint = host .. "/public/redeem/" .. fToString(service);



    local body = {

        identifier = lDigest(fGetHwid()),

        key = key

    }



    if useNonce then

        body.nonce = nonce;

    end



    local response = fRequest({

        Url = endpoint,

        Method = "POST",

        Body = lEncode(body),

        Headers = {

            ["Content-Type"] = "application/json"

        }

    });



    if response.StatusCode == 200 then

        local decoded = lDecode(response.Body);



        if decoded.success == true then

            if decoded.data.valid == true then

                if useNonce then

                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then

                        return true;

                    else

                        onMessage("failed to verify integrity.");

                        return false;

                    end    

                else

                    return true;

                end

            else

                onMessage("key is invalid.");

                return false;

            end

        else

            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then

                onMessage("you already have an active key, please wait for it to expire before redeeming it.");

                return false;

            else

                onMessage(decoded.message);

                return false;

            end

        end

    elseif response.StatusCode == 429 then

        onMessage("you are being rate limited, please wait 20 seconds and try again.");

        return false;

    else

        onMessage("server returned an invalid status code, please try again later.");

        return false; 

    end

end



--!optimize 2

local verifyKey = function(key)

    if requestSending == true then

        onMessage("a request is already being sent, please slow down.");

        return false;

    else

        requestSending = true;

    end



    local nonce = generateNonce();

    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;



    if useNonce then

        endpoint = endpoint .. "&nonce=" .. nonce;

    end



    local response = fRequest({

        Url = endpoint,

        Method = "GET",

    });



    requestSending = false;



    if response.StatusCode == 200 then

        local decoded = lDecode(response.Body);



        if decoded.success == true then

            if decoded.data.valid == true then

                if useNonce then

                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then

                        return true;

                    else

                        onMessage("failed to verify integrity.");

                        return false;

                    end

                else

                    return true;

                end

            else

                if fStringSub(key, 1, 4) == "KEY_" then

                    return redeemKey(key);

                else

                    onMessage("key is invalid.");

                    return false;

                end

            end

        else

            onMessage(decoded.message);

            return false;

        end

    elseif response.StatusCode == 429 then

        onMessage("you are being rate limited, please wait 20 seconds and try again.");

        return false;

    else

        onMessage("server returned an invalid status code, please try again later.");

        return false;

    end

end



--!optimize 2

local getFlag = function(name)

    local nonce = generateNonce();

    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;



    if useNonce then

        endpoint = endpoint .. "&nonce=" .. nonce;

    end



    local response = fRequest({

        Url = endpoint,

        Method = "GET",

    });



    if response.StatusCode == 200 then

        local decoded = lDecode(response.Body);



        if decoded.success == true then

            if useNonce then

                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then

                    return decoded.data.value;

                else

                    onMessage("failed to verify integrity.");

                    return nil;

                end

            else

                return decoded.data.value;

            end

        else

            onMessage(decoded.message);

            return nil;

        end

    else

        return nil;

    end

end

-------------------------------------------------------------------------------



-------------------------------------------------------------------------------

--! platoboost usage documentation
local keyFileName = "platokey.txt"

-- Tạo hàm lưu key vào file
local function saveKeyToFile(key)
    if writefile then
        writefile(keyFileName, key)
    end
end

-- Tạo hàm đọc key từ file
local function readKeyFromFile()
    if readfile and isfile and isfile(keyFileName) then
        return readfile(keyFileName)
    end
    return ""
end
-- copyLink() -> string

-- verifyKey(key: string) -> boolean

-- getFlag(name: string) -> boolean, string | boolean | number



-- use copyLink() to copy a link to the clipboard, in which the user will paste it into their browser and complete the keysystem.

-- use verifyKey(key) to verify a key, this will return a boolean value, true means the key was valid, false means it is invalid.

-- use getFlag(name) to get a flag from the server, this will return nil if an error occurs, if no error occurs, the value configured in the platoboost dashboard will be returned.



-- IMPORTANT: onMessage is a callback, it will be called upon status update, use it to provide information to user.

-- EXAMPLE: 

--[[

onMessage = function(message)

    game:GetService("StarterGui"):SetCore("SendNotification", {

        Title = "Platoboost status",

        Text = message

    })

end

]]--



-- NOTE: PLACE THIS ENTIRE SCRIPT AT THE TOP OF YOUR SCRIPT, ADD THE LOGIC, THEN OBFUSCATE YOUR SCRIPT.



--! example usage

--[[

copyButton.MouseButton1Click:Connect(function()

    copyLink();

end)



verifyButton.MouseButton1Click:Connect(function()

    local key = keyBox.Text;

    local success = verifyKey(key);



    if success then

        print("key is valid.");

    else

        print("key is invalid.");

    end

end)



local flag = getFlag("example_flag");

if flag ~= nil then

    print("flag value: " .. flag);

else

    print("failed to get flag.");

end

]]--

-------------------------------------------------------------------------------
--! GUI Đơn Giản Cho GetKey Platoboost
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
gui.Name = "PlatoboostKeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "🔑 Enter key to continue"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)

local keyBox = Instance.new("TextBox", frame)
-- Tự động điền lại key đã lưu nếu có
local savedKey = readKeyFromFile()
if savedKey ~= "" then
    keyBox.Text = savedKey
end
keyBox.PlaceholderText = "Paste the key here"
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.Position = UDim2.new(0.1, 0, 0, 50)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", keyBox)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Text = "get key"
copyBtn.Size = UDim2.new(0.8, 0, 0, 30)
copyBtn.Position = UDim2.new(0.1, 0, 0, 90)
copyBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", copyBtn)

local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Text = "✅verify "
verifyBtn.Size = UDim2.new(0.8, 0, 0, 30)
verifyBtn.Position = UDim2.new(0.1, 0, 0, 130)
verifyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 14
verifyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", verifyBtn)

--! Callback hiển thị thông báo
onMessage = function(message)
    StarterGui:SetCore("SendNotification", {
        Title = "Platoboost",
        Text = message,
        Duration = 4
    })
end

--! Bấm "Lấy Key"
copyBtn.MouseButton1Click:Connect(function()
    copyLink()
    onMessage("📋 copied the key")
end)

--! Bấm "Xác minh"
verifyBtn.MouseButton1Click:Connect(function()
    local inputKey = keyBox.Text
    local success = verifyKey(inputKey)

    if success then
        onMessage("✅ fine")
        gui:Destroy()

        --! CHẠY GUI RAYFIELD SAU KHI ĐÚNG KEY
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Rayfield Example Window",
           Icon = 0, -- Có thể thay số ID ảnh nếu cần
           LoadingTitle = "Rayfield Interface Suite",
           LoadingSubtitle = "by Sirius",
           ShowText = "Rayfield",
           Theme = "Default", -- Hoặc: "Dark", "Abyss", v.v

           ToggleUIKeybind = "K",

           DisableRayfieldPrompts = false,
           DisableBuildWarnings = false,

           ConfigurationSaving = {
              Enabled = true,
              FolderName = nil,
              FileName = "Big Hub"
           },

           Discord = {
              Enabled = false,
              Invite = "noinvitelink",
              RememberJoins = true
           },

           KeySystem = false -- Quan trọng: không dùng key của Rayfield nữa!
        })

        -- Tabs
        local TabPlayer = Window:CreateTab("player", 4483362458)
        
        --button and note
        Rayfield:Notify({
   Title = "introduce",
   Content = "the keys will not save, because of it you will waste precious seconds, sorry that code can not create file or maybe, thanks for reading",
   Duration = 6.5,
   Image = 4483362458,
})
        Rayfield:Notify({
   Title = "my name",
   Content = "my name is phuoc, form vietnam",
   Duration = 6.5,
   Image = 12278516070,
})
        local Button = TabPlayer:CreateButton({
   Name = "AIMBOT",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/phuoc389/Aimbotnpc/fc019fe861d9581acc9e951d431751b27ddbe88c/aimbotplayer.lua"))()
   end,
})
        --esp
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.ESPPlayerEnabled = true
local UseTeamColor = true
local FriendColor = Color3.fromRGB(0, 255, 255)
local EnemyColor = Color3.fromRGB(255, 0, 0)

-- 🔘 Toggle GUI (gắn vào TabPlayer trong Rayfield GUI)
Callback = function(Value)
	_G.ESPPlayerEnabled = Value
	warn("ESP Player: " .. (Value and "BẬT ✅" or "TẮT ❌"))

	-- Khi TẮT thì xóa Highlight còn lại
	if not Value then
		for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
			if plr.Character and plr.Character:FindFirstChild("Highlight") then
				plr.Character.Highlight:Destroy()
			end
		end
	end
end
		_G.ESPPlayerEnabled = Value
		warn("ESP Player: " .. (Value and "BẬT ✅" or "TẮT ❌"))
	end,
})

-- ⚙️ Hàm vẽ ESP cho từng player
local function ApplyESP(player)
	if player == LocalPlayer then return end

	-- Highlight
	local function CreateHighlight(char)
		if char:FindFirstChild("Highlight") then return end
		local hl = Instance.new("Highlight", char)
		hl.Name = "Highlight"
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.FillTransparency = 0.5
		hl.OutlineTransparency = 0
		hl.Adornee = char

		if UseTeamColor and player.Team ~= nil then
			hl.FillColor = player.TeamColor.Color
		else
			hl.FillColor = EnemyColor
		end
	end

	-- Drawing
	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Filled = false
	box.Color = Color3.fromRGB(255,255,255)

	local nameText = Drawing.new("Text")
	nameText.Size = 13
	nameText.Center = true
	nameText.Outline = true
	nameText.Color = Color3.fromRGB(255,255,255)

	local distanceText = Drawing.new("Text")
	distanceText.Size = 12
	distanceText.Center = true
	distanceText.Outline = true
	distanceText.Color = Color3.fromRGB(0,255,255)

	local healthBar = Drawing.new("Square")
	healthBar.Filled = true
	healthBar.Color = Color3.fromRGB(0,255,0)

	local healthText = Drawing.new("Text")
	healthText.Size = 12
	healthText.Center = true
	healthText.Outline = true
	healthText.Color = Color3.fromRGB(0,255,0)

	RunService.RenderStepped:Connect(function()
		if not _G.ESPPlayerEnabled then
			box.Visible = false
			nameText.Visible = false
			distanceText.Visible = false
			healthBar.Visible = false
			healthText.Visible = false
			return
		end

		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") then
			box.Visible = false
			nameText.Visible = false
			distanceText.Visible = false
			healthBar.Visible = false
			healthText.Visible = false
			return
		end

		CreateHighlight(player.Character)

		local hrp = player.Character:FindFirstChild("HumanoidRootPart")
		local hum = player.Character:FindFirstChild("Humanoid")
		local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

		if onScreen then
			local size = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.6, 0)).Y) / 2
			local boxSize = Vector2.new(math.floor(size * 1.5), math.floor(size * 2.5))
			local boxPos = Vector2.new(math.floor(pos.X - boxSize.X / 2), math.floor(pos.Y - boxSize.Y / 2))

			box.Size = boxSize
			box.Position = boxPos
			box.Visible = true

			nameText.Text = player.Name
			nameText.Position = Vector2.new(pos.X, boxPos.Y - 14)
			nameText.Visible = true

			local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
			distanceText.Text = dist .. " studs"
			distanceText.Position = Vector2.new(pos.X, boxPos.Y + boxSize.Y + 2)
			distanceText.Visible = true

			local hp = hum.Health
			local maxhp = hum.MaxHealth
			local percent = math.clamp(hp / maxhp, 0, 1)
			local barH = boxSize.Y * percent

			healthBar.Size = Vector2.new(3, barH)
			healthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + (boxSize.Y - barH))
			healthBar.Color = Color3.fromRGB(255 - percent*255, percent*255, 0)
			healthBar.Visible = true

			healthText.Text = math.floor(percent * 100) .. "%"
			healthText.Position = Vector2.new(boxPos.X - 20, boxPos.Y + boxSize.Y / 2)
			healthText.Visible = true
		else
			box.Visible = false
			nameText.Visible = false
			distanceText.Visible = false
			healthBar.Visible = false
			healthText.Visible = false
		end
	end)
end

-- Tạo ESP cho người chơi hiện tại
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(function()
		ApplyESP(player)
	end)
end

-- Tạo ESP cho người chơi mới vào
Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		ApplyESP(player)
	end)
end)
        --idk
        local Button = TabPlayer:CreateButton({
   Name = "IY(may be subject to banners)",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
        local Button = TabPlayer:CreateButton({
   Name = "aimbot npc",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/phuoc389/Aimbotnpc/657bd8ae07bea243619407283d5589407bdd92ae/AimbotNpc.lua"))()
   end,
})
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Biến lưu tốc độ nhập
local customSpeed = 16
local isSpeedEnabled = false

-- ⚙️ Ô Nhập Tốc Độ
local Input = TabPlayer:CreateInput({
    Name = "(Speed) Some games will have anti-speed files :(",
    CurrentValue = "16", -- Giá trị mặc định
    PlaceholderText = "ENTER (1234)",
    RemoveTextAfterFocusLost = false,
    Flag = "SpeedInput",
    Callback = function(Text)
        local Speed = tonumber(Text)
        if Speed then
            customSpeed = Speed
            if isSpeedEnabled then
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = customSpeed
                    print("SET SPEED TO: " .. customSpeed)
                end
            end
        else
            warn("WHAT THE FUCK, WHAT IS THIS🤡🤯")
        end
    end,
})

-- 🔘 Nút Bật/Tắt Speed Hack
local Toggle = TabPlayer:CreateToggle({
    Name = "Bật/Tắt Speed Hack",
    CurrentValue = false,
    Flag = "ToggleSpeedHack",
    Callback = function(Value)
        isSpeedEnabled = Value
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            if isSpeedEnabled then
                humanoid.WalkSpeed = customSpeed
                print("SPEED ON - WalkSpeed: " .. customSpeed)
            else
                humanoid.WalkSpeed = 16 -- reset về mặc định
                print("SPEED OFF - Reset to default")
            end
        end
    end,
})
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclipConnection
local noclipEnabled = false

local Toggle = TabPlayer:CreateToggle({
   Name = "maybe anti noclip:( (NoClip)",
   CurrentValue = false,
   Flag = "ToggleNoClip",
   Callback = function(Value)
      noclipEnabled = Value
      
      -- Ngắt kết nối nếu đã có
      if noclipConnection then
         noclipConnection:Disconnect()
         noclipConnection = nil
      end

      if noclipEnabled then
         noclipConnection = RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
               for _, part in pairs(character:GetDescendants()) do
                  if part:IsA("BasePart") and part.CanCollide == true then
                     part.CanCollide = false
                  end
               end
            end
         end)
         print("turned on NoClip")
      else
         -- Khôi phục CanCollide khi tắt
         local character = LocalPlayer.Character
         if character then
            for _, part in pairs(character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = true
               end
            end
         end
         print("turned off NoClip")
      end
   end,
})
        --esp npc
        local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tạo Toggle ESP NPC
local Toggle = TabPlayer:CreateToggle({
	Name = "ESP NPC",
	CurrentValue = false,
	Flag = "Toggle_ESPNPC",
	Callback = function(Value)
		_G.ESPNPCEnabled = Value

		local NPCColor = Color3.fromRGB(255, 200, 0)

		local function ApplyESPNPC(npc)
			if not npc:IsA("Model") or Players:GetPlayerFromCharacter(npc) then return end
			if not npc:FindFirstChild("Humanoid") or not npc:FindFirstChild("HumanoidRootPart") then return end

			local box = Drawing.new("Square")
			box.Thickness = 1
			box.Filled = false
			box.Color = NPCColor

			local nameText = Drawing.new("Text")
			nameText.Size = 13
			nameText.Center = true
			nameText.Outline = true
			nameText.Color = NPCColor
			nameText.Text = npc.Name

			local healthBar = Drawing.new("Square")
			healthBar.Filled = true
			healthBar.Color = Color3.fromRGB(0,255,0)

			local healthText = Drawing.new("Text")
			healthText.Size = 12
			healthText.Center = true
			healthText.Outline = true
			healthText.Color = Color3.fromRGB(0,255,0)

			RunService.RenderStepped:Connect(function()
				if not _G.ESPNPCEnabled or not npc or not npc.Parent or not npc:FindFirstChild("HumanoidRootPart") then
					box.Visible = false
					nameText.Visible = false
					healthBar.Visible = false
					healthText.Visible = false
					return
				end

				local hrp = npc.HumanoidRootPart
				local hum = npc.Humanoid
				local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

				if onScreen then
					local size = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.6, 0)).Y) / 2
					local boxSize = Vector2.new(math.floor(size * 1.5), math.floor(size * 2.5))
					local boxPos = Vector2.new(math.floor(pos.X - boxSize.X / 2), math.floor(pos.Y - boxSize.Y / 2))

					box.Size = boxSize
					box.Position = boxPos
					box.Visible = true

					nameText.Position = Vector2.new(pos.X, boxPos.Y - 14)
					nameText.Visible = true

					local hp = hum.Health
					local maxhp = hum.MaxHealth
					local percent = math.clamp(hp / maxhp, 0, 1)
					local barH = boxSize.Y * percent

					healthBar.Size = Vector2.new(3, barH)
					healthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + (boxSize.Y - barH))
					healthBar.Color = Color3.fromRGB(255 - percent * 255, percent * 255, 0)
					healthBar.Visible = true

					healthText.Text = math.floor(percent * 100) .. "%"
					healthText.Position = Vector2.new(boxPos.X - 20, boxPos.Y + boxSize.Y / 2)
					healthText.Visible = true
				else
					box.Visible = false
					nameText.Visible = false
					healthBar.Visible = false
					healthText.Visible = false
				end
			end)
		end

		if Value then
			for _, model in ipairs(workspace:GetDescendants()) do
				if model:IsA("Model") and model:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(model) then
					task.spawn(function()
						ApplyESPNPC(model)
					end)
				end
			end

			workspace.DescendantAdded:Connect(function(obj)
				if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
					task.spawn(function()
						ApplyESPNPC(obj)
					end)
				end
				if obj:IsA("HumanoidRootPart") and obj.Parent:IsA("Model") then
					local model = obj.Parent
					if model:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(model) then
						task.spawn(function()
							ApplyESPNPC(model)
						end)
					end
				end
			end)
		end
	end,
})
        --idk
        
    else
        onMessage("❌ IS NOT KEY!")
    end
end)
