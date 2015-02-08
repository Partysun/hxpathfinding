package pathfinding.core;


/**
 * A path of several nodes. 
 *
 * @author Yura Zatsepin
 */
class Path
{
	public static var INVALID:Path = new Path();
	public var nodes:Array<Node>;

	public function new()
	{
		nodes = new Array<Node>();
	}

	public function getGoal():Node
	{
		if (nodes.length == 0)
			return null;
		return nodes[nodes.length - 1];
	}

	public function getStart():Node
	{
		if (nodes.length == 0)
			return null;
		return nodes[0];
	}

	public function toString():String
	{
		var res:String = "( ";
		for (node in nodes)
		{
			res = res + node.toString() + " --> ";
		}
		return res + ")";

	}
	
}
