({
    getWeather : function(component, event) {
        this.getWeatherObservation(component);
    },
    getWeatherObservation : function(component) {
        var action = component.get("c.getWeatherObservation");
        action.setParams({recordId:component.get("v.recordId")});
        action.setCallback(this, function(data) {
            component.set("v.weatherObservationData", data.getReturnValue());
            this.getWeatherForecast(component);
        });
        $A.enqueueAction(action);
    },
    getWeatherForecast : function(component) {
        var action = component.get("c.getWeather3DayForecasts");
        action.setParams({recordId:component.get("v.recordId")});
        action.setCallback(this, function(data) {
            component.set("v.weatherForecastData", data.getReturnValue());
			this.getWeatherAlerts(component);
        });
        $A.enqueueAction(action);
    },
    getWeatherAlerts : function(component) {
        var action = component.get("c.getWeatherAlerts");
        action.setParams({recordId:component.get("v.recordId")});
        action.setCallback(this, function(data) {
            console.log(data.getReturnValue());
            component.set("v.weatherAlertData", data.getReturnValue());
            var observationData = component.get("v.weatherObservationData");
            var alertData = component.get("v.weatherAlertData");
            if (observationData!=null) {
                component.set("v.weatherLoadedWithIcon", (observationData.wx_icon!=null));
                component.set("v.weatherLoaded", true);
            }
            if (alertData!=null) {
                component.set("v.weatherAlertDataAvailable", true);
            }
        });
        $A.enqueueAction(action);
    }
})