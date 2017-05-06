@isTest
public class Test_IBMWeather {
    
    static testMethod void testWeatherObservation() {
        
        Contact cont = new Contact(LastName='Test Contact', MailingLongitude=37.1256228, MailingLatitude=-89.1997095);
        insert cont;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new Test_IBMWeather_HttpMockResponse());
        
        IBMWeather_Observation observation = IBMWeather_Controller.getWeatherObservation(cont.Id);
        
        System.assertEquals('Cairo', observation.obs_name);
        System.assertEquals('60', observation.temp);
        System.assertEquals(60, observation.rh);
        System.assertEquals('Cloudy', observation.wx_phrase);
        System.assertEquals(26, observation.wx_icon);
        
        Test.stopTest();
        
    }
    
    static testMethod void testWeather3DayForecasts() {
        Contact cont = new Contact(LastName='Test Contact', MailingLongitude=37.1256228, MailingLatitude=-89.1997095);
        insert cont;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new Test_IBMWeather_HttpMockResponse());
        
        IBMWeather_Forecast[] forecasts = IBMWeather_Controller.getWeather3DayForecasts(cont.Id);
        
        System.assertEquals('Plenty of sun. Highs in the mid 70s and lows in the low 50s.', forecasts[1].narrative);
        System.assertEquals(75, forecasts[1].max_temp);
        System.assertEquals(52, forecasts[1].min_temp);
        System.assertEquals('Tomorrow', forecasts[1].day.daypart_name);
        System.assertEquals(34, forecasts[1].day.icon_code);
        
        Test.stopTest();
    }
    
    static testMethod void testWeatherAlerts() {
        
        Contact cont = new Contact(LastName='Test Contact', MailingLongitude=37.1256228, MailingLatitude=-89.1997095);
        insert cont;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new Test_IBMWeather_HttpMockResponse());
        
        IBMWeather_Alert[] alerts = IBMWeather_Controller.getWeatherAlerts(cont.Id);
        
        System.assertEquals('River Flood Warning', alerts[0].event_desc);
        System.assertEquals('26eeb32a-820d-36c9-9655-4e9eef978f40', alerts[0].key);
        System.assertEquals('26eeb32a-820d-36c9-9655-4e9eef978f40', alerts[0].detail_key);
        System.assertEquals('National Weather Service', alerts[0].source);
        System.assertEquals('W', alerts[0].significance);
        System.assertEquals('River Flood Warning until 5AM CDT SAT', alerts[0].headline_text);
        System.assertEquals('2017-04-10T21:08:00-05:00', alerts[0].issue_dt_tm_local);
        System.assertEquals('CDT', alerts[0].issue_dt_tm_tz_abbrv);
        System.assertEquals('f94284f3093e4ae4754171a05fb01f94', alerts[0].identifier);
        System.assertEquals('2017-04-10T21:08:20-05:00', alerts[0].proc_dt_tm_local);
        System.assertEquals('CDT', alerts[0].proc_dt_tm_tz_abbrv);
        System.assertEquals('Avoid', alerts[0].response_types[0].response_type);
        
        Test.stopTest();
        
    }
    
}