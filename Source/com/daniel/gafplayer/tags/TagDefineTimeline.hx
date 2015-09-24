package com.daniel.gafplayer.tags;

import com.daniel.gafplayer.Utils;
import openfl.geom.Point;
import openfl.utils.ByteArray;

class TagDefineTimeline extends Tag {

	var framesCount : Int;

	public function new(data : ByteArray) {
		super();
		data.readUnsignedByte();
		//data.readUnsignedByte();
		//trace("id: " + data.readUnsignedInt());
		trace("framesCount " + data.readUnsignedInt());
		trace("bounds: " + Utils.readRect(data));
		trace("pivot: " + Utils.readPoint(data));
		trace("has linkage: " + data.readUnsignedByte());
		var tag : Tag;
		do {
			tag = TagParser.readTag(data);
			trace("asdas: " + tag.toString());
		} while (tag.toString()!="TagEnd");
	}

	override public function toString () {
		return "TagDefineTimeline";
	}

}
