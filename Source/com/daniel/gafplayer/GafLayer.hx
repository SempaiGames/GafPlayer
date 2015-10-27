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
		this.drawArray = [];
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public function createElement () : GafLayerElement {
		return new GafLayerElement(parserResults);
	}

	public function addElement (e : GafLayerElement) : Void {
		elements.push(e);
		for (i in 0...7*e.maxSubElements) {
			drawArray.push(0);
		}
		dirty = true;
	}

	public function removeElement (e : GafLayerElement) : Void {
		elements.remove(e);
		for (i in 0...7*e.maxSubElements) {
			drawArray.pop();
		}
		dirty = true;
	}

	function onEnterFrame (e : Event) {
		var now = Lib.getTimer();
		for (e in elements) {
			if (e.update(now)) {
				dirty = true;
			}
		}
		if (dirty) {
			var i = 0;
			var gfx = this.graphics;
			gfx.clear();
			for (e in elements) {
				i = e.addToArray(drawArray, i);
			}
			while (i<drawArray.length) {
				drawArray[i++] = -1;
			}
			tilesheet.drawTiles(gfx, drawArray, true, Tilesheet.TILE_TRANS_2x2);
		}
		dirty = false;
	}

}
