# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


user authentication
1) bcrypt (encyrpt password, column: password_digest)
2) clearance (encyrpt password, on top of bcrypt)
3) devise ( on top of clearance, admin dashboard)

4) clearance + facebook omniauth log in 
5) google omniauth log in