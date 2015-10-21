package com.daniel.gafplayer;

import com.daniel.gafplayer.tags.TagDefineAnimationFrames2;
import com.daniel.gafplayer.tags.TagDefineAnimationFrames2.Frame;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

class GAFSprite extends Sprite {

	var animationObjects : Map<Int, Sprite>;
	var frames : Array<Frame>;
	var fps : Float;
	var frameId : Int;
	var lastFrameTime : Int;

	public function new (p : ParserResult) {
		super();
		animationObjects = new Map<Int, Sprite>();
		frameId = 0;
		lastFrameTime = Lib.getTimer();
		var stageData = p.getStageData();
		fps = stageData.fps;
		var atlas = p.getAtlas();
		var pAnimationObjects = p.getAnimationObjects();
		trace("len: " + pAnimationObjects.objects.length);
		for (obj in pAnimationObjects.objects) {
			var spr = new Sprite();
			var bmp = new Bitmap(atlas.elements[obj.atlasIdRef], true);
			spr.addChild(bmp);
			animationObjects[obj.id] = spr;
			var tmp = atlas.elementsData[obj.atlasIdRef];
			bmp.x = Std.int(-tmp.pivot.x);
			bmp.y = Std.int(-tmp.pivot.y);
			this.addChild(spr);
		}
		frames = p.getAnimationFrames().frames;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(_) advanceFrame());
	}

	function advanceFrame () {
		if (frameId==0) {
			for (o in animationObjects) {
				o.alpha = 0;
			}
		}
		trace(frameId+1);
		var frame = frames[frameId];
		for (c in frame.changes) {
			var spr = animationObjects[c.objectIdRef];
			spr.alpha = c.alpha;
			spr.transform.matrix = c.matrix;
			spr.parent.setChildIndex(spr, c.depth);
		}
		frameId++;
		if (frameId==frames.length) {
			frameId = 0;
		}
	}

	function onEnterFrame (e : Event) {
		var now = Lib.getTimer();
		if (now-lastFrameTime/*+Lib.current.stage.frameRate/2*/>1000/fps) {
			advanceFrame();
			lastFrameTime = now;
		}
	}

}
