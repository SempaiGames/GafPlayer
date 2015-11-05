package com.sempaigames.gafplayer.tags;

import openfl.utils.ByteArray;
import openfl.utils.Endian;

class TagDefineAnimationFrames extends Tag {

	public function new () {
		super();
		this.id = TagId.TagDefineAnimationFrames;
		this.endian = Endian.LITTLE_ENDIAN;
	}

}
