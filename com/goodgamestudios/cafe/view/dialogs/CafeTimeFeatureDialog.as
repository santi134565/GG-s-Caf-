package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class CafeTimeFeatureDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeTimeFeatureDialog";
      
      public static const featureDialogs:Array = [LtdFeatureDialog_2,LtdFeatureDialog_3,LtdFeatureDialog_5,LtdFeatureDialog_12,LtdFeatureDialog_13,LtdFeatureDialog_14,LtdFeatureDialog_15];
       
      
      public function CafeTimeFeatureDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         this.featureDialog.txt_title.text = CafeModel.languageData.getTextById("limitedfeatureDialog_title");
         this.featureDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
         while(this.featureDialog.mc_featurecontainer.numChildren > 0)
         {
            this.featureDialog.mc_featurecontainer.removeChildAt(0);
         }
         var _loc1_:Class = getDefinitionByName("LtdFeatureDialog_" + this.featureDialogProperties.eventId) as Class;
         var _loc2_:MovieClip = new _loc1_();
         if(_loc2_)
         {
            this.featureDialog.mc_featurecontainer.addChild(_loc2_);
            this.fillItems(_loc2_,this.featureDialogProperties.eventId);
         }
         updateAllTextFields();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.featureDialog.btn_ok:
               hide();
         }
      }
      
      private function fillItems(param1:MovieClip, param2:int) : void
      {
         var _loc3_:int = param1.mc_textcontainer.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param1.mc_textcontainer["txt_" + _loc4_].text = CafeModel.languageData.getTextById("limitedfeatureDialog_" + param2 + "_copy_" + _loc4_);
            _loc4_++;
         }
         this.featureDialog.mc_sticker.visible = this.featureDialogProperties.daysleft > -1;
         this.featureDialog.mc_sticker.txt_time.text = CafeModel.languageData.checkSingleOrMultiText(this.featureDialogProperties.daysleft,"limitedfeatureDialog_time",[this.featureDialogProperties.daysleft]);
      }
      
      protected function get featureDialogProperties() : CafeTimeFeatureDialogProperties
      {
         return properties as CafeTimeFeatureDialogProperties;
      }
      
      private function get featureDialog() : LtdFeatureDialog
      {
         return disp as LtdFeatureDialog;
      }
   }
}
