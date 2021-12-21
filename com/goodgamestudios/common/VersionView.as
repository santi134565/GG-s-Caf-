package com.goodgamestudios.common
{
   import flash.display.Sprite;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuBuiltInItems;
   import flash.ui.ContextMenuItem;
   
   public class VersionView
   {
       
      
      public function VersionView()
      {
         super();
      }
      
      public static function addVersionToContextMenu(view:Sprite, versionText:String) : void
      {
         var _loc4_:ContextMenu;
         (_loc4_ = new ContextMenu()).hideBuiltInItems();
         var _loc5_:ContextMenuBuiltInItems;
         (_loc5_ = _loc4_.builtInItems).print = true;
         var _loc3_:ContextMenuItem = new ContextMenuItem(versionText,true);
         _loc4_.customItems.push(_loc3_);
         view.contextMenu = _loc4_;
      }
   }
}
