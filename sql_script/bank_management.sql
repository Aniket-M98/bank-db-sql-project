CREATE DATABASE Bank_management

USE Bank_management

-- ==============================
-- BANK OLTP DATABASE (MySQL)
-- ==============================

-- ==============================
-- Customers
-- ==============================
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- Branches
-- ==============================
CREATE TABLE Branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(150) NOT NULL,
    branch_address VARCHAR(255) NOT NULL,
    branch_phone VARCHAR(15)
);

-- ==============================
-- Employees
-- ==============================
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    branch_id INT NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(12,2),
    hire_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- ==============================
-- Accounts
-- ==============================
CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0,
    opened_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active',
    CONSTRAINT fk_account_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_account_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- ==============================
-- Transactions
-- ==============================
CREATE TABLE Transactions (
    transaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type ENUM('Credit','Debit') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    CONSTRAINT fk_transaction_account FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- ==============================
-- Loans
-- ==============================
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    loan_type VARCHAR(50),
    amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'Ongoing',
    CONSTRAINT fk_loan_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_loan_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- ==============================
-- Cards
-- ==============================
CREATE TABLE Cards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    card_type ENUM('Debit','Credit') NOT NULL,
    card_number CHAR(16) NOT NULL UNIQUE,
    expiry_date DATE,
    cvv CHAR(3),
    CONSTRAINT fk_card_account FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
