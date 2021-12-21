package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeComebackBonusDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeComebackBonusDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureUnlockedDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureUnlockedProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeLevelUpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeLevelUpDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryCompleteDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryCompleteDialogProperties;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class CafeShowBonusDialogCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "CafeShowBonusDialogCommand";
       
      
      public function CafeShowBonusDialogCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         _loc2_ = param1 as Array;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.shift());
         switch(_loc3_)
         {
            case CafeBonusDialogProperties.TYPE_EXPAND:
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_bonus_title_expand"),CafeModel.languageData.getTextById("dialogwin_bonus_copy_expand"),null));
               break;
            case CafeBonusDialogProperties.TYPE_LEVELUP:
               this.showNewFeatures();
               this.layoutManager.showDialog(CafeLevelUpDialog.NAME,new CafeLevelUpDialogProperties(_loc2_.shift(),_loc2_.shift(),_loc2_.shift()));
               break;
            case CafeBonusDialogProperties.TYPE_NEWFURNITURE:
               _loc5_ = String(_loc2_.shift());
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_bonus_title_" + _loc5_),CafeModel.languageData.getTextById("dialogwin_bonus_copy_" + _loc5_),_loc2_.shift()));
               break;
            case CafeBonusDialogProperties.TYPE_NEWELEMENTS:
               if(_loc2_[0][0])
               {
                  this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_bonus_title_dish"),CafeModel.languageData.getTextById("dialogwin_bonus_copy_dish"),_loc2_.shift()));
               }
               break;
            case CafeBonusDialogProperties.TYPE_WAITER:
               _loc6_ = _loc2_.shift();
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_bonus_title_newwaiter"),CafeModel.languageData.getTextById("dialogwin_bonus_copy_newwaiter"),null,[_loc6_]));
               break;
            case CafeBonusDialogProperties.TYPE_ACHIEVEMENT:
               _loc7_ = _loc2_.shift();
               _loc8_ = parseInt(_loc7_[0]);
               _loc9_ = parseInt(_loc7_[1]);
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById(CafeModel.achievementData.getAchievementName(_loc8_)),CafeModel.languageData.getTextById("dialogwin_bonus_copy_achievement",[_loc9_]),CafeModel.achievementData.getBonusElementsById(_loc8_,_loc9_ - 1),[CafeModel.languageData.getTextById(CafeModel.achievementData.getAchievementName(_loc8_))],CafeModel.achievementData.getWodIdById(_loc8_)));
               break;
            case CafeBonusDialogProperties.TYPE_LEVELTEXT:
               _loc10_ = CafeModel.languageData.getTextById("dialogwin_bonus_title_level" + _loc2_.shift());
               _loc11_ = CafeModel.languageData.getTextById("dialogwin_bonus_copy_level" + _loc2_.shift());
               if(_loc10_.length > 0 && _loc11_.length > 0)
               {
                  this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,_loc10_,_loc11_));
               }
               break;
            case CafeBonusDialogProperties.TYPE_LOGINBONUS:
               if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_WHEELOFFORTUNE)
               {
                  _loc3_ = CafeBonusDialogProperties.TYPE_LOGINBONUS_WO_WOF;
               }
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_bonus_title_login"),CafeModel.languageData.getTextById("dialogwin_bonus_copy_login"),_loc2_.shift()));
               break;
            case CafeBonusDialogProperties.TYPE_FIND_INGREDIENT:
               _loc4_ = String(_loc2_.shift());
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_lonelyingredient_title"),CafeModel.languageData.getTextById("dialogwin_lonelyingredient_copy"),_loc2_.shift(),[_loc4_]));
               break;
            case CafeBonusDialogProperties.TYPE_FIND_TIP:
               _loc4_ = String(_loc2_.shift());
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_lonelytip_title"),CafeModel.languageData.getTextById("dialogwin_lonelytip_copy"),_loc2_.shift(),[_loc4_]));
               break;
            case CafeBonusDialogProperties.TYPE_PERFECTDISH:
               _loc4_ = String(_loc2_.shift());
               _loc12_ = CafeModel.languageData.getTextById("recipe_" + (_loc2_[0][0] as BasicDishVO).type.toLowerCase());
               this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_perfectdish_title"),CafeModel.languageData.getTextById("dialogwin_perfectdish_copy",[_loc12_]),_loc2_.shift(),[_loc4_]));
               break;
            case CafeBonusDialogProperties.TYPE_SOCIALLOGINBONUS:
               if((_loc13_ = int(_loc2_.shift())) == 0)
               {
                  this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_receivemoney_title"),CafeModel.languageData.getTextById("dialogwin_receivemoney_copy"),_loc2_.shift()));
               }
               else
               {
                  this.layoutManager.showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_receiveitem_title"),CafeModel.languageData.getTextById("dialogwin_receiveitem_copy"),_loc2_.shift()));
               }
               break;
            case CafeBonusDialogProperties.TYPE_NEW_MASTERY:
               _loc4_ = String(_loc2_.shift());
               _loc14_ = (_loc2_[0][0] as BasicDishVO).wodId;
               this.layoutManager.showDialog(CafeMasteryCompleteDialog.NAME,new CafeMasteryCompleteDialogProperties(_loc14_,_loc4_));
               break;
            case CafeBonusDialogProperties.TYPE_COMEBACK_BONUS:
               _loc16_ = (_loc15_ = _loc2_.shift()).length > 1 ? "dialogwin_welcomeback_text2" : "dialogwin_welcomeback_text";
               this.layoutManager.showDialog(CafeComebackBonusDialog.NAME,new CafeComebackBonusDialogProperties(_loc3_,CafeModel.languageData.getTextById("dialogwin_welcomeback_title",[CafeModel.userData.userName]),CafeModel.languageData.getTextById(_loc16_,[_loc15_[0].amount]),_loc15_));
         }
      }
      
      private function showNewFeatures() : void
      {
         var _loc1_:int = CafeModel.userData.userLevel;
         switch(_loc1_)
         {
            case CafeConstants.LEVEL_FOR_HIGHSCORE:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_HIGHSCORE));
               break;
            case CafeConstants.LEVEL_FOR_PERSONAL:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_STAFF));
               break;
            case CafeConstants.LEVEL_FOR_MARKETPLACE:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_MARKETPLACE));
               break;
            case CafeConstants.LEVEL_FOR_COOPS:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_COOPS));
               break;
            case CafeConstants.LEVEL_FOR_FANCYS:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_FANCYS));
               break;
            case CafeConstants.LEVEL_FOR_WHEELOFFORTUNE:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_WHEELOFFORTUNE));
               break;
            case CafeConstants.LEVEL_FOR_MUFFINMAN:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_MUFFINMAN));
               break;
            case CafeConstants.LEVEL_FOR_VENDINGMACHINE:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_FROSTY));
               break;
            case CafeConstants.LEVEL_FOR_PREMIUMDECO:
               this.layoutManager.showDialog(CafeFeatureUnlockedDialog.NAME,new CafeFeatureUnlockedProperties(CafeFeatureUnlockedProperties.TYPE_PREMIUMDECO));
         }
      }
      
      private function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
   }
}
