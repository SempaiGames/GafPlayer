package com.sempaigames.gafplayer.tags;

class Tag {

	public var id(default, null) : Int;

	public function new () {
		id = -1;
	}

	public function getSubTags() : Array<Tag> {
		return [];
	}

	public function toString () {
		return "Unknown";
	}

}
