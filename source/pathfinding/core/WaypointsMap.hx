package pathfinding.core;

import pathfinding.core.Node;
import pathfinding.core.Heuristic;

class WaypointsMap implements IMap
{
	public var COST:Int = 10;

	public var nodes:Array<Node>;

	public function new()
	{
		nodes = new Array<Node>();
	}

	public function addNode(node:Node):Node
	{
		return nodes[nodes.length] = node;
	}

	public function heuristic(node1:Node, node2:Node):Float
	{
		var dx:Float = node1.x - node2.x;
		var dy:Float = node1.y - node2.y;
		return Heuristic.manhattan((dx > 0 ? dx : -dx), (dy > 0 ? dy : -dy));
	}

	public function getNeighbors(node:Node):Array<Node>
	{
		return [for (node in node.neighbors) if (node.walkable) node];
	}
}
