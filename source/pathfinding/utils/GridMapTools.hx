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
    public static var pxWidthNode:Float = -1;
    public static var pxHeightNode:Float = -1;

    public static var pxXOffset:Float = -1;
    public static var pxYOffset:Float = -1;

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

    // return the midpoint of the node in real world coordinates (px)
    public static function getMidpointXYByNode(map:GridMap, node:Node):Array<Float> 
    {
        if (pxWidthNode == -1 || pxHeightNode == -1)
        {
            throw "Real world map data does not set up! Please provide world width/height of the node."; 
        }
        var midX = (pxWidthNode * node.x + pxWidthNode * .5) + (pxXOffset == -1 ? 0 : pxXOffset);
        var midY = (pxHeightNode * node.y + pxHeightNode * .5) + (pxYOffset == -1 ? 0 : pxYOffset);

        return [midX, midY];
    }

    public static function getMidpointXYByNodeXY(map:GridMap, x:Float, y:Float):Array<Float> 
    {
        checkSetUp();
        var midX = (pxWidthNode * x + pxWidthNode * .5) + (pxXOffset == -1 ? 0 : pxXOffset);
        var midY = (pxHeightNode * y + pxHeightNode * .5) + (pxYOffset == -1 ? 0 : pxYOffset);

        return [midX, midY];
    }

    public static function setWorldData(map:GridMap, pxWidthNode:Int, pxHeightNode:Int, pxXOffset:Int=0, pxYOffset:Int=0):Void
    {
        GridMapTools.pxWidthNode = pxWidthNode;
        GridMapTools.pxHeightNode = pxHeightNode;
        GridMapTools.pxXOffset = pxXOffset;
        GridMapTools.pxYOffset = pxYOffset;
    }

    private static inline function checkSetUp():Bool
    {
        if (pxWidthNode == -1 || pxHeightNode == -1)
        {
            throw "Real world map data does not set up! Please provide world width/height of the node."; 
        }
        return true;
    }

    public static function getWorldWidth(map:GridMap):Float
    {
        checkSetUp();
        return pxWidthNode * map.width;
    }

    public static function getWorldHeight(map:GridMap):Float
    {
        checkSetUp();
        return pxHeightNode * map.height;
    }

    public static function getWorldPosition(map:GridMap):Array<Float>
    {
        checkSetUp();
        return [pxXOffset, pxYOffset];
    }
}
