package com.sempaigames.gafplayer.display.tilesheetsimpl;

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
		tilesheet = buildTilesheet(p);
		var animObjects = p.getTagsByType(TagDefineAnimationObjects)[0];
		var stageData = p.getTagsByType(TagDefineStage)[0];
		var timeLine = p.getTagsByType(TagDefineTimeline)[0];
		var builder = new DrawTilesArraysBuilder(frames, animObjects, timeLine.pivot);
		drawArrays = builder.buildDrawArrays();
		fps = stageData.fps;
		startTime = Lib.getTimer();
		gotoFrame(0);
		#if !gafplayer_manual_update
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		#end
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
