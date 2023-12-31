-- Feel free to modify this file to match your development goal.
-- Here we only create 3 tables for demo purpose.

CREATE TABLE Users (
    id INT NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    email VARCHAR UNIQUE NOT NULL,
    passwrd VARCHAR(255) NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    mailing_address VARCHAR(255) NOT NULL,
    balance FLOAT NOT NULL
);

CREATE TABLE Category(
    category_name VARCHAR(255) NOT NULL PRIMARY KEY
);



CREATE TABLE Seller(
    id INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Users(id)
);

CREATE TABLE Products(
    product_id INT NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    image_url VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255) NOT NULL REFERENCES Category(category_name),
    owner_id INT REFERENCES Seller(id)
);

CREATE TABLE CartItems(
    quantity INT NOT NULL,
    product_ID INT NOT NULL REFERENCES Products(product_id),
    seller_ID INT NOT NULL REFERENCES Seller(id),
    u_id INT NOT NULL REFERENCES Users(id)
);

CREATE TABLE ReviewProduct(
    user_id INT NOT NULL REFERENCES Users(id),
    product_id INT NOT NULL REFERENCES Products(product_id),
    rating INT NOT NULL,
    title  VARCHAR(255) NOT NULL,
    content VARCHAR(255) NOT NULL,
    time_post timestamp without time zone NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'UTC'),
    num_upvotes INT NOT NULL DEFAULT 0
);

CREATE TABLE ReviewSeller(
    user_id INT NOT NULL REFERENCES Users(id),
    seller_id INT NOT NULL REFERENCES Seller(id),
    rating INT NOT NULL,
    title  VARCHAR(255) NOT NULL,
    content VARCHAR(255) NOT NULL,
    time_post timestamp without time zone NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'UTC'),
    num_upvotes INT NOT NULL DEFAULT 0
);

CREATE TABLE Orders(
    order_id INT NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    user_id INT NOT NULL REFERENCES Users(id)
);

CREATE TABLE OrderDetails(
    order_id INT NOT NULL REFERENCES Orders(order_id),
    quantity INT NOT NULL,
    fulfill_status BOOLEAN DEFAULT False,
    order_timestamp timestamp without time zone NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'UTC'),
    fulfill_timestamp timestamp without time zone,
    product_id INT NOT NULL REFERENCES Products(product_id),
    seller_id INT NOT NULL REFERENCES Seller(id)
);

CREATE TABLE Inventory(
    product_id INT NOT NULL REFERENCES Products(product_id),
    quantity INT NOT NULL,
    seller_id INT NOT NULL REFERENCES Seller(id),
    product_description VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL
);

