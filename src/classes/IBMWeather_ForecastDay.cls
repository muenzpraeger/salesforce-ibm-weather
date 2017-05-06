public class IBMWeather_ForecastDay {
    
    @AuraEnabled
    public String daypart_name {get; set;}
    @AuraEnabled
    public Integer icon_code {get; set;}
    
    // "Bad weather" values for Process
    public Integer wspd {get; set;} // windspeed
    public Integer precipitation {get; set;} // precipitation 
    
}