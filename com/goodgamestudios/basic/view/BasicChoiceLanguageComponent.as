package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class BasicChoiceLanguageComponent extends EventDispatcher
   {
       
      
      protected var _choiceLanguageHeight:Number;
      
      protected var _languageMC:MovieClip;
      
      protected var bgOffsetHeight:int = 0;
      
      public function BasicChoiceLanguageComponent(param1:MovieClip)
      {
         super();
         this._languageMC = param1;
         this._languageMC.btn_arrow.addEventListener(MouseEvent.CLICK,this.toggleLanguagePopUp);
      }
      
      public function destory() : void
      {
         this._languageMC.btn_arrow.removeEventListener(MouseEvent.CLICK,this.toggleLanguagePopUp);
      }
      
      protected function toggleLanguagePopUp(param1:MouseEvent) : void
      {
         if(this._languageMC.mc_bg.scaleY > 1)
         {
            this.unshowChoiceLangage();
         }
         else
         {
            this.showChoiceLangage();
         }
      }
      
      public function addLanguageButton(param1:BasicLanguageData = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:Class = null;
         var _loc6_:MovieClip = null;
         while(this._languageMC.mc_flagholder.numChildren > 0)
         {
            this._languageMC.mc_flagholder.removeChildAt(0);
         }
         this._languageMC.mc_flagholder.visible = false;
         var _loc2_:Array = this.env.availableLanguages.sort();
         if(_loc2_.length == 1)
         {
            this._languageMC.visible = false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc6_ = new (_loc5_ = getDefinitionByName("language_" + _loc4_) as Class)())
            {
               _loc6_.name = _loc4_;
               this._languageMC.mc_flagholder.addChild(_loc6_);
               _loc6_.mouseChildren = false;
               if(param1)
               {
                  _loc6_.toolTipText = param1.getTextById("generic_language_" + _loc4_);
               }
               _loc6_.addEventListener(MouseEvent.CLICK,this.onClickLanguage);
            }
            _loc3_++;
         }
         this.positionLanguageBtn();
         this.unshowChoiceLangage();
      }
      
      private function onClickLanguage(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name;
         this.selectetLanguageButton(_loc3_);
         dispatchEvent(new LanguageDataEvent(LanguageDataEvent.SELECT_LANGUAGE_COMPLETE,_loc3_));
         this.unshowChoiceLangage();
      }
      
      protected function positionLanguageBtn() : void
      {
         var _loc2_:MovieClip = null;
         this._choiceLanguageHeight = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this._languageMC.mc_flagholder.numChildren)
         {
            _loc2_ = this._languageMC.mc_flagholder.getChildAt(_loc1_) as MovieClip;
            if(_loc2_)
            {
               _loc2_.x = (_loc2_.width + 10) * (_loc1_ % 2);
               _loc2_.y = (_loc2_.height + 10) * int(_loc1_ / 2);
               this._choiceLanguageHeight = _loc2_.height + _loc2_.y;
            }
            _loc1_++;
         }
         this._languageMC.mc_flagholder.y = -(this._choiceLanguageHeight + this._languageMC.mc_bg.height);
      }
      
      protected function unshowChoiceLangage() : void
      {
         this._languageMC.mc_flagholder.visible = false;
         this._languageMC.mc_bg.scaleY = 1;
         this._languageMC.btn_arrow.gotoAndStop(1);
      }
      
      protected function showChoiceLangage() : void
      {
         this._languageMC.mc_flagholder.visible = true;
         var _loc1_:Number = this._languageMC.mc_bg.height + this._choiceLanguageHeight - this._languageMC.mc_currentflag.y + this.bgOffsetHeight;
         this._languageMC.mc_bg.scaleY = _loc1_ / this._languageMC.mc_bg.height;
         this._languageMC.btn_arrow.gotoAndStop(2);
      }
      
      public function selectetLanguageButton(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:MovieClip = null;
         while(this._languageMC.mc_currentflag.numChildren > 0)
         {
            this._languageMC.mc_currentflag.removeChildAt(0);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._languageMC.mc_flagholder.numChildren)
         {
            _loc3_ = this._languageMC.mc_flagholder.getChildAt(_loc2_) as MovieClip;
            if(_loc3_)
            {
               if(_loc3_.name == param1)
               {
                  this.selectChild(_loc3_);
                  if(_loc5_ = new (_loc4_ = getDefinitionByName("language_" + param1) as Class)())
                  {
                     _loc5_.name = param1;
                     this._languageMC.mc_currentflag.addChild(_loc5_);
                  }
               }
               else
               {
                  _loc3_.deselected();
               }
            }
            _loc2_++;
         }
      }
      
      public function setDefaultLanguage(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._languageMC.mc_flagholder.numChildren)
         {
            _loc3_ = this._languageMC.mc_flagholder.getChildAt(_loc2_) as MovieClip;
            if(_loc3_ && _loc3_.name == param1)
            {
               _loc3_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            _loc2_++;
         }
      }
      
      protected function selectChild(param1:MovieClip) : void
      {
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
