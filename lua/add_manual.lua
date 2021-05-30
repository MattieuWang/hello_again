local mysql = require "resty.mysql"
local db, err = mysql:new()
if not db then
    ngx.say("failed to instantiate mysql: ", err)
    return
end

db:set_timeout(1000) -- 1 sec

local ok, err, errcode, sqlstate = db:connect{
    host = "127.0.0.1",
    port = 3306,
    database = "ip_database",
    user = "app",
    password = "app",
    charset = "utf8",
    max_packet_size = 1024 * 1024,
}

if not ok then
    ngx.say("failed to connect: ", err, ": ", errcode, " ", sqlstate)
    return
end

lunajson = require 'lunajson'

ngx.req.read_body()  -- explicitly read the req body
local data = ngx.req.get_body_data()
if data then
	local jsonparse = lunajson.decode( data )
	for key, ip in pairs(jsonparse) do
		res, err, errcode, sqlstate =
		    db:query("insert into blacklist (ip, is_munual) "
			     .. "values (\'" .. ip .. "\', 1)"
			     .. "ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;")
		if not res then
		    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".")
		    return
		end
	end
	ngx.say("successfully add " .. table.getn(jsonparse) .. " to the blacklist")
	return
end
ngx.say("no available data added")




