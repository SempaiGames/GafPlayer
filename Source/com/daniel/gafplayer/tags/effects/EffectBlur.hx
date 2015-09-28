package com.daniel.gafplayer.tags.effects;

import com.daniel.gafplayer.tags.effects.Effect;
import openfl.utils.ByteArray;

class EffectBlur extends Effect {

	public var blurX : Float;
	public var blurY : Float;

	public function new (data : ByteArray) {
		super(EffectType.EffectBlur);
		blurX = data.readFloat();
		blurY = data.readFloat();
	}

}
