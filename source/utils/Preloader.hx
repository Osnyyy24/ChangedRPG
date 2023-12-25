package utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxPreloader;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Preloader extends FlxPreloader
{
	var loaderBar:FlxSprite;
	var randomTextES:Array<String> = [
		"Tu personaje puede correr con la tecla <TAB> en tu teclado",
		"Osny (El personaje principal) es femboy",
		"Haxe es vida",
		"Este es el peor mensaje",
		"uwu"
	];

	var randomTextEN:Array<String> = [
		"You can run with <TAB> button in the keyboard",
		"Osny (The main character) is a femboy",
		"Haxe is life",
		"This is the worst message",
		"uwu"
	];

	var textos:FlxText;

	public function new()
	{
		super();

		loaderBar = new FlxSprite();
		loaderBar.makeGraphic(1, 10, FlxColor.BLUE);
		loaderBar.x = (FlxG.width - loaderBar.width) / 2;
		loaderBar.y = FlxG.height - 30;
		add(loaderBar);

		textos = new FlxText(0, 350, 0, "", 14);
		textos.setFormat(AssetPaths.Daydream__ttf, 14, FlxColor.WHITE, RIGHT);
		textos.alignment = RIGHT;
		textos.screenCenter(X);
		add(textos);

		// randomText();
	}

	/*private function randomText()
		{
			if (FlxG.save.data.lang == ES)
				{
					var randomIndex:Int = Math.floor(Math.random() * randomTextES);
					var randomTextPaths:String = randomTextES[randomIndex];
					textos.text = randomTextPaths;
				}
			else
				{
					var randomIndex:Int = Math.floor(Math.random() * randomTextEN);
					var randomTextPaths:String = randomTextEN[randomIndex];
					textos.text = randomTextPaths;
				}
	}*/
	override public function onUpdate(elapsed:Float):Void
	{
		super.onUpdate(elapsed);

		var progress:Float = FlxG.loader.percentLoaded();
		loaderBar.scale.x = FlxG.width * progress;
	}
}
