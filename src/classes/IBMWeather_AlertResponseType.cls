public with sharing class IBMWeather_AlertResponseType {
    
    @AuraEnabled
    public String response_type {get; set;}
    @AuraEnabled
    public String urgency {get; set;}

}