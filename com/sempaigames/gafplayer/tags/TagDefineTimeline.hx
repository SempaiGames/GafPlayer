package com.sempaigames.gafplayer.tags;

import com.sempaigames.gafplayer.Utils;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

class TagDefineTimeline extends Tag {

	public var frameSize : Rectangle;
	public var linkageName : String;
	public var pivot : Point;
	public var tags : Array<Tag>;

	public function new(data : ByteArray) {
		super();
		this.id = TagId.TagDefineTimeline;
		this.tags = [];
		data.endian = Endian.LITTLE_ENDIAN;
		data.readInt();
		data.readInt();
		frameSize = Utils.readRect(data);
		pivot = Utils.readPoint(data);
		var hasLinkage = data.readByte();
		if (hasLinkage!=0) {
			linkageName = Utils.readString(data);
		}
		var tag : Tag;
		do {
			tag = TagParser.readTag(data);
			tags.push(tag);
		} while (tag.id != TagId.TagEnd);
	}

	override public function getSubTags() : Array<Tag> {
		return tags.copy();
	}

	override public function toString () {
		return "TagDefineTimeline: " + tags;
	}

}
