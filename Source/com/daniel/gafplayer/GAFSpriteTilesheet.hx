package com.daniel.gafplayer;

import com.daniel.gafplayer.tags.TagDefineAnimationFrames2;
import com.daniel.gafplayer.tags.TagDefineAnimationObjects;
import com.daniel.gafplayer.tags.TagDefineAtlas;
import com.daniel.gafplayer.tags.TagDefineStage;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Tilesheet;

class GAFSpriteTilesheet extends Sprite {

	var drawArrays : Map<Int, Array<Float>>;
	var tilesheet : Tilesheet;
	var currentFrame : Int;
	var fps : Int;
	var frameCount : Int;
	var startTime : Int;

	public function new (p : ParserResult) {
		super();
		drawArrays = new Map<Int, Array<Float>>();
		tilesheet = p.tilesheets[0];
		var atlas = p.getTagsByType(TagDefineAtlas)[0];
		var frames = p.getTagsByType(TagDefineAnimationFrames2)[0].frames;
		var animObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var stageData = p.getTagsByType(TagDefineStage)[0];
		fps = stageData.fps;
		frameCount = frames.length;
		startTime = Lib.getTimer();
		currentFrame = 0;
		for (frame in frames) {
			var arr = [];
			for (change in frame.changes) {
				var id = 0;
				for (o in animObjects.objects) {
					if (change.objectIdRef==o.id) {
						break;
					}
					id++;
				}
				var matrix = change.matrix;
				arr.push(matrix.tx-atlas.elements[id].pivot.x);
				arr.push(matrix.ty-atlas.elements[id].pivot.y);
				arr.push(id);
				arr.push(matrix.a);
				arr.push(matrix.b);
				arr.push(matrix.c);
				arr.push(matrix.d);
			}
			drawArrays[frame.frameId] = arr;
		}
		renderFrame(0);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function renderFrame (frameId : Int) {
		var gfx = this.graphics;
		gfx.clear();
		tilesheet.drawTiles(gfx, drawArrays[frameId+1], true, Tilesheet.TILE_TRANS_2x2);
	}

	function onEnterFrame (e : Event) {
		var now = Lib.getTimer();
		var totalAnimationTime = (1000/fps)*frameCount;		
		var currentAnimationTime = (now-startTime)%totalAnimationTime;
		currentFrame = Std.int((currentAnimationTime/totalAnimationTime)*frameCount);
		renderFrame(currentFrame);
	}

}
