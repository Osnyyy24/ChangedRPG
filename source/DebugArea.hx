package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import shaders.Shaders;

class DebugArea extends FlxState
{
	var map:FlxOgmo3Loader;

	// tiles??
	var decoration:FlxTilemap;
	var grass:FlxTilemap;
	var walls:FlxTilemap;

	var back:FlxText;

	var _sprite:FlxSprite;
	var waveEffect:FlxWaveEffect;

	var player:Player;

	var loaded_or_saved:FlxText;
	var savedTween:FlxTween;

	override public function create()
	{
		FlxG.camera.follow(player, TOPDOWN, 1);

		super.create();

		map = new FlxOgmo3Loader(AssetPaths.TestWithOGMO__ogmo, AssetPaths.testwithOGMO__json);
		decoration = map.loadTilemap(AssetPaths.grassDeco__png, "decoration");
		grass = map.loadTilemap(AssetPaths.grass__png, "grass");
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		decoration.follow();
		grass.follow();
		walls.follow();
		// wth is this
		decoration.setTileProperties(0, NONE);
		decoration.setTileProperties(1, NONE);
		decoration.setTileProperties(2, NONE);
		decoration.setTileProperties(3, NONE);
		grass.setTileProperties(0, NONE);
		grass.setTileProperties(1, NONE);
		grass.setTileProperties(2, NONE);
		grass.setTileProperties(3, NONE);
		grass.setTileProperties(4, NONE);
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, NONE);
		walls.setTileProperties(3, NONE);
		walls.setTileProperties(4, NONE);
		walls.setTileProperties(5, NONE);
		walls.setTileProperties(6, NONE);
		walls.setTileProperties(7, NONE);
		walls.setTileProperties(8, NONE);
		walls.setTileProperties(9, NONE);
		walls.setTileProperties(10, NONE);
		walls.setTileProperties(11, NONE);
		walls.setTileProperties(12, NONE);
		walls.setTileProperties(13, NONE);
		walls.setTileProperties(0, ANY);
		add(decoration);
		add(grass);
		add(walls);

		player = new Player(20, 20);
		add(player);

		map.loadEntities(placeEntities, "entities");

		/*_sprite = new FlxSprite(0, 0);
			_sprite.loadGraphic(AssetPaths.Water200__png);

			// wave animation

			var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 4, -1, 4);
			var waveSprite = new FlxEffectSprite(_sprite, [waveEffect]);
			add(waveSprite);

			_sprite.scale.set(2, 1);
			_sprite.screenCenter(); */

		// FlxG.sound.playMusic(AssetPaths.Test__ogg, 1);

		FlxG.sound.music.pause();

		back = new FlxText(20, 20, 0, "y", 24);
		back.setFormat(AssetPaths.PixArrows__ttf, 24, FlxColor.WHITE, LEFT);
		add(back);

		loaded_or_saved = new FlxText(200, 200, 0, "Saved", 24);
		loaded_or_saved.setFormat(AssetPaths.CooperBits__ttf, 18, FlxColor.WHITE, RIGHT);
		loaded_or_saved.alpha = 0;
		add(loaded_or_saved);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}

	function onSave()
	{
		trace("aaaaa");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			loaded_or_saved.alpha = 1;
			new FlxTimer().start(0.6, function(tween:FlxTimer)
			{
				savedTween = FlxTween.tween(loaded_or_saved, {alpha: 0}, 1);
				savedTween.ease = FlxEase.sineOut;
			});
		}

		FlxG.collide(player, decoration);
		FlxG.collide(player, grass);
		FlxG.collide(player, walls);

		if (FlxG.mouse.x >= back.x && FlxG.mouse.x <= back.x + back.width && FlxG.mouse.y >= back.y && FlxG.mouse.y <= back.y + back.height)
		{
			back.text = "w";

			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.music.play();
				FlxG.sound.play(AssetPaths.MenuMove__ogg, 1, false);
				FlxG.switchState(new MenuState());
			}
		}
		else
		{
			back.text = "y";
		}
	}
}
