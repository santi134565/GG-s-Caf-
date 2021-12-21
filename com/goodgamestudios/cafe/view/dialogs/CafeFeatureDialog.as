package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class CafeFeatureDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeFeatureDialog";
      
      public static const featureDialogs:Array = [FeatureDialog_21,FeatureDialog_22,FeatureDialog_23,FeatureDialog_24,FeatureDialog_25,FeatureDialog_26,FeatureDialog_27,FeatureDialog_28,FeatureDialog_29,FeatureDialog_30,FeatureDialog_31,FeatureDialog_32,FeatureDialog_33];
       
      
      private var removingFeature:Boolean = false;
      
      public function CafeFeatureDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         while(this.featureDialog.mc_featurecontainer.numChildren > 0)
         {
            this.featureDialog.mc_featurecontainer.removeChildAt(0);
         }
         var _loc1_:Class = getDefinitionByName("FeatureDialog_" + this.featureDialogProperties.featureId) as Class;
         var _loc2_:MovieClip = new _loc1_();
         if(_loc2_)
         {
            this.featureDialog.mc_featurecontainer.addChild(_loc2_);
            this.fillItems(_loc2_,this.featureDialogProperties.featureId);
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
         if(param2 == 28)
         {
            this.removingFeature = true;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2 == 28 && _loc4_ == 1)
            {
               param1.mc_textcontainer["txt_" + _loc4_].text = CafeModel.languageData.getTextById("limitedfeatureDialog_time_single");
            }
            else
            {
               param1.mc_textcontainer["txt_" + _loc4_].text = CafeModel.languageData.getTextById("featureDialog_" + param2 + "_text_" + _loc4_);
            }
            _loc4_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         if(this.removingFeature)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(28,this.featureDialog.txt_title,CafeModel.languageData.getTextById("limitedfeatureDialog_title"),1);
         }
         else
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(28,this.featureDialog.txt_title,CafeModel.languageData.getTextById("featureDialog_title"),1);
         }
         this.featureDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
      }
      
      protected function get featureDialogProperties() : CafeFeatureDialogProperties
      {
         return properties as CafeFeatureDialogProperties;
      }
      
      private function get featureDialog() : FeatureDialog
      {
         return disp as FeatureDialog;
      }
   }
}
