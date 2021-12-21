package CafeInterface_fla
{
   import fl.text.TCMRuntimeManager;
   import fl.text.TCMText;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.Font;
   import flash.text.TextField;
   
   public dynamic class Banner_344 extends MovieClip
   {
       
      
      public var __id1_:TCMText;
      
      public var txt_label:TextField;
      
      public var __checkFontName_:String;
      
      public var __cacheXMLSettings:Object;
      
      public function Banner_344()
      {
         super();
         this.__checkFontName_ = "CafeInterface_fla.Font_1";
         if(!TCMRuntimeManager.checkTLFFontsLoaded(null,this.__checkFontName_,this.__registerTLFFonts))
         {
            addEventListener(Event.FRAME_CONSTRUCTED,TCMRuntimeManager.checkTLFFontsLoaded,false,1);
         }
         this.__cacheXMLSettings = XML.settings();
         try
         {
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            XML.prettyPrinting = false;
            TCMRuntimeManager.getSingleton().addInstance(this,"__id1_",new Rectangle(0,0,151.55,51.95),<tlfTextObject type="Paragraph" editPolicy="readOnly" columnCount="1" columnGap="0" verticalAlign="top" firstBaselineOffset="auto" paddingLeft="0" paddingTop="0" paddingRight="0" paddingBottom="0" background="false" backgroundColor="#ffffff" backgroundAlpha="1" border="false" borderColor="#000000" borderAlpha="1" borderWidth="1" paddingLock="false" multiline="true" antiAliasType="advanced" embedFonts="true"><TextFlow alignmentBaseline="useDominantBaseline" blockProgression="tb" columnCount="inherit" columnGap="inherit" columnWidth="inherit" direction="ltr" dominantBaseline="auto" lineBreak="inherit" paddingBottom="inherit" paddingLeft="inherit" paddingRight="inherit" paddingTop="inherit" paragraphEndIndent="0" paragraphSpaceAfter="0" paragraphSpaceBefore="0" paragraphStartIndent="0" textAlign="center" textIndent="0" verticalAlign="inherit" whiteSpaceCollapse="preserve" xmlns="http://ns.adobe.com/textLayout/2008"><p baselineShift="0" breakOpportunity="auto" color="#000000" digitCase="default" digitWidth="default" direction="ltr" fontFamily="Cooper Black" fontSize="22.865" fontStyle="normal" fontWeight="normal" ligatureLevel="common" lineHeight="120%" lineThrough="false" locale="de" textAlpha="0" textDecoration="none" textRotation="auto" trackingRight="0%" typographicCase="default" xmlns="http://ns.adobe.com/textLayout/2008"><span xmlns="http://ns.adobe.com/textLayout/2008">KOSTENLOS</span></p></TextFlow></tlfTextObject>,null,undefined,0,0,"",false,true);
         }
         finally
         {
            XML.setSettings(this.__cacheXMLSettings);
         }
         TCMRuntimeManager.getSingleton().addInstanceComplete(this);
      }
      
      public function __registerTLFFonts() : void
      {
         Font.registerFont(Font_1);
      }
   }
}
