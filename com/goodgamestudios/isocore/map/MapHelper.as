package com.goodgamestudios.isocore.map
{
   import flash.geom.Point;
   
   public class MapHelper
   {
       
      
      public function MapHelper()
      {
         super();
      }
      
      public static function isXYonMap(param1:Point, param2:Point) : Boolean
      {
         if(param1)
         {
            if(param1.x >= 0 && param1.y >= 0)
            {
               if(param1.y < param2.y && param1.x < param2.x)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
