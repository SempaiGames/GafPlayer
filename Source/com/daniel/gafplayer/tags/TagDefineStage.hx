package com.daniel.gafplayer.tags;

import openfl.utils.ByteArray;

class TagDefineStage extends Tag {

	var fps : Int;
	var color : Int;
	var width : Int;
	var height : Int;

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
