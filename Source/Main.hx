package;


import com.daniel.gafplayer.GAFSprite;
import com.daniel.gafplayer.Parser;
import openfl.display.Sprite;


class Main extends Sprite {


	public function new () {

		super ();
		var p = Parser.loadFromFile("assets/vamp-as3.gaf");
		trace(p);
		//addChild(p.getAtlas().getDebugSprite());
		var sp = new GAFSprite(p);
		addChild(sp);
		addChild(new flash.display.FPS());
	}


}
