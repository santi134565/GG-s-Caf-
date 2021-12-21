package com.goodgamestudios.ageGate.view
{
   import org.osflash.signals.Signal;
   
   public interface IAgeGatePage
   {
       
      
      function initPage() : void;
      
      function get verificationIsFinished() : Signal;
      
      function dispose() : void;
   }
}
