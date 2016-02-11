package com.sempaigames.gafplayer.display.tilesheetsimpl;

import com.sempaigames.gafplayer.tags.TagDefineAnimationFrames2;
import com.sempaigames.gafplayer.tags.TagDefineAnimationObjects;
import flash.geom.Matrix;
import flash.geom.Point;

private class AnimObject {

	var atlasIdRef : Int;
	var id : Int;
	var matrix : Matrix;

	public function new (atlasIdRef : Int, id : Int) {
		this.atlasIdRef = atlasIdRef;
		this.id = id;
		matrix = new Matrix();
		matrix.identity();
	}

	public function appendChanges (changes : Array<Change>) {
		for (c in changes) {
			if (c.objectIdRef==id) {
				matrix.concat(c.matrix);
				//matrix = c.matrix;
			}
		}
	}

	public function asArray (pivot : Point) : Array<Float> {
		var arr = [
			matrix.tx + pivot.x,
			matrix.ty + pivot.y,
			atlasIdRef,
			matrix.a,
			matrix.b,
			matrix.c,
			matrix.d
		];
		return arr;
	}

}

class DrawTilesArraysBuilder {

	var frames : Array<Frame>;
	var objects : TagDefineAnimationObjects;
	var pivot : Point;

	public function new (frames : Array<Frame>, objects : TagDefineAnimationObjects, pivot : Point) {
		this.frames = frames;
		this.objects = objects;
		this.pivot = pivot;
	}

	public function buildDrawArrays () : Map<Int, Array<Float>> {
		var drawArrays = new Map<Int, Array<Float>>();
		for (i in 0...frames.length) {
			drawArrays.set(i+1, buildDrawArrayForFrame(i));
		}
		return drawArrays;		
	}

	function buildDrawArrayForFrame (frameId : Int) : Array<Float> {
		var animObjects = [];
		for (o in objects.objects) {
			var n = new AnimObject(o.atlasIdRef, o.id);
			animObjects.push(n);
		}
		for (i in 0...frameId) {
			for (o in animObjects) {
				o.appendChanges(frames[i].changes);
			}
		}
		var ret = [];
		for (o in animObjects) {
			for (f in o.asArray(pivot)) {
				ret.push(f);
			}
		}
		return ret;
	}

}
