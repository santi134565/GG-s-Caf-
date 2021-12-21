package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeMasteryCompleteDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMasteryCompleteDialog";
       
      
      private var dishWod:BasicDishVO;
      
      public function CafeMasteryCompleteDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.dishWod = CafeModel.wodData.voList[this.masteryCompleteProperties.wodId] as BasicDishVO;
         this.masteryCompleteDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
         this.masteryCompleteDialog.btn_cancle.label = CafeModel.languageData.getTextById("btn_text_cancle");
         this.masteryCompleteDialog.btn_share.label = CafeModel.languageData.getTextById("btn_text_share");
         this.masteryCompleteDialog.m1.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_broncestar");
         this.masteryCompleteDialog.m2.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_silverstar");
         this.masteryCompleteDialog.m3.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_goldstar");
         this.masteryCompleteDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_dishmastery_title");
         if(env.enableLonelyCow)
         {
            this.masteryCompleteDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_dishmastery_copy_1");
         }
         else
         {
            this.masteryCompleteDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_dishmastery_copy_0",[CafeModel.languageData.getTextById("recipe_" + this.dishWod.type.toLowerCase())]);
         }
         this.masteryCompleteDialog.btn_share.visible = env.enableLonelyCow;
         this.masteryCompleteDialog.btn_cancle.visible = env.enableLonelyCow;
         this.masteryCompleteDialog.btn_ok.visible = !env.enableLonelyCow;
         this.addDishPic(this.dishWod);
         var _loc1_:int = CafeModel.masteryData.getMasteryLevel(this.dishWod.wodId);
         if(env.enableLonelyCow)
         {
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 4)
         {
            this.masteryCompleteDialog["m" + _loc2_].gotoAndStop(2);
            if(_loc2_ == _loc1_)
            {
               this.masteryCompleteDialog["m" + _loc2_].visible = true;
            }
            else
            {
               this.masteryCompleteDialog["m" + _loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function addDishPic(param1:BasicDishVO) : void
      {
         var _loc2_:Class = getDefinitionByName(param1.getVisClassName()) as Class;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.gotoAndStop(BasicDishVO.GFX_FRAME_READY);
         var _loc4_:Rectangle = _loc3_.getBounds(null);
         _loc3_.x = -(_loc4_.width / 2 + _loc4_.left);
         _loc3_.y = -(_loc4_.height / 2 + _loc4_.top);
         while(this.masteryCompleteDialog.mc_dishHolder.numChildren > 0)
         {
            this.masteryCompleteDialog.mc_dishHolder.removeChildAt(0);
         }
         this.masteryCompleteDialog.mc_dishHolder.addChild(_loc3_);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.masteryCompleteDialog.btn_share:
               CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_DISHMASTERY,[this.masteryCompleteProperties.spamId,CafeModel.languageData.getTextById("recipe_" + this.dishWod.type.toLowerCase())]);
               hide();
               break;
            case this.masteryCompleteDialog.btn_ok:
            case this.masteryCompleteDialog.btn_cancle:
               hide();
         }
      }
      
      protected function get masteryCompleteProperties() : CafeMasteryCompleteDialogProperties
      {
         return properties as CafeMasteryCompleteDialogProperties;
      }
      
      protected function get masteryCompleteDialog() : CafeMasteyComplete
      {
         return disp as CafeMasteyComplete;
      }
   }
}
