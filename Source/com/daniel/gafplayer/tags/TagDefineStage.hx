package com.daniel.gafplayer.tags;

import openfl.utils.ByteArray;

class TagDefineStage extends Tag {

	public var fps : Int;
	public var color : Int;
	public var width : Int;
	public var height : Int;

	public function new(data : ByteArray) {
		super();
		fps = data.readUnsignedByte();
		color = data.readUnsignedInt();	// RGBA
		width = data.readUnsignedShort();
		height = data.readUnsignedShort();
		/*
		trace("fps: " + fps);
		trace("color: " + color);
		trace("width: " + width);
		trace("height: " + height);
		*/
	}

	override public function toString () {
		return "TagDefineStage";
	}

}
