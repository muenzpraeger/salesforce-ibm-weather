global class IBMWeather_Scheduled implements Schedulable {
    
    global void execute(SchedulableContext ctx) {
        List<Fitting_Appointment__c> appts = [SELECT Account__c FROM Fitting_Appointment__c WHERE Fitting_Date__c=TOMORROW];
        for (Fitting_Appointment__c appt : appts) {
            IBMWeather_Controller.checkWeatherForecastsForFittings(appt.Account__c);
        }
    }
    
}