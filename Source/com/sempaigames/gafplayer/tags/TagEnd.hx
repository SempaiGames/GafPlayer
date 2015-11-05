package com.sempaigames.gafplayer.tags;

class TagEnd extends Tag {

	public function new () {
		super();
		this.id = TagId.TagEnd;
	}

	override public function toString () {
		return "TagEnd";
	}

}
