if ngx.var.real_ip ~= "127.0.0.1" and ngx.shared.ip_blacklist:get(ngx.var.real_ip) then
 return ngx.exit(ngx.HTTP_FORBIDDEN);
end
