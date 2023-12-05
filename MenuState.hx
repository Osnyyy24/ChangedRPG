package;

import DiscordPresence;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxShader;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.system.System;

class MenuState extends FlxState
{
	var title:FlxText;
	var titleTween:FlxTween;

	// bgs
	var backgroundImagePaths:Array<String> = [AssetPaths.Offices__png, AssetPaths.Warehouse__png, AssetPaths.DarkLatex__png];

	var background:FlxSprite;
	var backgroundSpeed:Float = 0.4;

	// States
	var PlayState:FlxState;
	var OptionsState:FlxState;

	// mas bgs
	var fontBG:FlxSprite;

	// textos-botones :3
	var buttonsTexts:Array<FlxText> = [];
	var buttonsTest:Array<Dynamic> = [['Play', 'PlayState'], ['Options', 'OptionsState'], ['Quit', 'Quit']];

	override public function create()
	{
		FlxG.autoPause = false;
		#if debug
		FlxG.mouse.visible = false;
		#end

		DiscordPresence.changePresence("Main Menu", null);
		// primero le pones las imagenes y textos

		background = new FlxSprite();
		loadRandomBackground();
		background.screenCenter(Y);
		add(background);

		title = new FlxText(0, -100, 0, "Changed RPG", 24);
		title.setFormat(AssetPaths.Crang__ttf, 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.alignment = LEFT;
		title.screenCenter(X);
		add(title);

		fontBG = new FlxSprite(0, 185);
		fontBG.loadGraphic(AssetPaths.TextBG__png);
		fontBG.screenCenter(X);
		add(fontBG);

		for (i in 0...buttonsTest.length)
		{
			var buttonsText:FlxText = new FlxText(0, 215 + (50 * i), 0, buttonsTest[i][0], 24);
			buttonsText.setFormat(AssetPaths.Daydream__ttf, 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			buttonsText.alignment = CENTER;
			buttonsText.screenCenter(X);
			add(buttonsText);
			buttonsTexts.push(buttonsText);
		}

		add(new FlxButton(0, 0, "DebugArea", function()
		{
			FlxG.switchState(new DebugArea());
		}));

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.Menu__ogg, 1, true);
		}

		// y aqui le pones los ultimos toques

		titleTween = FlxTween.tween(title, {y: 85}, 1, {type: ONESHOT, ease: FlxEase.quadInOut});

		super.create();
	}

	private function quit()
	{
		trace("Quitting the game!");
		System.exit(0);
	}

	private function loadRandomBackground()
	{
		// Seleccionar una imagen aleatoria de la lista y cargarla en el fondo
		var randomIndex:Int = Math.floor(Math.random() * backgroundImagePaths.length);
		var randomImagePath:String = backgroundImagePaths[randomIndex];
		background.loadGraphic(randomImagePath);

		// Escalar la imagen para ajustarse a la pantalla
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		background.x -= backgroundSpeed;

		if (background.x + background.width < FlxG.width)
		{
			loadRandomBackground();
			background.x = FlxG.width - 800;
		}

		for (i in 0...buttonsTest.length)
		{
			var buttonText:FlxText = buttonsTexts[i];

			if (FlxG.mouse.x >= buttonText.x
				&& FlxG.mouse.x <= buttonText.x + buttonText.width
				&& FlxG.mouse.y >= buttonText.y
				&& FlxG.mouse.y <= buttonText.y + buttonText.height)
			{
				buttonText.color = FlxColor.BLACK;
				buttonText.borderStyle = NONE;
				buttonText.size = 26;

				// Boton-Texto Clickeado?
				if (FlxG.mouse.justPressed)
				{
					FlxG.sound.play(AssetPaths.MenuSelect__ogg, 1, false);
					switch (buttonsTest[i][1])
					{
						case 'PlayState':
							FlxG.switchState(new PlayState());
						case 'OptionsState':
							FlxG.switchState(new OptionsState());
					}

					if (buttonsTest[i][1] == 'Quit')
					{
						quit();
					}
					else
					{
						trace("pushed " + buttonsTest[i][0]);
					}
				}
			}
			else
			{
				buttonText.color = FlxColor.WHITE;
				buttonText.borderStyle = FlxTextBorderStyle.OUTLINE;
				buttonText.size = 24;
			}
		}
	}
}
