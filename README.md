# Bookstore Web Application

## Overview

This repository contains the code for a bookstore web application developed as part of a project(The part I developed was Creating the products.jsp file and addBook.jsp file). The main functionalities of this application include displaying a list of books available in the bookstore, allowing users to add new books to the database, and providing options for editing and deleting existing books.

## Author

- **Name**: MFF Rahna
- **Registration Number**: KEG/IT/2021/F/0021

## Tools and Technologies Used

- **Java Servlets and JSP**: For server-side development to handle HTTP requests and dynamically generate web pages.
- **MySQL Database**: To store book information such as title, author, description, and price.
- **HTML, CSS, and JavaScript**: For frontend development to create the user interface and enhance user experience.
- **Apache Tomcat**: Used as the web server to deploy and run the Java web application.
- **Git and GitHub**: For version control and collaboration among team members.

## Features
- **User Registration**:Allowing new users to create an account
- **User Login(session)**: User can login to the website using their username and password. 
- **Display Books**: Show a list of books with details such as title, author, description, and price.
- **Add Book**: Add new books to the database using a form.
- **Edit Book**: Edit existing books by updating their details.
- **Delete Book**: Delete books from the database with confirmation.

## Getting Started

### Prerequisites

- **Java Development Kit (JDK)** installed on your machine.
- **Apache Tomcat installed and configured.**
- **MySQL database installed and running.** 

## How to Use

### Home Page:

- If the user is not logged in, they will see options to log in or register.
- If the user is logged in, they can navigate to the products page or log out.

### Products Page:

- Displays a list of books with details and actions.
- The "Add Book" button redirects to the addBook.jsp page where users can add new books.
- The "Edit" button next to each book allows users to edit book details.
- The "Delete" button next to each book allows users to delete the book after a confirmation.
