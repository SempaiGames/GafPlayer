package com.daniel.gafplayer.tags;

import com.daniel.gafplayer.tags.effects.Effect;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

class TagDefineAnimationFrames2 extends Tag {

	public function new (data : ByteArray) {
		super();
		this.id = TagId.TagDefineAnimationFrames2;
		data.endian = Endian.LITTLE_ENDIAN;
		var count = data.readUnsignedInt();
		for (i in 0...count) {
			var frame = data.readUnsignedInt();
			var hasChangesInDisplayList = data.readUnsignedByte()!=0;
			var hasActions = data.readUnsignedByte()!=0;
			if (hasChangesInDisplayList) {
				var changesCount = data.readUnsignedInt();
				for (j in 0...changesCount) {
					var hasColorTransform = data.readUnsignedByte()!=0;
					var hasMask = data.readUnsignedByte()!=0;
					var hasEffect = data.readUnsignedByte()!=0;
					var objectIdRef = data.readUnsignedInt();
					var depth = data.readInt();
					var alpha = data.readFloat();
					var matrix = Utils.readMatrix(data);
					if (hasColorTransform) {
						var alphaOffset = data.readFloat();
						var redMultiplier = data.readFloat();
						var redOffset = data.readFloat();
						var greenMultiplier = data.readFloat();
						var greenOffset = data.readFloat();
						var blueMultiplier = data.readFloat();
						var blueOffset = data.readFloat();
					}
					if (hasEffect) {
						var effectCount = data.readUnsignedByte();
						for (k in 0...effectCount) {
							Effect.parse(data);
						}
					}
				}
			}
		}
	}

}
