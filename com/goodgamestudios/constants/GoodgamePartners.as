package com.goodgamestudios.constants
{
   public class GoodgamePartners
   {
      
      public static const NETWORK_DEFAULT:int = 1;
      
      public static const NETWORK_GENERAL:int = 1;
      
      public static const NETWORK_FACEBOOK:int = 2;
      
      public static const NETWORK_MYSPACE:int = 3;
      
      public static const NETWORK_STUDIVZ:int = 5;
      
      public static const NETWORK_MEINVZ:int = 5;
      
      public static const NETWORK_SCHUELERVZ:int = 6;
      
      public static const NETWORK_SANDBOXVZ:int = 7;
      
      public static const NETWORK_GENERALVZ:int = 8;
      
      public static const NETWORK_FRIENDSTER:int = 9;
      
      public static const NETWORK_NETLOG:int = 10;
      
      public static const NETWORK_NASZAKLASA:int = 11;
      
      public static const NETWORK_KWICK:int = 12;
      
      public static const NETWORK_LOKALISTEN:int = 13;
      
      public static const NETWORK_MOBAGE:int = 14;
      
      public static const NETWORK_HI5:int = 15;
      
      public static const NETWORK_ORKUT:int = 16;
      
      public static const NETWORK_QUEPASA:int = 17;
      
      public static const NETWORK_SONICO:int = 18;
      
      public static const NETWORK_KIWIBOX:int = 19;
      
      public static const NETWORK_ODNOKLASSNIKI:int = 20;
      
      public static const NETWORK_IWIW:int = 21;
      
      public static const NETWORK_GRONO:int = 22;
      
      public static const NETWORK_YONJA:int = 23;
      
      public static const NETWORK_CHROME:int = 24;
      
      public static const NETWORK_NEUTRON:int = 25;
      
      public static const NETWORK_SPIL_JETZTSPIELEN:int = 26;
      
      public static const NETWORK_LOKALISTEN_SPIELWIESE:int = 27;
      
      public static const NETWORK_SPIL_JEUX_FR:int = 28;
      
      public static const NETWORK_SPIL_GIOCO_IT:int = 29;
      
      public static const NETWORK_SPIL_GRY_PL:int = 30;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_COM:int = 31;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_UK:int = 32;
      
      public static const NETWORK_SPIL_SPIELEN:int = 33;
      
      public static const NETWORK_SPIL_AGAME:int = 34;
      
      public static const NETWORK_SPIL_JEU_FR:int = 35;
      
      public static const NETWORK_SPIL_GAMES_UK:int = 36;
      
      public static const NETWORK_SPIL_GAMESGAMES:int = 37;
      
      public static const NETWORK_SPIL_JUEGOS:int = 38;
      
      public static const NETWORK_SPIL_OURGAMES_RU:int = 39;
      
      public static const NETWORK_SPIL_SPELA_SE:int = 40;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_FR:int = 41;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_ES:int = 42;
      
      public static const NETWORK_SPIL_JUEGOSDECHICAS:int = 43;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_RU:int = 44;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_NL:int = 45;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_IT:int = 46;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_SE:int = 47;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_PL:int = 48;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_DE:int = 49;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_BR:int = 50;
      
      public static const NETWORK_SPIL_SPEL_SE:int = 51;
      
      public static const NETWORK_SPIL_FLASHGAMES_RU:int = 52;
      
      public static const NETWORK_SPIL_SPEL_NL:int = 53;
      
      public static const NETWORK_SPIL_ZAPJUEGOS:int = 54;
      
      public static const NETWORK_SPIL_GAME_CO_IN:int = 55;
      
      public static const NETWORK_SPIL_CLICKJOGOS:int = 56;
      
      public static const NETWORK_SPIL_OJOGOS_PT:int = 57;
      
      public static const NETWORK_SPIL_SPELLETJES_NL:int = 58;
      
      public static const NETWORK_SPIL_OJOGOS_BR:int = 59;
      
      public static const NETWORK_SPIL_GUESTS:int = 60;
      
      public static const NETWORK_SPIL_GAMES_CO_ID:int = 61;
      
      public static const NETWORK_SPIL_GIRLSGOGAMES_CO_ID:int = 62;
      
      public static const NETWORK_SPIL_GIOCHI:int = 63;
       
      
      public function GoodgamePartners()
      {
         super();
      }
      
      public static function isSpilNetwork(param1:int) : Boolean
      {
         return [NETWORK_SPIL_JETZTSPIELEN,NETWORK_SPIL_JEUX_FR,NETWORK_SPIL_GIOCO_IT,NETWORK_SPIL_GRY_PL,NETWORK_SPIL_GIRLSGOGAMES_COM,NETWORK_SPIL_GIRLSGOGAMES_UK,NETWORK_SPIL_SPIELEN,NETWORK_SPIL_AGAME,NETWORK_SPIL_JEU_FR,NETWORK_SPIL_GAMES_UK,NETWORK_SPIL_GAMESGAMES,NETWORK_SPIL_JUEGOS,NETWORK_SPIL_OURGAMES_RU,NETWORK_SPIL_SPELA_SE,NETWORK_SPIL_GIRLSGOGAMES_FR,NETWORK_SPIL_GIRLSGOGAMES_FR,NETWORK_SPIL_GIRLSGOGAMES_ES,NETWORK_SPIL_JUEGOSDECHICAS,NETWORK_SPIL_GIRLSGOGAMES_RU,NETWORK_SPIL_GIRLSGOGAMES_NL,NETWORK_SPIL_GIRLSGOGAMES_IT,NETWORK_SPIL_GIRLSGOGAMES_SE,NETWORK_SPIL_GIRLSGOGAMES_PL,NETWORK_SPIL_GIRLSGOGAMES_DE,NETWORK_SPIL_GIRLSGOGAMES_BR,NETWORK_SPIL_SPEL_SE,NETWORK_SPIL_FLASHGAMES_RU,NETWORK_SPIL_SPEL_NL,NETWORK_SPIL_ZAPJUEGOS,NETWORK_SPIL_GAME_CO_IN,NETWORK_SPIL_CLICKJOGOS,NETWORK_SPIL_OJOGOS_PT,NETWORK_SPIL_SPELLETJES_NL,NETWORK_SPIL_OJOGOS_BR,NETWORK_SPIL_GUESTS,NETWORK_SPIL_GAMES_CO_ID,NETWORK_SPIL_GIRLSGOGAMES_CO_ID,NETWORK_SPIL_GIOCHI].indexOf(param1) >= 0;
      }
      
      public static function usesCDN(param1:int) : Boolean
      {
         return true;
      }
   }
}
