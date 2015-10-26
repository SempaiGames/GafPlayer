package com.daniel.gafplayer;

import com.daniel.gafplayer.ParserResult;
import com.daniel.gafplayer.tags.TagDefineAnimationFrames2;
import com.daniel.gafplayer.tags.TagDefineAnimationObjects;
import com.daniel.gafplayer.tags.TagDefineAtlas;
import com.daniel.gafplayer.tags.TagDefineStage;
import com.daniel.gafplayer.tags.TagDefineTimeline;
import flash.Lib;

class GafLayerElement {

	var currentArray : Array<Float>;
	var currentFrame : Int;
	var drawArrays : Map<Int, Array<Float>>;
	var drawArraysOriginal : Map<Int, Array<Float>>;
	var fps : Int;
	var frameCount : Int;
	var startTime : Int;
	var dirty : Bool;

	public var x(default, set) : Float;
	public var y(default, set) : Float;
	public var width(default, null) : Float;
	public var height(default, null) : Float;

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
		this.width = timeLine.frameSize.width - timeLine.frameSize.x;
		this.height = timeLine.frameSize.height - timeLine.frameSize.y;

		this.drawArrays = new Map<Int, Array<Float>>();
		this.drawArraysOriginal = new Map<Int, Array<Float>>();

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
			drawArrays[frame.frameId] = arr;
			drawArraysOriginal[frame.frameId] = arr.copy();
		}

		updateCurrentArray();

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

	function updateCurrentArray() {
		currentArray = drawArrays[currentFrame+1];
		var original = drawArraysOriginal[currentFrame+1];
		var i = 0;
		while (i+1<currentArray.length) {
			currentArray[i] = original[i] + x;
			++i;
			currentArray[i] = original[i] + y;
			i+=6;
		}
	}

	public function update (now : Int) : Bool {
		var totalAnimationTime = (1000/fps)*frameCount;
		var currentAnimationTime = (now-startTime)%totalAnimationTime;
		var targetFrame = Std.int((currentAnimationTime/totalAnimationTime)*frameCount);
		if (dirty || targetFrame != currentFrame) {
			currentFrame = targetFrame;
			updateCurrentArray();
			dirty = false;
			return true;
		} else {
			return false;
		}
	}

	public function drawArray() : Array<Float> {
		return currentArray;
	}

}
