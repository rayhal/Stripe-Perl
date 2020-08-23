# Stripe-Perl
Simple Perl integration for Stripe credit card only payments
I need a quick and simple way to add Stripe credit card payments to an existing project built in Perl. The Net::Stripe module was complete overkill so I created this simple script and html page.
The script creates a Stripe payment_intent and inserts the returned json into a template. Stripe's Javascript module inserted into the template handles the actual payment with some additional code to create the workflow.
You can copy and paste code from striple.pl into your own project then create a Perl script to handle the data returned from the webhook you set up in your Stripe profile. This is easy to do using the JSON::Parse module.
