package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   
   public class JobProgress extends BasicToolTip
   {
      
      private static const MC_NAME:String = "JobProgress";
       
      
      private var amount:int;
      
      public function JobProgress(param1:VisualElement)
      {
         super(param1);
         init(MC_NAME);
         this.amount = 0;
      }
      
      public function update(param1:Number) : void
      {
         param1 = Math.min(Math.max(0,param1),100);
         disp.barMc.scaleX = param1 / 100;
      }
      
      public function showProgressTip(param1:String, param2:String) : void
      {
         if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_MARKETPLACE || CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_JOBS)
         {
            return;
         }
         disp.txt_title.text = param1;
         TextFieldHelper.changeTextFromatSizeByTextWidth(7,disp.txt_title,param1,1);
         disp.txt_action.text = param2;
         TextFieldHelper.changeTextFromatSizeByTextWidth(7,disp.txt_action,param2,1);
         disp.txt_amount.text = param2.length > 0 ? String(this.amount) : "";
         show();
      }
      
      public function incrementAmount() : void
      {
         ++this.amount;
         disp.txt_amount.text = String(this.amount);
      }
   }
}
