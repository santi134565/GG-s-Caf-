package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeCoopRewardDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeCoopRewardDialog";
       
      
      public function CafeCoopRewardDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.coopRewardDialog.btn_ok.label = this.coopRewardDialogProperties.buttonLabel_okay;
         this.coopRewardDialog.txt_cash.text = String(this.coopRewardDialogProperties.cash);
         this.coopRewardDialog.txt_gold.text = String(this.coopRewardDialogProperties.gold);
         this.coopRewardDialog.txt_xp.text = String(this.coopRewardDialogProperties.xp);
         if(this.coopRewardDialogProperties.finishLevel != CafeConstants.COOP_FINISHLEVEL_FAIL)
         {
            this.coopRewardDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_coopreward_title_success",[CafeModel.languageData.getTextById("dialogwin_coopreward_finish_" + this.coopRewardDialogProperties.finishLevel)]);
         }
         else
         {
            this.coopRewardDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_coopreward_title_fail");
         }
         this.coopRewardDialog.btn_share.visible = env.enableFeedMessages && this.coopRewardDialogProperties.finishLevel != CafeConstants.COOP_FINISHLEVEL_FAIL;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.coopRewardDialog.btn_ok:
               hide();
               break;
            case this.coopRewardDialog.btn_share:
               if(env.enableFeedMessages)
               {
                  _loc2_ = CafeModel.languageData.getTextById("coop_title_" + this.coopRewardDialogProperties.coopType);
                  _loc3_ = CafeModel.languageData.getTextById("dialogwin_coopreward_finish_" + this.coopRewardDialogProperties.finishLevel);
                  CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_COOPEND,[_loc2_,_loc3_]);
               }
         }
      }
      
      protected function get coopRewardDialogProperties() : CafeCoopRewardDialogProperties
      {
         return properties as CafeCoopRewardDialogProperties;
      }
      
      protected function get coopRewardDialog() : CafeCoopReward
      {
         return disp as CafeCoopReward;
      }
   }
}
