package com.sempaigames.gafplayer;

import com.sempaigames.gafplayer.header.Header;
import com.sempaigames.gafplayer.tags.Tag;
import com.sempaigames.gafplayer.tags.TagDefineAtlas;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;

class ParserResult {

	public var header : Header;
	public var tags : Array<Tag>;

	public function new (header : Header, tags : Array<Tag>) {

		this.header = header;
		this.tags = tags;

	}

	function tagsList () : Array<Tag> {
		var ret = [];
		for (t in tags) {
			ret.push(t);
			for (t2 in t.getSubTags()) {
				ret.push(t2);
			}
		}
		return ret;
	}

	public function getTagsByType<T> (type : Class<T>) : Array<T> {
		var ret = [];
		for (t in tagsList()) {
			if (Std.is(t, type)) {
				ret.push(cast(t));
			}
		}
		return ret;
	}

}
