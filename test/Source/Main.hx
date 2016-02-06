package;

import com.sempaigames.gafplayer.display.GAFSprite;
import com.sempaigames.gafplayer.display.GAFSpriteTilesheet;
import com.sempaigames.gafplayer.Parser;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class Main {

	static var sprA : GAFSpriteTilesheet;
	static var sprB : GAFSprite;

	public static function main () {
		var p = Parser.loadFromFile("assets/vamp-as3.gaf");
		sprA = new GAFSpriteTilesheet(p);
		sprB = new GAFSprite(p);
		sprA.playLoop(1, sprA.getFrameCount());
		sprB.playLoop(1, sprA.getFrameCount());
		Lib.current.stage.addChild(sprA);
		Lib.current.stage.addChild(sprB);
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
		onResize(null);
	}

	static function onResize (_) {
		sprA.x = Lib.current.stage.stageWidth/2 - sprA.width/2 - 200;
		sprA.y = Lib.current.stage.stageHeight/2 - sprA.height/2;
		sprB.x = Lib.current.stage.stageWidth/2 - sprB.width/2 + 200;
		sprB.y = Lib.current.stage.stageHeight/2 - sprB.height/2;
	}

}
