package com.daniel.gafplayer.tags;

import openfl.utils.ByteArray;
import openfl.utils.Endian;

class AnimationObject {

	public var id : Int;
	public var atlasIdRef : Int;
	public var type : Int;

	public function new () {}

}

class TagDefineAnimationObjects extends Tag {

	public var objectsCount : Int;
	public var objects : Array<AnimationObject>;

	public function new (data : ByteArray) {
		super();
		this.id = TagId.TagDefineAnimationObjects;
		data.endian = Endian.LITTLE_ENDIAN;
		objectsCount = data.readUnsignedInt();
		objects = [];
		for (i in 0...objectsCount) {
			var obj = new AnimationObject();
			obj.id = data.readUnsignedInt();
			obj.atlasIdRef = data.readUnsignedInt();
			// TODO: if version>=4
			obj.type = data.readUnsignedShort();
			objects.push(obj);
		}
	}

	override public function toString () {
		return "TagDefineAnimationObjects";
	}

}
