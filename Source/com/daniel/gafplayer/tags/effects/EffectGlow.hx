package com.daniel.gafplayer.tags.effects;

import com.daniel.gafplayer.tags.effects.Effect;
import openfl.utils.ByteArray;

class EffectGlow extends Effect {

	var color : Int;
	var blurX : Float;
	var blurY : Float;
	var strength : Float;
	var inner : Bool;
	var knockout : Bool;

	public function new (data : ByteArray) {
		super(EffectType.EffectGlow);
		color = data.readUnsignedInt();
		blurX = data.readFloat();
		blurY = data.readFloat();
		strength = data.readFloat();
		inner = data.readUnsignedByte()!=0;
		knockout = data.readUnsignedByte()!=0;
	}

}
