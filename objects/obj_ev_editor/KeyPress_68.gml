var level = get_string("", "");
var splitter_pos = string_pos("|", level)

import_level(string_copy(level, 1, splitter_pos - 1), string_copy(level, splitter_pos + 1, string_length(level) - splitter_pos));