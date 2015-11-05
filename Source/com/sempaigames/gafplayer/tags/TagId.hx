package com.sempaigames.gafplayer.tags;

@:enum abstract TagId (Int) from Int to Int {

	var TagEnd = 0;
	var TagDefineAtlas = 1;
	var TagDefineAnimationMasks = 2;
	var TagDefineAnimationObjects = 3;
	var TagDefineAnimationFrames = 4;
	var TagDefineNamedParts = 5;
	var TagDefineSequences = 6;
	var TagDefineTextFields = 7;
	//var TagDefineAtlas = 8;
	var TagDefineStage = 9;
	//var TagDefineAnimationObjects = 10;
	//var TagDefineAnimationMasks = 11;
	var TagDefineAnimationFrames2 = 12;
	var TagDefineTimeline = 13;

	inline function new (i : Int) {
		this = i;
	}

	@:from static public function fromInt(i : Int) {
		if (i==8)	i = TagDefineAtlas;
		if (i==10)	i = TagDefineAnimationObjects;
		if (i==11)	i = TagDefineAnimationMasks;
		return new TagId(i);
	}

}
