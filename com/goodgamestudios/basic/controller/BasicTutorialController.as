package com.goodgamestudios.basic.controller
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.constants.CommonGameStates;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   
   public class BasicTutorialController
   {
      
      protected static var tutorialController:BasicTutorialController;
      
      public static const TUT_STATE_WELCOME:String = CommonGameStates.TUTORIAL_START;
      
      public static const TUT_STATE_COMPLETED:String = CommonGameStates.TUTORIAL_END;
      
      public static const TUT_STATE_OFF:String = CommonGameStates.TUTORIAL_OFF;
      
      public static const TUT_STATE_CANCEL:String = CommonGameStates.TUTORIAL_CANCEL;
       
      
      protected var stateOrder:Array;
      
      protected var _tutorialState:String = "tut_off";
      
      protected var _tutLength:Number = 0;
      
      private var _tutCompleted:Boolean = false;
      
      protected var _currentStateStep:int;
      
      protected var _tutorialArrow:MovieClip;
      
      public function BasicTutorialController()
      {
         super();
      }
      
      public static function getInstance() : BasicTutorialController
      {
         if(!tutorialController)
         {
            throw new Error("Tutorial controller is not initialized!");
         }
         return tutorialController;
      }
      
      public static function isInitialized() : Boolean
      {
         if(!tutorialController)
         {
            return false;
         }
         return true;
      }
      
      public function startTutorial(param1:MovieClip) : void
      {
         this._tutLength = getTimer();
         this.initArrow(param1);
         this._currentStateStep = 0;
         this.tutorialState = this.stateOrder[this._currentStateStep];
      }
      
      public function endTutorial() : void
      {
         this._tutLength = getTimer() - this._tutLength;
         this._tutorialArrow = null;
         if(!BasicModel.userData.isGuest())
         {
            this.env.gameState = CommonGameStates.REGISTERED_AND_PLAYING;
         }
         this._tutCompleted = true;
      }
      
      public function cancelTutorial() : void
      {
         this._tutLength = getTimer() - this._tutLength;
         this._tutorialArrow = null;
         this.tutorialState = TUT_STATE_CANCEL;
         if(!BasicModel.userData.isGuest())
         {
            this.env.gameState = CommonGameStates.REGISTERED_AND_PLAYING;
         }
      }
      
      public function reset() : void
      {
      }
      
      public function resetCurrentStep() : void
      {
      }
      
      protected function initArrow(param1:MovieClip) : void
      {
         this._tutorialArrow = param1;
         this._tutorialArrow.mouseChildren = false;
         this._tutorialArrow.mouseEnabled = false;
      }
      
      public function get tutorialArrow() : MovieClip
      {
         return this._tutorialArrow;
      }
      
      public function removeArrow() : void
      {
         if(!this._tutorialArrow)
         {
            return;
         }
         this._tutorialArrow.scaleX = this._tutorialArrow.scaleY = 1;
         this._tutorialArrow.x = 0;
         this._tutorialArrow.y = 0;
         if(this._tutorialArrow.parent)
         {
            if(this._tutorialArrow.parent.contains(this._tutorialArrow))
            {
               this._tutorialArrow.parent.removeChild(this._tutorialArrow);
            }
         }
      }
      
      public function mirrorArrow() : void
      {
         this._tutorialArrow.scaleX = -1;
      }
      
      public function flipArrow() : void
      {
         this._tutorialArrow.scaleY = -1;
      }
      
      public function addTutorialArrowAt(param1:DisplayObjectContainer, param2:Boolean = true) : void
      {
         this.removeArrow();
         param1.addChild(this.tutorialArrow);
         param1.mouseChildren = false;
         param1.mouseEnabled = false;
         if(param2)
         {
            this.mirrorArrow();
         }
      }
      
      public function get tutorialLength() : String
      {
         var _loc1_:Number = NaN;
         _loc1_ = !!this.isActive ? Number(getTimer() - this._tutLength) : Number(this._tutLength);
         return Math.round(_loc1_ / 1000).toString();
      }
      
      public function nextStep() : void
      {
         this.removeArrow();
         ++this._currentStateStep;
         this.tutorialState = this.stateOrder[this._currentStateStep];
      }
      
      public function get tutorialState() : String
      {
         return this._tutorialState;
      }
      
      public function set tutorialState(param1:String) : void
      {
      }
      
      public function get isActive() : Boolean
      {
         switch(this._tutorialState)
         {
            case TUT_STATE_OFF:
            case TUT_STATE_COMPLETED:
            case TUT_STATE_CANCEL:
               return false;
            default:
               return true;
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return null;
      }
      
      public function get tutCompleted() : Boolean
      {
         return this._tutCompleted;
      }
   }
}
