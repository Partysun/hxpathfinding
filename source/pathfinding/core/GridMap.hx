package pathfinding.core;

import pathfinding.core.Node;
import pathfinding.core.Heuristic;

/**
 * GridMap describes a simple rectangle map.
 *
 * @author: Yura Zatsepin
 */
class GridMap implements IMap
{
	public var COST:Int = 1;
    /**
     * A 2D array of nodes.
     */
	public var nodes:Array<Node> = new Array<Node>();

    public var width(default, null):Int;
    public var height(default, null):Int;

    /**
     * The Grid class, which serves as the encapsulation of the layout of the nodes.
     * @constructor
     * @param {Int} width Number of columns of the grid.
     * @param {Int} height Number of rows of the grid.
     *   
     */
	public function new(width:Int, height:Int)
    {
        this.width = width;
        this.height = height;

        for (x in 0...width) {
            for (y in 0...height) {
                this.addNode(new Node(x, y));
            }
        }
    }

    /**
     * Create GridMap object from integer matrix of nodes
     * @param {Array<Array<Int>>} [matrix] - A 0-1 matrix
     *     representing the walkable status of the nodes(0 for walkable).
     */
    public static function gridMapFromIntArray(matrix:Array<Array<Int>>):GridMap
    {
      //TODO: this
        return null;
    }

	public function addNode(node:Node):Node
	{
		return nodes[nodes.length] = node;
	}

	public function heuristic(node1:Node, node2:Node):Float
	{
		var dx:Float = node2.x - node1.x;
		var dy:Float = node2.y - node1.y;
		return Heuristic.manhattan(Math.abs(dx), Math.abs(dy));
	}

    /**
     * Find neighbors for the target
     *     0   1   2 
     *   +---+---+---+ 
     * 0 |   | 0 |   | 
     *   +---+---+---+ 
     * 1 | 3 | N | 1 | 
     *   +---+---+---+ 
     * 2 |   | 2 |   | 
     *   +---+---+---+ 
     */
	public function getNeighbors(node:Node):Array<Node>
	{
        var neighbors = new Array<Node>();
        // ↑
        if (this.isWalkable(node.x, node.y - 1))
        {
            neighbors.push(this.getNode(node.x, node.y - 1));
        }
        // →
        if (this.isWalkable(node.x + 1, node.y))
        {
            neighbors.push(this.getNode(node.x + 1, node.y));
        }
        // ↓
        if (this.isWalkable(node.x, node.y + 1))
        {
            neighbors.push(this.getNode(node.x, node.y + 1));
        }
        // ←
        if (this.isWalkable(node.x - 1, node.y))
        {
            neighbors.push(this.getNode(node.x - 1, node.y));
        }
		return neighbors;
	}

    public function getNode(x:Int, y:Int):Node
    {
        return nodes[width * x + y];
    }

    /**
     * Determine whether the node at the given position is walkable.
     * (Also returns false if the position is outside the grid.)
     * @param {Int} x - The x coordinate of the node.
     * @param {Int} y - The y coordinate of the node.
     * @return {Bool} - The walkability of the node.
     */
    public function isWalkable(x:Int, y:Int):Bool
    {
        return this.inBounds(x, y) && this.getNode(x, y).walkable;
    };


    /**
     * Determine whether the position is in bounds of the grid.
     * @param {Int} x
     * @param {Int} y
     * @return {Bool}
     */
    public inline function inBounds(x:Int, y:Int):Bool
    {
        return (x >= 0 && x < this.width) && (y >= 0 && y < this.height);
    };

    private function buildNodes(width:Int, height:Int, matrix:Array<Array<Int>>):Array<Node>
    {
        return null;
    }
}
