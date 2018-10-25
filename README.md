# CodeigniterPesapal-API

This is PesaPal Payment API with IPN (Instant Payment Notification) based on PHP programming languange, developed using Codeigniter 3 PHP Framework.  

## Getting Started
In order to use this API you need to have:

1- Knowledge of PHP Programming Language. <br />
2- Understanding of Codeigniter PHP Framework (Mostly MVC) concepts. <br />
3- Pesapal Developer account/Actual Business Account (Sign up here:  http://developer.pesapal.com/ or http://www.pesapal.com/). <br />
4- Codeigniter Core Framework / Codeigniter Project. <br />

### Prerequisites

This project is based from offical Pesapal <b>PostPesapalDirectOrderV4</b> in order to use the API you need: <br>
1- <b>consumer_key</b> – merchant key issued by PesaPal to the merchant <br />
2- <b>consumer_secret</b> – merchant secret issued by PesaPal to the merchant <br />
3- <b>Oauth.php File </b> - Download and rename in to <b>.php</b> or use the one come with the API

More can be found here : http://developer.pesapal.com/how-to-integrate/php-sample <br />
Document and reference : http://developer.pesapal.com/how-to-integrate/samples-downloads <br />

Download the file from this repositories and copy them to your existng roject

```
Application Folder Add in
  Config Folder
  | route.php 
     -- add
     $route['checkout'] = 'PayPesaPal'; //Buy
     $route['buygoods'] = 'PayPesaPal/buyproducts';
     $route['pesapal/pay'] = 'PayPesaPal/paynow';
     $route['pesapal/paid'] = 'PayPesaPal/paid';
     $route['pesapal/response'] = 'PayPesaPal/ipn';

  Controller Folder
  | PayPesaPal.php

  Libraries Folder
  | Pesapal.php
  | Create Folder -> PesaPalFile
    | OAuth.php

Add Table : pesapal_txn 
- using file pesapal_txn.sql

```

### Installing

To install the API and start using follow the procedure above by coping the files as directed, then follwo the steps below. <br />

<b>Step One</b><br />
<b>A:</b>Prepair the html form which you will use to collect details from the customer. <br />
-- The API uses form <i>index.php</i> found in views/pesapal <br /> 
-- The request is called using the <b>index()</b> function found in controller <b>PayPesaPal</b> <br />
-- You can access the form direct or by using route <b><i>checkout</i></b> <br />
<i> more on route, url and forms read codeigniter documentation </i> https://www.codeigniter.com/user_guide/  <br />

<b>B:</b> Submit the form data to Controller <b>PayPesaPal/buyproducts</b> optional use route <b><i>buygoods</i></b> <br />
 
Take all value passed from the checkout form and pass them to <b>paynow function</b> <br />
- Change the access keys to those given to you from the PesaPal account dashboard<br />
```
$consumer_key = 'Your PesaPal Merchant Consumer Key'; 
$consumer_secret = 'Your PesaPal Merchant Consumer Secret';
```
```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
