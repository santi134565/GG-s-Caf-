package com.goodgamestudios.language.countryMapper
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.log.ICountryDetectionLogAdapter;
   import com.goodgamestudios.language.countryMapper.log.MockCountryDetectionAdapter;
   import com.goodgamestudios.language.countryMapper.performance.ICountryDetectorPerformanceAdapter;
   import com.goodgamestudios.language.countryMapper.performance.MockCountryDetectorPerformanceAdapter;
   import com.goodgamestudios.net.Base64;
   import com.goodgamestudios.parser.country.CountryXMLBuilder;
   import com.goodgamestudios.parser.country.CountryXMLParser;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import org.osflash.signals.Signal;
   
   public class CountryDetector
   {
      
      public static const VERSION:String = "$Id: CountryDetector.as 10292 2014-02-18 09:35:29Z alexander.bahlk $";
      
      private static var _log:ICountryDetectionLogAdapter;
      
      private static var _countryDetectorPerfomanceAdapter:ICountryDetectorPerformanceAdapter;
       
      
      private var _ggsCountryController:GGSCountryController;
      
      private var _countryXML:XML;
      
      private var currentCountryDetectionVO:CountryDetectionVO;
      
      private var _lastDetectedCountry:AbstractGGSCountry;
      
      private var countriesFilteredByLanguage:Vector.<AbstractGGSCountry>;
      
      private var countriesFilteredByLanguageAndTimezone:Vector.<AbstractGGSCountry>;
      
      private const FLASH_LANGUAGE_CODE_UNKNOWN:String = "xu";
      
      private const GEO_IP_SERVER_URL:String = "http://i2c.goodgamestudios.com";
      
      private const GEO_IP_RESPONSE_TIMEOUT:uint = 3000;
      
      private var isWaitingForGeoIpResponse:Boolean;
      
      private var geoIpUrlLoader:URLLoader;
      
      private var geoIpTimeoutTimer:Timer;
      
      private var geopIpRequestTime:int;
      
      private var _countriesLoaded:Signal;
      
      private var _countryLoadFailed:Signal;
      
      private var _detectionCompleted:Signal;
      
      private var countryXmlUrl:String;
      
      public function CountryDetector()
      {
         _countriesLoaded = new Signal();
         _countryLoadFailed = new Signal();
         _detectionCompleted = new Signal(AbstractGGSCountry);
         super();
         _ggsCountryController = GGSCountryController.instance;
         _log = new MockCountryDetectionAdapter();
         _countryDetectorPerfomanceAdapter = new MockCountryDetectorPerformanceAdapter();
      }
      
      private static function filterCountryListByLanguage(countries:Vector.<AbstractGGSCountry>, languageCode:String, languageIdentifierType:int) : Vector.<AbstractGGSCountry>
      {
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         switch(int(languageIdentifierType) - 1)
         {
            case 0:
               for each(_loc7_ in countries)
               {
                  _loc6_ = _loc7_.browserLanguageCodes.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     if(_loc7_.browserLanguageCodes[_loc4_].toLowerCase() == languageCode.toLowerCase())
                     {
                        _loc5_.push(_loc7_);
                     }
                     _loc4_++;
                  }
               }
               break;
            case 2:
               for each(_loc7_ in countries)
               {
                  _loc6_ = _loc7_.flashRuntimeLanguageCodes.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     if(_loc7_.flashRuntimeLanguageCodes[_loc4_].toLowerCase() == languageCode.toLowerCase())
                     {
                        _loc5_.push(_loc7_);
                     }
                     _loc4_++;
                  }
               }
               break;
            default:
               _log.error("GGSCountryDetector, filterCountryListByLanguage() -> NO VALID LANGUAGE IDENTIFIER: " + languageIdentifierType,countries);
         }
         return _loc5_;
      }
      
      private static function filterCountryListByTimezone(countries:Vector.<AbstractGGSCountry>, utcTimezone:Number) : Vector.<AbstractGGSCountry>
      {
         var _loc3_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         for each(var _loc4_ in countries)
         {
            if(!isNaN(_loc4_.utcTimezoneMin) && _loc4_.utcTimezoneMin <= utcTimezone && _loc4_.utcTimezoneMax >= utcTimezone)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private static function hexStringToBytes(hex:String) : Vector.<uint>
      {
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         while(hex.length >= 2)
         {
            _loc2_.push(uint("0x" + hex.substr(0,2)));
            hex = hex.substr(2,hex.length - 2);
         }
         return _loc2_;
      }
      
      private static function bytesToAsciiString(bytes:Vector.<uint>) : String
      {
         var _loc2_:* = 0;
         var _loc3_:Array = [];
         _loc2_ = uint(0);
         while(_loc2_ < bytes.length)
         {
            _loc3_.push(String.fromCharCode(bytes[_loc2_]));
            _loc2_++;
         }
         return _loc3_.join("");
      }
      
      public function loadCountryXML(countryXmlUrl:String) : void
      {
         if(_ggsCountryController.countriesAreInitialized)
         {
            _countriesLoaded.dispatch();
            return;
         }
         this.countryXmlUrl = countryXmlUrl;
         var _loc3_:URLRequest = new URLRequest(countryXmlUrl);
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener("complete",onCountryXMLLoadingComplete);
         _loc2_.addEventListener("ioError",onCountryXMLIOError);
         _loc2_.addEventListener("securityError",onCountryXMLSecurityError);
         _loc2_.load(_loc3_);
      }
      
      private function onCountryXMLLoadingComplete(event:Event) : void
      {
         try
         {
            _countryXML = XML(URLLoader(event.currentTarget).data);
         }
         catch(e:Error)
         {
            _log.error("country.xml loading error: " + event);
            return;
         }
         parseCountryXML();
         _countriesLoaded.dispatch();
      }
      
      private function parseCountryXML() : void
      {
         var _loc1_:CountryXMLBuilder = new CountryXMLBuilder();
         var _loc2_:CountryXMLParser = new CountryXMLParser(_loc1_);
         _ggsCountryController.initAllCountries(_loc2_.parseCountries(_countryXML));
      }
      
      private function onCountryXMLSecurityError(event:SecurityErrorEvent) : void
      {
         _log.logExternalSecurityError(event.text,countryXmlUrl);
         _countryLoadFailed.dispatch();
         _log.error("Cannot load country.xml: " + event.toString());
      }
      
      private function onCountryXMLIOError(event:IOErrorEvent) : void
      {
         _log.logIOError(event.text,countryXmlUrl);
         _countryLoadFailed.dispatch();
      }
      
      public function detectCountry(detectionVO:CountryDetectionVO) : void
      {
         if(!detectionVO)
         {
            _log.error("CountryDetectionVO is null.");
         }
         if(isNaN(detectionVO.timezoneOffset))
         {
            _log.warn("CountryDetectionVO.timezoneOffset is NaN!");
            detectionVO.timezoneOffset = 0;
         }
         _log.info("CountryDetectionVO: " + detectionVO);
         countriesFilteredByLanguage = null;
         countriesFilteredByLanguageAndTimezone = null;
         currentCountryDetectionVO = detectionVO;
         if(detectionVO.countryByInstance && detectionVO.countryByInstance != "default" && detectionVO.countryByInstance != "")
         {
            _log.info("Setting country by instance: \'" + detectionVO.countryByInstance + "\'");
            _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(1);
            setDetectedCountry(getCountryByCountryCode(detectionVO.countryByInstance));
         }
         else if(detectionVO.countryByNetworkCookie && detectionVO.countryByNetworkCookie != "")
         {
            _log.info("Setting country by flash cookie: \'" + detectionVO.countryByNetworkCookie + "\'");
            _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(2);
            setDetectedCountry(getCountryByCountryCode(detectionVO.countryByNetworkCookie));
         }
         else if(_ggsCountryController.isCountryForCountryCodeAvailable(detectionVO.countryByFlashvar,!detectionVO.alsoDetectUnavailableCountries))
         {
            _log.info("Setting country by flashvar: \'" + detectionVO.countryByFlashvar + "\'");
            _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(3);
            setDetectedCountry(getCountryByCountryCode(detectionVO.countryByFlashvar));
         }
         else if(_ggsCountryController.isCountryWithBrowserLanguageAvailable(detectionVO.browserLanguage,!detectionVO.alsoDetectUnavailableCountries))
         {
            _log.info("Trying to detect country by browser language: \'" + detectionVO.browserLanguage + "\' ...");
            detectCountryByLanguageAndTimezone(detectionVO.browserLanguage,1,detectionVO.timezoneOffset,4);
         }
         else if(detectionVO.flashRuntimeLanguage != "xu" && _ggsCountryController.isCountryWithFlashRuntimeLanguageAvailable(detectionVO.flashRuntimeLanguage,!detectionVO.alsoDetectUnavailableCountries))
         {
            _log.info("Trying to detect country by flashruntime language: \'" + detectionVO.flashRuntimeLanguage + "\' ...");
            detectCountryByLanguageAndTimezone(detectionVO.flashRuntimeLanguage,3,detectionVO.timezoneOffset,5);
         }
         else
         {
            _log.info("Information insufficient for country detection, requesting geoIP...");
            requestGeoIp();
         }
      }
      
      private function checkGeoIpCountry(countryCode:String) : void
      {
         var _loc2_:AbstractGGSCountry = getCountryByGeoIpResponse(countryCode);
         if(_loc2_ != null)
         {
            _log.info("Setting country by geoIP response: \'" + _loc2_.ggsCountryCode + "\'");
            setDetectedCountry(_loc2_);
         }
         else
         {
            _log.info("Country returned by geoIP is not available, using detection fallback...");
            detectCountryFallback();
         }
      }
      
      private function detectCountryFallback() : void
      {
         _log.info("geoIp response inconclusive, using default country");
         _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(7);
         setDetectedCountry(_ggsCountryController.getDefaultCountry());
      }
      
      private function detectCountryByLanguageAndTimezone(languageCode:String, languageCodeType:int, timezoneOffset:Number, factor:int) : void
      {
         var _loc5_:Vector.<AbstractGGSCountry> = !!currentCountryDetectionVO.alsoDetectUnavailableCountries ? _ggsCountryController.allCountries : _ggsCountryController.activeCountries;
         countriesFilteredByLanguage = filterCountryListByLanguage(_loc5_,languageCode,languageCodeType);
         switch(int(countriesFilteredByLanguage.length))
         {
            case 0:
               _log.info("No countries in language-filtered list, requesting geoIP...");
               requestGeoIp();
               break;
            case 1:
               _log.info("Setting country from language-filtered list: \'" + countriesFilteredByLanguage[0].ggsCountryCode + "\'");
               _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(factor);
               setDetectedCountry(countriesFilteredByLanguage[0]);
               break;
            default:
               countriesFilteredByLanguageAndTimezone = filterCountryListByTimezone(countriesFilteredByLanguage,timezoneOffset);
               if(countriesFilteredByLanguageAndTimezone.length == 1)
               {
                  _log.info("Setting country from language-and-timezone-filtered list: \'" + countriesFilteredByLanguageAndTimezone[0].ggsCountryCode + "\'");
                  _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(int(factor + " " + 1));
                  setDetectedCountry(countriesFilteredByLanguageAndTimezone[0]);
                  break;
               }
               if(countriesFilteredByLanguageAndTimezone.length == 0)
               {
                  _log.info("No countries in language-and-timezone-filtered list, requesting geoIP...");
               }
               else
               {
                  _log.info("More than one country in language-and-timezone-filtered list, requesting geoIP...");
               }
               requestGeoIp();
               break;
         }
      }
      
      private function setDetectedCountry(detectedCountry:AbstractGGSCountry) : void
      {
         _lastDetectedCountry = detectedCountry;
         _log.info("Detected country: " + detectedCountry.ggsCountryCode);
         _detectionCompleted.dispatch(detectedCountry);
      }
      
      private function requestGeoIp() : void
      {
         var _loc1_:* = null;
         _countryDetectorPerfomanceAdapter.storeCountryDetectionFactor(6);
         if(currentCountryDetectionVO.fakeGeoIpResponse != null)
         {
            checkGeoIpCountry(currentCountryDetectionVO.fakeGeoIpResponse);
         }
         else
         {
            if(geoIpUrlLoader == null)
            {
               geoIpUrlLoader = new URLLoader();
            }
            geopIpRequestTime = getTimer();
            _loc1_ = new URLRequest("http://i2c.goodgamestudios.com");
            _loc1_.method = "GET";
            geoIpUrlLoader.addEventListener("complete",onGeoIpResponse);
            geoIpUrlLoader.addEventListener("ioError",onGeoIpIOError);
            geoIpUrlLoader.addEventListener("securityError",onGeoIpSecurityError);
            geoIpUrlLoader.load(_loc1_);
            if(geoIpTimeoutTimer == null)
            {
               geoIpTimeoutTimer = new Timer(3000,1);
            }
            geoIpTimeoutTimer.addEventListener("timer",onGeoIpFailure);
            geoIpTimeoutTimer.start();
            isWaitingForGeoIpResponse = true;
         }
      }
      
      private function onGeoIpResponse(event:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(event.target);
         var _loc3_:String = _loc2_.data as String;
         var _loc4_:String = Base64.decode(bytesToAsciiString(hexStringToBytes(_loc3_)));
         geopIpRequestTime = getTimer() - geopIpRequestTime;
         _countryDetectorPerfomanceAdapter.storeGeoIPRequestTime(geopIpRequestTime);
         checkGeoIpCountry(_loc4_);
         if(geoIpTimeoutTimer != null)
         {
            geoIpTimeoutTimer.removeEventListener("timer",onGeoIpFailure);
         }
         removeLoaderListeners();
         isWaitingForGeoIpResponse = false;
      }
      
      private function onGeoIpSecurityError(event:SecurityErrorEvent) : void
      {
         _log.logExternalSecurityError(event.text,"http://i2c.goodgamestudios.com");
         onGeoIpFailure(event);
      }
      
      private function onGeoIpIOError(event:IOErrorEvent) : void
      {
         _log.logIOError(event.text,"http://i2c.goodgamestudios.com");
         onGeoIpFailure(event);
      }
      
      private function onGeoIpFailure(event:Event) : void
      {
         if(isWaitingForGeoIpResponse)
         {
            geopIpRequestTime = 3000;
            _countryDetectorPerfomanceAdapter.storeGeoIPRequestTime(geopIpRequestTime);
            _log.info("geoIP response either timed out or request failed, using detection fallback...");
            detectCountryFallback();
            if(geoIpTimeoutTimer != null)
            {
               geoIpTimeoutTimer.removeEventListener("timer",onGeoIpFailure);
            }
            removeLoaderListeners();
            isWaitingForGeoIpResponse = false;
         }
      }
      
      private function removeLoaderListeners() : void
      {
         if(geoIpUrlLoader != null)
         {
            geoIpUrlLoader.removeEventListener("complete",onGeoIpResponse);
            geoIpUrlLoader.removeEventListener("ioError",onGeoIpIOError);
            geoIpUrlLoader.removeEventListener("securityError",onGeoIpSecurityError);
         }
      }
      
      private function getCountryByCountryCode(countryCode:String) : AbstractGGSCountry
      {
         countryCode = countryCode.toLowerCase();
         var _loc2_:Vector.<AbstractGGSCountry> = !!currentCountryDetectionVO.alsoDetectUnavailableCountries ? _ggsCountryController.allCountries : _ggsCountryController.activeCountries;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.ggsCountryCode.toLowerCase() == countryCode)
            {
               return _loc3_;
            }
         }
         return provideFallBackCountry();
      }
      
      private function getCountryByGeoIpResponse(geoIpResponse:String) : AbstractGGSCountry
      {
         var _loc2_:Vector.<AbstractGGSCountry> = !!currentCountryDetectionVO.alsoDetectUnavailableCountries ? _ggsCountryController.allCountries : _ggsCountryController.activeCountries;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.geoIpCodes.indexOf(geoIpResponse) != -1)
            {
               return _loc3_;
            }
         }
         return provideFallBackCountry();
      }
      
      private function provideFallBackCountry() : AbstractGGSCountry
      {
         return _ggsCountryController.getDefaultCountry();
      }
      
      public function get detectionCompleted() : Signal
      {
         return _detectionCompleted;
      }
      
      public function get countriesLoaded() : Signal
      {
         return _countriesLoaded;
      }
      
      public function get countryLoadFailed() : Signal
      {
         return _countryLoadFailed;
      }
      
      public function get lastDetectedCountry() : AbstractGGSCountry
      {
         return _lastDetectedCountry;
      }
      
      public function set lastDetectedCountry(value:AbstractGGSCountry) : void
      {
         _lastDetectedCountry = value;
      }
      
      public function set log(value:ICountryDetectionLogAdapter) : void
      {
         _log = value;
         _ggsCountryController.log = value;
      }
      
      public function set countryDetectorPerfomanceAdapter(value:ICountryDetectorPerformanceAdapter) : void
      {
         _countryDetectorPerfomanceAdapter = value;
      }
   }
}
