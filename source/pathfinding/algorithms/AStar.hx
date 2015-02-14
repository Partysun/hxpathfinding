package pathfinding.algorithms;

import pathfinding.core.IMap;
import pathfinding.core.Heuristic;
import pathfinding.core.Node;
import pathfinding.core.Path;

/**
 * A* path-finder.
 * based upon https://github.com/bgrins/javascript-astar
 */
//TODO: added weight to find more optimal path
class AStar 
{

    public function new() {}

	private function sortFunc(node1:Node, node2:Node):Int
	{
		return node2.f - node1.f;
	}

	public function search(start:Node, goal:Node, map:IMap):Path
	{
        var openList = new Array<Node>();
        var closedList = new Array<Node>();
        //openList = [];
        //closedList = [];
		var current:Node = start;
		var neighbors:Array<Node> = null;
		var nextG:Int = 0;
		openList.push(start);
		start.g = 0;
		start.f = Std.int(map.heuristic(start, goal));

		while (openList.length != 0) {
            openList.sort(sortFunc);
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
				nextG = current.g + map.COST;
 
				var contains:Bool = openList.indexOf(neighbor) != -1;
                
				// check if the neighbor has not been inspected yet, or
				// can be reached with smaller cost from the current node
                if (contains)
                {
                    if (nextG < neighbor.g) 
                    {
                        neighbor.g = nextG;
					    neighbor.parent = current;
                    }
                }
                else {
                    neighbor.g = nextG;
                    neighbor.h = Std.int(map.heuristic(neighbor, goal));
                    neighbor.f = neighbor.g + neighbor.h;
                    neighbor.parent = current;
                    openList.push(neighbor);
                }
				//if (!contains || nextG < neighbor.g)
				//{
					//neighbor.g = nextG;
                    //neighbor.h = Std.int(map.heuristic(neighbor, goal));
                    //neighbor.f = neighbor.g + neighbor.h;
					//neighbor.parent = current;
 
					//if (!contains)
					//{
						//openList.push(neighbor);
					//}
					//else 
					//{
						//// the neighbor can be reached with smaller cost.
						//// Since its f value has been updated, we have to
						//// update its position in the open list
					//}
				//}
			}
		}
		return Path.INVALID;
	}
}
