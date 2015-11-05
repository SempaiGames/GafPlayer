package com.sempaigames.gafplayer.tags;

import openfl.utils.ByteArray;
import openfl.utils.Endian;

class TagDefineStage extends Tag {

	public var fps : Int;
	public var color : Int;
	public var width : Int;
	public var height : Int;

	public function new (data : ByteArray) {
		super();
		this.id = TagId.TagDefineStage;
		data.endian = Endian.LITTLE_ENDIAN;
		fps = data.readUnsignedByte();
		color = data.readUnsignedInt();	// RGBA
		width = data.readUnsignedShort();
		height = data.readUnsignedShort();
	}

	override public function toString () {
		return "TagDefineStage";
	}

}
