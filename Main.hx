package;

import DiscordPresence;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fpsVar:FPS;

	public function new()
	{
		DiscordPresence.initialize();
		super();

		var game:FlxGame = new FlxGame(0, 0, MenuState, true, false);
		addChild(game);
		// addChild(new FlxGame(0, 0, MenuState));

		#if desktop
		if (FlxG.save.data.fullscreen != null)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
		}
		#end

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		fpsVar.visible = true;
		#end
	}
}
