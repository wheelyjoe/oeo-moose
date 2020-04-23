
-- SPDX-License-Identifier: LGPL-3.0

local utils = {}

function utils.foreach(ctx, itr, fcn, array, ...)
	for k, v in itr(array) do
		fcn(ctx, k, v, unpack({select(1, ...)}))
	end
end

function utils.shallowclone(obj)
	local obj_type = type(obj)
	local copy

	if obj_type == 'table' then
		copy = {}
		for k,v in pairs(obj) do
			copy[k] = v
		end
	else
		copy = obj
	end
	return copy
end

function utils.deepcopy(obj)
	local obj_type = type(obj)
	local copy

	if obj_type == 'table' then
		copy = {}
		for k,v in next, obj, nil do
			copy[k] = utils.deepcopy(v)
		end
	else
		copy = obj
	end
	return copy
end

function utils.mergetables(dest, source)
	assert(type(dest) == "table", "dest must be a table")
	for k, v in pairs(source or {}) do
		dest[k] = v
	end
	return dest
end

function utils.readlua(file, tblname)
	assert(file and type(file) == "string", "file path must be provided")
	assert(tblname and type(tblname) == "string", "tblname must be provided")
	assert(lfs.attributes(file) ~= nil, "file does not exist: "..file)
	assert(pcall(dofile, file), "failed to parse: "..file)
	assert(_G[tblname] ~= nil, string.format("parsing of '%s' didn't "..
		"contain expected symbol '%s'", file, tblname))
	local data = _G[tblname]
	_G[tblname] = nil
	return data
end

-- return the directory seperator used for the given OS
utils.sep = package.config:sub(1,1)

return utils
