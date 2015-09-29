package com.daniel.gafplayer;

import com.daniel.gafplayer.header.HeaderParser;
import com.daniel.gafplayer.tags.Tag;
import com.daniel.gafplayer.tags.TagId;
import com.daniel.gafplayer.tags.TagParser;
import openfl.Assets;
import openfl.utils.ByteArray;

class Parser {
	
	public static function parse (inStream : ByteArray) {
		var h = HeaderParser.parse(inStream);
		var tagsData = [];
		var tag : Tag;
		do {
			tag = TagParser.readTag(h.body);
			tagsData.push(tag);
		} while (tag.id != TagId.TagEnd);
	}

	public static function loadFromFile (path : String) {
		var bytes = Assets.getBytes(path);
		parse(bytes);
	}

}
