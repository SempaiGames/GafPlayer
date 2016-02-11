package com.sempaigames.gafplayer.display.spritesimpl;

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
import openfl.display.PixelSnapping;

class GAFSprite extends AbstractGafSprite {

	var animationObjects : Map<Int, Sprite>;

	public function new (p : ParserResult) {
		super(p);
		animationObjects = new Map<Int, Sprite>();
		var tmp = p.getTagsByType(TagDefineAtlas)[0];
		var atlas = new Atlas(tmp);
		var pAnimationObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var containerSpr = new Sprite();
		for (obj in pAnimationObjects.objects) {
			var spr = new Sprite();
			var bmp = new Bitmap(atlas.elements[obj.atlasIdRef], PixelSnapping.AUTO, true);
			spr.addChild(bmp);
			animationObjects[obj.id] = spr;
			var tmp = atlas.elementsData[obj.atlasIdRef];
			bmp.x = Std.int(-tmp.pivot.x);
			bmp.y = Std.int(-tmp.pivot.y);
			containerSpr.addChild(spr);
		}
		this.addChild(containerSpr);
		var pivot = p.getTagsByType(TagDefineTimeline)[0].pivot;
		containerSpr.x = pivot.x;
		containerSpr.y = pivot.y;
		do {
			advanceFrame();
		} while (currentFrame!=0);
	}

	override function gotoFrame (target : Int) : Void {
		while (currentFrame!=target) {
			advanceFrame();
		}
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

}
