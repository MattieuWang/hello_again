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


res, err, errcode, sqlstate = db:query("select ip from blacklist limit 1000;")
if not res then
	ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".")
	return
end

local ip_blacklist  = ngx.shared.ip_blacklist

ip_blacklist:flush_all();
for k, v in pairs(res) do
	for k1, v1 in pairs(v) do
		ip_blacklist:set(v1, true);
	end
end

ngx.say("blacklist in cache is updated")


local ok, err = db:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end
