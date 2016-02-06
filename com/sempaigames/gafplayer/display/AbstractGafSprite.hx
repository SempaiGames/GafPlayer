package com.sempaigames.gafplayer.display;

import com.sempaigames.gafplayer.tags.TagDefineStage;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class AbstractGafSprite extends Sprite {

	var currentFrame : Int;
	var endFrame : Int;
	var fps : Int;
	var loop : Bool;
	var paused : Bool;
	var startFrame : Int;
	var startTime : Int;

	public function new (p : ParserResult) {
		super();
		var stageData = p.getTagsByType(TagDefineStage)[0];
		fps = stageData.fps;
		currentFrame = 0;
		endFrame = 0;
		loop = false;
		paused = false;
		startFrame = 0;
		startTime = Lib.getTimer();
		#if !gafplayer_manual_update
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		#end
	}

	public function play (startFrame : Int, endFrame : Int
	#if gafplayer_manual_update
	, startTime : Int
	#end
	) : Void {
		paused = false;
		this.startFrame = startFrame;
		this.endFrame = endFrame;
		gotoFrame(startFrame);
		this.loop = false;
		#if gafplayer_manual_update
		this.startTime = startTime;
		#else
		this.startTime = Lib.getTimer();
		#end
	}

	public function playLoop (startFrame : Int, endFrame : Int
	#if gafplayer_manual_update
	, startTime : Int
	#end
	) : Void {
		paused = false;
		this.startFrame = startFrame;
		this.endFrame = endFrame;
		gotoFrame(startFrame);
		this.loop = true;
		#if gafplayer_manual_update
		this.startTime = startTime;
		#else
		this.startTime = Lib.getTimer();
		#end
	}

	public function pause () : Void {
		paused = true;
	}

	public function update (now : Int) : Void {
		var targetFrame : Int;
		if (paused) {
			return;
		}
		if (endFrame==startFrame) {
			targetFrame = startFrame;
		} else {
			var totalAnimationTime = Std.int((1000/fps)*(endFrame-startFrame));
			var currentAnimationTime = (now-startTime)%totalAnimationTime;
			var prevFrame = currentFrame;
			targetFrame = Std.int((currentAnimationTime/totalAnimationTime)*(endFrame-startFrame)) + startFrame - 1;
			if (!loop && prevFrame>targetFrame) {
				targetFrame = prevFrame;
			}
		}
		gotoFrame(targetFrame);
	}

	#if !gafplayer_manual_update
	function onEnterFrame (e : Event) {
		update(Lib.getTimer());
	}
	#end

	function gotoFrame (target : Int) : Void {
		throw "Implement this method in child";
	}

}
