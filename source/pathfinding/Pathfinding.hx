package pathfinding;

import pathfinding.core.WaypointsMap;
import pathfinding.core.Node;
import pathfinding.core.Path;

/**
 * Find the shortest path between two waipoints on the map
 *
 *
 * @author Yura Zatsepin
 */
class Pathfinding
{
	public var map:WaypointsMap;
	private var aStar:AStar;

	public function new(map:WaypointsMap)
	{
		this.map = map;
		aStar = new AStar();
	}

	public function findPath(start:Node, goal:Node):Path 
	{
		return aStar.search(start, goal, map);
	}

	/**
	 * Backtrace according to the parent records and return the path.
	 * (including both start and end nodes)
	 * @param node End node
	 * @return the path
	 */
	public static function backtrace(node:Node):Path {
		var path:Path = new Path();
		path.nodes.push(node);
		while (node.parent != null) {
			node = node.parent;
			path.nodes.push(node);
		}
		path.nodes.reverse();
		return path;
	}
}

/**
 * A* path-finder.
 * based upon https://github.com/bgrins/javascript-astar
 */
//TODO: added weight to find more optimal path
class AStar 
{
	private static inline var COST:Int = 10;

	var openList = new Array<Node>();
	var closedList = new Array<Node>();



	private function sortFunc(node1:Node, node2:Node):Int
	{
		return node1.f - node2.f;
	}

	public function search(start:Node, goal:Node, map:WaypointsMap):Path
	{
		var current:Node = null;
		var neighbors:Array<Node> = null;
		var nextG:Int = 0;
		openList.push(start);
		start.g = 0;
		start.f = Std.int(map.heuristic(start, goal));

		while (openList.length != 0) {
			// pop the position of node which has the minimum `f` value.
			current = openList.pop();
			closedList.push(current);

			// if reached the end position, construct the path and return it
			if (current.equals(goal)) 
			{
				return Pathfinding.backtrace(goal);
			}

			neighbors = map.getNeighbors(current);
			for (neighbor in neighbors) 
			{
				if (closedList.indexOf(neighbor) != -1)
					continue;
 
				// get the distance between current node and the neighbor
				// and calculate the next g score
				nextG = current.g + COST;
 
				var contains:Bool = openList.indexOf(neighbor) != -1;
				// check if the neighbor has not been inspected yet, or
				// can be reached with smaller cost from the current node
				if (!contains || nextG < neighbor.g)
				{
					neighbor.g = nextG;
					neighbor.f = Std.int(map.heuristic(neighbor, goal));
					neighbor.parent = current;
 
					if (!contains)
					{
						openList.push(neighbor);
					}
					else 
					{
						// the neighbor can be reached with smaller cost.
						// Since its f value has been updated, we have to
						// update its position in the open list
						openList.sort(sortFunc);
					}
				}
			}
		}
		return Path.INVALID;
	}
}
