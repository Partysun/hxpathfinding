package pathfinding.core;


/**
 * A node in graph. 
 * This class holds some basic information about a node and custom 
 * attributes may be added.
 *
 * @param x - The x coordinate of the node on the grid.
 * @param y - The y coordinate of the node on the grid.
 * @param walkable - Whether this node is walkable.
 *
 * @author Yura Zatsepin
 */
class Node 
{
	public var x:Float;
	public var y:Float;
	public var walkable:Bool;
	public var neighbors:Array<Node>;
	public var parent:Node = null;
	public var g:Int = 0;
	public var f:Int = 0;

	public function new(x:Float, y:Float, walkable:Bool = true) 
	{
		this.x = x;
		this.y = y;
		this.walkable = walkable;
		this.neighbors = new Array<Node>();
	}

	public function toString():String
	{
		return "[" + x + ", " + y + "]";
	}

	public function equals(node:Node):Bool
	{
		return this.x == node.x && this.y == node.y;
	}

	public function isConnected():Bool
	{
		return neighbors.length > 0;	
	}
}
