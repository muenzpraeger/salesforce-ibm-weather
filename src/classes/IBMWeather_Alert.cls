public with sharing class IBMWeather_Alert {
    
    @AuraEnabled
    public String key;
    @AuraEnabled
    public String detail_key;
    @AuraEnabled
    public String source;
    @AuraEnabled
    public String significance;
    @AuraEnabled
    public String event_desc;
    @AuraEnabled
    public String headline_text;
	@AuraEnabled
    public String issue_dt_tm_local;
    @AuraEnabled
    public String issue_dt_tm_tz_abbrv;
    @AuraEnabled
    public String identifier;
    @AuraEnabled
    public String proc_dt_tm_local;
    @AuraEnabled
    public String proc_dt_tm_tz_abbrv;
    @AuraEnabled
    public IBMWeather_AlertResponseType[] response_types;
    
}