package com.sempaigames.gafplayer.tags.effects;

import openfl.utils.ByteArray;
import openfl.utils.Endian;

@:enum abstract EffectType (Int) from Int to Int {
	var EffectDropShadow = 0;
	var EffectBlur = 1;
	var EffectGlow = 2;
	var EffectColorMatrix = 6;
}

class Effect {
	
	public var type : EffectType;

	public function new (type : EffectType) {
		this.type = type;
	}

	public static function parse (data : ByteArray) {
		var type = data.readUnsignedByte();
		return switch (data.readUnsignedInt()) {
			case EffectType.EffectDropShadow:	new EffectDropShadow(data);
			case EffectType.EffectBlur:			new EffectBlur(data);
			case EffectType.EffectGlow:			new EffectGlow(data);
			case EffectType.EffectColorMatrix:	new EffectColorMatrix(data);
			default:	throw "Unknown effect: " + type;
		}
	}

}
