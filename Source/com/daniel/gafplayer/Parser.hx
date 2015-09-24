package com.daniel.gafplayer;

import com.daniel.gafplayer.header.HeaderParser;
import com.daniel.gafplayer.tags.TagParser;
import openfl.Assets;
import openfl.utils.ByteArray;

class Parser {
	
	public static function parse (inStream : ByteArray) {
		var header = HeaderParser.parse(inStream);
		Sys.println(header.toString());
		
	}

	public static function loadFromFile (path : String) {
		var bytes = Assets.getBytes(path);
		parse(bytes);
	}

}
