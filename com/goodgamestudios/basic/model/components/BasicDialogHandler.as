package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.basic.vo.BasicDialogVO;
   
   public class BasicDialogHandler
   {
      
      protected static var dialogHandler:BasicDialogHandler;
      
      public static const PRIORITY_LOW:int = 1;
      
      public static const PRIORITY_MIDDLE:int = 2;
      
      public static const PRIORITY_HIGH:int = 3;
      
      public static const PRIORITY_TOP:int = 4;
       
      
      private var _dialogs:Vector.<BasicDialogVO>;
      
      private var _dialog:BasicDialogVO;
      
      private var _blockDialogs:Boolean = false;
      
      private var _delay:Number = 0;
      
      public function BasicDialogHandler()
      {
         super();
         this.init();
         if(dialogHandler)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : BasicDialogHandler
      {
         if(!dialogHandler)
         {
            dialogHandler = new BasicDialogHandler();
         }
         return dialogHandler as BasicDialogHandler;
      }
      
      public function init() : void
      {
         this._dialogs = new Vector.<BasicDialogVO>();
      }
      
      public function registerDialogs(param1:String, param2:BasicDialogProperties = null, param3:Boolean = false, param4:int = 1, param5:Number = 0) : void
      {
         var _loc6_:BasicDialogVO;
         (_loc6_ = new BasicDialogVO()).name = param1;
         _loc6_.properties = param2;
         _loc6_.blockDialogs = param3;
         _loc6_.delay = param5;
         _loc6_.priority = param4;
         this._dialogs.push(_loc6_);
         this._dialogs.sort(this.sortDialogs);
      }
      
      private function sortDialogs(param1:BasicDialogVO, param2:BasicDialogVO) : Number
      {
         if(param1.priority > param2.priority)
         {
            return -1;
         }
         if(param1.priority < param2.priority)
         {
            return 1;
         }
         return 0;
      }
      
      public function showDialog(param1:Number = 0) : void
      {
         if(!this.isThereADialog())
         {
            return;
         }
         if(!this._blockDialogs)
         {
            this._dialog = this._dialogs.shift();
            this._blockDialogs = this._dialog.blockDialogs;
            this.layoutManager.showDialog(this._dialog.name,this._dialog.properties);
         }
      }
      
      public function onHideCurrentDialog() : void
      {
         if(this._dialog)
         {
            this._dialog = null;
            this.blockDialogs = false;
         }
      }
      
      public function isThereADialog() : Boolean
      {
         return this._dialogs.length > 0;
      }
      
      public function destroy() : void
      {
         this._dialogs = new Vector.<BasicDialogVO>();
      }
      
      protected function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      public function get blockDialogs() : Boolean
      {
         return this._blockDialogs;
      }
      
      public function set blockDialogs(param1:Boolean) : void
      {
         this._blockDialogs = param1;
      }
   }
}
