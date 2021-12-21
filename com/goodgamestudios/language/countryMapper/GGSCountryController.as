package com.goodgamestudios.language.countryMapper
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.log.ICountryDetectionLogAdapter;
   import com.goodgamestudios.language.countryMapper.log.MockCountryDetectionAdapter;
   import com.goodgamestudios.logging.warn;
   import org.osflash.signals.Signal;
   
   public final class GGSCountryController
   {
      
      public static const VERSION:String = "$Id: $";
      
      public static const NAME:String = "GGSCountryController";
      
      private static var _instance:GGSCountryController;
      
      private static var _log:ICountryDetectionLogAdapter;
       
      
      private var _countriesInitialized:Signal;
      
      private var _currentCountryChanged:Signal;
      
      private var _allCountries:Vector.<AbstractGGSCountry>;
      
      private var _activeCountries:Vector.<AbstractGGSCountry>;
      
      private var _activeCountriesStr:Vector.<String>;
      
      private var _availableCountries:Vector.<AbstractGGSCountry>;
      
      private var _notSupportedCountries:Vector.<AbstractGGSCountry>;
      
      private var _currentCountry:AbstractGGSCountry;
      
      private var _selectedLanguageCode:String;
      
      private var _selectedCountryCode:String;
      
      private var _languageIdentifierType:int;
      
      private var _defaultCountry:AbstractGGSCountry;
      
      public function GGSCountryController()
      {
         _countriesInitialized = new Signal();
         _currentCountryChanged = new Signal(AbstractGGSCountry);
         _allCountries = new Vector.<AbstractGGSCountry>();
         _activeCountries = new Vector.<AbstractGGSCountry>();
         _activeCountriesStr = new Vector.<String>();
         _availableCountries = new Vector.<AbstractGGSCountry>();
         _notSupportedCountries = new Vector.<AbstractGGSCountry>();
         super();
         _log = new MockCountryDetectionAdapter();
         if(_instance)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : GGSCountryController
      {
         if(!_instance)
         {
            _instance = new GGSCountryController();
         }
         return _instance;
      }
      
      private static function sortAlphabetically(country1:AbstractGGSCountry, country2:AbstractGGSCountry) : int
      {
         var _loc3_:Array = [country1.ggsCountryCode,country2.ggsCountryCode];
         _loc3_.sort();
         if(country1.ggsCountryCode == country2.ggsCountryCode)
         {
            return 0;
         }
         if(_loc3_.indexOf(country1.ggsCountryCode) < _loc3_.indexOf(country2.ggsCountryCode))
         {
            return -1;
         }
         return 1;
      }
      
      public function get allCountries() : Vector.<AbstractGGSCountry>
      {
         return _allCountries;
      }
      
      public function get availableCountries() : Vector.<AbstractGGSCountry>
      {
         return _availableCountries;
      }
      
      public function get notSupportedCountries() : Vector.<AbstractGGSCountry>
      {
         return _notSupportedCountries;
      }
      
      public function get currentCountry() : AbstractGGSCountry
      {
         return _currentCountry;
      }
      
      public function set currentCountry(country:AbstractGGSCountry) : void
      {
         if(!country)
         {
            _log.error("currentCountry -> Country is null!");
            return;
         }
         _log.info("set currentCountry() -> New country code: \'" + country.ggsCountryCode + "\', previous country code: \'" + _selectedCountryCode + "\'");
         var _loc2_:String = _selectedCountryCode;
         _currentCountry = country;
         _selectedCountryCode = _currentCountry.ggsCountryCode;
         if(_loc2_ != _selectedCountryCode)
         {
            _currentCountryChanged.dispatch(currentCountry);
         }
      }
      
      public function set currentCountryByCountryCode(ggsCountryCode:String) : void
      {
         var _loc2_:AbstractGGSCountry = getAvailableCountryByCountryCode(ggsCountryCode);
         currentCountry = !!_loc2_ ? _loc2_ : GGSCountryController.instance.getDefaultCountry();
      }
      
      public function setSelectedLanguage(_language:String, _identifierType:int) : void
      {
         _log.info("Language: " + _language + ", identifierType: " + _identifierType);
         _selectedLanguageCode = _language;
         _languageIdentifierType = _identifierType;
      }
      
      public function initActiveCountries(activeCountryGGSCountryCodes:Vector.<AbstractGGSCountry>) : void
      {
         _activeCountries = activeCountryGGSCountryCodes;
         _activeCountries.sort(sortAlphabetically);
         initNotSupportedCountries();
      }
      
      public function initActiveCountriesStr(activeCountryGGSCountryCodes:Vector.<String>) : void
      {
         _activeCountriesStr = activeCountryGGSCountryCodes.concat();
         _log.debug("_activeCountriesStr: " + _activeCountriesStr.length,_activeCountriesStr);
      }
      
      private function initNotSupportedCountries() : void
      {
         var _loc1_:uint = _allCountries.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            if(_activeCountries.indexOf(_allCountries[_loc2_]) == -1)
            {
               if(_allCountries[_loc2_].ggsCountryCode != "XX")
               {
                  _notSupportedCountries.push(_allCountries[_loc2_]);
               }
            }
            _loc2_++;
         }
      }
      
      public function initAllCountries(allCountries:Vector.<AbstractGGSCountry>) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _allCountries = allCountries;
         _loc4_ = 0;
         while(_loc4_ < _allCountries.length)
         {
            _loc3_ = _allCountries[_loc4_];
            if(_loc3_.ggsCountryCode.toLowerCase() == "XX".toLowerCase())
            {
               _loc2_ = _loc3_;
            }
            if(_loc3_.isDefault)
            {
               _defaultCountry = _loc3_;
               break;
            }
            _loc4_++;
         }
         if(!_defaultCountry)
         {
            warn("There is no default country specified in the country.xml, using \'XX\' as default instead. Check country.xml configuration!");
            _defaultCountry = _loc2_;
         }
         _countriesInitialized.dispatch();
      }
      
      public function isCountryForCountryCodeAvailable(countryCode:String, onlyCheckCountriesInAvailableCountriesList:Boolean = true) : Boolean
      {
         var _loc3_:Vector.<AbstractGGSCountry> = !!onlyCheckCountriesInAvailableCountriesList ? _activeCountries : _allCountries;
         countryCode = countryCode.toLowerCase();
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.ggsCountryCode.toLowerCase() == countryCode)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAvailableCountryByCountryCode(ggsCountryCode:String) : AbstractGGSCountry
      {
         ggsCountryCode = ggsCountryCode.toLowerCase();
         for each(var _loc2_ in _allCountries)
         {
            if(_loc2_.ggsCountryCode.toLowerCase() == ggsCountryCode)
            {
               return _loc2_;
            }
         }
         _log.warn("No country for ggsCountryCode: " + ggsCountryCode + " found. Check country.xml/network.xml configuration.");
         return null;
      }
      
      public function isCountryWithBrowserLanguageAvailable(browserLang:String, onlyCheckCountriesInAvailableCountriesList:Boolean = true) : Boolean
      {
         if(!browserLang || browserLang == "")
         {
            return false;
         }
         var _loc3_:Vector.<AbstractGGSCountry> = !!onlyCheckCountriesInAvailableCountriesList ? _activeCountries : _allCountries;
         browserLang = browserLang.toLowerCase();
         for each(var _loc5_ in _loc3_)
         {
            for each(var _loc4_ in _loc5_.browserLanguageCodes)
            {
               if(_loc4_.toLowerCase() == browserLang)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isCountryWithFlashRuntimeLanguageAvailable(flashLanguage:String, onlyCheckCountriesInAvailableCountriesList:Boolean = true) : Boolean
      {
         if(!flashLanguage || flashLanguage == "")
         {
            return false;
         }
         var _loc3_:Vector.<AbstractGGSCountry> = !!onlyCheckCountriesInAvailableCountriesList ? _activeCountries : _allCountries;
         flashLanguage = flashLanguage.toLowerCase();
         for each(var _loc5_ in _loc3_)
         {
            for each(var _loc4_ in _loc5_.flashRuntimeLanguageCodes)
            {
               if(_loc4_.toLowerCase() == flashLanguage)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getDefaultCountry() : AbstractGGSCountry
      {
         return _defaultCountry;
      }
      
      public function set defaultCountry(country:AbstractGGSCountry) : void
      {
         _defaultCountry = country;
      }
      
      public function get countriesInitialized() : Signal
      {
         return _countriesInitialized;
      }
      
      public function get currentCountryChanged() : Signal
      {
         return _currentCountryChanged;
      }
      
      public function get selectedLanguageCode() : String
      {
         return _selectedLanguageCode;
      }
      
      public function get activeCountries() : Vector.<AbstractGGSCountry>
      {
         return _activeCountries;
      }
      
      public function set activeCountries(value:Vector.<AbstractGGSCountry>) : void
      {
         _activeCountries = value;
      }
      
      public function printAllGGSCountryCodes() : String
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in _allCountries)
         {
            _loc1_.push(_loc2_.ggsCountryCode);
         }
         _loc1_.sort();
         return _loc1_.join(",");
      }
      
      public function printActiveGGSCountryCodes() : String
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in _activeCountries)
         {
            _loc1_.push(_loc2_.ggsCountryCode);
         }
         _loc1_.sort();
         return _loc1_.join(",");
      }
      
      public function printNotSupportedGGSCountryCodes() : String
      {
         if(!_notSupportedCountries)
         {
            initNotSupportedCountries();
         }
         var _loc1_:Array = [];
         for each(var _loc2_ in _notSupportedCountries)
         {
            _loc1_.push(_loc2_.ggsCountryCode);
         }
         _loc1_.sort();
         return _loc1_.join(",");
      }
      
      public function get countriesAreInitialized() : Boolean
      {
         return _allCountries.length != 0;
      }
      
      public function set log(value:ICountryDetectionLogAdapter) : void
      {
         _log = value;
      }
   }
}
