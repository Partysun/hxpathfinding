package pathfinding.utils;

import pathfinding.core.Node;
import pathfinding.core.GridMap;

/**
 * Tools for the GridMap
 *
 * @author: Yura Zatsepin
 */
class GridMapTools
{
    public static var pxWidthNode:Int = -1;
    public static var pxHeightNode:Int = -1;

    public static var pxXOffset:Int = -1;
    public static var pxYOffset:Int = -1;

    public function new() {}

    // return the node by real world x and y in pixels
    public static function getNodeByXY(map:GridMap, x:Float, y:Float):Node 
    {
        if (pxWidthNode == -1 || pxHeightNode == -1)
        {
            throw "Real world map data does not set up! Please provide world width/height of the node."; 
        }
        var xInGrid:Int = Std.int((x - (pxXOffset == -1 ? 0 : pxXOffset)) / pxWidthNode);
        var yInGrid:Int = Std.int((y - (pxYOffset == -1 ? 0 : pxYOffset)) / pxHeightNode);
        return map.getNode(xInGrid, yInGrid);
    }

    public static function setWorldData(map:GridMap, pxWidthNode:Int, pxHeightNode:Int, pxXOffset:Int=0, pxYOffset:Int=0):Void
    {
        GridMapTools.pxWidthNode = pxWidthNode;
        GridMapTools.pxHeightNode = pxHeightNode;
        GridMapTools.pxXOffset = pxXOffset;
        GridMapTools.pxYOffset = pxYOffset;
    }
}
