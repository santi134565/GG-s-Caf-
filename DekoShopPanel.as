package
{
   import flash.display.MovieClip;
   
   public dynamic class DekoShopPanel extends MovieClip
   {
       
      
      public var btn_functional_Extras:Extras;
      
      public var btn_functional_Fridge:Fridges;
      
      public var btn_functional_Stove:Stove;
      
      public var j3:DekoShopItem;
      
      public var btn_close:Check;
      
      public var btn_deko_Deko:DecoElements;
      
      public var btn_decoshophelp:playerinfo;
      
      public var j4:DekoShopItem;
      
      public var btn_arrowright:right;
      
      public var blockLayer:MovieClip;
      
      public var btn_deko_Door:Doors;
      
      public var btn_functional_Counter:Counter;
      
      public var btn_expansion:Erweiterungen;
      
      public var btn_sell:DragdropSell;
      
      public var btn_deko:decoshop;
      
      public var btn_arrowleft:left;
      
      public var btn_deko_Table:Tables;
      
      public var mc_decotooltip:MovieClip;
      
      public var btn_functional:FunktionalItems;
      
      public var btn_deko_Wallobject:Windows;
      
      public var btn_deko_Wall:Wallpapers;
      
      public var btn_deko_Chair:Chairs;
      
      public var btn_deko_Tiles:FloorElements;
      
      public var j0:DekoShopItem;
      
      public var j1:DekoShopItem;
      
      public var j2:DekoShopItem;
      
      public function DekoShopPanel()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
   }
}
