package com.daniel.gafplayer.tags.effects;

import com.daniel.gafplayer.tags.effects.Effect;
import openfl.utils.ByteArray;

class EffectDropShadow extends Effect {

	public var color : Int;
	public var blurX : Float;
	public var blurY : Float;
	public var angle : Float;
	public var distance : Float;
	public var strength : Float;
	public var inner : Bool;
	public var konckout : Bool;

	public function new (data : ByteArray) {
		super(EffectType.EffectDropShadow);
		color = data.readUnsignedInt();
		blurX = data.readFloat();
		blurY = data.readFloat();
		angle = data.readFloat();
		distance = data.readFloat();
		strength = data.readFloat();
		inner = data.readUnsignedByte()!=0;
		konckout = data.readUnsignedByte()!=0;
	}

}