package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeGameHelpDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeGameHelpDialog";
       
      
      private var currentPage:int = 1;
      
      private var maxPage:int = 4;
      
      private const FRAME_BASIC:int = 1;
      
      private const FRAME_INGREDIENTS:int = 2;
      
      private const FRAME_STATS:int = 3;
      
      private const FRAME_MISC:int = 4;
      
      public function CafeGameHelpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.explainDialog.btn_basic.btn_basic.toolTipText = CafeModel.languageData.getTextById("dialogwin_ingamehelp_1_1");
         this.explainDialog.btn_ingredients.btn_ingredients.toolTipText = CafeModel.languageData.getTextById("dialogwin_ingamehelp_2_1");
         this.explainDialog.btn_stats.btn_stats.toolTipText = CafeModel.languageData.getTextById("dialogwin_ingamehelp_3_1");
         this.explainDialog.btn_misc.btn_misc.toolTipText = CafeModel.languageData.getTextById("dialogwin_ingamehelp_4_1");
         this.changePage(1);
      }
      
      private function changePage(param1:int) : void
      {
         this.currentPage = param1;
         this.explainDialog.mc_info.gotoAndStop(this.currentPage);
         this.setTabs();
         this.fillGameInfo();
      }
      
      private function setTabs() : void
      {
         this.explainDialog.btn_basic.gotoAndStop(this.currentPage == this.FRAME_BASIC ? 1 : 2);
         this.explainDialog.btn_ingredients.gotoAndStop(this.currentPage == this.FRAME_INGREDIENTS ? 1 : 2);
         this.explainDialog.btn_stats.gotoAndStop(this.currentPage == this.FRAME_STATS ? 1 : 2);
         this.explainDialog.btn_misc.gotoAndStop(this.currentPage == this.FRAME_MISC ? 1 : 2);
      }
      
      private function fillGameInfo() : void
      {
         var _loc1_:int = 1;
         while(this.explainDialog.mc_info["txt_text" + _loc1_])
         {
            this.explainDialog.mc_info.mouseChildren = this.explainDialog.mc_info.mouseEnabled = false;
            this.explainDialog.mc_info["txt_text" + _loc1_].text = CafeModel.languageData.getTextById("dialogwin_ingamehelp_" + this.currentPage + "_" + _loc1_);
            _loc1_++;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.explainDialog.btn_basic.btn_basic:
               this.changePage(this.FRAME_BASIC);
               break;
            case this.explainDialog.btn_ingredients.btn_ingredients:
               this.changePage(this.FRAME_INGREDIENTS);
               break;
            case this.explainDialog.btn_stats.btn_stats:
               this.changePage(this.FRAME_STATS);
               break;
            case this.explainDialog.btn_misc.btn_misc:
               this.changePage(this.FRAME_MISC);
               break;
            case this.explainDialog.btn_close:
               hide();
         }
      }
      
      private function get explainDialog() : CafeGameHelp
      {
         return disp as CafeGameHelp;
      }
   }
}
