public with sharing class IBMWeather_Observation {
    
        @AuraEnabled
        public String obs_name {get; set;}
        @AuraEnabled
        public String temp {get; set;}        
        @AuraEnabled
        public Integer rh {get; set;}
        @AuraEnabled
        public String wx_phrase {get; set;}
        @AuraEnabled
        public Integer wx_icon {get; set;}
    
}