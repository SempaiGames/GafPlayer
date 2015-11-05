package com.sempaigames.gafplayer;

import com.sempaigames.gafplayer.ParserResult;
import com.sempaigames.gafplayer.tags.TagDefineAnimationFrames2;
import com.sempaigames.gafplayer.tags.TagDefineAnimationObjects;
import com.sempaigames.gafplayer.tags.TagDefineAtlas;
import com.sempaigames.gafplayer.tags.TagDefineStage;
import com.sempaigames.gafplayer.tags.TagDefineTimeline;
import flash.Lib;

class GafLayerElement {

	var currentArray : Array<Float>;
	var currentFrame : Int;
	var drawArrays : Map<Int, Array<Float>>;
	var fps : Int;
	var frameCount : Int;
	var startTime : Int;
	var dirty : Bool;

	public var x(default, set) : Float;
	public var y(default, set) : Float;
	public var width(get, null) : Float;
	public var height(get, null) : Float;
	public var scale(default, set) : Float;
	public var maxSubElements(default, null) : Int;

	private function new (p : ParserResult) {
		var animObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var frames = p.getTagsByType(TagDefineAnimationFrames2)[0].frames;
		var stageData = p.getTagsByType(TagDefineStage)[0];
		var timeLine = p.getTagsByType(TagDefineTimeline)[0];

		this.currentFrame = 0;
		this.fps = stageData.fps;
		this.frameCount = frames.length;
		this.startTime = Lib.getTimer();
		this.x = 0;
		this.y = 0;
		this.width = timeLine.frameSize.width/* - timeLine.frameSize.x*/;
		this.height = timeLine.frameSize.height/* - timeLine.frameSize.y*/;
		this.scale = 1.0;

		this.drawArrays = new Map<Int, Array<Float>>();
		this.maxSubElements = 0;

		for (frame in frames) {
			var arr = [];
			frame.changes.sort(function(x, y) {
				return x.depth>y.depth ? 1 : -1;
			});
			for (change in frame.changes) {
				var id = 0;
				for (o in animObjects.objects) {
					if (change.objectIdRef==o.id) {
						break;
					}
					id++;
				}
				var matrix = change.matrix;
				arr.push(matrix.tx+timeLine.pivot.x);
				arr.push(matrix.ty+timeLine.pivot.y);
				arr.push(id);
				arr.push(matrix.a);
				arr.push(matrix.b);
				arr.push(matrix.c);
				arr.push(matrix.d);
			}
			if (maxSubElements<frame.changes.length) {
				maxSubElements = frame.changes.length;
			}
			drawArrays[frame.frameId] = arr;
		}

	}

	function set_x (x : Float) : Float {
		this.x = x;
		dirty = true;
		return x;
	}

	function set_y (y : Float) : Float {
		this.y = y;
		dirty = true;
		return y;
	}

	function set_scale (scale : Float) : Float {
		this.scale = scale;
		dirty = true;
		return scale;
	}

	function get_width () : Float {
		return this.width * this.scale;
	}

	function get_height () : Float {
		return this.height * this.scale;
	}

	public function addToArray(arr : Array<Float>, arrIndex : Int) : Int {
		var currentArray = drawArrays[currentFrame+1];
		var i = 0;
		while (i<currentArray.length) {
			arr[arrIndex++] = currentArray[i++] * scale+ x;
			arr[arrIndex++] = currentArray[i++] * scale+ y;
			arr[arrIndex++] = currentArray[i++];
			arr[arrIndex++] = currentArray[i++] * scale;
			arr[arrIndex++] = currentArray[i++] * scale;
			arr[arrIndex++] = currentArray[i++] * scale;
			arr[arrIndex++] = currentArray[i++] * scale;
		}
		return arrIndex;
	}

	public function update (now : Int) : Bool {
		var totalAnimationTime = (1000/fps)*frameCount;
		var currentAnimationTime = (now-startTime)%totalAnimationTime;
		var targetFrame = Std.int((currentAnimationTime/totalAnimationTime)*frameCount);
		if (dirty || targetFrame != currentFrame) {
			currentFrame = targetFrame;
			dirty = false;
			return true;
		} else {
			return false;
		}
	}

}
