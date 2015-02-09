package pathfinding.core;

class Heuristic
{

	/**
	 * Manhattan distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return dx + dy
	 */
	public static function manhattan(dx:Float, dy:Float):Float 
	{
		return dx + dy;
	}

	/**
	 * Euclidean distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return sqrt(dx * dx + dy * dy)
	 */
	public static function euclidean(dx:Float, dy:Float):Float
	{
		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Chebyshev distance.
	 * @param dx - Difference in x.
	 * @param dy - Difference in y.
	 * @return max(dx, dy)
	 */
	//public static function chebyshev(dx:Float, dy:Float):Float
	//{
		//return Math.max(dx, dy);
	//}
}
