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
<b>A:</b> Prepair the html form which you will use to collect details from the customer. <br />
-- The API uses form <i>index.php</i> found in views/pesapal <br /> 
-- The request is called using the <b>index()</b> function found in controller <b>PayPesaPal</b> <br />
-- You can access the form direct or by using route <b><i>checkout</i></b> <br />
<i> more on route, url and forms read codeigniter documentation </i> https://www.codeigniter.com/user_guide/  <br />

<b>Step Two</b><br />
<b>A:</b> Submit the form data to Controller <b>PayPesaPal/buyproducts</b> optional use route <b><i>buygoods</i></b> <br />
 
Take all value passed from the checkout form and pass them to <b>paynow function</b> <br />
- Change the access keys to those given to you from the PesaPal account dashboard<br />
```
$consumer_key = 'Your PesaPal Merchant Consumer Key'; 
$consumer_secret = 'Your PesaPal Merchant Consumer Secret';
```
Add the <b>iframelink</b>
```
$iframelink = 'https://demo.pesapal.com/api/PostPesapalDirectOrderV4';
```
<b>NB:</b> Remember this changes to 
```
$iframelink = 'https://www.pesapal.com/API/PostPesapalDirectOrderV4';
```
Once the project is on the live server (Production Phase) <br />
Set-up the values Amount,Description,Names,Email et.c <br />

Then add the <b>callback_url</b> 
```
$callback_url = 'https://www.yourhost.com/pesapal/paid'; //redirect url, the page that will handle the response from pesapal.
```

The populated iFrame will appear in view <b>paynow</b> and is passed via <b>$data</b> array
```
$data['iframe_src'] = $iframe_src;

//View
$this->load->view('pesapal/paynow',$data);
```

<b>Step Three</b><br />
On the view <b>paynow</b> you will see the <b>PesaPal</b> payment iFrame appear in a position depending with your <b>CSS</b> customization. <br />
- If you get an error and the <b>PesaPal</b> Form doesn't appear, kindly check your <b><i>consumer_key, consumer_secret, iframelink, callback_url and OAuth.php </i></b> if they are well linked. <br /> <br />

- Generate the Payment confirmantion code from: https://demo.pesapal.com/dashboard/my/mobilemoneytest <br />
- Once you input and click <b>Complete Buttom</b> the payment will be handled to PesaPal and the receival confirmantion will be sent to the <b>callback_url = https://www.yourhost.com/pesapal/paid</b> <br />
- That will take the request to <b>function paid</b>. There you can define your TimeZone if you wish (place this code above variable $dateTime) <br />
```
date_default_timezone_set('Your Time Zone');
$dateTime =  date('Y-m-d, H:i:s');
```
Pesapal will pass to our function values <b> reference and pesapal_tracking_id </b> <br />
```
$reference = $_GET['pesapal_merchant_reference']; // This is our order ID
$pesapal_tracking_id = $_GET['pesapal_transaction_tracking_id']; // PesaPal Payment Reference ID
```

All values will be stored in table <b> pesapal_txn </b> which is declared at the top before the <b>constructer</b>
```
 private $TXNtable = 'pesapal_txn'; //TXN Table
```

Once the Data is saved, the function will take the user to 'Payment Complete Page which can be called by <b>function success() </b> <br />

<b>NB:</b> Kindly note this process means the payment has been sent to PesaPal. But incase of DEBIT / CREDIT cards the card charging process can be rejected hence the payment will be incomplete. <br />
That is why in this step our <b>txn_status is set to 'WAITING'</b> and <b>txn_ipn_date, notification_type are 'NULL'</b> <br />

<b>Step Four (IPN)</b><br />
<b>A:</b> By now you must have set-up the IPN urls form you developer account / business account back-end. If not yet set up from your <b> IPN Settings</b> menu under Account Settings. <br />

- Example of IPN settings details
```
Web Domain:
www.yourhost.com

IPN Listener URL:
https://www.yourhost.com/pesapal/response
```
- Once <b>step three</b> is over it will take 60sec for pesapal to confirm if the payment was received successful, and if it's true the IPN urs <b><i>https://www.yourhost.com/pesapal/response</i></b> which will access controller <b>PayPesaPal/ipn</b> will be triggered.

<b>B:</b> Set-up the <b>consumer_key and consumer_secret </b> as how you did in <b>STEP TWO</b> then add
```
$statusrequestAPI = 'https://demo.pesapal.com/api/querypaymentstatus';
```
- Remember to change to:
```
https://www.pesapal.com/api/querypaymentstatus' when you are ready to go live!
```

- On this step is were we will find out if the payment process completed successful. We will update the payment with variable <b>$status</b>. <br />

- Set value <b>txn_ipn_date, notification_type, txn_status and flag </b> <br />
- The <b>txn_status = 'PAID'</b> and <b> flag = 1 </b> this is to indicate that the IPN call was initiated successful. <br />
- Once this is done the <b> notification_type </b> will be set to <b>'COMPLETE'</b>

<b>Step Five</b><br />
From there you can query values from the table and indicate to the Admin dashboard if the product purchase and payment was successful (This page is not provided with this API, you can develop it and access the data from the <i>pesapal_txn</i> or your prefered table)


## Built With

* [Codeigniter](https://codeigniter.com/) - The PHP framework used
* [PHP](http://php.net/) - PHP Language
* [MYSQL](https://www.mysql.com/) - MySQL Database
* [PesaPal](https://pesapal.com/) - PesaPal Payment API

## Contributing

Please feel free to contribute, contact me via email.

## Versioning

We will update the API for better code flow or when <b>PesaPal</b> update their API 

## Author

* **Josh L Minga** - *Initial work* - [Josh](https://github.com/joshlminga)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

