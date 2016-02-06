package;

import com.sempaigames.gafplayer.display.GAFSprite;
import com.sempaigames.gafplayer.Parser;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class Main {

	static var spr : GAFSprite;

	public static function main () {
		var p = Parser.loadFromFile("assets/vamp-as3.gaf");
		spr = new GAFSprite(p);
		spr.playLoop(1, spr.getFrameCount());
		Lib.current.stage.addChild(spr);
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
		onResize(null);
	}

	static function onResize (_) {
		spr.x = Lib.current.stage.stageWidth/2 - spr.width/2;
		spr.y = Lib.current.stage.stageHeight/2 - spr.height/2;
	}

}
