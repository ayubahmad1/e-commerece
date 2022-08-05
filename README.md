# E-Commerece

A simple E-commerece store to sell and purchase products.

## Ruby version
- 2.7.0

## Rails version
- 5.2

## Modules
- Users
- Products
- Cart
- Checkout
- Coupon

## Features
- A user can add or buy products
- A user can comment to others products
- A user can edit or delete his comments and products
- A user can make his cart before login and can checkout after login to his account
- A user can add his profile picture
- A User can add many pictures for a product
- Coupon can be used for discount if it is valid

Above are the some main features of my application.

## System Dependencies

I have used the following gems for my system:

- Pundit - For the authorization purpose in my app
- Devise - Do all the authentication for my app
- Cloudinary - Store my all the files on cloud.
- Postgres - Used to manage my database
- Rubocop - to style and manage my indentation of my code
- Stripe - Manage checkouts and coupons
- Bootstrap - Used to style my UI
- Jquery - Used in place of javascript
- byebug - To debug my application

And of course i used visual studio as an editor.

## Configuration

I have done some configurations for my application as:

For sending emails:

```sh
config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:        'smtp.gmail.com',
    port:           '587',
    user_name:      'email@example.com',
    password:       'password',
    authentication: :plain
    enable_starttls_auto: true
  }
```

For cloudinary:

```sh
config.active_storage.service = :cloudinary
```
And for some other gems i install gems and make initializers for them.


## Database
```sh
Postgres
```
#### Deployement

I have deployed my application on heroku-18.

## Project Setup for new machine
- Use Git clone to clone the repository to the local machine
- Run
  ```sh
    Bundle install
  ```
- Use
  ```sh
    rake db/setup
  ```
  to create db, load schema and seed add into it
- Start server using
  ```sh
    rails s
  ```
- Run
  ```sh
    loaclhost:3000
  ```
- Sign up as a customer and move towards login.
- View Items and add in cart and place your order after pay the amount and wait for order delivery
