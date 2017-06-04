public class IBMWeather_ProcessBuilder {
    
    @InvocableMethod
    public static void checkWeatherBeforeFittingAppointment(List<Fitting_Appointment__c> appts) {
        for (Fitting_Appointment__c appt : appts) {
            IBMWeather_Controller.checkWeatherForecastsForFittings(appt.Account__c);
        }
    }
    
}