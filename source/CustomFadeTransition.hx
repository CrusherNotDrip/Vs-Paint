package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	var pain:FlxSprite;

	public function new(duration:Float, ?isTransIn:Bool) {
		super();

		this.isTransIn = isTransIn;
		var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);

		pain = new FlxSprite().loadGraphic('assets/paint/pain');
		pain.scrollFactor.set();
		pain.alpha = 0;
		add(pain);
		
		FlxTween.tween(pain, {alpha: 1}, 0.3, {
		onComplete: function(twn:FlxTween) {
			new FlxTimer().start(duration, function(tmr:FlxTimer)
			{
			   FlxTween.tween(pain, {alpha: 0}, 0.3, {
						onComplete: function(twn:FlxTween) {
							close();
						},
						ease: FlxEase.linear});
			});
		},
		ease: FlxEase.linear});

		if(nextCamera != null) {
			pain.cameras = [nextCamera];
		}
		nextCamera = null;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}
