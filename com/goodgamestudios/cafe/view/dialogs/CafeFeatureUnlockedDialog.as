package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeFeatureUnlockedDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeFeatureUnlockedDialog";
       
      
      public function CafeFeatureUnlockedDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         this.unlockDialog.gotoAndStop(this.unlockProperties.type);
         super.show();
      }
      
      override protected function applyProperties() : void
      {
         this.unlockDialog.txt_title.text = CafeModel.languageData.getTextById("featureDialog_title");
         switch(this.unlockProperties.type)
         {
            case CafeFeatureUnlockedProperties.TYPE_HIGHSCORE:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_ranking");
               break;
            case CafeFeatureUnlockedProperties.TYPE_STAFF:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_staff");
               break;
            case CafeFeatureUnlockedProperties.TYPE_MARKETPLACE:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_marketplace");
               break;
            case CafeFeatureUnlockedProperties.TYPE_COOPS:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_coop");
               break;
            case CafeFeatureUnlockedProperties.TYPE_FANCYS:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_fancy");
               break;
            case CafeFeatureUnlockedProperties.TYPE_WHEELOFFORTUNE:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_wheeloffortune");
               break;
            case CafeFeatureUnlockedProperties.TYPE_MUFFINMAN:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_muffinman");
               break;
            case CafeFeatureUnlockedProperties.TYPE_FROSTY:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_frosty");
               break;
            case CafeFeatureUnlockedProperties.TYPE_PREMIUMDECO:
               this.unlockDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_featureUnlocked_decoration");
         }
         this.unlockDialog.btn_ok.label = CafeModel.languageData.getTextById("dialogwin_giftbox_close");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target == this.unlockDialog.btn_ok)
         {
            hide();
         }
      }
      
      protected function get unlockProperties() : CafeFeatureUnlockedProperties
      {
         return properties as CafeFeatureUnlockedProperties;
      }
      
      private function get unlockDialog() : CafeFeatureUnlocked
      {
         return disp as CafeFeatureUnlocked;
      }
   }
}
