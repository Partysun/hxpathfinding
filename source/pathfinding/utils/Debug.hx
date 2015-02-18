package pathfinding.utils;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Graphics;
import openfl.text.TextField;
import openfl.text.TextFormat;

import pathfinding.core.GridMap;
import pathfinding.core.Path;
import pathfinding.core.Node;
using pathfinding.utils.GridMapTools;

typedef Point = {x:Int, y:Int}
   
/**
 *
 * @author: Yura Zatsepin
 */
class Debug
{
  private static inline var RED:Int = 0xFF3333;
  private static inline var BLUE:Int = 0x66B2FF;
  private static inline var GREEN:Int = 0xB2FF66;
  private static inline var PINK:Int = 0xFF69B4;

  public var display(default, null):Sprite;

  private var dx:Float;
  private var dy:Float;
  private var position:Array<Float>;
   
  public function new() 
  {
      display = new Sprite();
  }

  private function drawLine(x1:Float, y1:Float, x2:Float, y2:Float, color:Int = 0x00000020):Void
  {
	  display.graphics.lineStyle(1, color, 100);
      display.graphics.moveTo(x1, y1);
      display.graphics.lineTo(x2, y2);
  }

  public function clear():Void
  { 
      display.graphics.clear();
  }

  public function draw(map:GridMap, path:Path=null):Void
  {   
      var width = map.getWorldWidth();
      var height = map.getWorldHeight();
      dx = GridMapTools.pxWidthNode;
      dy = GridMapTools.pxHeightNode;
      position = map.getWorldPosition();

      // draw map
      for (x in 0...map.width)
      {
          drawLine(dx * x + position[0], 0, dx * x + position[0], height);
      }

      for (y in 0...map.height)
      {
          drawLine(0, dy * y + position[1], width, dy * y + position[1]);
      }

      // draw circles of start and goal node
      for(node in map.nodes)
      {
          if (!node.walkable) 
          {
              drawCircleFromNode(node, PINK);
          }
      }

      // draw path line
      if (path != null)
      {
          for(i in 0...path.nodes.length){
              if (i == path.nodes.length - 1)
                  break;
              drawLineBetweenNode(path.nodes[i], path.nodes[i+1]);
          }      
      }

      // draw start and goal node
      drawCircleFromNode(path.nodes[0], BLUE);
      drawCircleFromNode(path.nodes[path.nodes.length - 1], RED);

      // draw debug text information
      drawDebugInfo(map);
  }

  private function drawLineBetweenNode(node1:Node, node2:Node):Void
  {
      var node1Pos = getXYFromNode(node1);
      var node2Pos = getXYFromNode(node2);
      drawLine(node1Pos.x, node1Pos.y, node2Pos.x, node2Pos.y, 0x00880020);
  }

  private function drawCircleFromNode(node:Node, color:Int=BLUE):Void
  {
      var position = getXYFromNode(node);
      drawCircle(position.x, position.y, color);
  }

  private function drawDebugInfo(map:GridMap):Void
  {
      for (node in map.nodes)
      {
          var pathfindDebugData:TextField = new TextField();
          var tf = new TextFormat('Arial', 12, 0x000000);
          pathfindDebugData.text = node +"\n G: " + node.g + "\n F: " + node.f + "\n H: "+ node.h;
          pathfindDebugData.textColor = 0xFF0000;
          pathfindDebugData.width = dx;
          pathfindDebugData.defaultTextFormat = tf;
          var pos:Point = getXYFromNode(node);
          pathfindDebugData.x = pos.x - dx * .5;
          pathfindDebugData.y = pos.y - dy * .5;

          display.addChild(pathfindDebugData);
      }
  }

  private function drawCircle(x:Float, y:Float, color:Int=BLUE, size:Int=20):Void
  {
      display.graphics.beginFill(color);
      display.graphics.drawCircle(x, y, size);
  }

  private function getXY(xMap, yMap):Point
  {
      var dx = GridMapTools.pxWidthNode;
      var dy = GridMapTools.pxHeightNode;
      return {x:Std.int(dx * (xMap + 1) - dx * .5), y:Std.int(dy * (yMap + 1) - dy * .5)};
  }

  private function getXYFromNode(node:Node):Point
  {
      return getXY(node.x, node.y);
  }

}
