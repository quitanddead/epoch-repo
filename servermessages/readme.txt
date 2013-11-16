ServerMessages RCon client by gdscei
BattleNET library by ziellos2k

RCon client for automatic server messages on specified times.

Installation instructions:
- Put files in a folder of your choice.
- Open settings.cfg in your favorite text editor and edit the values to your servers' configuration.
- Open messages.cfg and add/edit your messages. There is a specified format of doing this:
	- Every new message starts on a new line
	- Time is in HH:mm:ss format, 24h time
	- Seperate time and message by tilde (~) character. (this means you may not use the tilde character in your message)
- Save both files and run the ServerMessages client. Client will give notices if anything is wrong with connecting to the server.

Changelog:

v1.1: Fixed bug with reloading messages file
v1.0: Initial release