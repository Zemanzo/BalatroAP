-- this saves a file (without compressing it -> debug purposes)
function save_file(_file, _data)
	NFS.write(_file, _data)
end

-- this loads a file (wihtout uncompressing it -> debug purposes)
function load_file(_file)
	local file_data = NFS.getInfo(_file)
	if file_data ~= nil then
		local file_string = NFS.read(_file)
		if file_string ~= "" then
			return file_string
		end
	end
end

-- debug

function copy_uncompressed(_file)
	local file_data = NFS.getInfo(_file)
	if file_data ~= nil then
		local file_string = NFS.read(_file)
		if file_string ~= "" then
			local success = nil
			success, file_string = pcall(love.data.decompress, "string", "deflate", file_string)
			NFS.write(_file .. ".txt", file_string)
		end
	end
end

function tableContains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end

table_contains = tableContains

---Gets a node from a structured UI table
---@param ui_table table
---@param target number[] index per 'nodes'. can be negative: will search from the last element
---@return nil | table
function util_get_ui_node(ui_table, target)
	local nodes = ui_table.nodes
	for i, value in ipairs(target) do
		local nodeIndex = value
		if value < 0 then
			nodeIndex = #nodes + value + 1
		end
		if nodes[nodeIndex] and nodes[nodeIndex].nodes then
			nodes = nodes[nodeIndex].nodes
		else
			print("Element not found, got to index " .. i)
			return nodes
		end
	end
	return nodes
end
