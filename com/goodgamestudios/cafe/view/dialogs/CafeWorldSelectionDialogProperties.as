package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeWorldSelectionDialogProperties extends BasicDialogProperties
   {
       
      
      public var serverList:Array;
      
      public function CafeWorldSelectionDialogProperties()
      {
         this.serverList = [{
            "label":"Tino",
            "data":{
               "ip":"192.168.1.30",
               "port":443,
               "zone":"CafeEx",
               "instance":-2
            }
         },{
            "label":"Lokal",
            "data":{
               "ip":"127.0.0.1",
               "port":443,
               "zone":"CafeEx",
               "instance":-3
            }
         },{
            "label":"Siavash",
            "data":{
               "ip":"192.168.1.57",
               "port":443,
               "zone":"CafeEx",
               "instance":-4
            }
         }];
         super();
      }
   }
}
