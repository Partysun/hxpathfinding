package;

import openfl.Lib;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;

import pathfinding.core.GridMap;
import pathfinding.core.Node;
import pathfinding.core.Path;
import pathfinding.Pathfinding;
import pathfinding.utils.Debug;
using pathfinding.utils.GridMapTools;

/**
 * @author Yura Zatsepin
 **/
class Main extends Sprite
{
	private var pathfinder:Pathfinding;
	private var start_node:Node;
	private var goal_node:Node;
	private var map:GridMap;
	private var path:Path;

    static function main()
    {
        var stage = Lib.current.stage;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        // entry point
        
        var m = new Main();
        stage.addChild(m);
    }

    public function new()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

	public function init(e:Event)
	{
		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);

		map = new GridMap(7, 7);
        var dx = Std.int(Lib.current.stage.stageWidth / map.width);
        var dy = Std.int(Lib.current.stage.stageHeight / map.height);
        map.setWorldData(dx, dy, 0, 0);

        start_node = map.getNode(2, 1);
        goal_node = map.getNode(5, 4);
        map.getNode(5, 1).walkable = false;
        map.getNode(2, 2).walkable = false;
        map.getNode(3, 2).walkable = false;
        map.getNode(4, 2).walkable = false;

        pathfinder = new Pathfinding(map);
        path = pathfinder.findPath(start_node, goal_node);

        var debug = new Debug();
        debug.clear();
        debug.draw(map, path);
        addChild(debug.display);
	}

	// Event Handlers
	private function stage_onMouseDown(event:MouseEvent):Void 
	{
        //we should create dymanic logic
	}
}
