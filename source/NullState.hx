package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;

class NullState extends MusicBeatState
{
    var bg:FlxSprite;
    var notRealTxt:FlxText;

    override public function create()
    {
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();

        notRealTxt = new FlxText(0, 0, FlxG.width, "THIS STATE DOESN'T EXIST! PRESS ESC TO GO BACK TO THE MAIN MENU", 48);
		notRealTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		notRealTxt.scrollFactor.set();
		notRealTxt.borderSize = 2;
		add(notRealTxt);
		notRealTxt.screenCenter();

        super.create();
    }

    var notRealSine:Float = 0;

    override public function update(elapsed:Float)
    {
        notRealSine += 180 * elapsed;
		notRealTxt.alpha = 1 - Math.sin((Math.PI * notRealSine) / 180);

        if(FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MainMenuState());
        }

        super.update(elapsed);
    }
}