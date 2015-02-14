package;

import openfl.Lib;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Graphics;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;

import pathfinding.core.GridMap;
import pathfinding.core.Node;
import pathfinding.core.Path;
import pathfinding.Pathfinding;
typedef PF = Pathfinding;
typedef Point = {x:Int, y:Int}

class Main extends Sprite
{
	private static inline var RED:Int = 0xFF3333;
	private static inline var BLUE:Int = 0x66B2FF;
	private static inline var GREEN:Int = 0xB2FF66;
	private static inline var PINK:Int = 0xFF69B4;

	private var pathfinder:PF;
	private var start_node:Node;
	private var goal_node:Node;
	private var map:GridMap;
	private var path:Path;
    private var mapLayer:Sprite;

    private var lines:Sprite;

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

		map = new GridMap(9, 9);

        start_node = map.getNode(2, 1);
        goal_node = map.getNode(5, 4);
        map.getNode(5, 1).walkable = false;
        map.getNode(2, 2).walkable = false;
        map.getNode(3, 2).walkable = false;
        map.getNode(4, 2).walkable = false;

		mapLayer = drawMap(map);
        var start = createCircleFromNode(start_node);
        var goal = createCircleFromNode(goal_node);

        lines = new Sprite();
        addChild(lines);

        pathfinder = new Pathfinding(map);
        path = pathfinder.findPath(start_node, goal_node);


        for (i in 0...path.nodes.length)
        {
            if (i == path.nodes.length - 1)
                break;
            lineBetweenNode(path.nodes[i], path.nodes[i+1]);
        }
        //drawDebugInfo();
	}

    private function drawDebugInfo():Void
    {
        for (node in map.nodes)
        {
            var dx = width / map.width;
            var dy = height / map.height;
            //trace(node.toString() + " : G: " +  node.g + " F: " + node.f);
            var pathfindDebugData:TextField = new TextField();
            var tf = new TextFormat('Arial', 12, 0x000000);
            pathfindDebugData.text = node +"\n G: " + node.g + "\n F: " + node.f + "\n H: "+ node.h;
            pathfindDebugData.textColor = 0xFF0000;
            pathfindDebugData.width = dx;
            pathfindDebugData.defaultTextFormat = tf;     // This line is the x factor most likely.
            var pos:Point = getXY(node.x, node.y);
            pathfindDebugData.x = pos.x - dx * .5;
            pathfindDebugData.y = pos.y - dy * .5;

		    var debugLayer:Sprite = new Sprite();
            debugLayer.addChild(pathfindDebugData);
            addChild(debugLayer);
        }
    }

    private function getXY(xMap, yMap):Point
    {
        var dx = width / map.width;
        var dy = height / map.height;
        return {x:Std.int(dx * (xMap + 1) - dx * .5), y:Std.int(dy * (yMap + 1) - dy * .5)};
    }

    private function getXYFromNode(node:Node):Point
    {
        return getXY(node.x, node.y); 
    }
	
	private function drawMap(map:GridMap):Sprite
	{
      //Actuate.update (customResize, 1, [100, 100], [300, 300]);
        var width = Lib.current.stage.stageWidth;
        var height = Lib.current.stage.stageHeight;
        var dx = width / map.width;
        var dy = height / map.height;

		var gridMap:Sprite = new Sprite();
		var g = gridMap.graphics;
		g.lineStyle(1, 0x00000020, 100);
        for (x in 0...map.width)
        {
            g.moveTo(dx * x, 0);
            g.lineTo(dx * x, height);
        }
        for (y in 0...map.height)
		{
			g.moveTo(0, dy * y);
		    g.lineTo(width, dy * y);
		}
		this.addChild(gridMap);

        for (node in map.nodes)
        {
            if (!node.walkable) 
            {
                createCircleFromNode(node, PINK);
            }
        }
        return gridMap;
	}
	
	private function createCircle(x:Float, y:Float, color:Int=BLUE, size:Int=20):Sprite
	{
		var circle = new Sprite();
		
		circle.graphics.beginFill(color);
		circle.graphics.drawCircle(0, 0, size);
		//circle.alpha = 0.6;
		circle.x = x;
		circle.y = y;
		
		addChild(circle);
        return circle;
	}

	private function createCircleFromNode(node:Node, color:Int=BLUE):Sprite
    {
        var position = getXYFromNode(node);
        return createCircle(position.x, position.y, color);
    }

    private function lineBetweenNode(node1:Node, node2:Node):Void
    {
        var node1Pos = getXYFromNode(node1);
        var node2Pos = getXYFromNode(node2);
        var g = lines.graphics;
        g.moveTo(node1Pos.x, node1Pos.y);
		g.lineStyle(1, 0x00880020, 100);
        g.lineTo(node2Pos.x, node2Pos.y);
    }

	// Event Handlers
	private function stage_onMouseDown(event:MouseEvent):Void 
	{
		//var t = getNodeByXY(event.stageX, event.stageY);
		//if (t != null)
		//{
			//goal = t;
			//path = null;	
			//drawMap(map);
		//}

		//if (path !=null && path.nodes.length > 0)
		//{
			//path = null;	
			//drawMap(map);
		//}
		//else
		//{
			//pathfinder = new Pathfinding(map);
			//path = pathfinder.findPath(start, goal);
			//for (node in path.nodes)
			//{
				//if (node != goal && node != start)
					//createCircle(node.x, node.y, PINK, CIRCLE_RADIUS, 0);
			//}
		//}
		//cacheMouse = new Point (event.stageX, event.stageY);
	}
}
