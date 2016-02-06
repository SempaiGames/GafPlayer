package com.sempaigames.gafplayer.display;

import com.sempaigames.gafplayer.Parser;
import com.sempaigames.gafplayer.tags.TagDefineAnimationFrames2;
import com.sempaigames.gafplayer.tags.TagDefineAnimationObjects;
import com.sempaigames.gafplayer.tags.TagDefineAtlas;
import com.sempaigames.gafplayer.tags.TagDefineStage;
import com.sempaigames.gafplayer.tags.TagDefineTimeline;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.Lib;
import openfl.Assets;
import openfl.display.Tilesheet;

class GAFSpriteTilesheet extends AbstractGafSprite {

	var drawArrays : Map<Int, Array<Float>>;
	var tilesheet : Tilesheet;

	public function new (p : ParserResult) {
		super(p);
		drawArrays = new Map<Int, Array<Float>>();
		tilesheet = buildTilesheet(p);
		var animObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var stageData = p.getTagsByType(TagDefineStage)[0];
		var timeLine = p.getTagsByType(TagDefineTimeline)[0];
		fps = stageData.fps;
		startTime = Lib.getTimer();
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
		}
		gotoFrame(0);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function buildTilesheet (p : ParserResult) : Tilesheet {
		var atlases = p.getTagsByType(TagDefineAtlas);
		var bmpDataPath = atlases[0].getFirstAtlasFileName();
		var bmpData = Assets.getBitmapData(Parser.assetsPrefix + bmpDataPath);
		var tilesheet = new Tilesheet(bmpData);
		for (e in atlases[0].elements) {
			tilesheet.addTileRect(new Rectangle(e.origin.x, e.origin.y, e.width, e.height), e.pivot);
		}
		return tilesheet;
	}

	override function gotoFrame (frameId : Int) {
		var gfx = this.graphics;
		gfx.clear();
		tilesheet.drawTiles(gfx, drawArrays[frameId+1], true, Tilesheet.TILE_TRANS_2x2);
	}

}
