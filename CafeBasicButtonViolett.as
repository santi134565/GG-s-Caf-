package
{
   import CafeInterface_fla.ArialRoundedMTPro_0;
   import com.goodgamestudios.cafe.view.BasicButton;
   import fl.text.RuntimeFontMapper;
   import fl.text.TCMRuntimeManager;
   import fl.text.TCMText;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.Font;
   
   public dynamic class CafeBasicButtonViolett extends BasicButton
   {
       
      
      public var __id0_:TCMText;
      
      public var __checkFontName_:String;
      
      public var __cacheXMLSettings:Object;
      
      public function CafeBasicButtonViolett()
      {
         super();
         this.__checkFontName_ = "CafeInterface_fla.ArialRoundedMTPro_0";
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
            TCMRuntimeManager.getSingleton().addInstance(this,"__id0_",new Rectangle(0,0,110.2,17.5),<tlfTextObject type="Paragraph" editPolicy="readOnly" columnCount="1" columnGap="18" verticalAlign="top" firstBaselineOffset="ascent" paddingLeft="0" paddingTop="0" paddingRight="0" paddingBottom="0" background="false" backgroundColor="#ffffff" backgroundAlpha="1" border="false" borderColor="#000000" borderAlpha="1" borderWidth="1" paddingLock="false" multiline="true" antiAliasType="advanced" embedFonts="true"><TextFlow alignmentBaseline="useDominantBaseline" blockProgression="tb" columnCount="inherit" columnGap="inherit" columnWidth="inherit" direction="ltr" dominantBaseline="auto" lineBreak="inherit" paddingBottom="inherit" paddingLeft="inherit" paddingRight="inherit" paddingTop="inherit" paragraphEndIndent="0" paragraphSpaceAfter="0" paragraphSpaceBefore="0" paragraphStartIndent="0" textAlign="center" textIndent="0" verticalAlign="inherit" whiteSpaceCollapse="preserve" xmlns="http://ns.adobe.com/textLayout/2008"><p baselineShift="0" breakOpportunity="auto" color="#453d28" digitCase="default" digitWidth="default" direction="ltr" fontFamily="Arial Rounded MT Bold" fontSize="14" fontStyle="normal" fontWeight="normal" ligatureLevel="common" lineHeight="120%" lineThrough="false" locale="de" textAlpha="1" textDecoration="none" textRotation="auto" trackingRight="0%" typographicCase="default" xmlns="http://ns.adobe.com/textLayout/2008"><span xmlns="http://ns.adobe.com/textLayout/2008">Drehen</span></p></TextFlow></tlfTextObject>,null,undefined,0,0,"",false,true);
         }
         finally
         {
            XML.setSettings(this.__cacheXMLSettings);
         }
         TCMRuntimeManager.getSingleton().addInstanceComplete(this);
      }
      
      public function __registerTLFFonts() : void
      {
         Font.registerFont(ArialRoundedMTPro_0);
         RuntimeFontMapper.addFontMapEntry("[\'Arial Rounded MT Bold\',\'normal\',\'normal\']",["Arial Rounded MT Pro","bold","normal"]);
      }
   }
}
