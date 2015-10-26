package com.daniel.gafplayer;

import com.daniel.gafplayer.ParserResult;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.Tilesheet;
import flash.Lib;

@:access(com.daniel.gafplayer.GafLayerElement)
class GafLayer extends Sprite {

	var tilesheet : Tilesheet;
	var elements : Array<GafLayerElement>;
	var drawArray : Array<Float>;
	var parserResults : ParserResult;
	var dirty : Bool;

	public function new (p : ParserResult) {
		super();
		this.elements = [];
		this.parserResults = p;
		this.dirty = false;
		this.tilesheet = p.tilesheets[0];
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public function createElement () : GafLayerElement {
		return new GafLayerElement(parserResults);
	}

	public function addElement (e : GafLayerElement) : Void {
		dirty = true;
		elements.push(e);
	}

	public function removeElement (e : GafLayerElement) : Void {
		dirty = true;
		elements.remove(e);
	}

	function onEnterFrame (e : Event) {
		var now = Lib.getTimer();
		for (e in elements) {
			if (e.update(now)) {
				dirty = true;
			}
		}
		if (dirty) {
			trace(1);
			var gfx = this.graphics;
			drawArray = [];
			gfx.clear();
			for (e in elements) {
				for (i in e.drawArray()) {
					drawArray.push(i);
				}
			}
			tilesheet.drawTiles(gfx, drawArray, true, Tilesheet.TILE_TRANS_2x2);
		} else {
			trace(2);
		}
		dirty = false;
	}

}
