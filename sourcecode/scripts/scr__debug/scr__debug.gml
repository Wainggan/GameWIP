#macro DEBUG_THINGS true
global.debug = true;
#macro DEBUG_LOG_FILE "log.txt"
#macro LOG_WARNING 1
#macro LOG_ERROR 2

function Logger(_filename) constructor {
	filename = _filename;
	// 0 = log, 1 = warning, 2 = error, 3 = off
	priority = 0
	file = file_text_open_append(filename)
	
	log = function(_input, _priority = 0) {
		if priority <= _priority || _priority == -1 {
			//var file = file_text_open_append(filename)
			file_text_write_string(file, (_priority != -1 ? (_priority == 0 ? "Log - " : (_priority == 1 ? "Warning - " : "Error - ")) : "") + _input)
			file_text_writeln(file)
			//file_text_close(file)
		}
	}
	
	newline = function(){
		var file = file_text_open_append(filename)
		file_text_writeln(file)
		file_text_close(file)
	}
	
	priority_set = function(_pr){
		priority = _pr
	}
	
}

///@func log(str, num = 0)
function log(_str, _priority = 0) {
	global.logger.log(_str, _priority)
}
function log_newline() {
	global.logger.newline()
}


if file_exists(DEBUG_LOG_FILE) {
	file_delete(DEBUG_LOG_FILE)
}
global.logger = new Logger(DEBUG_LOG_FILE)
log("Logger initialized")

///@func print(...)
function print() {
	var r = string(argument[0]), i;
	for (i = 1; i < argument_count; i++) {
	    r += ", " + string(argument[i])
	}
	show_debug_message(r)
}


if DEBUG_THINGS exception_unhandled_handler(function(ex){
	log_newline()
	log("-------------", -1)
	log(string(ex.message), LOG_ERROR)
	log(string(ex.longMessage), -1)
	log("Script: " + string(ex.script), -1)
	log("Line " + string(ex.line), -1)
	log(string(ex.stacktrace), -1)
	
	file_text_close(global.logger.file)
	
	show_message("The game crashed! \n" + ex.longMessage + "\nCheck the debug log for more info. You can find it here: \n" + filename_path(DEBUG_LOG_FILE) )
	
	return 0
})
