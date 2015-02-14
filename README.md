PathFinding (Haxe Library)
==============
## The 'KISS' path-finding library in haxe. ##

*Haxe* is awesome language for game development. And Haxe should has the cool *easy to use* pathfinding lib.

Install
------

`haxelib git pathfinding git@github.com:Partysun/hxpathfinding.git`

And then in your project's hxml build file, add

`-lib pathfinding`


Usage
-----------

`AStarFinder` is the first algorythm in the library.

GridMap example:
```haxe
var map:GridMap = new GridMap(9, 9);
start_node = map.getNode(2, 1);
goal_node = map.getNode(5, 4);
map.getNode(5, 1).walkable = false;
map.getNode(2, 2).walkable = false;
map.getNode(3, 2).walkable = false;
map.getNode(4, 2).walkable = false;

var pathfinder = new Pathfinding(map);
var path = pathfinder.findPath(start_node, goal_node);

trace("Path:" + path);
```

WaypointsMap example:
```haxe
import pathfinding.Pathfinding;
import pathfinding.core.WaypointsMap;
import pathfinding.core.Node;
import pathfinding.core.Path;

var map = new WaypointsMap();
// map generation
start = map.addNode(new Node(baseX, baseY));
map.addNode(new Node(baseX + 70, baseY));
map.addNode(new Node(baseX + 150, baseY));
map.addNode(new Node(baseX + 150, baseY + 70));
goal = map.addNode(new Node(baseX + 270, baseY));
map.nodes[0].neighbors.push(map.nodes[1]);
map.nodes[1].neighbors.push(map.nodes[0]);
map.nodes[1].neighbors.push(map.nodes[2]);
map.nodes[2].neighbors.push(map.nodes[1]);
map.nodes[2].neighbors.push(map.nodes[4]);
map.nodes[4].neighbors.push(map.nodes[2]);

// find path
var pathfinder = new Pathfinding(map);
var path = pathfinder.findPath(start, goal);

trace("Path:");
for (node in path.nodes)
{
    trace(node + "");
}
```
