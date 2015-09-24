package com.daniel.gafplayer.tags;

import com.daniel.gafplayer.tags.TagId;
import openfl.utils.ByteArray;

typedef TagData = {
	var id : TagId;
	var length : Int;
	var data : ByteArray;
}

class TagParser {
	
	public static function readTagData (inStream : ByteArray) : TagData {
		var id : TagId = inStream.readUnsignedShort();
		var length = inStream.readUnsignedInt();
		var data = new ByteArray();
		inStream.readBytes(data, 0, length)
		return { id : id, length : length, data : data}
	}

}
