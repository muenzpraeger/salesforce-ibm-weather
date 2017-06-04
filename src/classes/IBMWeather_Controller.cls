public class IBMWeather_Controller {
    
    private static JSONParser getWeatherJson(String url, String jsonKey) {
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        Map<String, String> retData = new Map<String, String>();
        
        String jsonContent = res.getBody();
        
        JSONParser parser = JSON.createParser(jsonContent);
        while (parser.nextToken()!=null) {
            if (parser.getCurrentToken()==JSONToken.FIELD_NAME) {
                String currentProperty = parser.getText();
                if (currentProperty==jsonKey) {
                    while(parser.nextToken() != null) {
                        if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
                            return parser;
                        } else if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                            return parser;
                        }
                    }
                }
            }
        }
        
        return null;
    }
    
    private static Double[] resolveGeolocation(Id recordId) {
        
        double latitude = 0;
        double longitude = 0;
        
        if (recordId.getSobjectType() == Schema.Account.getSObjectType()) {
            Account acc = [Select Id, BillingLongitude, BillingLatitude from Account WHERE Id=:recordId];
            if (acc!=null) {
                latitude = acc.BillingLatitude;
                longitude = acc.BillingLongitude;
            }            
        } else if (recordId.getSobjectType() == Schema.Contact.getSObjectType()) {
            Contact con = [Select Id, MailingLongitude, MailingLatitude from Contact WHERE Id=:recordId];
            if (con!=null) {
                latitude = con.MailingLatitude;
                longitude = con.MailingLongitude;
            }
        } else if (recordId.getSobjectType() == Schema.Lead.getSObjectType()) {
            Lead lea = [Select Id, Address from Lead WHERE Id=:recordId];
            if (lea!=null) {
                latitude = lea.Address.getLatitude();
                longitude = lea.Address.getLongitude();
            } 
        }
        
        return new Double[]{latitude, longitude};
            }
    
    @AuraEnabled
    public static IBMWeather_Observation getWeatherObservation(Id recordId) {
        
        Double[] geoLocation = resolveGeoLocation(recordId);
        
        String url = 'callout:IBM_Weather/api/weather/v1/geocode/' + geoLocation[0] + '/' + geoLocation[1] + '/observations.json?language=' + UserInfo.getLanguage().replace('_','-');
        
        JSONParser parser = getWeatherJson(url, 'observation');
        
        if (parser!=null) {
            IBMWeather_Observation observation = (IBMWeather_Observation)parser.readValueAs(IBMWeather_Observation.class);
            return observation;
        }
        
        return null;
    }
    
    @AuraEnabled
    public static IBMWeather_Forecast[] getWeather3DayForecasts(Id recordId) {
        
        Double[] geoLocation = resolveGeoLocation(recordId);
        
        String url = 'callout:IBM_Weather/api/weather/v1/geocode/' + geoLocation[0] + '/' + geoLocation[1] + '/forecast/daily/3day.json?units=m&language=en-US';
        
        JSONParser parser = getWeatherJson(url, 'forecasts');
        
        if (parser!=null) {
            IBMWeather_Forecast[] weather = (IBMWeather_Forecast[])parser.readValueAs(IBMWeather_Forecast[].class);
            return weather;
        }
        
        return null;
    }
    
    @AuraEnabled
    public static IBMWeather_Alert[] getWeatherAlerts(Id recordId) {
        
        Double[] geoLocation = resolveGeoLocation(recordId);
        
        String url = 'callout:IBM_Weather/api/weather/v1/geocode/' + geoLocation[0] + '/' + geoLocation[1] + '/alerts.json?language=en-US';
        
        JSONParser parser = getWeatherJson(url, 'alerts');
        
        if (parser!=null) {
            IBMWeather_Alert[] alerts = (IBMWeather_Alert[])parser.readValueAs(IBMWeather_Alert[].class);
            return alerts;
        }
        
        return null;
    }
    
    @future(callout=true)
    public static void checkWeatherForecastsForFittings(Id accountId) {
        IBMWeather_Forecast[] forecasts = getWeather3DayForecasts(accountId);
        
        // We only need tomorrows weather in this implementation
        String message = evaluateBadWeatherConditions(forecasts.get(1));
        
        if (!message.equals('')) {
            ConnectApi.FeedElement fe = ConnectApiHelper.postFeedItemWithMentions(
                Network.getNetworkId(),
                accountId,
                message);
        }
    }
    
    private static String evaluateBadWeatherConditions(IBMWeather_Forecast forecast) {
        
        Boolean withRain;
        Boolean withWind;
        
        if (forecast.day.precipitation>35) { // precipitation is higher than 35%
            withRain = true;
        }
        if (forecast.day.wspd>5) { // wind is stronger than 5
            withWind = true;
        }
        
        if (withRain && withWind) {
            return 'Holy Moly - it will be rainy and stormy!';
        } else if (withRain) {
            return 'Some rain will come down!';
        } else if (withWind) {
            return 'Strong winds are expected!';
        }
        
        return '';
    }
    
}