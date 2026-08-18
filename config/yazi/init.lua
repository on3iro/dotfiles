-- Feed every directory yazi visits into zoxide's database, so paths
-- reached only via yazi navigation also show up in `z`/zoxide queries.
ps.sub("cd", function()
	local cwd = tostring(cx.active.current.cwd)
	ya.async(function()
		Command("zoxide"):arg("add"):arg(cwd):spawn()
	end)
end)
