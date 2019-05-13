## Turing Backend Challenge


The API documentation can be found here: [![Run in Postman](https://run.pstmn.io/button.svg)](https://www.getpostman.com/collections/77da43d136770767f52c)

Hours spent on project roughly 56 hours

Setting the project and running

-   Check that python 3 is installed:

    ```
    python --version
    >> Python 3.6.5
    ```

-   Install pipenv:

    ```
    brew install pipenv
    ```

-   Check pipenv is installed:
    ```
    pipenv --version
  
    ```
    
    ### Using github
-   Clone the project repo and cd into it:

    ```
    git clone https://github.com/TheSteelGuy/tur_ecom.git
    cd tur_ecom
    git checkout develop
  
    ```
    
-   Install dependencies:

    ```
    pipenv install
    ```
    
        
    ### Using github
-   Clone the project repo and cd into it:

    ```
    unzip the file
    cd tur_ecom
  
    ```
    
-   Install dependencies:

    ```
    pipenv install
    ```

-   Make a copy of the .env.sample file  and rename it to .env and update the variables accordingly:

    ```
    DATABASE_URI=mysql://username:password@localhost/tur
    FLASK_ENV=development
    API_BASE_URL_V1=/api/v1
    TEST_DATABASE_URI=mysql://username:password@localhost/tur_tests
    ECOMM_MAIL_USERNAME=""
    stripe_api_key=sk_test_lomdOfxbm7QDgZWvR82UhV6D
    ADMIN=e_admin
    ADMIN_PWD=secret_password
    ```

-   Activate a virtual environment:

    ```
    pipenv shell
    ```
    
-   Install dev dependencies from requirements.txt:

    ```
    pip install -r requirements.txt
    ```
 
 ## Setting database:
 
  - assuming your mysql has no password set like mine type on terminal:
    ```
    mysql -u root
    ```
    
 - on the msql client terminal create database like so:
    ```
    create database tur
    ```
    
  - on the msql client terminal create a user like so and then grant them permission:
    ```
    CREATE USER 'username'@'localhost IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON tur.* TO 'username'@'localhost';
    ```
    ### import the database and data.
    
   ### Starting the application
  - on the project root directory run:
    ```
    export FLASK_APP=manage.py
    
    flask run
    ```
    
