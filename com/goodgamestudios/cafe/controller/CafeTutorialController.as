package com.goodgamestudios.cafe.controller
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeTutorialEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CafeTutorialController extends BasicTutorialController
   {
      
      public static const TUT_STATE_COOK_PREPARECOOK:String = "tut_cookpreparecook";
      
      public static const TUT_STATE_COOK_OPENSHOP:String = "tut_cookopenshop";
      
      public static const TUT_STATE_COOK_BUYMISSINGINGREDIENT:String = "tut_buymissingingredient";
      
      public static const TUT_STATE_COOK_COOKMEAL:String = "tut_cookmeal";
      
      public static const TUT_STATE_COOK_PREPARESTEPS:String = "tut_preparesteps";
      
      public static const TUT_STATE_COOK_PREPARESTEP_TOMATO:String = "tut_preparestep_1";
      
      public static const TUT_STATE_COOK_PREPARESTEP_ONION:String = "tut_preparestep_2";
      
      public static const TUT_STATE_COOK_PREPARESTEP_SALAD:String = "tut_preparestep_3";
      
      public static const TUT_STATE_COOK_INSTANT_COOK:String = "tut_instantcook";
      
      public static const TUT_STATE_COOK_INSTANT_COOK2:String = "tut_instantcook2";
      
      public static const TUT_STATE_COOK_SERVEDISH:String = "tut_servedish";
      
      public static const TUT_STATE_CAFEOPEN:String = "tut_cafeopen";
      
      private static const ISO_ARROWOFFSET_STOVE:Point = new Point(30,-5);
       
      
      private var _activeIsoObject:IsoObject;
      
      public var aimDO_tutotialArrow:AnimatedDisplayObject;
      
      private var spotLight:TutorialSpotLight;
      
      public function CafeTutorialController()
      {
         this.spotLight = new TutorialSpotLight();
         super();
         stateOrder = [TUT_STATE_WELCOME,TUT_STATE_COOK_PREPARECOOK,TUT_STATE_COOK_OPENSHOP,TUT_STATE_COOK_BUYMISSINGINGREDIENT,TUT_STATE_COOK_COOKMEAL,TUT_STATE_COOK_PREPARESTEP_TOMATO,TUT_STATE_COOK_PREPARESTEP_ONION,TUT_STATE_COOK_PREPARESTEP_SALAD,TUT_STATE_COOK_INSTANT_COOK,TUT_STATE_COOK_INSTANT_COOK2,TUT_STATE_COOK_SERVEDISH,TUT_STATE_CAFEOPEN,TUT_STATE_COMPLETED];
      }
      
      public static function getInstance() : CafeTutorialController
      {
         if(!tutorialController)
         {
            tutorialController = new CafeTutorialController();
         }
         return tutorialController as CafeTutorialController;
      }
      
      override public function set tutorialState(param1:String) : void
      {
         switch(param1)
         {
            case TUT_STATE_COOK_PREPARECOOK:
            case TUT_STATE_COOK_PREPARESTEP_TOMATO:
            case TUT_STATE_COOK_PREPARESTEP_ONION:
            case TUT_STATE_COOK_PREPARESTEP_SALAD:
            case TUT_STATE_COOK_INSTANT_COOK:
            case TUT_STATE_COOK_SERVEDISH:
               this._activeIsoObject = this.world.getIsoObjectByPoint(new Point(1,7));
               (this._activeIsoObject as BasicStove).deactivateTimer();
               this._activeIsoObject.disp.addChild(this.mc_tutotialArrow);
               this.mc_tutotialArrow.scaleX = -1;
               this.mc_tutotialArrow.x = ISO_ARROWOFFSET_STOVE.x;
               this.mc_tutotialArrow.y = ISO_ARROWOFFSET_STOVE.y;
               break;
            case TUT_STATE_CAFEOPEN:
               this._activeIsoObject = null;
               break;
            case TUT_STATE_COMPLETED:
               this.layoutManager.removeTutorialPanel();
               this._activeIsoObject = this.world.getIsoObjectByPoint(new Point(1,7));
               (this._activeIsoObject as BasicStove).activateTimer();
               this.endTutorial();
         }
         _tutorialState = param1;
         this.env.gameState = _tutorialState;
         if(isActive)
         {
            this.drawSpotLights();
         }
         else
         {
            this.removespotLight();
         }
         BasicController.getInstance().dispatchEvent(new CafeTutorialEvent(CafeTutorialEvent.TUTORIAL_STATE_CHANGE));
      }
      
      private function drawSpotLights() : void
      {
         switch(_tutorialState)
         {
            case TUT_STATE_WELCOME:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.5,0.5,1);
               break;
            case TUT_STATE_COOK_PREPARECOOK:
               this.drawBlackWallWithSpotlightOnIsoObject(this.world.getIsoObjectByPoint(new Point(1,7)));
               break;
            case TUT_STATE_COOK_OPENSHOP:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.43,0.4,1.8);
               break;
            case TUT_STATE_COOK_BUYMISSINGINGREDIENT:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.43,0.5,1.8);
               break;
            case TUT_STATE_COOK_COOKMEAL:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.43,0.4,1.8);
               break;
            case TUT_STATE_COOK_PREPARESTEP_TOMATO:
               this.drawBlackWallWithSpotlightOnIsoObject(this.world.getIsoObjectByPoint(new Point(1,7)));
               break;
            case TUT_STATE_COOK_PREPARESTEP_ONION:
            case TUT_STATE_COOK_PREPARESTEP_SALAD:
            case TUT_STATE_COOK_INSTANT_COOK:
               break;
            case TUT_STATE_COOK_INSTANT_COOK2:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.5,0.5,2.5);
               break;
            case TUT_STATE_COOK_SERVEDISH:
               this.drawBlackWallWithSpotlightOnIsoObject(this.world.getIsoObjectByPoint(new Point(1,7)));
               break;
            case TUT_STATE_CAFEOPEN:
               this.layoutManager.tutPanel.drawBlackWallWithSpotlight(this.spotLight,0.5,0.5,1);
         }
      }
      
      public function drawBlackWallWithSpotlightOnIsoObject(param1:IsoObject, param2:Number = 1) : void
      {
         var _loc3_:Sprite = this.layoutManager.tutLayer;
         if(this.spotLight.parent == _loc3_)
         {
            this.layoutManager.tutPanel.removeSpotLight();
         }
         this.spotLight.scaleX = this.spotLight.scaleY = param2;
         this.world.worldLayer.addChild(this.spotLight);
         var _loc4_:Point = this.world.map.grid.gridPosToPixelPos(param1.isoGridPos.clone());
         this.spotLight.x = _loc4_.x + CafeConstants.ISOTILESIZE_X / 2;
         this.spotLight.y = _loc4_.y - CafeConstants.ISOTILESIZE_Y / 2;
      }
      
      private function removespotLight() : void
      {
         var _loc1_:Sprite = this.layoutManager.tutLayer;
         if(this.spotLight.parent == _loc1_ && this.layoutManager.tutPanel)
         {
            this.layoutManager.tutPanel.removeSpotLight();
         }
         if(this.spotLight.parent)
         {
            this.spotLight.parent.removeChild(this.spotLight);
         }
      }
      
      override protected function initArrow(param1:MovieClip) : void
      {
         this.aimDO_tutotialArrow = new AnimatedMovieClip(-1,1,"ta");
         this.aimDO_tutotialArrow.processAnimation(param1,null,false);
         this.aimDO_tutotialArrow.setFrameRate(24);
         this.aimDO_tutotialArrow.play();
         this.layoutManager.addAniDo(this.aimDO_tutotialArrow);
      }
      
      override public function removeArrow() : void
      {
         if(!this.mc_tutotialArrow)
         {
            return;
         }
         this.mc_tutotialArrow.scaleX = this.mc_tutotialArrow.scaleY = 1;
         this.mc_tutotialArrow.x = 0;
         this.mc_tutotialArrow.y = 0;
         if(this.mc_tutotialArrow.parent)
         {
            if(this.mc_tutotialArrow.parent.contains(this.mc_tutotialArrow))
            {
               this.mc_tutotialArrow.parent.removeChild(this.mc_tutotialArrow);
            }
         }
      }
      
      override public function endTutorial() : void
      {
         super.endTutorial();
         this.removeArrow();
         this.aimDO_tutotialArrow = null;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_TUTORIAL_FINISH,[]);
         CafeModel.userData.checkXPChanges(5);
      }
      
      public function get mc_tutotialArrow() : Sprite
      {
         if(this.aimDO_tutotialArrow && this.aimDO_tutotialArrow.disp)
         {
            return this.aimDO_tutotialArrow.disp;
         }
         return null;
      }
      
      public function get activeIsoObject() : IsoObject
      {
         return this._activeIsoObject;
      }
      
      private function get world() : CafeIsoWorld
      {
         return this.layoutManager.isoScreen.isoWorld as CafeIsoWorld;
      }
      
      private function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
