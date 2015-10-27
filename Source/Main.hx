package;


import com.daniel.gafplayer.GafLayer;
import com.daniel.gafplayer.GafLayerElement;
import com.daniel.gafplayer.GAFSprite;
import com.daniel.gafplayer.GAFSpriteTilesheet;
import com.daniel.gafplayer.Parser;
import flash.events.Event;
import flash.Lib;
import openfl.display.Sprite;

class Main extends Sprite {

	var anims : Array<{spr : GafLayerElement, xSpeed : Float, ySpeed : Float}>;

	public function new () {
		super ();
		anims = [];
		var p = Parser.loadFromFile("assets/vamp-as3.gaf");
		var gafLayer = new GafLayer(p);
		for (i in 0...20) {
			var sp = gafLayer.createElement();
			sp.scale = 0.5;
			anims.push({
				spr : sp,
				xSpeed : (Math.random()-0.5)*10,
				ySpeed : (Math.random()-0.5)*10,
			});
			gafLayer.addElement(sp);
		}
		addChild(gafLayer);
		addChild(new flash.display.FPS());
		addEventListener(Event.ENTER_FRAME, onEnterFrame);

	}

	function onEnterFrame (_) {
		var stageW = Lib.current.stage.stageWidth;
		var stageH = Lib.current.stage.stageHeight;
		for (a in anims) {
			var spr = a.spr;
			spr.x += a.xSpeed;
			spr.y += a.ySpeed;
			if (spr.x<0) {
				a.xSpeed = -a.xSpeed;
				spr.x = 0;
			}
			if (spr.x+spr.width>stageW) {
				a.xSpeed = -a.xSpeed;
				spr.x = stageW-spr.width;
			}
			if (spr.y<0) {
				a.ySpeed = -a.ySpeed;
				spr.y = 0;
			}
			if (spr.y+spr.height>stageH) {
				a.ySpeed = -a.ySpeed;
				spr.y = stageH-spr.height;
			}
			
		}
	}

}
