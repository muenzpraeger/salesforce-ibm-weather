# salesforce-ibm-weather

This repository showcases how to use The Weather Company Data within Salesforce.

* A Lightning component that displays the current weather, a 3-day forecast and - if applicable - weather alerts.

You can see the component here in action:

[![Salesforce Lightning and The Weather Company](http://img.youtube.com/vi/ZjffiGsdrWM/0.jpg)](https://youtube.com/watch?v=ZjffiGsdrWM)

This implementation does *not* reflect the planned The Weather Company integrations as announced [here](https://www.salesforce.com/campaign/ibm/) (i. e. with push data). It rather showcases how to use existing APIs to fetch data on demand.

Read more about using weather data on the [Salesforce Developer Blog](https://developer.salesforce.com/blogs/developer-relations/2017/05/using-ibms-the-weather-company-data-in-salesforce).

# Pre-Requisites

## The Weather Company Data (Bluemix)

Access to The Weather Company Data is available via an IBM Bluemix service. Signup [here](https://console.ng.bluemix.net/catalog/services/weather-company-data/) for the service.

You can find an overview of the API in the [The Weather Company Data REST API explorer](https://twcservice.mybluemix.net/rest-api/).

## Salesforce

### Installation

You can add the source code of this repo via your favorite tooling (i. e. Salesforce DX or the Force.com IDE). Alternatively you can use [this unmanaged package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t0Y000001VTXL) to install the code into a Salesforce org.

### Configuration - Credentials

After you've added the source code you have to set up the a new *Named Credential*.

1. Go to *Setup*.
2. Enter *Named Credentials* in the quick find box and select the highlighted entry.
3. Click on *New Named Credential*.
4. Enter the following values:
    * Label: IBM Weather
    * Name: IBM_Weather
    * URL: https://twcservice.mybluemix.net
    * Identity Type: Named Principial
    * Authentication Protocol: Password Authentication
    * Username: the individual username from the Bluemix service
    * Password: the individual password from the Bluemix service
5. Confirm by clicking on *Save*.

### Configuration - Lightning Component

The Lightning component fetches the current weather, forecast and alert data based on latitude and longitude information of the current object. Is is designed to work out of the box with Account, Contact and Lead objects. For that you have to enable the automatic geocoding feature within your Salesforce org. This will automatically add longitude and latitude data to the aforementioned objects.

1. Go to *Setup*.
2. Enter *Data Integration Rules* in the quick find box and select the highlighted entry.
3. Activate for the wanted objects the geocoding feature.

Depending on the number of objects in your org it may take some time till the records are updated with the geocodes. You can see the status in the Data Integration Rules view. Once it is activated the geocodes will be updated everytime an object of that type is saved.

# Weather Lightning Component

Just drop it via Lightning App Builder into a Lightning record page (Account, Contact, Lead) of your choice to see it in action.

It uses also some backend Apex classes which handle the communication with the APIs.

# License

For licensing see the included [license file](https://github.com/muenzpraeger/salesforce-ibm-weather/blob/master/LICENSE.md).