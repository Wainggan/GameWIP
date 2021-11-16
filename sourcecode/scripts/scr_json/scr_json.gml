function json_writeFrom(_filename, _tree) {
	var _string = json_stringify(_tree);
	var _buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _filename);
	buffer_delete(_buffer);
}

function json_readFrom(_filename) {
	if file_exists(_filename) {
		var _buffer = buffer_load(_filename);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		var _loadData = json_parse(_string);
		
		return _loadData
		
	} else {
		return undefined;
	}
}