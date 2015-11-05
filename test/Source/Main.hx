package;

import com.sempaigames.gafplayer.GAFSprite;
import com.sempaigames.gafplayer.Parser;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class Main {

	static var spr : Sprite;

	public static function main () {
		var p = Parser.loadFromFile("assets/vamp-as3.gaf");
		spr = new GAFSprite(p);
		Lib.current.stage.addChild(spr);
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
		onResize(null);
	}

	static function onResize (_) {
		spr.x = Lib.current.stage.stageWidth/2 - spr.width/2;
		spr.y = Lib.current.stage.stageHeight/2 - spr.height/2;
	}

}
