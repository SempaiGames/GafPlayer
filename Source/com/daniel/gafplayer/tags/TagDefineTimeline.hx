package com.daniel.gafplayer.tags;

import com.daniel.gafplayer.Utils;
import openfl.geom.Point;
import openfl.utils.ByteArray;

class TagDefineTimeline extends Tag {

	var frameSize : Point;
	var pivot : Point;

	public function new(data : ByteArray) {
		super();
		data.readUnsignedInt();
		data.readUnsignedInt();
		frameSize = Utils.readPoint(data);
		pivot = Utils.readPoint(data);
		var hasLinkage = data.readUnsignedByte();
		if (hasLinkage!=0) {
			var linkageName = Utils.readString(data);
		}
		trace("frameSize: " + frameSize);
		trace("pivot: " + pivot);
		trace("hasLinkage: " + hasLinkage);
	}

	override public function toString () {
		return "TagDefineTimeline";
	}

}
