package com.daniel.gafplayer;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;

class Utils {

	public static function readRect(b : ByteArray) {
		return new Rectangle(
			b.readFloat(),
			b.readFloat(),
			b.readFloat(),
			b.readFloat()
		);
	}

	public static function readPoint (b : ByteArray) {
		return new Point(b.readFloat(), b.readFloat());
	}

	public static function readString (b : ByteArray) {
		var ret = "";
		var len = b.readUnsignedShort();
		for (i in 0...len) {
			ret += String.fromCharCode(b.readUnsignedByte());
		}
		return ret;
	}

}
