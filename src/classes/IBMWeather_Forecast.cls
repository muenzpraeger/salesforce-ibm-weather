public with sharing class IBMWeather_Forecast {
    
    @AuraEnabled
    public String narrative {get; set;}
    @AuraEnabled
    public Integer max_temp {get; set;}
    @AuraEnabled
    public Integer min_temp {get; set;}
    @AuraEnabled
    public IBMWeather_ForecastDay day {get; set;}
    
}