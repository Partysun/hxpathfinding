package;

import massive.munit.Assert;

import pathfinding.core.GridMap;
import pathfinding.core.Node;
import pathfinding.core.Path;

import pathfinding.algorithms.AStar;

import pathfinding.Pathfinding;

using pathfinding.utils.GridMapTools;

/**
 * Test grid map
 *
 * @author: Yura Zatsepin
 */
class GridMapTest
{
	private var pathfinder:Pathfinding;
	private var start:Node;
	private var goal:Node;
	private var map:GridMap;
    private var aStar:AStar;

	public function new() {}

	@Before
	function before()
	{
        map = new GridMap(9, 9);
        pathfinder = new Pathfinding(map);
		aStar = new AStar();
	}

    @Test 
    function testFindShortestPath():Void 
    {
        var start = map.getNode(1, 1);
        var goal = map.getNode(2, 1);
        var path = pathfinder.findPath(start, goal);
        Assert.isTrue(path != null && path != Path.INVALID);
    }

    @Test
    function testAStarSearch():Void 
    {
        var aStar = new AStar();
        var start = map.getNode(1, 1);
        var goal = map.getNode(2, 1);
        var path = aStar.search(start, goal, map);
        Assert.isTrue(path != null && path != Path.INVALID);
    }

    @Test 
    function testBacktracePath():Void 
    {
        var node1:Node = new Node(50, 20);
        node1.parent = null;
        var node2:Node = new Node(70, 20);
        node2.parent = node1;
        //check smoke
        Assert.isTrue(Pathfinding.backtrace(node2).nodes.length == 2);
    }
	
    @Test 
    function testHeuristic():Void 
    {
        var node1:Node = new Node(50, 20);
        var node2:Node = new Node(70, 20);
        Assert.isTrue(map.heuristic(node1, node2) == 20);
    }

    /**
     * Find neighbors for the target
     *     0   1   2 
     *   +---+---+---+ 
     * 0 |   | 0 |   | 
     *   +---+---+---+ 
     * 1 | 3 | T | 1 | 
     *   +---+---+---+ 
     * 2 |   | 2 |   | 
     *   +---+---+---+ 
     */
    @Test 
    function testGetNeighbors():Void 
    {
        var target:Node = new Node(1, 1);
        var neighbors:Array<Node> = map.getNeighbors(target);
        Assert.isTrue(neighbors.length != 0);
        Assert.isTrue(neighbors[0].equals(map.getNode(1, 0)));
        Assert.isTrue(neighbors[1].equals(map.getNode(2, 1)));
        Assert.isTrue(neighbors[2].equals(map.getNode(1, 2)));
        Assert.isTrue(neighbors[3].equals(map.getNode(0, 1)));
        Assert.isTrue(neighbors.length == 4);

        map.getNode(0, 1).walkable = false;
        map.getNode(0, 2).walkable = false;
        neighbors = map.getNeighbors(target);
        Assert.isTrue(neighbors.length != 0);
        Assert.isTrue(neighbors.length == 3);
        Assert.isTrue(neighbors[0].equals(map.getNode(1, 0)));
        Assert.isTrue(neighbors[1].equals(map.getNode(2, 1)));
        Assert.isTrue(neighbors[2].equals(map.getNode(1, 2)));
    }

    @Test 
    function testGetNode():Void 
    {
        Assert.isTrue(
            map.getNode(0, 0).equals(new Node(0, 0)));
        Assert.isTrue(
            map.getNode(2, 1).equals(new Node(2, 1)));
        Assert.isTrue(
            map.getNode(2, 2).equals(new Node(2, 2)));

        map.getNode(1, 1).walkable = false;
        Assert.isFalse(map.isWalkable(1, 1));
        Assert.isTrue(map.isWalkable(0, 1));
        map.getNode(1, 1).walkable = true;
    }

    @Test
    function testGenerateMap():Void
    {
        var map = new GridMap(3, 3);
        Assert.isTrue(map.nodes != null);
        Assert.isTrue(map.nodes[0].x == 0);
        Assert.isTrue(map.nodes[0].y == 0);
        Assert.isTrue(map.nodes.length == 9);
        Assert.isTrue(map.nodes[8].x == 2);
        Assert.isTrue(map.nodes[8].y == 2);
    }

    @Test
    function testGridMapTools() {
        var map = new GridMap(3, 3);
        Assert.isTrue(map.nodes != null);
        map.setWorldData(10, 10);
        var node = map.getNodeByXY(11, 11);
        Assert.isTrue(node != null);
        Assert.isTrue(node.equals(map.getNode(1, 1)));
        map.setWorldData(10, 10, 10, 10);
        var node = map.getNodeByXY(20, 20);
        Assert.isTrue(node != null);
        Assert.isTrue(node.equals(map.getNode(1, 1)));
        var node = map.getNodeByXY(25, 25);
        Assert.isTrue(node != null);
        Assert.isTrue(node.equals(map.getNode(1, 1)));
        var node = map.getNodeByXY(29, 29);
        Assert.isTrue(node != null);
        Assert.isTrue(node.equals(map.getNode(1, 1)));
        var node = map.getNodeByXY(30, 30);
        Assert.isTrue(node != null);
        Assert.isTrue(node.equals(map.getNode(2, 2)));

        var node = map.getNodeByXY(0, 0);
        Assert.isTrue(node == null);
    }
}
