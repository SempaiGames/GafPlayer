package com.daniel.gafplayer.tags;

import openfl.utils.ByteArray;

class TagParser {
	
	public static function readTag (inStream : ByteArray) : Tag {
		var data = readTagData(inStream);
		return switch (data.id) {
			case TagId.TagEnd:				new TagEnd();
			case TagId.TagDefineStage:		new TagDefineStage(data.data);
			case TagId.TagDefineTimeline:	new TagDefineTimeline(data.data);
			case TagId.TagDefineAtlas:		new TagDefineAtlas(data.data);
			case TagId.TagDefineAnimationObjects:	new TagDefineAnimationObjects(data.data);
			default:	throw "Unimplemented: " + data.id;
		}
	}
	
	static function readTagData (inStream : ByteArray) : TagData {
		var id : TagId = TagId.fromInt(inStream.readUnsignedShort());
		trace("id: " + id);
		var length = inStream.readUnsignedInt();
		trace("id: " + id + " length: " + length);
		var data = new ByteArray();
		if (id!=TagId.TagEnd) {
			inStream.readBytes(data, 0, length);
		}
		return { id : id, length : length, data : data };
	}

}