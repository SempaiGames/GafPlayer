package com.sempaigames.gafplayer.tags;

import com.sempaigames.gafplayer.Utils;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

private class AtlasSource {

	public var fileName : String;
	public var csf : Float;

	public function new() {}

}

private class Atlas {

	public var id : Int;
	public var sources : Array<AtlasSource>;

	public function new () {}

}

class Element {

	public var pivot : Point;
	public var origin : Point;
	public var scale : Float;
	public var width : Float;
	public var height : Float;
	public var atlasIndex : Int;
	public var elementAtlasIndex : Int;
	public var hasScale9Grid : Bool;
	public var scale9Grid : Rectangle;

	public function new () {}

}

class TagDefineAtlas extends Tag {

	public var scale : Float;
	public var atlases : Array<Atlas>;
	public var elements : Array<Element>;

	public function new (data : ByteArray) {
		super();
		this.id = TagId.TagDefineAtlas;
		data.endian = Endian.LITTLE_ENDIAN;
		scale = data.readFloat();
		var atlasCount = data.readUnsignedByte();
		atlases = [];
		for (i in 0...atlasCount) {
			var atlas = new Atlas();
			atlas.id = data.readUnsignedInt();
			var atlasSourcesCount = data.readUnsignedByte();
			atlas.sources = [];
			for (i in 0...atlasSourcesCount) {
				var source = new AtlasSource();
				source.fileName = Utils.readString(data);
				source.csf = data.readFloat();
				atlas.sources.push(source);
			}
			atlases.push(atlas);
		}
		elements = [];
		var elementsCount = data.readUnsignedInt();
		for (i in 0...elementsCount) {
			var element = new Element();
			element.pivot = Utils.readPoint(data);
			element.origin = Utils.readPoint(data);
			element.scale = data.readFloat();
			element.width = data.readFloat();
			element.height = data.readFloat();
			element.atlasIndex = data.readUnsignedInt();
			element.elementAtlasIndex = data.readUnsignedInt();
			// TODO: if version>=4
			element.hasScale9Grid = data.readUnsignedByte()!=0;
			if (element.hasScale9Grid) {
				element.scale9Grid = Utils.readRect(data);
			}
			elements.push(element);
		}
	}

	public function getAtlasFileName (atlasId : Int) : String {
		return atlases[atlasId-1].sources[0].fileName;
	}

	public function getFirstAtlasFileName () : String {
		return getAtlasFileName(1);
	}

	override public function toString () {
		return "TagDefineAtlas";
	}

}
