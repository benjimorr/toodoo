# Toodoo
## A self-destructing to-do list to make your life less cluttered.

This repository holds a Ruby on Rails API that I built for a simple todo application, called **Toodoo**. This todo app automatically removes todo tasks that are older than 7 days, to keep your life less cluttered or stressful. The API itself lives at: https://my-toodoo-api.herokuapp.com/. The API can be accessed via `cURL`, Postman, or any other HTTP request client you may use. It has been built with JSON Web Token (JWT) authentication, so each request after login or signup will require a token in the request's header. There is also a front end React app that I built to consume this API, which you can use [here](https://my-toodoo.herokuapp.com/). Feel free to sign up!

### Prerequisites

This API is built with `Ruby 2.4.1` and `Rails 5.1.3`. It uses a PostgreSQL database in both development and production. Some gems used in this API include:

1. `jwt` to implement Web Token Authentication
2. `simple_command` to easily create service objects to deal with authentication
3. `rack-cors` to allow for Cross-Origin requests (_note_: if you want to access this API remotely, you must send requests from `localhost:8080`)

If you'd like to clone this repo and run the API locally, please ensure that you have `homebrew` installed with `postgres`.

### Getting Started

If you would like to use this project remotely to add additional functionality to the API itself, you can perform the following steps:

1. Clone this repository
2. `cd` into the new `toodoo` directory
3. Run `bundle install` to install gem dependencies
4. Edit the code how you see fit
5. In order to start the database server, run the Homebrew command `brew services start postgresql`
6. In your terminal, use `rails -s` to start a server where the API will be accessible
7. Use `cURL` or any HTTP request client of your choice to access the API via `localhost`
8. When you're done, be sure to stop the database server by using `brew services stop postgresql`

However, since the API is already running on Heroku, I suggest building a cool front-end client that can talk to it. When running this front-end code locally, just be sure to send requests via `localhost:8080` due to CORS.

### Available Endpoints

The following API endpoints are available when accessing my Toodoo API. Endpoints marked with `*` require a JWT to be sent in the header.

| **Endpoint** | **Attributes** | **Description** |
| :--- | :--- | :--- |
| **Retrieve Auth Token**<br><br>`POST /sessions` | 1. `email` (required, string)<br>2. `password` (required, string)  | Returns an Auth token (JWT) for the current user, assuming successful authentication. A `401` unauthorized will be returned if the user is not found. |
| **Retrieve User Info**<br><br>`*` `GET /users/me` | _None_ | Returns the `user_id`, `name`, and `email` of the current user. |
| **Create User**<br><br>`POST /users` | 1. `name` (required, string)<br>2. `email` (required, string)<br>3. `password` (required, string)<br>4. `password_confirmation` (required, string) | Creates a new user in the database, and returns the JWT for authorization. |
| **Edit User**<br><br>`*` `PUT /users/:id` | 1. `id` (required, int)<br>2. `name` (optional, string)<br>3. `email` (optional, string)<br>4. `password` (optional, string)<br>5. `password_confirmation` (optional, string) | Update user with the `id` passed through the request. |
| **Delete User**<br><br>`*` `DELETE /users/:id` | 1. `id` (required, int) | Delete user with the `id` passed through the request. |
| **Retrieve Todo Lists**<br><br>`*` `GET /todos` | _none_ | Returns a list of the current user's todo lists in JSON format. |
| **Retrieve Single Todo List**<br><br>`*` `GET /todos/:id` | 1. `id` (required, int) | Returns the `title` and `category` of todo list with the `id` passed, as well as a list of its todo items.  |
| **Create Todo List**<br><br>`*` `POST /todos` | 1. `title` (required, string)<br>2. `category` (required, string) | Creates a new todo list with the respective `title` and `category` sent in the request. |
| **Update Todo List**<br><br>`*` `PUT /todos/:id` | 1. `id` (required, int)<br>2. `title` (optional, string)<br>3. `category` (optional, string) | Update todo list with the `id` passed through the request. |
| **Delete Todo List**<br><br>`*` `DELETE /todos/:id` | 1. `id` (required, int) | Delete todo list with the `id` passed through the request. |
| **Create Todo Item**<br><br>`*` `POST /todos/:todo_id/items` | 1. `todo_id` (required, int)<br>2. `id` (required, int)<br>3. `name` (required, string)<br>4. `complete` (optional, false by default) | Creates a new todo item for the given todo list, marked as incomplete by default. |
| **Update Todo Item**<br><br>`*` `PUT /todos/:todo_id/items/:id` | 1. `todo_id` (required, int)<br>2. `id` (required, int)<br>3. `name` (optional, string)<br>4. `complete` (optional, boolean) | Update todo item with the `id` passed through the request. |
| **Delete Todo Item**<br><br>`*` `DELETE /todos/:todo_id/items/:id` | 1. `todo_id` (required, int)<br>2. `id` (required, int) | Delete todo item with the `id` passed through the request. |
