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

	static var bmpDataCache : Map<Int, Map<Int, BitmapData>>;

	public var elements : Map<Int, BitmapData>;
	public var elementsData : Map<Int, Element>;

	public function new (from : TagDefineAtlas) {
		if (bmpDataCache==null) {
			bmpDataCache = new Map<Int, Map<Int, BitmapData>>();
		}
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
			var bmpData : BitmapData = null;
			if (bmpDataCache[element.atlasIndex]!=null) {
				bmpData = bmpDataCache[element.atlasIndex][element.elementAtlasIndex];
			} else {
				bmpDataCache[element.atlasIndex] = new Map<Int, BitmapData>();
			}
			if (bmpData==null) {
				bmpData = new BitmapData(Std.int(element.width), Std.int(element.height));
				bmpData.copyPixels(
					sources[element.atlasIndex],
					new Rectangle(element.origin.x, element.origin.y, element.width, element.height),
					new Point(0, 0)
				);
				bmpDataCache[element.atlasIndex][element.elementAtlasIndex] = bmpData;
			}
			this.elements[element.elementAtlasIndex] = bmpData;
			this.elementsData[element.elementAtlasIndex] = element;
		}
	}

}
