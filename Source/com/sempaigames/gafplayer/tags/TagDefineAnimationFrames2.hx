package com.sempaigames.gafplayer.tags;

import com.sempaigames.gafplayer.tags.effects.Effect;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

class Change {

	public var hasColorTransform : Bool;
	public var hasMask : Bool;
	public var hasEffect : Bool;
	public var objectIdRef : Int;
	public var depth : Int;
	public var alpha : Float;
	public var matrix : Matrix;
	public var colorTransform : ColorTransform;
	public var effects : Array<Effect>;

	public function new() {
		effects = [];
	}

}

class Frame {

	public var frameId : Int;
	public var hasChangesInDisplayList : Bool;
	public var hasActions : Bool;
	public var changes : Array<Change>;

	public function new() {
		changes = [];
	}

}

class TagDefineAnimationFrames2 extends Tag {

	public var frames : Array<Frame>;

	public function new (data : ByteArray) {
		super();
		this.id = TagId.TagDefineAnimationFrames2;
		data.endian = Endian.LITTLE_ENDIAN;
		var frameCount = data.readUnsignedInt();
		frames = [];
		for (i in 0...frameCount) {
			var frame = new Frame();
			frame.frameId = data.readUnsignedInt();
			frame.hasChangesInDisplayList = data.readUnsignedByte()!=0;
			frame.hasActions = data.readUnsignedByte()!=0;
			if (frame.hasChangesInDisplayList) {
				var changesCount = data.readUnsignedInt();
				for (j in 0...changesCount) {
					var change = new Change();
					change.hasColorTransform = data.readUnsignedByte()!=0;
					change.hasMask = data.readUnsignedByte()!=0;
					change.hasEffect = data.readUnsignedByte()!=0;
					change.objectIdRef = data.readUnsignedInt();
					change.depth = data.readInt();
					change.alpha = data.readFloat();
					change.matrix = Utils.readMatrix(data);
					if (change.hasColorTransform) {
						var alphaOffset = data.readFloat();
						var redMultiplier = data.readFloat();
						var redOffset = data.readFloat();
						var greenMultiplier = data.readFloat();
						var greenOffset = data.readFloat();
						var blueMultiplier = data.readFloat();
						var blueOffset = data.readFloat();
						change.colorTransform = new ColorTransform(
							redMultiplier,
							greenMultiplier,
							blueMultiplier,
							1,	// TODO: ???
							redOffset,
							greenOffset,
							blueOffset,
							alphaOffset
						);
					}
					if (change.hasEffect) {
						var effectCount = data.readUnsignedByte();
						for (k in 0...effectCount) {
							change.effects.push(Effect.parse(data));
						}
					}
					frame.changes.push(change);
				}
			}
			frames.push(frame);
		}
	}

	override public function toString () {
		return "TagDefineAnimationFrames2";
	}

}
