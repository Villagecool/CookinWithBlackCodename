function update(elapsed)
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => 'custom/newMainMenu'
];

function preStateSwitch()
{
    for(redirectState in redirectStates.keys())
        if(Std.isOfType(FlxG.game._requestedState, redirectState))
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
    
}