package;

import massive.munit.Assert;

import pathfinding.core.WaypointsMap;
import pathfinding.core.Node;
import pathfinding.core.Path;
import pathfinding.Pathfinding;

/**
 * Test: Find the shortest path between two waipoints on the map
 *
 * @author: Yura Zatsepin
 */
class PathfindingTest
{
	private var pathfinder:Pathfinding;
	private var start:Node;
	private var goal:Node;
	private var map:WaypointsMap;

	public function new() {}

	@Before
	function before()
	{
		//create the test demo map of waypoints
		map = new WaypointsMap();
		start = map.addNode(new Node(0, 0));
		map.addNode(new Node(20, 0));
		map.addNode(new Node(50, 0));
		goal = map.addNode(new Node(50, 20));
		map.addNode(new Node(70, 0));

		map.nodes[0].neighbors.push(map.nodes[1]);

		map.nodes[1].neighbors.push(map.nodes[0]);
		map.nodes[1].neighbors.push(map.nodes[2]);

		map.nodes[2].neighbors.push(map.nodes[1]);
		map.nodes[2].neighbors.push(map.nodes[3]);
		map.nodes[2].neighbors.push(map.nodes[4]);

		map.nodes[3].neighbors.push(map.nodes[2]);

		map.nodes[4].neighbors.push(map.nodes[2]);

		// init the pathfinder
		pathfinder = new Pathfinding(map);
	}

	@Test 
	function testFindShortestPath():Void 
	{
		var path = pathfinder.findPath(start, goal);
		//check smoke
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

	@Test 
	function testGetNeighbors():Void 
	{
		var neighbors:Array<Node> = map.getNeighbors(start);
		Assert.isTrue(neighbors[0].equals(map.nodes[1]));

		neighbors = map.getNeighbors(map.nodes[2]);
		Assert.isTrue(neighbors[0].equals(map.nodes[1]));
		Assert.isTrue(neighbors[1].equals(map.nodes[3]));
		Assert.isTrue(neighbors[2].equals(map.nodes[4]));
		Assert.isFalse(neighbors[0].equals(map.nodes[0]));

		map.nodes[3].walkable = false;
		neighbors = map.getNeighbors(map.nodes[2]);
		Assert.isTrue(neighbors.length == 2);
	}
}
