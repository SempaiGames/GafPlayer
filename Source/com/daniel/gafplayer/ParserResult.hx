package com.daniel.gafplayer;

import com.daniel.gafplayer.header.Header;
import com.daniel.gafplayer.tags.Tag;
import com.daniel.gafplayer.tags.TagDefineAnimationFrames2;
import com.daniel.gafplayer.tags.TagDefineAnimationObjects;
import com.daniel.gafplayer.tags.TagDefineAtlas;
import com.daniel.gafplayer.tags.TagDefineStage;

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

	public function getAtlas () : com.daniel.gafplayer.Atlas {
		for (t in tagsList()) {
			if (Std.is(t, TagDefineAtlas)) {
				return new com.daniel.gafplayer.Atlas(cast(t, TagDefineAtlas));
			}
		}
		return null;
	}

	public function getAnimationFrames () : TagDefineAnimationFrames2 {
		for (t in tagsList()) {
			if (Std.is(t, TagDefineAnimationFrames2)) {
				return cast(t, TagDefineAnimationFrames2);
			}
		}
		return null;
	}

	public function getAnimationObjects () : TagDefineAnimationObjects {
		for (t in tagsList()) {
			if (Std.is(t, TagDefineAnimationObjects)) {
				return cast(t, TagDefineAnimationObjects);
			}
		}
		return null;
	}

	public function getStageData () : TagDefineStage {
		for (t in tagsList()) {
			if (Std.is(t, TagDefineStage)) {
				return cast(t, TagDefineStage);
			}
		}
		return null;
	}

}
