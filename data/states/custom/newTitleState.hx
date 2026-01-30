import flixel.util.FlxColor;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import funkin.menus.TitleState;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxText.FlxTextAlign;

var menuBG:FunkinSprite;
var logo:FunkinSprite;
var enter:FunkinSprite;
var menuFG:FlxSprite;
var tities:FlxText;
var tities2:FlxText;
var collab:FlxSprite;
var curWacky:Array<String> = [];
using StringTools;

function create()
{
    
    FlxG.camera.bgColor = 0xFF999999;
	curWacky = FlxG.random.getObject(getIntroTextShit());

    menuBG = new FunkinSprite(0,0, Paths.image('menus/titlescreen/titleIntro'));
	menuBG.addAnim('e0', '10000', 6, false);
	menuBG.addAnim('e1', '10', 6, false);
	menuBG.addAnim('e2', '20', 6, false);
	menuBG.addAnim('e3', '30', 6, false);
	menuBG.addAnim('e4', '40', 6, false);
	menuBG.addAnim('e5', '50', 8, false);
	menuBG.addAnim('e6', '60', 6, false);
	menuBG.addAnim('e7', '70', 6, false);
	menuBG.addAnim('e8', '80', 6, false);
    menuBG.playAnim('e0');
    menuBG.scale.x = menuBG.scale.y = 2;
    menuBG.screenCenter();
    add(menuBG);

    logo = new FunkinSprite(0,0, Paths.image('menus/logoBumpin'));
	logo.addAnim('idle', '', 24);
    logo.playAnim('idle');
    logo.scale.x = logo.scale.y = 0.75;
    logo.screenCenter();
    logo.y += -FlxG.height;
    add(logo);
    
    enter = new FunkinSprite(0,FlxG.height - 200 + menuBG.height, Paths.image('menus/titlescreen/titleEnter'));
	enter.addAnim('flash', 'ENTER PRESSED', 24, true);
	enter.addAnim('idle', 'Press Enter to Begin', 24, true);
    enter.playAnim('idle');
    enter.screenCenter(FlxAxes.X);
    
    
    var bars:FlxSprite = new FlxSprite(0,0);
    bars.loadGraphic(Paths.image('menus/titlebars'));
    bars.screenCenter();
    add(bars);

    
    collab = new FlxSprite(0,0);
    collab.loadGraphic(Paths.image('menus/titlescreen/collabLogo'));
    collab.screenCenter();
    collab.scale.x = collab.scale.y = 2;
    

    
	tities = new FlxText(250, 350, 0, curWacky[0], 36);
    tities.setFormat(Paths.font('vcr') + ".ttf", 32, 0xFFC54E3C, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.GRAY);
    tities.angle = -15;
    tities.scale.y = 0.75;
    tities.x += (tities.text.length*-0.4);
    tities.y += (tities.text.length*-0.2);
    add(tities);

    
	tities2 = new FlxText(500, 450, 0, curWacky[1], 36);
    tities2.setFormat(Paths.font('vcr') + ".ttf", 32, 0xFFC54E3C, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.GRAY);
    tities2.angle = 7;
    tities2.scale.y = 0.75;
    tities2.x += (tities2.text.length*-0.4);
    tities2.y += (tities2.text.length*-0.2);
    add(tities2);
    tities.visible = false;
    tities2.visible = false;

    add(enter);

    

    FlxG.sound.playMusic(Paths.music('freakyMenu'));
    
	//new FlxTimer().start(5, function(tmr:FlxTimer)
	//{
    //    FlxG.switchState(new MainMenuState());
	//});
}

function update(elapsed:Float) {
    if(FlxG.keys.justPressed.ENTER)
    {
        enter.playAnim('flash');
        FlxG.camera.flash(FlxColor.WHITE, 1);
        FlxG.sound.play(Paths.sound('menu/confirm'));
        new FlxTimer().start(1, function(tmr:FlxTimer)
	    {
            FlxG.switchState(new MainMenuState());
	    });
    }
}
function beatHit(curBeat:Int) {
    logo.playAnim('idle', true);
    
    if (curBeat == 14) FlxG.camera.flash(FlxColor.WHITE, 1);
    if (curBeat % 2 == 0) menuBG.playAnim('e'+(Math.floor(curBeat/2)+1));
    if (curBeat == 14) {
        FlxTween.tween(enter, {y: FlxG.height - 200}, 2, { startDelay: 0.5, ease: FlxEase.expoInOut });
        FlxTween.tween(logo, {y: logo.y+FlxG.height-50}, 2, { ease: FlxEase.expoOut });
    }
    if (curBeat == 6) add(collab);
    if (curBeat == 8) collab.visible = false;
    if (curBeat == 9) tities.visible = true;
    if (curBeat == 10) tities2.visible = true;
    if (curBeat == 12) { tities.visible = false; tities2.visible = false;}

	//tities.text = titleLines[curBeat - 1];
    //if (tities.text != null && tities.text != "") tities.text = tities.text.replace("wacky1", curWacky[0]).replace("wacky2", curWacky[1]);
    //tities.screenCenter();
    //if (curBeat == titleLines.length) {
    //    
    //}
}

function getIntroTextShit():Array<Array<String>>
{
	var fullText:String = Assets.getText(Paths.txt('titlescreen/introText'));
	var firstArray:Array<String> = fullText.split('\n');
	var swagGoodArray:Array<Array<String>> = [];
	for (i in firstArray)
	{
		swagGoodArray.push(i.split('--'));
	}
	return swagGoodArray;
}

var titleLines = [
	"Hylo\nPhoneix\nand\nthe team\n ",
	"Hylo\nPhoneix\nand\nthe team\npresents",
	"",
    "In association\nwith\n ",
    "In association\nwith\nYou're mother",
    "",
    "wacky1\n ",
    "wacky1\nwacky2",
    "",
    "Friday Night Corruption\n\n ",
    "Friday Night Corruption\nUnknown\n ",
    "Friday Night Corruption\nUnknown\nAlliance"
]