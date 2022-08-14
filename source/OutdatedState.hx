package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(0, 0, Paths.image('outdatedBG'));
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Ay bro, looks like you're running an   \n
			outdated version of Vs Paint (Your Version: v" + MainMenuState.vsPaintVersion + "),\n
			We would appreciate it if you update it to v" + TitleState.updateVersion + "!\n
			Press ESC to proceed anyway or Press ENTER to update.\n
			\n
			Thank you for playing this mod!",
			32);
		warnText.setFormat(Paths.font("Marker.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		warnText.borderSize = 1.25;
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://gamebanana.com/mods/351288");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 0.3, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
