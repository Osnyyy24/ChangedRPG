package;

import Sys.sleep;
import discord_rpc.DiscordRpc;

class DiscordPresence
{
	public function new()
	{
		DiscordRpc.start({clientID: "1180420496710438993", onReady: onReady});

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			// trace("Discord Client Update");
		}
	}

	static function onReady()
	{
		DiscordRpc.presence({
			details: "Main Menu",
			state: null,
			largeImageKey: 'discord',
		});
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordPresence();
		});
		trace("Discord Client initialized");
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float)
	{
		DiscordRpc.presence({
			details: details,
			state: state,
			largeImageKey: 'discord',
			largeImageText: "Secret Information 🐺",
			// smallImageKey : 'rahrah',
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp: null,
			endTimestamp: null
		});

		trace(details, state);
	}
}
