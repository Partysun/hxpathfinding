package pathfinding.core;

import pathfinding.core.Node;

/**
 * Interface for different map, 
 * like waypoint/grapth based map & grid based map.
 *
 * @author: Yura Zatsepin
 */
interface IMap
{
	public var COST:Int = 1;
	public var nodes:Array<Node>;

	public function addNode(node:Node):Node;
    public function heuristic(node1:Node, node2:Node):Float;
	public function getNeighbors(node:Node):Array<Node>;
}
