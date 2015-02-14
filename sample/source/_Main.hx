package;


import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Graphics;
import openfl.text.TextField;
import openfl.text.TextFormat;

import pathfinding.core.WaypointsMap;
import pathfinding.core.Node;
import pathfinding.core.Path;
import pathfinding.Pathfinding;
typedef PF = Pathfinding;

class Main extends Sprite
{
	private static inline var CIRCLE_RADIUS:Int = 14;
	private static inline var RED:Int = 0xFF3333;
	private static inline var BLUE:Int = 0x66B2FF;
	private static inline var GREEN:Int = 0xB2FF66;
	private static inline var PINK:Int = 0xFF69B4;

	private var pathfinder:PF;
	private var start:Node;
	private var goal:Node;
	private var map:WaypointsMap;
	private var path:Path;

	public function new ()
	{
		super ();
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);

		map = generateMap();
		drawMap(map);

		createLabel(stage.stageWidth / 100 * 10, 50,
				"Pathfinding A* + Manhattan & Euqlid heuristik");
	}
	
	private function drawMap(map:WaypointsMap):Void
	{
		var g:Graphics=graphics;
		g.lineStyle(1, 0x00000020, 100);
		for (node in map.nodes)
		{
			createNode(node);
			g.moveTo(node.x, node.y);
			for (neighbor in node.neighbors)
			{
				g.moveTo(node.x, node.y);
				g.lineTo(neighbor.x, neighbor.y);
			}
		}
	}
	
	private function generateMap():WaypointsMap
	{
		var baseX:Int = Std.int(stage.stageWidth / 100 * 12);
		var baseY:Int = Std.int(stage.stageHeight * .5 - CIRCLE_RADIUS * .5);

		var map = new WaypointsMap();
		start = map.addNode(new Node(baseX, baseY));
		map.addNode(new Node(baseX + 70, baseY));
		map.addNode(new Node(baseX + 150, baseY));
		map.addNode(new Node(baseX + 150, baseY + 70));
		goal = map.addNode(new Node(baseX + 270, baseY));

		map.nodes[0].neighbors.push(map.nodes[1]);

		map.nodes[1].neighbors.push(map.nodes[0]);
		map.nodes[1].neighbors.push(map.nodes[2]);
		//map.nodes[1].neighbors.push(map.nodes[3]);

		map.nodes[2].neighbors.push(map.nodes[1]);
		//map.nodes[2].neighbors.push(map.nodes[3]);
		map.nodes[2].neighbors.push(map.nodes[4]);

		//map.nodes[3].neighbors.push(map.nodes[2]);

		map.nodes[4].neighbors.push(map.nodes[2]);

		return map;
	}

	private function getNodeByXY(x:Float, y:Float)
	{
		for (node in map.nodes)	
		{
			if (Math.abs(x - node.x) < 10 && Math.abs(y - node.y) < 10)	
				return node;
		}
		return null;
	}

	private function createNode(node:Node):Void
	{
		createCircle(node.x, node.y);
		if (node.equals(start))
			createCircle(node.x, node.y, GREEN, 10, 1);
		if (node.equals(goal))
			createCircle(node.x, node.y, RED, 10, 1);
		createLabel(node.x, node.y, map.nodes.indexOf(node) + "");
	}
	
	private function createCircle(x:Float, y:Float, color:Int=BLUE, size:Int=CIRCLE_RADIUS, index:Int=0):Void
	{
		var circle = new Sprite();
		
		circle.graphics.beginFill(color);
		circle.graphics.drawCircle(0, 0, CIRCLE_RADIUS);
		//circle.alpha = 0.6;
		circle.x = x;
		circle.y = y;
		
		//addChildAt(circle, index);
		addChild(circle);
	}

	private function createLabel(x:Float, y:Float, text:String, color=0x0)
	{
		var textField = new TextField();
		
		var myfmt:TextFormat = new TextFormat();
		myfmt.color = color;
		myfmt.size = 20;
		textField.defaultTextFormat = myfmt;
		textField.selectable = false;
		textField.x = x - 8;
		textField.y = y - 15;
		textField.width = 500;
		textField.height = 100;
		textField.text = text;
		
		addChild(textField);
	}
	
	// Event Handlers
	private function stage_onMouseDown(event:MouseEvent):Void 
	{
		var t = getNodeByXY(event.stageX, event.stageY);
		if (t != null)
		{
			goal = t;
			path = null;	
			drawMap(map);
		}

		if (path !=null && path.nodes.length > 0)
		{
			path = null;	
			drawMap(map);
		}
		else
		{
			pathfinder = new Pathfinding(map);
			path = pathfinder.findPath(start, goal);
			for (node in path.nodes)
			{
				if (node != goal && node != start)
					createCircle(node.x, node.y, PINK, CIRCLE_RADIUS, 0);
			}
		}
		//cacheMouse = new Point (event.stageX, event.stageY);
	}
}
