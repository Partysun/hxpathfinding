package pathfinding.core;

import pathfinding.core.Node;


class WaypointsMap
{
	public var nodes:Array<Node>;

	public function new()
	{
		//initialize variables
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

class Heuristic
{

	/**
	 * Manhattan distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return dx + dy
	 */
	public static function manhattan(dx:Float, dy:Float):Float 
	{
		return dx + dy;
	}

	/**
	 * Euclidean distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return sqrt(dx * dx + dy * dy)
	 */
	public static function euclidean(dx:Float, dy:Float):Float
	{
		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Chebyshev distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return max(dx, dy)
	 */
	//public static function chebyshev(dx:Float, dy:Float):Float
	//{
		//return Math.max(dx, dy);
	//}
}
