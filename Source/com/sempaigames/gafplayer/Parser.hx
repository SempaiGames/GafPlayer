package com.sempaigames.gafplayer;

import com.sempaigames.gafplayer.header.HeaderParser;
import com.sempaigames.gafplayer.tags.Tag;
import com.sempaigames.gafplayer.tags.TagId;
import com.sempaigames.gafplayer.tags.TagParser;
import openfl.Assets;
import openfl.utils.ByteArray;

class Parser {

	public static var assetsPrefix : String = "";

	public static function parse (inStream : ByteArray) : ParserResult {
		var h = HeaderParser.parse(inStream);
		var tags = [];
		var tag : Tag;
		do {
			tag = TagParser.readTag(h.body);
			tags.push(tag);
		} while (tag.id != TagId.TagEnd);
		return new ParserResult(h.header, tags);
	}

	public static function loadFromFile (path : String) : ParserResult {
		var lastIndex = path.lastIndexOf("/");
		if (lastIndex>0) {
			assetsPrefix = path.substring(0, lastIndex+1);
		}
		var bytes = Assets.getBytes(path);
		return parse(bytes);
	}

}
