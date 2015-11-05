package com.sempaigames.gafplayer;

import com.sempaigames.gafplayer.tags.TagDefineAnimationFrames2.Frame;
import com.sempaigames.gafplayer.tags.TagDefineAnimationFrames2;
import com.sempaigames.gafplayer.tags.TagDefineAnimationObjects;
import com.sempaigames.gafplayer.tags.TagDefineAtlas;
import com.sempaigames.gafplayer.tags.TagDefineStage;
import com.sempaigames.gafplayer.tags.TagDefineTimeline;
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
	var currentFrame : Int;
	var startTime : Int;

	public function new (p : ParserResult) {
		super();
		animationObjects = new Map<Int, Sprite>();
		currentFrame = 0;
		startTime = Lib.getTimer();
		var stageData = p.getTagsByType(TagDefineStage)[0];
		fps = stageData.fps;
		var tmp = p.getTagsByType(TagDefineAtlas)[0];
		var atlas = new Atlas(tmp);
		var pAnimationObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var containerSpr = new Sprite();
		for (obj in pAnimationObjects.objects) {
			var spr = new Sprite();
			var bmp = new Bitmap(atlas.elements[obj.atlasIdRef], true);
			spr.addChild(bmp);
			animationObjects[obj.id] = spr;
			var tmp = atlas.elementsData[obj.atlasIdRef];
			bmp.x = Std.int(-tmp.pivot.x);
			bmp.y = Std.int(-tmp.pivot.y);
			containerSpr.addChild(spr);
		}
		this.addChild(containerSpr);
		frames = p.getTagsByType(TagDefineAnimationFrames2)[0].frames;
		var pivot = p.getTagsByType(TagDefineTimeline)[0].pivot;
		containerSpr.x = pivot.x;
		containerSpr.y = pivot.y;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(_) advanceFrame());
	}

	function advanceFrame () {
		currentFrame = (currentFrame+1)%frames.length;
		if (currentFrame==0) {
			for (o in animationObjects) {
				o.alpha = 0;
			}
		}
		var frame = frames[currentFrame];
		for (c in frame.changes) {
			var spr = animationObjects[c.objectIdRef];
			spr.alpha = c.alpha;
			spr.transform.matrix = c.matrix;
			spr.parent.setChildIndex(spr, c.depth);
		}
	}

	function onEnterFrame (e : Event) {
		var now = Lib.getTimer();
		var totalAnimationTime = (1000/fps)*frames.length;		
		var currentAnimationTime = (now-startTime)%totalAnimationTime;
		var targetFrame = Std.int((currentAnimationTime/totalAnimationTime)*frames.length);
		while (targetFrame!=currentFrame) {
			advanceFrame();
		}
	}

}
