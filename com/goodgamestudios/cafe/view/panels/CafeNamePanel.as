package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.cafe.event.CafeLevelEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.math.MathBase;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class CafeNamePanel extends CafePanel
   {
      
      public static const NAME:String = "CafeNamePanel";
       
      
      public function CafeNamePanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            disp.x = disp.stage.stageWidth / 2;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(BasicUserEvent.REGISTERED,this.onRegister);
         controller.removeEventListener(CafeLevelEvent.RATING_CHANGE,this.onChangeRating);
         controller.removeEventListener(CafeLevelEvent.LUXUS_CHANGE,this.onChangeRating);
         controller.removeEventListener(CafeLevelEvent.INIT_LEVELDATA,this.onChangeRating);
      }
      
      override protected function init() : void
      {
         super.init();
         this.onChangeRating(null);
         this.cafeName.mc_name.mouseChildren = false;
         this.cafeName.mc_rating.mouseChildren = false;
         this.cafeName.mc_luxury.mouseChildren = false;
         controller.addEventListener(BasicUserEvent.REGISTERED,this.onRegister);
         controller.addEventListener(CafeLevelEvent.RATING_CHANGE,this.onChangeRating);
         controller.addEventListener(CafeLevelEvent.LUXUS_CHANGE,this.onChangeRating);
         controller.addEventListener(CafeLevelEvent.INIT_LEVELDATA,this.onChangeRating);
      }
      
      private function onRegister(param1:BasicUserEvent) : void
      {
         if(CafeModel.levelData.levelVO.ownerUserID == CafeModel.userData.userID)
         {
            CafeModel.levelData.levelVO.ownerName = CafeModel.userData.userName;
         }
         CafeModel.otherUserData.renameUser(CafeModel.userData.userID,CafeModel.userData.userName);
         this.onChangeRating(null);
      }
      
      private function onChangeRating(param1:CafeLevelEvent) : void
      {
         if(!CafeModel.levelData.levelVO)
         {
            return;
         }
         var _loc2_:Number = CafeModel.levelData.levelVO.rating / 10;
         if(_loc2_ > 0)
         {
            this.cafeName.mc_rating.txt_rating.text = MathBase.floor(_loc2_,1).toFixed(1);
         }
         else
         {
            this.cafeName.mc_rating.txt_rating.text = "";
         }
         this.cafeName.mc_luxury.txt_luxus.text = CafeModel.levelData.levelLuxury >= 0 ? CafeModel.levelData.levelLuxury : "";
         if(CafeModel.levelData.levelVO.ownerUserID == CafeModel.userData.userID)
         {
            this.cafeName.mc_rating.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeName.mc_rating.name);
            this.cafeName.mc_luxury.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeName.mc_luxury.name);
         }
         else
         {
            delete this.cafeName.mc_rating.toolTipText;
            delete this.cafeName.mc_luxury.toolTipText;
         }
         this.cafeName.txt_title.text = CafeModel.levelData.levelVO.ownerName;
         this.cafeName.txt_title.width = this.cafeName.txt_title.textWidth + 5;
         this.cafeName.txt_title.x = -this.cafeName.txt_title.width / 2;
         this.cafeName.mc_name.width = Math.max(260,this.cafeName.txt_title.width + 20);
      }
      
      protected function get cafeName() : CafeName
      {
         return disp as CafeName;
      }
   }
}
