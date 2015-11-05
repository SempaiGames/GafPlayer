package com.sempaigames.gafplayer.tags.effects;

import com.sempaigames.gafplayer.tags.effects.Effect;
import openfl.utils.ByteArray;

class EffectColorMatrix extends Effect {

	public var rr : Float;
	public var gr : Float;
	public var br : Float;
	public var ar : Float;
	public var r : Float;
	public var rg : Float;
	public var gg : Float;
	public var bg : Float;
	public var ag : Float;
	public var g : Float;
	public var rb : Float;
	public var gb : Float;
	public var bb : Float;
	public var ab : Float;
	public var b : Float;
	public var ra : Float;
	public var ga : Float;
	public var ba : Float;
	public var aa : Float;
	public var a : Float;

	public function new (data : ByteArray) {
		super(EffectType.EffectColorMatrix);
		rr = data.readFloat();
		gr = data.readFloat();
		br = data.readFloat();
		ar = data.readFloat();
		r = data.readFloat();
		rg = data.readFloat();
		gg = data.readFloat();
		bg = data.readFloat();
		ag = data.readFloat();
		g = data.readFloat();
		rb = data.readFloat();
		gb = data.readFloat();
		bb = data.readFloat();
		ab = data.readFloat();
		b = data.readFloat();
		ra = data.readFloat();
		ga = data.readFloat();
		ba = data.readFloat();
		aa = data.readFloat();
		a = data.readFloat();
	}

}
