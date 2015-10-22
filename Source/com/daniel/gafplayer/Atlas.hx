package com.daniel.gafplayer;

import com.daniel.gafplayer.tags.TagDefineAtlas;
import com.daniel.gafplayer.tags.TagDefineAtlas.Element;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;

class Atlas {

	public var elements : Map<Int, BitmapData>;
	public var elementsData : Map<Int, Element>;

	public function new (from : TagDefineAtlas) {
		elements = new Map<Int, BitmapData>();
		elementsData = new Map<Int, Element>();
		var sources = new Map<Int, BitmapData>();
		for (atlas in from.atlases) {
			for (source in atlas.sources) {
				var bmpData = Assets.getBitmapData(Parser.assetsPrefix + source.fileName);
				sources[atlas.id] = bmpData;
			}
		}
		for (element in from.elements) {
			var originBmp = sources[element.atlasIndex];
			var e = new BitmapData(Std.int(element.width), Std.int(element.height)/*, false*/);
			e.copyPixels(
				originBmp,
				new Rectangle(element.origin.x, element.origin.y, element.width, element.height),
				new Point(0, 0)
			);
			this.elements[element.elemenetAtlasIndex] = e;
			this.elementsData[element.elemenetAtlasIndex] = element;
		}
	}

	public function getDebugSprite () : Sprite {
		var spr = new Sprite();
		var xBase = 0;
		var yBase = 0;
		for (e in elements) {
			var newBmp = new Bitmap(e);
			spr.addChild(newBmp);
			newBmp.x = xBase;
			newBmp.y = yBase;
			if (xBase<yBase) {
				xBase += e.width + 5;
			} else {
				yBase += e.height + 5;
			}
		}
		return spr;
	}

}
